unit fmAtualiza;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Indy/FTP/bsSkin*/VCL}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, ValEdit,
  StrUtils, FPHTTPClient, base64, LCLIntf, LCLType, FileUtil, LResources,
  Process; {LAZARUS: TProcess para download FTP via curl quando servidor é FTP puro}

type
  TfAtualiza = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    {IdFTP1: TObject;} {LAZARUS: TIdFTP removido — substituído por HTTPS via TFPHTTPClient}
    GridPanel1: TPanel {LAZARUS: TGridPanel};
    img1: TImage {LAZARUS: TbsPngImageView};
    sTitulo: TLabel {LAZARUS: TbsSkinLabel};
    pbProgresso: TProgressBar;
    sProgresso: TLabel {LAZARUS: TbsSkinLabel};
    pbProgressoT: TProgressBar;
    sProgressoT: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinPanel1: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton2: TButton {LAZARUS: TbsSkinButton};
    tmrFecha: TTimer;
    ftp: TValueListEditor;
    sStatus: TLabel {LAZARUS: TbsSkinLabel};
    procedure FormActivate(Sender: TObject);
    procedure ftp_conecta();
    procedure ftp_baixa();
    procedure bsSkinButton2Click(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    arquivo_temp: string;
    arq: Integer;
    http_content_length: Int64; {LAZARUS: rastreia Content-Length para barra de progresso}
    function HttpGet(const AURL, AToken: string): string;
    procedure HttpOnDataReceived(Sender: TObject; const ContentLength, CurrentPos: Int64);
    {LAZARUS: TIdFTP substituído — HttpOnDataReceived substitui IdFTP1Work*}
  public
    arquivos: TStringList;
    arquivos_falha: TStringList;
    ftp_url: string;
    ftp_dir: string;
    ftp_porta: integer;
    ftp_usuario: string;
    ftp_senha: string;
    cancela: Boolean;
    erro: Boolean;
  end;

var
  fAtualiza: TfAtualiza;

implementation

uses
  fmMenu, dmComponentes, fmIniciando;


function TfAtualiza.HttpGet(const AURL, AToken: string): string;
var
  Http: TFPHTTPClient;
begin
  Result := '';
  Http := TFPHTTPClient.Create(nil);
  try
    if AToken <> '' then
      Http.AddHeader('Api-Token', AToken);
    Http.AllowRedirect := True;
    {LAZARUS: DM.IdHTTP1.Request.CustomHeaders + DM.IdHTTP1.Get → TFPHTTPClient local}
    Result := Http.Get(AURL);
  finally
    Http.Free;
  end;
end;

procedure TfAtualiza.HttpOnDataReceived(Sender: TObject; const ContentLength, CurrentPos: Int64);
{LAZARUS: substitui IdFTP1Work — atualiza barra de progresso durante download HTTPS}
begin
  if tmrFecha.Enabled then Exit;
  if ContentLength > 0 then
  begin
    http_content_length := ContentLength;
    pbProgresso.Max := ContentLength;
    pbProgresso.Position := CurrentPos;
    sProgresso.Caption := IntToStr(CurrentPos div 1024) + ' KB / ' +
      IntToStr(ContentLength div 1024) + ' KB';
  end
  else
  begin
    {tamanho desconhecido — mostrar bytes baixados}
    pbProgresso.Style := pbstMarquee;
    sProgresso.Caption := IntToStr(CurrentPos div 1024) + ' KB';
  end;
  Application.ProcessMessages;
end;

procedure TfAtualiza.ftp_conecta;
{LAZARUS: HTTPS/FTP é stateless — apenas valida presença da URL do servidor}
begin
  if ftp_url = '' then
  begin
    Application.MessageBox(
      PChar('URL do servidor de atualização não encontrada nos dados de conexão.'),
      PChar(fmIndex.TITULO), mb_ok + MB_ICONWARNING);
    tmrFecha.Enabled := True;
  end;
  {sem handshake FTP — conexão ocorre por arquivo em ftp_baixa}
end;

procedure TfAtualiza.ftp_baixa;
{LAZARUS: TIdFTP substituído — detecta FTP puro (usa curl) vs HTTPS (TFPHTTPClient)}
var
  Http: TFPHTTPClient;
  FS: TFileStream;
  Proc: TProcess;
  total, i: Integer;
  base_url, file_url, rel_path, dest_path, dest_dir: string;
  temp_file: string;
  is_ftp: Boolean;
  ftp_host_bare: string; {host sem protocolo, com porta se não-padrão}
begin
  total := arquivos.Count;
  if total = 0 then
  begin
    pbProgressoT.Max := 1;
    pbProgressoT.Position := 1;
    tmrFecha.Enabled := True;
    Exit;
  end;

  {detectar protocolo: URL explícita 'ftp://' ou porta 21/0 SEM prefixo HTTP → FTP; caso contrário → HTTPS}
  {LAZARUS: ftp_porta=0 era tratado como FTP mesmo para URLs https:// — corrigido: só é FTP se URL não começa com http}
  is_ftp := StartsText('ftp://', ftp_url) or
             (not StartsText('http', ftp_url) and
              ((ftp_porta = 21) or (ftp_porta = 0)));

  {montar base_url conforme protocolo}
  if is_ftp then
  begin
    {LAZARUS: usar curl para FTP — TIdFTP removido, Synapse não instalado}
    ftp_host_bare := ftp_url;
    {remover protocolo caso já incluso}
    if Pos('://', ftp_host_bare) > 0 then
      ftp_host_bare := Copy(ftp_host_bare, Pos('://', ftp_host_bare) + 3, MaxInt);
    {porta não-padrão}
    if (ftp_porta > 0) and (ftp_porta <> 21) then
      ftp_host_bare := ftp_host_bare + ':' + IntToStr(ftp_porta);
    {diretório raiz}
    base_url := ftp_host_bare;
    if ftp_dir <> '' then
    begin
      rel_path := StringReplace(ftp_dir, '\', '/', [rfReplaceAll]);
      if (rel_path <> '') and (rel_path[1] <> '/') then rel_path := '/' + rel_path;
      while (Length(rel_path) > 0) and (rel_path[Length(rel_path)] = '/') do
        Delete(rel_path, Length(rel_path), 1);
      base_url := base_url + rel_path;
    end;
    fmIndex.gravaLog('FTP (curl) host+root: ' + base_url);
  end
  else
  begin
    {HTTPS}
    base_url := ftp_url;
    if Pos('://', base_url) = 0 then
      base_url := 'https://' + base_url;
    while (Length(base_url) > 0) and (base_url[Length(base_url)] = '/') do
      Delete(base_url, Length(base_url), 1);
    if ftp_dir <> '' then
    begin
      rel_path := ftp_dir;
      rel_path := StringReplace(rel_path, '\', '/', [rfReplaceAll]);
      if (rel_path <> '') and (rel_path[1] <> '/') then rel_path := '/' + rel_path;
      while (Length(rel_path) > 0) and (rel_path[Length(rel_path)] = '/') do
        Delete(rel_path, Length(rel_path), 1);
      base_url := base_url + rel_path;
    end;
    fmIndex.gravaLog('HTTPS base_url: ' + base_url);
  end;

  pbProgressoT.Max := total;
  pbProgressoT.Position := 0;
  sProgressoT.Caption := '0 / ' + IntToStr(total);

  {criar cliente HTTP apenas para HTTPS}
  Http := nil;
  if not is_ftp then
  begin
    Http := TFPHTTPClient.Create(nil);
    Http.OnDataReceived := HttpOnDataReceived;
    Http.AllowRedirect := True;
  end;

  try
    for i := 0 to total - 1 do
    begin
      arq := i;
      if cancela or tmrFecha.Enabled then Break;
      Application.ProcessMessages;

      {normalizar separadores de caminho}
      rel_path := StringReplace(arquivos[arq], '\', '/', [rfReplaceAll]);

      {substituição de DB por idioma: FTP tem 'config/pt_database.db' mas app lê 'config/database.db'}
      {rel_path (URL do FTP) não muda — só o destino local (arquivos[arq]) é renomeado}
      if LowerCase(arquivos[arq]) = 'config\' + LowerCase(fIniciando.LANG) + '_database.db' then
        arquivos[arq] := 'config\database.db'; {destino local: renomear para database.db}

      arquivo_temp := ExtractFileName(rel_path);
      temp_file := fmIndex.dir_temp + arquivo_temp;

      sTitulo.Caption := 'Baixando: ' + arquivo_temp;
      sStatus.Caption := IntToStr(arq + 1) + ' / ' + IntToStr(total);
      pbProgresso.Style := pbstMarquee;
      pbProgresso.Max := 100;
      pbProgresso.Position := 0;
      http_content_length := 0;
      sProgresso.Caption := '0 KB';
      Application.ProcessMessages;

      try
        if is_ftp then
        begin
          {LAZARUS: download FTP via curl — modo passivo, credenciais via --user}
          file_url := 'ftp://' + base_url + '/' + rel_path;
          fmIndex.gravaLog('FTP GET: ' + file_url);
          Proc := TProcess.Create(nil);
          try
            Proc.Executable := 'curl';
            Proc.Parameters.Add('--silent');
            Proc.Parameters.Add('--ftp-pasv');
            Proc.Parameters.Add('--user');
            Proc.Parameters.Add(ftp_usuario + ':' + ftp_senha);
            Proc.Parameters.Add(file_url);
            Proc.Parameters.Add('--output');
            Proc.Parameters.Add(temp_file);
            Proc.Options := [poWaitOnExit, poNoConsole];
            Proc.Execute;
            if Proc.ExitCode <> 0 then
              raise Exception.CreateFmt(
                'curl encerrou com código %d ao baixar %s',
                [Proc.ExitCode, arquivo_temp]);
          finally
            Proc.Free;
          end;
          pbProgresso.Style := pbstNormal;
          pbProgresso.Position := 100;
          sProgresso.Caption := 'OK';
        end
        else
        begin
          {HTTPS via TFPHTTPClient}
          file_url := base_url + '/' + rel_path;
          pbProgresso.Style := pbstNormal;
          fmIndex.gravaLog('HTTPS GET: ' + file_url);
          FS := TFileStream.Create(temp_file, fmCreate);
          try
            Http.Get(file_url, FS);
          finally
            FS.Free;
          end;
          pbProgresso.Position := pbProgresso.Max;
          sProgresso.Caption := 'OK';
        end;

        {copiar para destino final}
        {LAZARUS: pai de dir_config — suporta /opt (somente leitura) e build de desenvolvimento}
        dest_path := ExtractFilePath(ExcludeTrailingPathDelimiter(fmIndex.dir_config)) +
          StringReplace(arquivos[arq], '\', '/', [rfReplaceAll]);
        dest_dir := ExtractFilePath(dest_path);
        if (dest_dir <> '') and not DirectoryExists(dest_dir) then
          ForceDirectories(dest_dir);

        {LAZARUS: CopyFile Windows API → FileUtil.CopyFile}
        FileUtil.CopyFile(temp_file, dest_path);
        DeleteFile(temp_file);

      except
        on E: Exception do
        begin
          fmIndex.gravaLog('Erro ao baixar ' + file_url + ': ' + E.Message);
          arquivos_falha.Add(arquivo_temp + ': ' + E.Message);
          sStatus.Caption := 'Erro: ' + E.Message;
          if FileExists(temp_file) then DeleteFile(temp_file);
        end;
      end;

      pbProgressoT.Position := i + 1;
      sProgressoT.Caption := IntToStr(i + 1) + ' / ' + IntToStr(total);
      Application.ProcessMessages;
    end;

  finally
    if Assigned(Http) then Http.Free;
  end;

  if arquivos_falha.Count > 0 then
  begin
    sTitulo.Caption := 'Concluído com ' + IntToStr(arquivos_falha.Count) + ' erro(s).';
    sStatus.Caption := 'Falha em: ' + arquivos_falha.CommaText;
  end
  else
  begin
    sTitulo.Caption := 'Atualização concluída com sucesso!';
    sStatus.Caption := 'Todos os arquivos foram baixados.';
  end;
  tmrFecha.Enabled := True;
end;

procedure TfAtualiza.tmrFechaTimer(Sender: TObject);
begin
  {LAZARUS: IdFTP1.Connected/Disconnect/Abort removidos — sem estado FTP}
  fAtualiza.close;
end;

procedure TfAtualiza.bsSkinButton2Click(Sender: TObject);
begin
  cancela := True;
  try
    tmrFecha.Enabled := true;
  except
    //
  end;
  pbProgresso.Position := 0;
  pbProgressoT.Position := 0;
end;

procedure TfAtualiza.FormActivate(Sender: TObject);
var
  lParams: string;
  ret_ftp: string;
  LinkPag, txt: string;
  url: string;
  dados_ftp: Boolean;
  tentat: Integer;
begin
  cancela := False;
  erro := False;

  tmrFecha.Enabled := False;
  arquivos_falha := TStringList.Create;
  sStatus.Caption := '';

  fmIndex.gravaLog('Conectando FTP');

  sTitulo.Caption := 'Buscando informações...';
  pbProgresso.Style := pbstMarquee;

  fmIndex.gravaLog('URL: ' + fmIndex.url_params);

  try
    LinkPag := HttpGet(fmIndex.url_params, fmIndex.api_token);
  except
    Sleep(2000);
    try
      LinkPag := HttpGet(fmIndex.url_params, fmIndex.api_token);
    except
      Application.MessageBox(PChar('Não foi possível se conectar!'), fmIndex.TITULO, mb_ok + MB_ICONERROR);
      tmrFecha.Enabled := True;
      erro := True;
      Exit;
    end;
  end;

  txt := LinkPag;
  txt := IfThen(trim(txt) = '', '=', txt);
  fmIndex.Param.Strings.Text := txt;
  fmIndex.Param.Strings.SaveToFile(fmIndex.dir_dados + 'configweb.ja');

  if fmIndex.param.Strings.Values['conn_ftp'] = '' then
  begin
    Application.MessageBox(PChar('Não foi possível buscar informações de conexão!'), fmIndex.TITULO, mb_ok + MB_ICONERROR);
    tmrFecha.Enabled := True;
    erro := True;
    Exit;
  end;

  ret_ftp := '';
  dados_ftp := False;
  tentat := 0;
  if trim(fmIndex.loadCol.Strings.Values['FTP']) = '' then
  begin
    while (tmrFecha.Enabled = False) and (Trim(ret_ftp) = '') do
    begin
      application.processmessages;
      tentat := tentat + 1;
      {LAZARUS: TIdIPWatch removido — ip local substituído por string vazia}
      lParams := '';
      lParams := lParams + '&lang=' + fIniciando.LANG;
      lParams := lParams + '&version=' + fmIndex.lblVersao.Caption;
      lParams := lParams + '&bin_version=' + fmIndex.VersaoExe;
      lParams := lParams + '&datetime=' + formatdatetime('yyyy-mm-dd hh:nn:ss', Now());
      lParams := lParams + '&ip='; {LAZARUS: TIdIPWatch.LocalIP removido}
      lParams := lParams + '&directory=' + Application.ExeName;
      fmIndex.paramtemp.Lines.Clear;
      fmIndex.paramtemp.Text := fmIndex.GetComputerNameFunc;
      lParams := lParams + '&pc_name=' + trim(fmIndex.paramtemp.Lines[0]);

      if Pos('?', fmIndex.param.Strings.Values['conn_ftp']) > 0 then
        url := fmIndex.param.Strings.Values['conn_ftp'] + '&data=' +
          EncodeStringBase64(lParams) + '&lang=' + fIniciando.LANG
          {LAZARUS: DM.IdEncoderMIME.EncodeString → EncodeStringBase64 (base64)}
      else
        url := fmIndex.param.Strings.Values['conn_ftp'] + '?data=' +
          EncodeStringBase64(lParams) + '&lang=' + fIniciando.LANG;
          {LAZARUS: DM.IdEncoderMIME.EncodeString → EncodeStringBase64 (base64)}

      fmIndex.gravaLog('URL para autorização de conexão: ' + url);

      while (tmrFecha.Enabled = False) and (dados_ftp = False) do
      begin
        dados_ftp := True;
        application.processmessages;
        try
          ret_ftp := HttpGet(url, '');
          {LAZARUS: DM.idHttp1.Get → HttpGet local}
        except
          on E: Exception do
          begin
            dados_ftp := False;
            if Application.MessageBox(
              PChar('Não foi possível obter dados FTP! O servidor pode estar indisponível, ou o programa não possui permissões de acesso à internet.' +
                #13#10 + 'Causa do erro: ' + E.Message + #13#10 + 'Tentar novamente?'),
              fmIndex.TITULO, mb_yesno + MB_ICONERROR) <> 6 then
            begin
              fmIndex.erro_log.Lines.Add(E.Message);
              fmIndex.erro_log.Lines.Add(url);
              tmrFecha.Enabled := True;
              Sleep(1);
              erro := True;
              Break;
              Exit;
            end
            else
            begin
              sTitulo.Caption := 'Reconectando...';
              Sleep(2);
            end;
          end;
        end;
      end;

      if tmrFecha.Enabled = true then
      begin
        Sleep(1);
        Break;
        Continue;
        Exit;
      end;

      if dados_ftp = true then
      begin
        if Trim(ret_ftp) = '' then
        begin
          if tentat <= 5 then
          begin
            sTitulo.Caption := 'Não foi possível obter dados da conexão! Tentando novamente...';
            dados_ftp := False;
            Sleep(2);
          end
          else
          begin
            if Application.MessageBox(
              PChar('Não foi possível obter dados da conexão!' + #13#10 + 'Tentar novamente?'),
              fmIndex.TITULO, mb_yesno + MB_ICONERROR) <> 6 then
            begin
              fmIndex.erro_log.Lines.Add(ret_ftp);
              fmIndex.erro_log.Lines.Add(url);
              tmrFecha.Enabled := True;
              erro := True;
              Break;
              Exit;
            end
            else
            begin
              sTitulo.Caption := 'Reconectando...';
              tentat := 0;
              dados_ftp := False;
              Sleep(2);
            end;
          end;
        end
        else
        begin
          ftp.Strings.Text := DecodeStringBase64(ret_ftp);
          {LAZARUS: DM.IdDecoderMIME.DecodeString → DecodeStringBase64 (base64)}
          fmIndex.loadCol.Strings.Values['FTP'] := ftp.Strings.Text;
        end;
      end;
    end;
  end
  else
  begin
    ftp.Strings.Text := fmIndex.loadCol.Strings.Values['FTP'];
    dados_ftp := True;
    ret_ftp := EncodeStringBase64(ftp.Strings.Text);
    {LAZARUS: DM.IdEncoderMIME.EncodeString → EncodeStringBase64 (base64)}
  end;

  if (tmrFecha.Enabled = true) or (dados_ftp = false) or (Trim(ret_ftp) = '') then
  begin
    sTitulo.Caption := 'Finalizando...';
    tmrFecha.Enabled := true;
    Exit;
  end;

  if ftp.Values['ftp_msg'] <> '' then
  begin
    Application.MessageBox(PChar(ftp.Values['ftp_msg']), fmIndex.TITULO, mb_ok + MB_ICONERROR);
    fmIndex.loadCol.Strings.Values['FTP'] := '';
    tmrFecha.Enabled := True;
    Exit;
  end;

  arquivo_temp := '';

  ftp_url := ftp.Values['host'];
  ftp_dir := ftp.Values['root'];
  ftp_porta := StrToInt('0' + ftp.Values['port']);
  ftp_usuario := ftp.Values['username'];
  ftp_senha := ftp.Values['password'];

  fmIndex.gravaLog('ftp_url: ' + ftp_url);
  fmIndex.gravaLog('ftp_dir: ' + ftp_dir);
  fmIndex.gravaLog('ftp_porta: ' + IntToStr(ftp_porta));

  sTitulo.Caption := 'Conectando ao servidor...';
  ftp_conecta();

  if tmrFecha.Enabled = True then
  begin
    sTitulo.Caption := 'Finalizando...';
    Exit;
  end;

  sTitulo.Caption := 'Obtendo informações dos arquivos...';
  try
    DM.qrARQUIVOS_SISTEMA.Close;
    DM.qrARQUIVOS_SISTEMA.Open;
  except
  end;
  ftp_baixa();
end;

procedure TfAtualiza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrFecha.Enabled := False;
end;

procedure TfAtualiza.FormCreate(Sender: TObject);
var
  Result: Integer;
  SearchRec: TSearchRec;
begin
  if DirectoryExists(fmIndex.dir_temp) then
  begin
    result := FindFirst(fmIndex.dir_temp + '*.*', faAnyFile, SearchRec);
    While Result = 0 do
    begin
      DeleteFile(fmIndex.dir_temp + SearchRec.Name);
      Result := FindNext(SearchRec);
    end;
  end
  else CreateDir(fmIndex.dir_temp);
end;


initialization
  {$I fmAtualiza.lrs}

end.
