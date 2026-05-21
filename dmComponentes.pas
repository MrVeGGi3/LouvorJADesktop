unit dmComponentes;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos FireDAC.*, Datasnap.*, Data.Win.ADODB, bsSkin*, Vcl.*, Windows, Indy}
  {LAZARUS: TFDConnection→TZConnection, TFDQuery→TZQuery, TClientDataSet→TBufDataset}
  {LAZARUS: TIdHTTP→TFPHTTPClient, TbsPngImageList→TImageList, skin dialogs→LCL dialogs}
  SysUtils, Classes, ExtCtrls, LCLIntf, LCLType,
  Forms, Dialogs, DB, BufDataset, ImgList, Controls, Menus, ExtDlgs,
  FileCtrl, Graphics, StdCtrls,
  ZConnection, ZDataset,
  FPHTTPClient, opensslsockets,
  base64, LResources; {LAZARUS: LResources necessario para include .lrs}

type
  TDM = class(TDataModule)
    tmrSortearNM: TTimer;
    tmrSair: TTimer;
    tmrRelogio: TTimer;
    tmrVersao: TTimer;
    tmrSortear: TTimer;
    tmrSorteio: TTimer;
    tmrCrono: TTimer;
    tmrMediaPlayer: TTimer;
    qrALBUNS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrMUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSEL_MUSICAS_IDMUS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrONL_CANAIS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    ADOQuery: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrLETRA_MUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrONL_PLAYLISTS_TUDO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrONL_VIDEOS_TUDO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrHINOS_LITURGIA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSEL_COLETANEAS_ID: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrVERSAO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrMUSICAS_INFANTIS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSLIDE_MUSICA_ALBUM: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrONL_PLAYLISTS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBIBLIA_LIVROS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrHINOS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBIBLIA_VERSAO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrDOXOLOGIA_CATE: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrLETRA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBUSCA_MAX_CAPITULOS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSLIDE_MUSICA_GRAVA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrONL_VIDEOS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBUSCA_MAX_VERSOS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBUSCA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrMUSICAS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSLIDE_MUSICA_TEMPOS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSLIDE_MUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    ADO: TZConnection; {LAZARUS: TFDConnection→TZConnection}
    cdsVideosOnPerso: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    StringField3: TStringField;
    StringField5: TStringField;
    StringField7: TStringField;
    cdsVideosOnPersoVIDEOID: TStringField;
    cdsFavoritos: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    StringField6: TStringField;
    cdsFavoritosNOME: TStringField;
    cdsFavoritosNOME_ABA: TStringField;
    cdsFavoritosIMAGEM: TIntegerField;
    cdsFavoritosORDEM: TIntegerField;
    cdsSLIDE_MUSICA2: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    cdsItensAgendadosClone: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    cdsSLIDE_MUSICA: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    cdsItensAgendados: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    cdsCategoriasItensAgendados: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    cdsCOLETANEAS_PERSO: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    cdsCOLETANEAS_PERSOID: TStringField;
    cdsCOLETANEAS_PERSONOME: TStringField;
    cdsCOLETANEAS_PERSOURL_INFO: TStringField;
    cdsCOLETANEAS_PERSOURL: TStringField;
    cdsCOLETANEAS_PERSOIMAGEM_INFO: TStringField;
    cdsCOLETANEAS_PERSOIMAGEM: TStringField;
    dsLETRA_MUSICA: TDataSource;
    dsFavoritos: TDataSource;
    dsMUSICAS: TDataSource;
    dsSLIDE_MUSICA: TDataSource;
    dsBIBLIA_LIVROS: TDataSource;
    dsVideosOnPerso: TDataSource;
    dsMUSICAS_INFANTIS: TDataSource;
    dsItensAgendados: TDataSource;
    dsItensAgendadosClone: TDataSource;
    dsBIBLIA_VERSAO: TDataSource;
    dsCOLETANEAS_PERSO: TDataSource;
    dsSLIDE_MUSICA2: TDataSource;
    dsHINOS: TDataSource;
    dsHINOS_LITURGIA: TDataSource;
    dsBUSCA: TDataSource;
    dsCategoriasItensAgendados: TDataSource;
    dsBD: TDataSource;
    {LAZARUS: TIdDecoderMIME/TIdEncoderMIME removidos — usar base64 unit diretamente}
    FHttp: TFPHTTPClient; {LAZARUS: TIdHTTP→TFPHTTPClient}
    DirectoryDialog: TSelectDirectoryDialog; {LAZARUS: TbsSkinSelectDirectoryDialog→TSelectDirectoryDialog}
    SaveDialog_: TSaveDialog; {LAZARUS: TbsSkinSaveDialog→TSaveDialog}
    {LAZARUS: progressDialog (TbsSkinProgressDialog) removido — usar FDownloadProgress/FDownloadTotal}
    {LAZARUS: bsSkinData1+bsCompressedSkinList1 removidos — sem equivalente necessário}
    imCapas: TImageList;
    ico_janela_hot: TImageList;
    ico_albuns: TImageList;
    ico_janela_dis: TImageList;
    ico_on_canais: TImageList;
    ico_janela: TImageList;
    ico_janela_clk: TImageList;
    ico_on_playlists: TImageList;
    ico_doxologia: TImageList;
    ico_on_videos: TImageList;
    ico_16x16: TImageList; {LAZARUS: TbsPngImageList→TImageList}
    ico_64x64: TImageList; {LAZARUS: TbsPngImageList→TImageList}
    ico_24x24: TImageList; {LAZARUS: TbsPngImageList→TImageList}
    ico_40x40: TImageList; {LAZARUS: TbsPngImageList→TImageList}
    OpenDialog: TOpenDialog;
    OpenPictureDialog: TOpenPictureDialog;
    OpenTextFileDialog: TOpenDialog; {LAZARUS: TOpenTextFileDialog→TOpenDialog}
    ColorDialog: TColorDialog;
    SaveDialog: TSaveDialog;
    SaveTextFileDialog: TSaveDialog; {LAZARUS: TSaveTextFileDialog→TSaveDialog}
    SavePictureDialog: TSavePictureDialog;
    qrARQUIVOS_HELP_DELETE: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrARQUIVOS_HELP: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBD: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    tmrBusca: TTimer;
    {LAZARUS: PasswordDialog (TbsSkinPasswordDialog) removido — usar InputQuery diretamente}
    qrBIBLIA_CAPITULOS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    dsBIBLIA_CAPITULOS: TDataSource;
    qrBIBLIA_VERSICULOS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    dsBIBLIA_VERSICULOS: TDataSource;
    cdsBIBLIA_HISTORICO: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    dsBIBLIA_HISTORICO: TDataSource;
    cdsBIBLIA_HISTORICOVERSAO: TStringField;
    cdsBIBLIA_HISTORICOLIVRO: TIntegerField;
    cdsBIBLIA_HISTORICOCAPITULO: TIntegerField;
    cdsBIBLIA_HISTORICOPASSAGEM: TStringField;
    cdsBIBLIA_HISTORICODATAHORA: TDateTimeField;
    cdsBIBLIA_HISTORICOID: TStringField;
    cdsBIBLIA_HISTORICOBRANCO: TStringField;
    qrBIBLIA_BUS_LIVROS: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    dsBIBLIA_BUSCA: TDataSource;
    qrBIBLIA_BUSCA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBIBLIA_VERSAO_2: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    dsBIBLIA_VERSAO_2: TDataSource;
    {LAZARUS: pwd (TbsSkinPasswordDialog) removido — usar InputQuery diretamente}
    cdsBIBLIA_HISTORICOVERSICULO: TStringField;
    cdsBIBLIA_HISTORICODESC_PASSAGEM: TStringField;
    qrALBUM_ATIV: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    dsALBUM_ATIV: TDataSource;
    qrDEL_ALBUM_IGNORAR: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrADD_ALBUM_IGNORAR: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrALBUM_INATIV: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    dsALBUM_INATIV: TDataSource;
    qrARQUIVOS_SISTEMA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrGRAVA_TAMANHO_ARQUIVO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrINSERE_LETRA_MUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    cdsArquivos: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    dsArquivos: TDataSource;
    tmrPlayer: TTimer;
    qrALTERA_LETRA_MUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSELECT_LETRA_MUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrINSERE_MUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrSELECT_MAX_MUSICA: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrINSERE_MUSICA_ALBUM: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    ico_flags: TImageList; {LAZARUS: TbsPngImageList→TImageList}
    {LAZARUS: TIdSSLIOHandlerSocketOpenSSL removido — SSL via opensslsockets (FPHTTPClient)}
    qrHINOSN: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    dsHINOSN: TDataSource;
    qrMUSICA_ATUALIZAR: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrALBUM_IGNORAR: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    cdsCOLETANEAS_PERSO_IMP: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    StringField1: TStringField;
    StringField2: TStringField;
    StringField4: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    qrDEL_COLETANEAS_PERSO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrADD_COLETANEAS_PERSO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    cdsMonitores: TBufDataset; {LAZARUS: TClientDataSet→TBufDataset}
    StringField11: TStringField;
    cdsMonitoresTOP: TIntegerField;
    cdsMonitoresWIDTH: TIntegerField;
    cdsMonitoresHEIGHT: TIntegerField;
    cdsMonitoresNUM: TIntegerField;
    cdsMonitoresLEFT: TIntegerField;
    dsMonitores: TDataSource;
    cdsMonitoresX: TStringField;
    qrBUSCA_VERSAO: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    qrBUSCA_VERSAO_1: TZQuery; {LAZARUS: TFDQuery→TZQuery}
    procedure tmrSortearTimer(Sender: TObject);
    procedure tmrSortearNMTimer(Sender: TObject);
    procedure tmrSorteioTimer(Sender: TObject);
    procedure tmrCronoTimer(Sender: TObject);
    procedure tmrMediaPlayerTimer(Sender: TObject);
    procedure tmrSairTimer(Sender: TObject);
    procedure tmrRelogioTimer(Sender: TObject);
    procedure tmrVersaoTimer(Sender: TObject);
    procedure ClientDataSetSaveToFile(DataSet: TDataSet);
    procedure progressDialogCancel(Sender: TObject);
    procedure HttpWorkBegin(TotalBytes: Int64); {LAZARUS: TIdHTTP.OnWorkBegin→HttpWorkBegin}
    procedure HttpWork(CurrentBytes: Int64); {LAZARUS: TIdHTTP.OnWork→HttpWork}
    procedure ppVideosOnPersoPopup(Sender: TObject);
    procedure bsPopupMenuFavoritosPopup(Sender: TObject);
    procedure tmrBuscaTimer(Sender: TObject);
    procedure tmrPlayerTimer(Sender: TObject);
  private
    FDownloadProgress: Int64; {LAZARUS: substitui progressDialog.Value}
    FDownloadTotal: Int64; {LAZARUS: substitui progressDialog.MaxValue}
    FDownloadCanceled: Boolean;
  public
    property DownloadProgress: Int64 read FDownloadProgress;
    property DownloadTotal: Int64 read FDownloadTotal;
    property DownloadCanceled: Boolean read FDownloadCanceled write FDownloadCanceled;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Controls.TControl'} {LAZARUS: removido prefixo Vcl.}

uses fmMenu, fmArquivosFalta, fmHelp, fmIniciando, fmTransmitir,
  fmMonitorRelogio, fmMonitorCronometro, fmMonitorSorteioNomes,
  fmMonitorSorteio, fmMonitorCronometroCulto,
  bass; {LAZARUS: BASS audio — BASS_ChannelGetPosition, BASS_ChannelGetLength, BASS_ChannelStop}

procedure TDM.bsPopupMenuFavoritosPopup(Sender: TObject);
begin
  if not DM.cdsFavoritos.Active then
    fmIndex.carregaFavoritos;
end;

procedure TDM.ClientDataSetSaveToFile(DataSet: TDataSet);
var
  nome,arquivo:string;
begin
  nome := DataSet.Name;
  if nome = 'cdsCategoriasItensAgendados'
    then arquivo := fmIndex.dir_dados + 'itensAgendadosCategorias.xml'
  else if nome = 'cdsItensAgendados'
    then arquivo := fmIndex.dir_dados + 'itensAgendados.xml'
  else if nome = 'cdsCOLETANEAS_PERSO'
    then arquivo := fmIndex.dir_dados + 'coletaneasUsuario.xml'
  else if nome = 'cdsFavoritos'
    then arquivo := fmIndex.dir_dados + 'favoritos.xml'
  else if nome = 'cdsVideosOnPerso'
    then arquivo := fmIndex.dir_dados + 'videosOnUsuario.xml';

  {LAZARUS: MergeChangeLog removido — TBufDataset confirma edições automaticamente no SaveToFile}
  TBufDataset(FindComponent(nome)).SaveToFile(arquivo);

  if nome = 'cdsItensAgendados'
    then cdsItensAgendadosClone.LoadFromFile(arquivo);
end;

procedure TDM.HttpWork(CurrentBytes: Int64);
{LAZARUS: ex-IdHTTP1Work — chamado manualmente durante download com FPHTTPClient}
begin
  if CurrentBytes >= FDownloadTotal then
    FDownloadTotal := CurrentBytes + 1;
  FDownloadProgress := CurrentBytes;
  fmIndex.Buffer := CurrentBytes;
end;

procedure TDM.HttpWorkBegin(TotalBytes: Int64);
{LAZARUS: ex-IdHTTP1WorkBegin — chamado antes de iniciar download com FPHTTPClient}
begin
  if TotalBytes > 0 then
    FDownloadTotal := TotalBytes;
  FDownloadProgress := 0;
  FDownloadCanceled := False;
end;

procedure TDM.ppVideosOnPersoPopup(Sender: TObject);
begin
  if DM.cdsVideosOnPerso.Active = false then
  begin
    Abort;
    Exit;
  end;
  if DM.cdsVideosOnPerso.RecordCount <= 0 then
  begin
    Abort;
    Exit;
  end;
end;

procedure TDM.progressDialogCancel(Sender: TObject);
{LAZARUS: progressDialog removido — sinaliza cancelamento via FDownloadCanceled}
begin
  if FDownloadProgress < FDownloadTotal then
    FDownloadCanceled := True;
end;

procedure TDM.tmrBuscaTimer(Sender: TObject);
begin
  tmrBusca.Enabled := False;
  fmIndex.buscaMusicas();
end;

procedure TDM.tmrCronoTimer(Sender: TObject);
var
  MyHora, MyMinuto, MySegundo, MyMiliSegundo: Word;
  Segundos: integer;
begin
  with fmIndex do
  begin
    if rbDirecao.ItemIndex = 0 then
    begin
      tCronoT := tCrono + Now - tCronoOld;
      lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], tCrono + Now - tCronoOld);
      if (gCrono.Max <= 1) then
        gCrono.Max := 1000;
      gCrono.Position := gCrono.Position + 1;
      gCrono.Max := gCrono.Max + 2;
      if fMonitorCronometro <> nil then
      begin
        fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
        fMonitorCronometro.gCrono.Position := gCrono.Position;
        fMonitorCronometro.gCrono.Max := gCrono.Max;
        fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;
      end;
    end
    else
    begin
      tCronoT := tCrono - (Now - tCronoOld);
      lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], tCrono - (Now - tCronoOld));

      DecodeTime(tCrono - (Now - tCronoOld), MyHora, MyMinuto, MySegundo, MyMiliSegundo);
      Segundos := MyMiliSegundo + (MySegundo * 1000) + (MyMinuto * 60000) + (MyHora * 3600000);
      if (Segundos > gCrono.Max) then
        gCrono.Max := Segundos;
      gCrono.Position := Segundos;

      if fMonitorCronometro <> nil then
      begin
        fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
        fMonitorCronometro.gCrono.Position := gCrono.Position;
        fMonitorCronometro.gCrono.Max := gCrono.Max;
        fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;
      end;

      if tCronoT <= 0 then
      begin
        tmrCrono.enabled := false;
        lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], StrToTime('00:00:00'));
        if fMonitorCronometro <> nil then
          fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
        if tsCronometro.TabVisible = false then
          abrePagina(tsCronometro);
        PageControl1.ActivePage := tsCronometro;
        //application.messagebox('Tempo esgotado!', PChar(TITULO + ' - Cron�metro'), mb_ok + mb_iconinformation);
        btZerarCrono.Tag := 1;
        btZerarCronoClick(Sender);
      end;
    end;
  end;
end;

procedure TDM.tmrMediaPlayerTimer(Sender: TObject);
{LAZARUS: TMediaPlayer.mpMusica→BASS — posição verificada via BASS_ChannelGetPosition}
begin
  with fmIndex do
  begin
    try
      if (BASS_ChannelGetPosition(BassPreviewChannel, BASS_POS_BYTE) >=
          BASS_ChannelGetLength(BassPreviewChannel, BASS_POS_BYTE)) then
      begin
        BASS_ChannelStop(BassPreviewChannel);
        btOuvir.Caption := 'Ouvir';
        btOuvir.Down := False;
        btOuvir.ImageIndex := 7;
        tmrMediaPlayer.Enabled := false;
      end;
    except
      btOuvir.Caption := 'Ouvir';
      btOuvir.Down := False;
      btOuvir.ImageIndex := 7;
      tmrMediaPlayer.Enabled := false;
    end;
  end;
end;

procedure TDM.tmrPlayerTimer(Sender: TObject);
{LAZARUS: TMediaPlayer.MediaPlayer1→BASS — PlayerStream declarado em fmMenu}
var
  Pos, Len: QWORD;
begin
  Pos := BASS_ChannelGetPosition(fmIndex.PlayerStream, BASS_POS_BYTE);
  Len := BASS_ChannelGetLength(fmIndex.PlayerStream, BASS_POS_BYTE);
  fmIndex.pbPlayer.Position := Pos;
  if (Len > 0) and (Pos >= Len) then
    fmIndex.btplFecharClick(Sender);
end;

procedure TDM.tmrRelogioTimer(Sender: TObject);
begin
  with fmIndex do
  begin
    spData.Text := formatdatetime('dd/mm/yyyy', now()); {LAZARUS: TStatusPanel.Caption→.Text}
    spRelogio.Text := formatdatetime('hh:mm:ss', now()); {LAZARUS: TStatusPanel.Caption→.Text}
    if (PageControl1.ActivePage = tsRelogio) or (fMonitorRelogio <> nil) then
    begin
      pnlRelogio.DoubleBuffered := True;
      lmdRelogio.Caption := formatdatetime(cbFormatoHora.Items[cbFormatoHora.ItemIndex], now());
      if fMonitorRelogio <> nil then
      begin
        fMonitorRelogio.lmdRelogio.Caption := lmdRelogio.Caption;
        fMonitorRelogio.pnlRelogio.DoubleBuffered := pnlRelogio.DoubleBuffered;
      end;
    end;


    if (PageControl1.ActivePage = tsCronoCulto) or (fMonitorCronometroCulto <> nil) then
    begin
      pnlEscSB.DoubleBuffered := True;
      if (cbEscSBRelogioFunc.Checked) or (btLigar.Caption <> 'Ligar')
        then lmdEscSb.Caption := formatdatetime(cbFormatoHoraES.Items[cbFormatoHoraES.ItemIndex], Now())
        else lmdEscSb.Caption := formatdatetime(cbFormatoHoraES.Items[cbFormatoHoraES.ItemIndex], StrToTime('00:00:00'));

      if (btLigar.Caption = 'Ligar') then
      begin
        lmdEscSbR.Caption := formatdatetime(cbFormatoTempoES.Items[cbFormatoTempoES.ItemIndex], StrToTime('00:00:00'));
        lblCronoCFim.Caption := '00:00';
      end
      else
      begin
        escSBTempo;
        lblCronoCFim.Caption := FormatDateTime('hh:mm',tEscSBCrono);
      end;

      if fMonitorCronometroCulto <> nil then
      begin
        fMonitorCronometroCulto.lmdEscSb.Caption := lmdEscSb.Caption;
        fMonitorCronometroCulto.lmdEscSbR.Caption := lmdEscSbR.Caption;
        fMonitorCronometroCulto.pnlEscSB.DoubleBuffered := pnlEscSB.DoubleBuffered;
      end;
    end;
  end;
end;

procedure TDM.tmrSairTimer(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TDM.tmrSortearNMTimer(Sender: TObject);
var
  sorteado: string;
  {LAZARUS: TbsSkinOfficeItem removido — TCheckListBox usa Items.Insert(idx, caption)}
begin
  with fmIndex do
  begin
    if vSorteioAnimFimNM <= Now then
    begin
      pnlSorteioNM.DoubleBuffered := False;
      tmrSortearNM.Enabled := false;

      btLimpaSorteioNM.Enabled := true;
      btSortearNM.Enabled := true;
      btLimpaSorteioReiniciaNM.Enabled := true;
      btLimpaSorteioLimpaNM.Enabled := true;
      btAddSorteioNM.Enabled := true;
      btImpSorteioNM.Enabled := true;

      sorteado := opNumSorteadoNM.text;
      lmdSorteioNM.Caption := sorteado;

      lbSorteioNM.ItemIndex := StrToInt(vlSorteioNM.Strings.Values[sorteado]);
      lbSorteioNM.Checked[lbSorteioNM.ItemIndex] := True; {LAZARUS: Items[i].Checked→Checked[i]}
      lbSorteioNMItemCheckClick(Sender);

      lbSorteadoNM.Items.Insert(0, sorteado); {LAZARUS: TbsSkinOfficeItem.Insert→Items.Insert(idx,caption)}

      SorteioContador();
      gSorteioNM.Position := gSorteioNM.Max;

      if fMonitorSorteioNomes <> nil then
      begin
        fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
        fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
        fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
        fMonitorSorteioNomes.lbSorteadoNM.Items := lbSorteadoNM.Items;
        fMonitorSorteioNomes.lbSorteadoNM.ItemIndex := lbSorteadoNM.ItemIndex;
        fMonitorSorteioNomes.gSorteioNM.Max := gSorteioNM.Max;
        fMonitorSorteioNomes.gSorteioNM.Min := gSorteioNM.Min;
        fMonitorSorteioNomes.gSorteioNM.Position := gSorteioNM.Position;
        fMonitorSorteioNomes.pnlSorteioNM.DoubleBuffered := pnlSorteioNM.DoubleBuffered;
      end;
    end
    else
    begin
      btLimpaSorteioNM.Enabled := false;
      btSortearNM.Enabled := false;
      btLimpaSorteioReiniciaNM.Enabled := false;
      btLimpaSorteioLimpaNM.Enabled := false;
      btAddSorteioNM.Enabled := false;
      btImpSorteioNM.Enabled := false;

      lmdSorteioNM.Caption := opNumSorteadoNM.text;
      if gSorteioNM.Max > 0 then
        gSorteioNM.Position := Random(gSorteioNM.Max); {LAZARUS: trunc(now*10^10) − TProgressBar exige Position<=Max}

      if fMonitorSorteioNomes <> nil then
      begin
        fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
        fMonitorSorteioNomes.gSorteioNM.Max := gSorteioNM.Max;
        fMonitorSorteioNomes.gSorteioNM.Min := gSorteioNM.Min;
        fMonitorSorteioNomes.gSorteioNM.Position := gSorteioNM.Position;
        fMonitorSorteioNomes.pnlSorteioNM.DoubleBuffered := pnlSorteioNM.DoubleBuffered;
      end;
    end;
  end;
end;

procedure TDM.tmrSortearTimer(Sender: TObject);
var
  sorteado: string;
  {LAZARUS: TbsSkinOfficeItem removido — TCheckListBox usa Items.Insert(idx, caption)}
begin
  with fmIndex do
  begin
    if vSorteioAnimFim <= Now then
    begin
      pnlSorteio.DoubleBuffered := False;
      tmrSortear.Enabled := false;

      btLimpaSorteio.Enabled := true;
      btSortear.Enabled := true;
      btLimpaSorteioReinicia.Enabled := true;
      btLimpaSorteioLimpa.Enabled := true;
      btAddSorteio.Enabled := true;

      sorteado := opNumSorteado.text;
      lmdSorteio.Caption := sorteado;

      lbSorteio.ItemIndex := StrToInt(vlSorteio.Strings.Values[sorteado]);
      lbSorteio.Checked[lbSorteio.ItemIndex] := True; {LAZARUS: Items[i].Checked→Checked[i]}
      lbSorteioItemCheckClick(Sender);

      lbSorteado.Items.Insert(0, sorteado); {LAZARUS: TbsSkinOfficeItem.Insert→Items.Insert(idx,caption)}

      SorteioContador();
      gSorteio.Position := gSorteio.Max;

      if fMonitorSorteio <> nil then
      begin
        fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
        fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
        fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
        fMonitorSorteio.lbSorteado.Items := lbSorteado.Items;
        fMonitorSorteio.lbSorteado.ItemIndex := lbSorteado.ItemIndex;
        fMonitorSorteio.gSorteio.Max := gSorteio.Max;
        fMonitorSorteio.gSorteio.Min := gSorteio.Min;
        fMonitorSorteio.gSorteio.Position := gSorteio.Position;
        fMonitorSorteio.pnlSorteio.DoubleBuffered := pnlSorteio.DoubleBuffered;
      end;
    end
    else
    begin
      btLimpaSorteio.Enabled := false;
      btSortear.Enabled := false;
      btLimpaSorteioReinicia.Enabled := false;
      btLimpaSorteioLimpa.Enabled := false;
      btAddSorteio.Enabled := false;

      lmdSorteio.Caption := opNumSorteado.text;
      if gSorteio.Max > 0 then
        gSorteio.Position := Random(gSorteio.Max); {LAZARUS: trunc(now*10^10) − TProgressBar exige Position<=Max}

      if fMonitorSorteio <> nil then
      begin
        fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
        fMonitorSorteio.gSorteio.Max := gSorteio.Max;
        fMonitorSorteio.gSorteio.Min := gSorteio.Min;
        fMonitorSorteio.gSorteio.Position := gSorteio.Position;
        fMonitorSorteio.pnlSorteio.DoubleBuffered := pnlSorteio.DoubleBuffered;
      end;
    end;
  end;
end;

procedure TDM.tmrSorteioTimer(Sender: TObject);
var
  Rnd: integer;
begin
  with fmIndex do
  begin
    if vlSorteio.Strings.Count > 0 then
    begin
      Rnd := 0 + Random(vlSorteio.Strings.Count);
      opNumSorteado.text := vlSorteio.Cells[0, Rnd + 1];
      opNumIndice.Text := IntToStr(Rnd);
    end;

    if vlSorteioNM.Strings.Count > 0 then
    begin
      Rnd := 0 + Random(vlSorteioNM.Strings.Count);
      opNumSorteadoNM.text := vlSorteioNM.Cells[0, Rnd + 1];
      opNumIndiceNM.Text := IntToStr(Rnd);
    end;
  end;
end;

procedure TDM.tmrVersaoTimer(Sender: TObject);
var
  versao_atu: TStringList;
  versao_hlp: TStringList;
begin
  with fmIndex do
  begin
    tmrVersao.Enabled := False;
    verVersao();

    if(tmrSair.enabled) then
      Exit;

    if lerParam('Config', 'AbreHelp', '0') <> lblVersao.caption then
    begin
      atualizaIgnoreAlbum;
      DM.qrALBUM_ATIV.Close;
      DM.qrALBUM_ATIV.Open;
      DM.qrALBUM_INATIV.Close;
      DM.qrALBUM_INATIV.Open;

      fIniciando.AppCreateForm(TfArquivosFalta, fArquivosFalta);
      fArquivosFalta.ShowModal;

      versao_atu := TStringList.Create;
      versao_atu.Delimiter := '.';
      versao_atu.DelimitedText := fmIndex.VersaoExe;

      versao_hlp := TStringList.Create;
      versao_hlp.Delimiter := '.';
      versao_hlp.DelimitedText := lerParam('Config', 'AbreHelp', '0.0.0.0');

      if (versao_atu[0] <>  versao_hlp[0])
        or (versao_atu[1] <>  versao_hlp[1]) then
      begin
        fIniciando.AppCreateForm(TfHelp, fHelp);
        fHelp.tabPage := '';
        fHelp.ShowModal;
      end;

      gravaParam('Config', 'AbreHelp', lblVersao.caption);
    end;

    if (fTransmitir.ckSrvConectar.Checked) then
      if fTransmitir.btServidor.ImageIndex = 8 then
        fTransmitir.btServidorClick(Sender);
  end;
end;

initialization
  {$I dmComponentes.lrs} {LAZARUS: .lfm pre-compilado com lazres — FPC LFM parser falha em Bitmap blocks grandes}

end.
