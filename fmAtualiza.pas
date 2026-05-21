unit fmAtualiza;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Indy/FTP/bsSkin*/VCL}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, ValEdit,
  StrUtils, FPHTTPClient, base64, LCLIntf, LCLType, FileUtil, LResources;

type
  TWorkMode = Integer; {LAZARUS: Indy TWorkMode stub — usado só nos eventos FTP}

  TfAtualiza = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    IdFTP1: TObject {LAZARUS: TIdFTP — FTP stub, aguardando migração para HTTPS};
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
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdFTP1Disconnected(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    arquivo_temp: string;
    arq: Integer;
    function HttpGet(const AURL, AToken: string): string;
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
    {LAZARUS: DM.IdHTTP1.Request.CustomHeaders + DM.IdHTTP1.Get → TFPHTTPClient local}
    Result := Http.Get(AURL);
  finally
    Http.Free;
  end;
end;

procedure TfAtualiza.ftp_baixa;
begin
  {LAZARUS: FTP não disponível — aguardando migração para HTTPS}
  sTitulo.Caption := 'FTP não disponível nesta versão Linux.';
  sStatus.Caption := 'Migração para HTTPS pendente.';
  pbProgressoT.Max := 1;
  pbProgressoT.Position := 1;
  tmrFecha.Enabled := True;
end;

procedure TfAtualiza.ftp_conecta;
begin
  {LAZARUS: TIdFTP removido — FTP stub}
  Application.MessageBox(
    'Download via FTP não está disponível nesta versão Linux.'
    + #13#10 + 'Aguardando migração para HTTPS.',
    PChar(fmIndex.TITULO), mb_ok + MB_ICONWARNING);
  tmrFecha.Enabled := True;
end;

procedure TfAtualiza.IdFTP1Disconnected(Sender: TObject);
begin
  {LAZARUS: FTP stub}
end;

procedure TfAtualiza.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  {LAZARUS: FTP stub}
  if tmrFecha.Enabled then Exit;
  pbProgresso.Position := AWorkCount;
  sProgresso.Caption := inttostr(AWorkCount div 1024) + ' KB / ' +
    inttostr(pbProgresso.Max div 1024) + ' KB';
end;

procedure TfAtualiza.IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  {LAZARUS: FTP stub}
  if tmrFecha.Enabled then Exit;
  pbProgresso.Position := 0;
  if pbProgresso.Max <= 0 then
    pbProgresso.Max := AWorkCountMax;
end;

procedure TfAtualiza.IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  dir: string;
begin
  {LAZARUS: FTP stub — CopyFile Windows API → FileUtil.CopyFile}
  if tmrFecha.Enabled then Exit;
  if (arq < 0) or (arquivo_temp = '') then Exit;

  pbProgresso.Position := pbProgresso.Max;

  dir := ExtractFilePath(ExtractFilePath(application.ExeName) + arquivos[arq]);
  if not DirectoryExists(dir) then
    ForceDirectories(dir);

  if arquivos[arq] = 'config\' + lowercase(fIniciando.LANG) + '_database.db' then
    arquivos[arq] := 'config\database.db';

  FileUtil.CopyFile(fmIndex.dir_temp + arquivo_temp,
    ExtractFilePath(application.ExeName) + arquivos[arq]);
  DeleteFile(fmIndex.dir_temp + arquivo_temp);
end;

procedure TfAtualiza.tmrFechaTimer(Sender: TObject);
begin
  {LAZARUS: IdFTP1.Connected/Disconnect/Abort removidos — FTP stub}
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
