unit fmTransmitir;
{$mode objfpc}{$H+} {LAZARUS: ObjFPC necessário — usa @Method para TThread.Synchronize}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/Indy/FireDAC}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Menus, Spin, DB, Clipbrd, Grids,
  FPHTTPServer, FPHTTPClient, ZDataset, ZSqlStrings,
  LCLIntf, LCLType, LMessages, LResources;

type
  {LAZARUS: TFPHttpServer.Active:=True BLOQUEIA a thread chamadora no accept loop.
   No Indy original o TIdHTTPServer criava threads internamente; aqui é preciso
   uma thread dedicada, senão a main thread congela (sem repaint/TTimer) com o
   servidor ligado.}
  THttpServerThread = class(TThread)
  private
    FServer: TFPHttpServer;
  protected
    procedure Execute; override;
  public
    constructor Create(AServer: TFPHttpServer);
  end;

  TfTransmitir = class(TForm)
    {LAZARUS: bsBusinessSkinForm1 removido — componente de skin}
    GridPanel77: TPanel {LAZARUS: TGridPanel};
    Panel58: TPanel;
    bsSkinStdLabel142: TLabel {LAZARUS: TbsSkinStdLabel};
    Panel59: TPanel;
    bsSkinStdLabel143: TLabel {LAZARUS: TbsSkinStdLabel};
    seSrvPorta: TSpinEdit {LAZARUS: TbsSkinNumericEdit};
    seSrvUrl: TEdit {LAZARUS: TbsSkinEdit};
    IdHTTPServer1: TFPHttpServer {LAZARUS: TIdHTTPServer};
    bsSkinPanel53: TPanel {LAZARUS: TbsSkinPanel};
    ckSrvConectar: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsRibbonDivider53: TBevel; {LAZARUS: TbsRibbonDivider}
    bsSkinPanel1: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLabel1: TLabel {LAZARUS: TbsSkinLabel};
    lblStatus: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinPanel2: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLabel2: TLabel {LAZARUS: TbsSkinLabel};
    lblLinkMus1: TLabel {LAZARUS: TbsSkinLinkLabel};
    btCopLinkMus1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    Memo1: TMemo;
    bsSkinPanel3: TPanel {LAZARUS: TbsSkinPanel};
    lblLinkMus2: TLabel {LAZARUS: TbsSkinLinkLabel};
    btCopLinkMus2: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinLabel3: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinPanel4: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLabel4: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinPanel5: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLabel5: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinPanel6: TPanel {LAZARUS: TbsSkinPanel};
    lblLinkBib1: TLabel {LAZARUS: TbsSkinLinkLabel};
    btCopLinkBib1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinLabel6: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinPanel7: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton2: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel8: TPanel {LAZARUS: TbsSkinPanel};
    btServidor: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btIPRede: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    ckSrvAltIPPorta: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinPanel9: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLabel7: TLabel {LAZARUS: TbsSkinLabel};
    btCopLink: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lblLink: TLabel {LAZARUS: TbsSkinLinkLabel};
    Panel1: TPanel;
    bsSkinStdLabel1: TLabel {LAZARUS: TbsSkinStdLabel};
    seSrvToken: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinSpeedButton1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    qrBUSCA: TZQuery {LAZARUS: TFDQuery};
    procedure seSrvUrlExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IdHTTPServer1CommandGet(Sender: TObject;
      var ARequest: TFPHTTPConnectionRequest; var AResponse: TFPHTTPConnectionResponse); {LAZARUS: TIdHTTPServer→TFPHttpServer}
    procedure btServidorClick(Sender: TObject);
    procedure ckSrvConectarClick(Sender: TObject);
    procedure btCopLinkMus1Click(Sender: TObject);
    procedure btCopLinkMus2Click(Sender: TObject);
    procedure btCopLinkBib1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure btIPRedeClick(Sender: TObject);
    procedure ckSrvAltIPPortaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btCopLinkClick(Sender: TObject);
    function geraToken():string;
    procedure seSrvTokenExit(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    tentativaConexao: Integer;
    serverThread: THttpServerThread; {LAZARUS: thread do accept loop do TFPHttpServer}
    FIPMenu: TPopupMenu; {LAZARUS: port 32c09b8 — menu de interfaces de rede}
    syncCronoCaption: string; {LAZARUS: buffer para get-time via Synchronize}
    {LAZARUS: parâmetros para SyncOpenSong (FPC 3.2 não tem closures p/ Synchronize)}
    syncSongId: Integer;
    syncTxtModo: string;
    syncTocarAudio: Boolean;
    syncSearchTerm: string;   {LAZARUS: in — termo da busca p/ SyncSearchSongs}
    syncSearchJson: string;   {LAZARUS: out — JSON resultado de SyncSearchSongs}
    syncSearchOk: Boolean;    {LAZARUS: out — sucesso de SyncSearchSongs}
    procedure pararServidor;
    function aguardaServidorAtivo: Boolean;
    procedure IPMenuItemClick(Sender: TObject); {LAZARUS: port 32c09b8}
  protected
    procedure Loaded; override; {LAZARUS: workaround ZeosLib params — igual TfLetra.Loaded}
  private
    {LAZARUS: métodos sync para chamar código LCL da thread do TFPHttpServer via TThread.Synchronize}
    procedure SyncStartCrono;
    procedure SyncStopCrono;
    procedure SyncAnotaTempo;
    procedure SyncNextSlide;
    procedure SyncPreviousSlide;
    procedure SyncGetCronoCaption;
    procedure SyncOpenSong;
    procedure SyncCloseSong;
    procedure SyncSortear;
    procedure SyncSortearNM;
    procedure SyncSearchSongs;
  public
    { Public declarations }
  end;

var
  fTransmitir: TfTransmitir;

implementation


uses
  fmMusica,fmMenu;

procedure TfTransmitir.bsSkinButton2Click(Sender: TObject);
begin
  close;
end;

{LAZARUS: port upstream 32c09b8 — em vez de preencher direto com o primeiro IP,
 lista as interfaces IPv4 ativas (nome + IP) num popup para o usuário escolher.
 GetAdaptersInfo/TrackPopupMenu (Windows) → enumerarInterfacesRede + TPopupMenu.}
procedure TfTransmitir.btIPRedeClick(Sender: TObject);
var
  ifaces: TStringList;
  item: TMenuItem;
  i: Integer;
  pt: TPoint;
begin
  ifaces := fmIndex.enumerarInterfacesRede;
  try
    if ifaces.Count <= 1 then
    begin
      {0 ou 1 interface — sem escolha a fazer; fallback GetIP como antes}
      seSrvUrl.Text := fmIndex.GetIP;
      Exit;
    end;

    if FIPMenu = nil then
      FIPMenu := TPopupMenu.Create(Self);
    FIPMenu.Items.Clear;
    for i := 0 to ifaces.Count - 1 do
    begin
      item := TMenuItem.Create(FIPMenu);
      item.Caption := ifaces.Names[i] + ' - ' + ifaces.ValueFromIndex[i];
      item.Hint := ifaces.ValueFromIndex[i]; {IP puro para o OnClick}
      item.OnClick := @IPMenuItemClick;
      FIPMenu.Items.Add(item);
    end;
    pt := btIPRede.ClientOrigin;
    FIPMenu.Popup(pt.X, pt.Y + btIPRede.Height);
  finally
    ifaces.Free;
  end;
end;

procedure TfTransmitir.IPMenuItemClick(Sender: TObject);
begin
  seSrvUrl.Text := TMenuItem(Sender).Hint;
end;

procedure TfTransmitir.bsSkinSpeedButton1Click(Sender: TObject);
begin
  seSrvToken.Text := geraToken();
  fmIndex.gravaParam('Servidor', 'Token', seSrvToken.Text);
end;

procedure TfTransmitir.btCopLinkBib1Click(Sender: TObject);
begin
  Clipboard.AsText := lblLinkBib1.Caption;
end;

procedure TfTransmitir.btCopLinkClick(Sender: TObject);
begin
  Clipboard.AsText := lblLink.Caption;
end;

procedure TfTransmitir.btCopLinkMus1Click(Sender: TObject);
begin
  Clipboard.AsText := lblLinkMus1.Caption;
end;

procedure TfTransmitir.btCopLinkMus2Click(Sender: TObject);
begin
  Clipboard.AsText := lblLinkMus2.Caption;
end;

procedure TfTransmitir.btServidorClick(Sender: TObject);
var
  url: string;
begin
  tentativaConexao := tentativaConexao+1;

  seSrvUrl.Enabled := True;
  seSrvPorta.Enabled := True;
  seSrvToken.Enabled := True;
  btIPRede.Enabled := True;
  fmIndex.spServer.Text {LAZARUS: TStatusPanel.Caption→.Text} := '';
  btServidor.Enabled := False;
  pararServidor; {LAZARUS: Active:=False + unblock do accept loop na thread}
  {LAZARUS: IdHTTPServer1.Bindings.Clear — TFPHttpServer não usa Bindings}
  lblStatus.Caption := 'Desconectado';

  lblLink.Caption := '';
  {LAZARUS: lblLink.URL removido — TLabel não tem propriedade URL}
  lblLinkMus1.Caption := '';
  {LAZARUS: lblLinkMus1.URL removido}
  lblLinkMus2.Caption := '';
  {LAZARUS: lblLinkMus2.URL removido}
  lblLinkBib1.Caption := '';
  {LAZARUS: lblLinkBib1.URL removido}

  if (btServidor.ImageIndex = 9) then
  begin
    btServidor.ImageIndex := 8;
    btServidor.Caption := 'Iniciar Servidor';
    btServidor.Enabled := True;
    tentativaConexao := 0;
  end
  else
  begin
    if (trim(seSrvUrl.Text) = '')
      then seSrvUrl.Text := fmIndex.GetIP;
    if (trim(seSrvPorta.Text) = '')
      then seSrvPorta.Text := '7070';
    if (StrToInt(seSrvPorta.Text) <= 0)
      then seSrvPorta.Text := '7070';
    if (trim(seSrvToken.Text) = '')
      then seSrvToken.Text := geraToken();


    IdHTTPServer1.Port := StrToInt(seSrvPorta.Text); {LAZARUS: DefaultPort→Port}
    {LAZARUS: Bindings removido — TFPHttpServer usa Port somente}
    try
      {LAZARUS: Active:=True bloqueia a thread chamadora — subir em thread dedicada
       e validar via probe HTTP (bind/porta ocupada cai no except → retry existente)}
      serverThread := THttpServerThread.Create(IdHTTPServer1);
      if not aguardaServidorAtivo then
        raise Exception.Create('Servidor nao respondeu na porta '+seSrvPorta.Text);
      btServidor.Enabled := True;
      btServidor.ImageIndex := 9;
      btServidor.Caption := 'Desconectar Servidor';
      seSrvUrl.Enabled := False;
      seSrvPorta.Enabled := False;
      seSrvToken.Enabled := False;
      btIPRede.Enabled := False;
      fmIndex.gravaParam('Servidor', 'URL', seSrvUrl.Text);
      fmIndex.gravaParam('Servidor', 'Porta', seSrvPorta.Text);
      fmIndex.gravaParam('Servidor', 'Token', seSrvToken.Text);

      url := 'http://'+seSrvUrl.Text+':'+seSrvPorta.Text;
      fmIndex.spServer.Text {LAZARUS: TStatusPanel.Caption→.Text} := url;
      lblStatus.Caption := 'Conectado';

      lblLink.Caption := url;
      {LAZARUS: lblLink.URL removido — TLabel não tem propriedade URL}
      lblLinkMus1.Caption := url+'/musica?transmissao';
      {LAZARUS: lblLinkMus1.URL removido}
      lblLinkMus2.Caption := url+'/musica?retorno';
      {LAZARUS: lblLinkMus2.URL removido}
      lblLinkBib1.Caption := url+'/biblia?transmissao';
      {LAZARUS: lblLinkBib1.URL removido}

      memo1.lines.savetofile(fmIndex.dir_config+'server/file/file.ja');
    except
      pararServidor;
      {LAZARUS: IdHTTPServer1.Bindings.Clear — TFPHttpServer não usa Bindings}
      btServidor.Enabled := True;

      if tentativaConexao < 3 then
      begin
        if (seSrvUrl.Text <> fmIndex.GetIP) then
        begin
          seSrvUrl.Text := fmIndex.GetIP;
          btServidorClick(Sender);
        end
        else
        begin
          seSrvPorta.Text := IntToStr(1 + Random(10000));
          btServidorClick(Sender);
        end;
      end
      else
      begin
        tentativaConexao := 0;
        Application.MessageBox(PChar('Erro ao iniciar servidor!'),fmIndex.TITULO,mb_ok+mb_iconerror);
      end;
    end;
  end;
end;

procedure TfTransmitir.ckSrvAltIPPortaClick(Sender: TObject);
begin
  if ckSrvAltIPPorta.Checked then
    fmIndex.gravaParam('Servidor', 'AltPortaIP', '1')
  else
    fmIndex.gravaParam('Servidor', 'AltPortaIP', '0');
end;

procedure TfTransmitir.ckSrvConectarClick(Sender: TObject);
begin
  if ckSrvConectar.Checked then
    fmIndex.gravaParam('Servidor', 'Conectar', '1')
  else
    fmIndex.gravaParam('Servidor', 'Conectar', '0');
end;

procedure TfTransmitir.Loaded;
{LAZARUS: ZeosLib param workaround — TZQuery em csLoading não cria params de SQL.
 Mesmo padrão de TDM.Loaded/TfLetra.Loaded.}
var
  i, j: Integer;
  sqlStr: TZSQLStrings;
  paramName: string;
begin
  inherited Loaded;
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TZQuery then
    begin
      sqlStr := TZSQLStrings(TZQuery(Components[i]).SQL);
      if sqlStr.ParamCount > 0 then
        for j := 0 to sqlStr.ParamCount - 1 do
        begin
          paramName := sqlStr.ParamNames[j];
          if TZQuery(Components[i]).Params.FindParam(paramName) = nil then
            TZQuery(Components[i]).Params.CreateParam(ftUnknown, paramName, ptUnknown);
        end;
    end;
end;

constructor THttpServerThread.Create(AServer: TFPHttpServer);
begin
  inherited Create(False);
  FServer := AServer;
  FreeOnTerminate := True;
end;

procedure THttpServerThread.Execute;
begin
  try
    FServer.Active := True; {bloqueia até Active:=False/erro — por isso a thread}
  except
    {socket fechado na desativação — ignorar}
  end;
end;

procedure TfTransmitir.FormCreate(Sender: TObject);
begin
  {LAZARUS: TIdHTTPServer removido do LFM — criar TFPHttpServer programaticamente}
  IdHTTPServer1 := TFPHttpServer.Create(Self);
  IdHTTPServer1.OnRequest := @IdHTTPServer1CommandGet;
  serverThread := nil;
end;

procedure TfTransmitir.pararServidor;
var
  cli: TFPHTTPClient;
begin
  if serverThread = nil then Exit;
  IdHTTPServer1.Active := False;
  {LAZARUS: o accept bloqueante só percebe Active=False na próxima conexão —
   conexão dummy desbloqueia a thread, que termina sozinha (FreeOnTerminate)}
  cli := TFPHTTPClient.Create(nil);
  try
    try
      cli.ConnectTimeout := 500;
      cli.IOTimeout := 500;
      cli.Get('http://127.0.0.1:'+IntToStr(IdHTTPServer1.Port)+'/api/ping');
    except
      {esperado — servidor desativando}
    end;
  finally
    cli.Free;
  end;
  serverThread := nil;
end;

function TfTransmitir.aguardaServidorAtivo: Boolean;
var
  cli: TFPHTTPClient;
  i: Integer;
begin
  Result := False;
  for i := 1 to 20 do
  begin
    Sleep(100);
    Application.ProcessMessages;
    cli := TFPHTTPClient.Create(nil);
    try
      try
        cli.ConnectTimeout := 500;
        cli.IOTimeout := 500;
        cli.Get('http://127.0.0.1:'+seSrvPorta.Text+'/api/ping');
        Result := True;
      except
        {servidor ainda subindo — tentar de novo}
      end;
    finally
      cli.Free;
    end;
    if Result then Exit;
  end;
end;

procedure TfTransmitir.FormActivate(Sender: TObject);
begin
  tentativaConexao := 0;
end;

procedure TfTransmitir.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

function TfTransmitir.geraToken: string;
const
  CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
var
  i: Integer;
begin
  Randomize;
  Result := '';
  for i := 1 to 5 do
    Result := Result + CHARS[Random(Length(CHARS)) + 1];
end;

procedure TfTransmitir.IdHTTPServer1CommandGet(Sender: TObject;
  var ARequest: TFPHTTPConnectionRequest; var AResponse: TFPHTTPConnectionResponse); {LAZARUS: TIdHTTPServer→TFPHttpServer}
var
  url:string;
  arq:string;
  txt: TStringList;
  songId: Integer;
  tagValue: Integer;
  txtModo: string;
  tocarAudio: Boolean;
  messageDraw: string;
  messageStopwatch: string;
  messageSlide: string;
  attemptCount: Integer;
  success: Boolean;
  isLocalRequest: Boolean;
  keyCode: Integer;
  I: Integer;
  searchTerm: String;
  jsonResult: String;
  primeiro: Boolean;
begin
  // Allow cross-origin requests from web applications
  AResponse.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
  AResponse.CustomHeaders.Values['Access-Control-Allow-Methods'] := 'GET, OPTIONS';

  arq := ARequest.URI;
  arq := Trim(arq);
  {LAZARUS: ARequest.URI pode incluir query string (ex: /api/ping?token=x) — extrair só o path}
  if Pos('?', arq) > 0 then
    arq := Copy(arq, 1, Pos('?', arq) - 1);
  if (arq <> '/') and (Length(arq) > 0) and (arq[Length(arq)] = '/') then
    Delete(arq, Length(arq), 1);

  // Requests via localhost (127.0.0.1) are trusted — only processes on the
  // same machine can reach this binding. Token is only required for network access.
  // AContext.Binding.IP returns the server-side socket address (getsockname),
  // which cannot be spoofed by a remote client.
  isLocalRequest := (ARequest.RemoteAddress = '127.0.0.1'); {LAZARUS: AContext.Binding.IP→RemoteAddress}

  if Pos('/api', arq) = 1 then
  begin
    AResponse.ContentType := 'application/json';
    {LAZARUS: CharSet não disponível em TFPHTTPConnectionResponse}

    // Validação de token (somente se não for localhost)
    if (not isLocalRequest) and
      (ARequest.QueryFields.Values['token'] <>
        fmIndex.lerParam('Servidor', 'Token','')) then
    begin
      AResponse.Code := 401;
      AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
        '{"status":"error","message":"Invalid token","code":"INVALID_TOKEN"}';
      Exit;
    end;

    // API: Health check endpoint (used by web apps to detect if LouvorJA is running)
    if arq = '/api/ping' then
    begin
      AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","app":"LouvorJA"}';
      Exit;
    end;

    // API: Simulate keyboard key press
    // Usage: /api/keyboard?key=13
    if arq = '/api/keyboard' then
    begin
      keyCode := StrToIntDef(ARequest.QueryFields.Values['key'], -1);

      if keyCode = -1 then
      begin
        AResponse.Code := 400;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"error","message":"Missing or invalid key","code":"INVALID_KEY"}';
        Exit;
      end;

      // Executa no thread da UI
      {LAZARUS: TThread.Queue com proc anônima não suportado em FPC 3.2.2 — SetForegroundWindow removido}

      AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
        '{"status":"ok","action":"keyboard","key":' + IntToStr(keyCode) + '}';

      Exit;
    end;

    // API: Change to next slide or previous slide and get status slides
    if arq = '/api/song-slides' then
    begin
      if (ARequest.QueryFields.Values['action'] = 'next') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          {LAZARUS: acaoSlide modifica UI — Synchronize garante execução na main thread}
          TThread.Synchronize(nil, @SyncNextSlide);
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","message":"Advanced to the next slide","code":"ADVANCED_SLIDE"}';
          Exit;
        end
        else
        begin
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequest.QueryFields.Values['action'] = 'previous') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          {LAZARUS: Synchronize para thread-safety}
          TThread.Synchronize(nil, @SyncPreviousSlide);
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"ok","message":"Reverted to the previous slide"}';
          Exit;
        end
        else
        begin
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequest.QueryFields.Values['action'] = 'playing-check') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"ok","message":"Song playing","code":"SONG_PLAYING"}';
          Exit;
        end
        else
        begin
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequest.QueryFields.Values['action'] = 'get-slide') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          messageSlide := '';

          if (ARequest.QueryFields.Values['slide'] = 'current') then
          begin
            messageSlide := fMusica.lblLetra.Caption;
          end
          else if (ARequest.QueryFields.Values['slide'] = 'next') then
          begin
            if (fMusica.lbLetras.Items.Count > fMusica.nslide) then
              messageSlide := fMusica.lbLetras.Items[fMusica.nslide]
            else
              messageSlide := '< FIM >';
          end;

          messageSlide := StringReplace(messageSlide, '"', '\"', [rfReplaceAll]);

          messageSlide := StringReplace(messageSlide, #13#10, '\n', [rfReplaceAll]);
          messageSlide := StringReplace(messageSlide, #13, '\n', [rfReplaceAll]);
          messageSlide := StringReplace(messageSlide, #10, '\n', [rfReplaceAll]);

          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","message":"' + messageSlide + '","code":"SONG_PLAYING"}';
          Exit;
        end
        else
        begin
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","message":"","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequest.QueryFields.Values['action'] = 'close') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          {LAZARUS: Close mexe em forms/GTK2 — rodar na main thread}
          TThread.Synchronize(nil, @SyncCloseSong);
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"ok","message":"Song closed","code":"SONG_CLOSED"}';
          Exit;
        end
        else
        begin
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else
      begin
        AResponse.Code := 400;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"error","message":"Missing or invalid action. Usage example: /api/song-slides?action=next","code":"MISSING_ACTION"}';
      end;
      Exit;
    end;

    // API: Gets the time of the computer where Louvor JA is
    if arq = '/api/clock' then
    begin
      AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
        '{"status":"ok","hour":"' + formatdatetime('hh:mm:ss', now()) + '"}';
      Exit;
    end;

    // API: Control Drawing number
    if arq = '/api/drawing-number' then
    begin
      if (ARequest.QueryFields.Values['action'] = 'get-last') then
      begin
        attemptCount := 0;
        success := False;

        while (attemptCount < 3) do
        begin
          if (fmIndex.btSortear.Enabled) then
          begin
            messageDraw := fmIndex.lmdSorteio.Caption;
            AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"get-last","message":"' + messageDraw + '"}';
            success := True;
            Break;
          end
          else
          begin
            Inc(attemptCount);
            Sleep(1000);
          end;
        end;

        if not success then
        begin
          AResponse.Code := 400;
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"error","message":"Failed after 3 attempts, button not enabled","code":"BUTTON_NOT_ENABLED"}';
        end;
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'draw') then
      begin

        if fmIndex.lbSorteio.Items.Count = 0 then
        begin
          AResponse.Code := 400;
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"error","message":"Nenhum participante adicionado ao sorteio","code":"EMPTY_PARTICIPANTS"}';
          Exit;
        end;

        {LAZARUS: btSortearClick mexe na UI — rodar na main thread}
        TThread.Synchronize(nil, @SyncSortear);

        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"ok","message":"Sorteando número"}';

        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'get-participants') then
      begin

        messageDraw := '';

        for I := 0 to fmIndex.lbSorteio.Items.Count - 1 do
        begin
          if messageDraw <> '' then
            messageDraw := messageDraw + ', ';

          messageDraw := messageDraw + fmIndex.lbSorteio.Items[I]; {LAZARUS: .Caption removido — TCheckListBox.Items[I] é String}
        end;

        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"participants","message":"' + StringReplace(messageDraw, '"', '\"', [rfReplaceAll]) +'"}';

        Exit;
      end
      else
      begin
        AResponse.Code := 400;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"error","message":"Missing or invalid action. Usage example: /api/drawing-number?action=draw","code":"MISSING_ACTION"}';
      end;
      Exit;
    end;

    // API: Control Drawing name
    if arq = '/api/drawing-name' then
    begin
      if (ARequest.QueryFields.Values['action'] = 'get-last') then
      begin
        attemptCount := 0;
        success := False;

        while (attemptCount < 3) do
        begin
          if (fmIndex.btSortearNM.Enabled) then
          begin
            messageDraw := fmIndex.lmdSorteioNM.Caption;
            AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"get-last","message":"' + messageDraw + '"}';
            success := True;
            Break;
          end
          else
          begin
            Inc(attemptCount);
            Sleep(1000);
          end;
        end;

        if not success then
        begin
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"error","message":"Failed after 3 attempts, button not enabled","code":"BUTTON_NOT_ENABLED"}';
        end;
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'draw') then
      begin

        if fmIndex.lbSorteioNM.Items.Count = 0 then
        begin
          AResponse.Code := 400;
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
            '{"status":"error","message":"Nenhum nome adicionado ao sorteio","code":"EMPTY_PARTICIPANTS"}';
          Exit;
        end;

        {LAZARUS: btSortearNMClick mexe na UI — rodar na main thread}
        TThread.Synchronize(nil, @SyncSortearNM);

        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"ok","message":"Sorteando nome"}';

        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'get-participants') then
      begin

        messageDraw := '';

        for I := 0 to fmIndex.lbSorteioNM.Items.Count - 1 do
        begin
          if messageDraw <> '' then
            messageDraw := messageDraw + ', ';

          messageDraw := messageDraw + fmIndex.lbSorteioNM.Items[I]; {LAZARUS: .Caption removido}
        end;

        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"participants","message":"' + StringReplace(messageDraw, '"', '\"', [rfReplaceAll]) +'"}';

        Exit;
      end
      else
      begin
        AResponse.Code := 400;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"error","message":"Missing or invalid action. Usage example: /api/drawing-name?action=draw","code":"MISSING_ACTION"}';
      end;
      Exit;
    end;

    // API: Control stopwatch
    if arq = '/api/stopwatch' then
    begin
      if (ARequest.QueryFields.Values['action'] = 'get-time') then
      begin
        {LAZARUS: lmdCrono.Caption é uma propriedade GTK2 — leitura deve ser na main thread}
        TThread.Synchronize(nil, @SyncGetCronoCaption);
        messageStopwatch := syncCronoCaption;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"get-time","message":"' + messageStopwatch + '"}';
        success := True;
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'start') then
      begin
        {LAZARUS: TThread.Synchronize garante que btIniciarCronoClick rode na main thread
         — DM.tmrCrono.Enabled e DoubleBuffered não são thread-safe em GTK2/LCL}
        TThread.Synchronize(nil, @SyncStartCrono);
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"ok","action":"start","message":"Iniciando cron' + #$C3#$B4 + 'metro"}';
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'stop') then
      begin
        {LAZARUS: mesmo — Synchronize para thread-safety}
        TThread.Synchronize(nil, @SyncStopCrono);
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"ok","action":"stop","message":"Parando e zerando cron' + #$C3#$B4 + 'metro"}';
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'note') then
      begin
        {LAZARUS: Synchronize para thread-safety}
        TThread.Synchronize(nil, @SyncAnotaTempo);
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"note","message":"Anotando tempo"}';
        Exit;
      end
      else
      begin
        AResponse.Code := 400;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"error","message":"Missing or invalid action. Usage example: /api/stopwatch?action=start","code":"MISSING_ACTION"}';
      end;
    end;

    // API: Search songs by title or author
    // Usage: GET /api/search-songs?q=termo
    if arq = '/api/search-songs' then
    begin
        searchTerm := Trim(ARequest.QueryFields.Values['q']);

        if searchTerm = '' then
        begin
            AResponse.Code := 400;
            AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
                '{"status":"error","message":"Missing search term","code":"MISSING_SEARCH_TERM"}';
            Exit;
        end;

        {LAZARUS: qrBUSCA usa DM.ADO (ZeosLib, main thread) — query roda via Synchronize}
        syncSearchTerm := searchTerm;
        TThread.Synchronize(nil, @SyncSearchSongs);
        if syncSearchOk then
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := syncSearchJson
        else
        begin
          AResponse.Code := 503;
          AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := syncSearchJson;
        end;

        Exit;
    end;

    // API: Open a song slide by its database ID
    // Usage: GET /api/open-song?id=123
    if arq = '/api/open-song' then
    begin
      if TryStrToInt(ARequest.QueryFields.Values['id'], songId) then
      begin
        if not TryStrToInt(ARequest.QueryFields.Values['tag'], tagValue) then
          tagValue := 1;

        if tagValue = 2 then
          txtModo := 'PB'
        else
          txtModo := '';

        tocarAudio := tagValue < 3;

        {LAZARUS: abreLetraMusica cria forms/toca GTK2 — precisa rodar na main thread.
         FPC 3.2 não tem closures p/ Synchronize: parâmetros vão em campos sync*}
        if Assigned(fmIndex) then
        begin
          syncSongId := songId;
          syncTxtModo := txtModo;
          syncTocarAudio := tocarAudio;
          TThread.Synchronize(nil, @SyncOpenSong);
        end;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"ok","action":"open-song","id":' + IntToStr(songId) + '}';
      end
      else
      begin
        AResponse.Code := 400;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} :=
          '{"status":"error","message":"Missing or invalid song ID. Usage example: /api/open-song?id=123","code":"MISSING_ID"}';
      end;
      Exit;
    end;
  end;

  // Static file serving (existing behavior)
  if (arq = '') or (arq = '/') then
    arq := '/index.html';

  if (arq = '/musica') or (arq = '/biblia') then
    arq := '/mirror.html';

  url := fmIndex.dir_config+'server'+arq;
  if not FileExists(url) then
  begin
    arq := '/404.html';
    url := fmIndex.dir_config+'server'+arq;
    AResponse.Code := 404; {LAZARUS: fix — 404 pages devem retornar HTTP 404, não 200}
  end;
  txt := TStringList.Create;
  try
    txt.LoadFromFile(url);
    AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := txt.Text;
  finally
    txt.Free;
  end;
end;

procedure TfTransmitir.seSrvTokenExit(Sender: TObject);
begin
  fmIndex.gravaParam('Servidor', 'Token', seSrvToken.Text);
end;

procedure TfTransmitir.seSrvUrlExit(Sender: TObject);
begin
  seSrvUrl.Text := StringReplace(seSrvUrl.Text,'http://','',[rfIgnoreCase, rfReplaceAll]);
  seSrvUrl.Text := StringReplace(seSrvUrl.Text,'https://','',[rfIgnoreCase, rfReplaceAll]);
  //192.168.56.1
end;


{LAZARUS: métodos sync — executam código LCL na main thread via TThread.Synchronize.
 Garante thread-safety quando chamados de TFPHttpServer (background thread).}

procedure TfTransmitir.SyncStartCrono;
begin
  {LAZARUS: cbFormatoTempoCrono só é populado quando o tab Cronômetro é aberto.
   Se o tab ainda não foi aberto, inicializa o combo com um formato padrão para
   evitar EStringListError: List index (-1) em btZerarCronoClick/tmrCronoTimer.}
  if fmIndex.cbFormatoTempoCrono.Items.Count = 0 then
    fmIndex.carregaComboFormatoTempo(fmIndex.cbFormatoTempoCrono, 'hh:mm:ss.zzz');
  fmIndex.btIniciarCronoClick(fmIndex.btIniciarCrono);
  {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
  Application.ProcessMessages;
end;

procedure TfTransmitir.SyncStopCrono;
begin
  try
    fmIndex.btZerarCronoClick(fmIndex.btZerarCrono);
    {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
    Application.ProcessMessages;
  except
    {silently ignore}
  end;
end;

procedure TfTransmitir.SyncAnotaTempo;
begin
  try
    fmIndex.btAnotTempoClick(fmIndex.btAnotTempo);
    {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
    Application.ProcessMessages;
  except
    {silently ignore}
  end;
end;

procedure TfTransmitir.SyncGetCronoCaption;
begin
  syncCronoCaption := fmIndex.lmdCrono.Caption;
end;

procedure TfTransmitir.SyncOpenSong;
begin
  fmIndex.abreLetraMusica('BD', syncTxtModo, syncSongId, syncTocarAudio);
  {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
  Application.ProcessMessages;
end;

procedure TfTransmitir.SyncCloseSong;
begin
  if (fMusica <> nil) and (fMusica.Visible) then
    fMusica.Close;
  {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
  Application.ProcessMessages;
end;

procedure TfTransmitir.SyncSortear;
begin
  fmIndex.btSortearClick(fmIndex.btSortear);
  {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
  Application.ProcessMessages;
end;

procedure TfTransmitir.SyncSortearNM;
begin
  fmIndex.btSortearNMClick(fmIndex.btSortear);
  {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
  Application.ProcessMessages;
end;

procedure TfTransmitir.SyncSearchSongs;
var
  primeiro: Boolean;
begin
  syncSearchOk := False;
  try
    qrBUSCA.Close;
    qrBUSCA.ParamByName('VALOR').AsString := fmIndex.termo_busca(syncSearchTerm);
    qrBUSCA.Open;

    syncSearchJson := '{"status":"ok","musicas":[';
    primeiro := True;

    while not qrBUSCA.Eof do
    begin
      if not primeiro then
        syncSearchJson := syncSearchJson + ',';
      primeiro := False;

      syncSearchJson := syncSearchJson + '{';
      syncSearchJson := syncSearchJson + '"id":' + qrBUSCA.FieldByName('ID').AsString + ',';
      syncSearchJson := syncSearchJson + '"nome":"' + StringReplace(qrBUSCA.FieldByName('NOME').AsString, '"', '\"', [rfReplaceAll]) + '",';
      syncSearchJson := syncSearchJson + '"album":"' + StringReplace(qrBUSCA.FieldByName('NOME_ALBUM_COM').AsString, '"', '\"', [rfReplaceAll]) + '"';
      syncSearchJson := syncSearchJson + '}';

      qrBUSCA.Next;
    end;

    syncSearchJson := syncSearchJson + ']}';
    syncSearchOk := True;
  except
    on E: Exception do
      syncSearchJson := '{"status":"error","message":"' +
        StringReplace(E.Message, '"', '\"', [rfReplaceAll]) +
        '","code":"SEARCH_ERROR"}';
  end;
end;

procedure TfTransmitir.SyncNextSlide;
begin
  if (fMusica <> nil) and (fMusica.Visible) then
  begin
    fMusica.acaoSlide('prox');
    {LAZARUS: dentro de Synchronize o GTK2 não processa a fila de paint sozinho —
     sem isso a projeção só repinta no próximo evento de input do usuário}
    Application.ProcessMessages;
  end;
end;

procedure TfTransmitir.SyncPreviousSlide;
begin
  if (fMusica <> nil) and (fMusica.Visible) then
  begin
    fMusica.acaoSlide('ant');
    {LAZARUS: ver SyncNextSlide — flush da fila de paint do GTK2}
    Application.ProcessMessages;
  end;
end;

initialization
  {$I fmTransmitir.lrs}

end.
