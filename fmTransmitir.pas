unit fmTransmitir;

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/Indy/FireDAC}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Menus, Spin, DB, Clipbrd, Grids,
  FPHTTPServer, FPHTTPClient, ZDataset,
  LCLIntf, LCLType, LMessages, LResources;

type
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

procedure TfTransmitir.btIPRedeClick(Sender: TObject);
begin
  seSrvUrl.Text := fmIndex.GetIP;
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
  IdHTTPServer1.Active := False;
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
      IdHTTPServer1.Active := True;
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
      IdHTTPServer1.Active := False;
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

procedure TfTransmitir.FormCreate(Sender: TObject);
begin
  {LAZARUS: TIdHTTPServer removido do LFM — criar TFPHttpServer programaticamente}
  IdHTTPServer1 := TFPHttpServer.Create(Self);
  IdHTTPServer1.OnRequest := @IdHTTPServer1CommandGet;
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
  if (arq <> '/') and arq.EndsWith('/') then
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
          fMusica.acaoSlide('prox');
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
          fMusica.acaoSlide('ant');
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
          fMusica.Close;
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

        fmIndex.btSortearClick(fmIndex.btSortear);

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

        fmIndex.btSortearNMClick(fmIndex.btSortear);

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
        messageStopwatch := fmIndex.lmdCrono.Caption;
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"get-time","message":"' + messageStopwatch + '"}';
        success := True;
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'start') then
      begin
        fmIndex.btIniciarCronoClick(fmIndex.btIniciarCrono);
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"start","message":"Iniciando cronÃ´metro"}';
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'stop') then
      begin
        fmIndex.btZerarCronoClick(fmIndex.btZerarCrono);
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := '{"status":"ok","action":"stop","message":"Parando e zerando cronÃ´metro"}';
        Exit;
      end
      else if (ARequest.QueryFields.Values['action'] = 'note') then
      begin
        fmIndex.btAnotTempoClick(fmIndex.btAnotTempo);
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

        qrBUSCA.Close;
        qrBUSCA.ParamByName('VALOR').AsString := fmIndex.termo_busca(searchTerm);
        qrBUSCA.Open;

        jsonResult := '{"status":"ok","musicas":[';
        primeiro := True;

        while not qrBUSCA.Eof do
        begin
            if not primeiro then
                jsonResult := jsonResult + ',';
            primeiro := False;

            jsonResult := jsonResult + '{';
            jsonResult := jsonResult + '"id":' + qrBUSCA.FieldByName('ID').AsString + ',';
            jsonResult := jsonResult + '"nome":"' + StringReplace(qrBUSCA.FieldByName('NOME').AsString, '"', '\"', [rfReplaceAll]) + '",';
            jsonResult := jsonResult + '"album":"' + StringReplace(qrBUSCA.FieldByName('NOME_ALBUM_COM').AsString, '"', '\"', [rfReplaceAll]) + '"';
            jsonResult := jsonResult + '}';

            qrBUSCA.Next;
        end;

        jsonResult := jsonResult + ']}';
        AResponse.Content {LAZARUS: ContentText→Content (TFPHTTPConnectionResponse)} := jsonResult;

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

        {LAZARUS: TThread.Queue proc anônima → chamada direta (FPC 3.2.2 não suporta TProc overload)}
        if Assigned(fmIndex) then
          fmIndex.abreLetraMusica('BD', txtModo, songId, tocarAudio);
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


initialization
  {$I fmTransmitir.lrs}

end.
