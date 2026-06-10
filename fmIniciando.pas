unit fmIniciando;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*, Vcl.*, bsSkin*, WinInet, System.*}
  {LAZARUS: WinInet.InternetGetConnectedState→removido (verificação simplificada)}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, Grids, ValEdit, typinfo, Menus,
  DBGrids, DBCtrls,
  LCLIntf, LCLType, LResources;


type
  TfIniciando = class(TForm)
    Timer1: TTimer;
    Panel2: TPanel;
    Panel1: TPanel;
    lblInfo: TLabel;
    Image1: TImage;
    vLang: TValueListEditor;
    paramexec: TValueListEditor;
    ImagePT: TImage;
    ImageES: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure AppCreateForm(InstanceClass: TComponentClass; var Reference);
    procedure TranslateForm(Form: TForm);
    function Translate(txt: string):string;
    procedure FormCreate(Sender: TObject);
  private

  const
    arq_liturgia: string = 'liturgia.ja';
    senha_bd: string = 'bddbuscacdja';
  public
      LANG: string;
      dir_dados: string;
      dir_temp: string;
      dir_config: string;
      url_params: string;
      api_token: string;
 end;

var
  fIniciando: TfIniciando;

implementation


uses fmMenu, fmAtualiza, dmComponentes, fmTransmitir, fmEditorSlides,
  fmBuscaMusica, fmItensAgendados, fmFormatacao, fmVideoOn, fmNovaVersao,
  fmLiturgia;

procedure TfIniciando.AppCreateForm(InstanceClass: TComponentClass;
  var Reference);
begin
  Application.CreateForm(InstanceClass, Reference);
  if (trim(LANG) <> '') and (trim(LANG) <> 'PT') then
    TranslateForm(TForm(Reference));
end;

procedure TfIniciando.FormCreate(Sender: TObject);
var
  arq: string;
begin
  try
    DM.ADO.Connected := false;
  except
  end;

  vLang.Strings.Clear;
  LANG := 'PT';

  arq := ExtractFilePath(application.exename)+'.translate';
  if FileExists(arq) then
  begin
    vLang.Strings.LoadFromFile(arq);
    LANG := vLang.Strings.Values['_'];
  end;
end;

procedure TfIniciando.Timer1Timer(Sender: TObject);
var
  i: integer;
  lista: TStringList;
  {LAZARUS: Flags: Cardinal removido — era para InternetGetConnectedState (WinInet)}
  externo: Boolean;
  TITULO: PChar;
begin
  Timer1.Enabled := False;
  externo := False;

  paramexec.Strings.Text := StringReplace(paramstr(2), ';' ,#13#10, [rfIgnoreCase, rfReplaceAll]);

  if (paramexec.Strings.Values['lang'] <> '') then
  begin
    vLang.Strings.LoadFromFile(ExtractFilePath(application.exename)+'lang/'+paramexec.Strings.Values['lang']+'.txt');
    LANG := vLang.Strings.Values['_'];
  end;

  if LANG = 'ES' then
  begin
    TITULO := 'Loor JA';
    ImagePT.Visible := false;
    ImageES.Visible := true;
  end
  else TITULO := 'Louvor JA';

//  lblTitulo.Caption := TITULO;
  lblInfo.Caption := Translate(lblInfo.Caption);
  application.ProcessMessages;

  if (paramexec.Strings.Values['dir_config'] <> '') then
  begin
    {LAZARUS: suporte a caminho absoluto no Linux — se começa com '/', usa direto
     em vez de concatenar com o diretório do executável (que fica em /opt/louvorja/)}
    if (paramexec.Strings.Values['dir_config'][1] = '/') then
      dir_config := IncludeTrailingPathDelimiter(paramexec.Strings.Values['dir_config'])
    else
      dir_config := ExtractFilePath(Application.ExeName) + paramexec.Strings.Values['dir_config'] + '/';
  end
  else
    dir_config := ExtractFilePath(Application.ExeName) + 'config/';

  if FileExists(ParamStr(1)) then
  begin
    lblInfo.Caption := Translate('Abrindo arquivo...');
    externo := True;
    application.ProcessMessages;
  end;


  //**CARREGA VARIAVEIS*********************************************************
  {LAZARUS: APPDATA→HOME/.local/share, TEMP→/tmp, separadores \→/}
  dir_dados := GetEnvironmentVariable('HOME') + '/.local/share/LouvorJA/';
  dir_temp := '/tmp/LouvorJA/';
  url_params := 'https://api.louvorja.com.br/params?type=env';
  api_token := '02@v2nFB2Dc';

  if not(DirectoryExists(dir_dados)) then
    ForceDirectories(dir_dados);

  if not(DirectoryExists(dir_temp)) then
    ForceDirectories(dir_temp);

  if not(DirectoryExists(dir_temp)) then
    dir_temp := '/tmp/';


  if fileexists(dir_dados + 'config.ja') then
    RenameFile(dir_dados + 'config.ja', dir_dados + 'config'+LANG+'.ja');



  //**ATIVANDO PROGRAMA*********************************************************
  AppCreateForm(TfmIndex, fmIndex);

  fmIndex.paramexec.Strings.Text := paramexec.Strings.Text;
  {LAZARUS: DM.PasswordDialog removido — pwd passado via paramexec se necessário}


  fmIndex.TITULO := TITULO;
  fmIndex.arq_liturgia := arq_liturgia;
  fmIndex.senha_bd := senha_bd;
  fmIndex.dir_dados := dir_dados;
  fmIndex.dir_temp := dir_temp;
  fmIndex.dir_config := dir_config;
  fmIndex.externo := externo;
  fmIndex.url_params := url_params;
  fmIndex.api_token := api_token;



  //**CARREGA BANCO DE DADOS****************************************************
  if not FileExists(dir_config + 'database.db') then
  begin
    if (application.messagebox(PChar(Translate('Banco de Dados não localizado! Deseja se conectar para fazer o download do banco de dados?')), TITULO, MB_yesno + mb_iconerror) <> 6) then
    begin
      application.terminate;
      Exit;
    end
    else
    begin
      {LAZARUS: InternetGetConnectedState removido — erro de rede tratado pela exceção no download}
      lista := TStringList.Create;
      {LAZARUS: FTP tem pt_database.db/es_database.db — ftp_baixa renomeia para database.db localmente}
      lista.Add('config\' + LANG + '_database.db');

      AppCreateForm(TfAtualiza, fAtualiza);
      fAtualiza.arquivos := lista;
      fAtualiza.ShowModal;

      if not FileExists(dir_config + 'database.db') then
      begin
        application.messagebox(PChar(Translate('Não foi possível baixar o Banco de Dados da internet. Favor, instale seu programa novamente!')), TITULO, MB_ok + mb_iconerror);
        application.terminate;
        Exit;
      end
      else
      begin
        fmIndex.RestartApplication;
        exit;
      end;
    end;
    Exit;
  end;


  DM.ADO.Connected := false;
  DM.ADO.Protocol := 'sqlite'; {LAZARUS: ZeosLib SQLite3 usa protocolo 'sqlite', não 'sqlite-3'}
  DM.ADO.Database := dir_config + 'database.db'; {LAZARUS: Params.Database→Database (ZeosLib)}
  {LAZARUS: fix "(MEMO)" em views SQLite — colunas sem tipo declarado usavam TEXT→stAsciiStream;
   Undefined_Varchar_AsString_Length≠0 muda fallback para CHAR→stString (ver ZDbcSqLiteResultSet.pas:570)}
  DM.ADO.Properties.Values['Undefined_Varchar_AsString_Length'] := '250';
  {LAZARUS: evitar "database is locked" ao iniciar segunda instância — esperar até 5s pelo lock}
  DM.ADO.Properties.Values['timeout'] := '5000';
  try
    DM.ADO.Connected := true;
  except
    on E: Exception do
    begin
      application.messagebox(PChar(Translate('Não foi possível conectar ao Banco de Dados.')+#13#10+E.Message), TITULO, MB_OK + mb_iconerror);
      application.terminate;
    end;
  end;





  //DESATIVA RECURSOS "ES"
  if (LANG = 'ES') then
  begin
    {LAZARUS: grpHinarios/grpHináriosN (Delphi TbsSkinGroupBox) →
     bsRibbonGroup21 (TPanel em tsColetaneas, Caption='Hinário Adventista').
     No port, ambas os botões (btAbreHinos + btAbreHinosN) estão no mesmo
     grupo bsRibbonGroup21. Esconder o grupo inteiro cobre os dois TODOs.}
    fmIndex.bsRibbonGroup21.Visible := False;  {equivale a grpHinarios+grpHináriosN}
    fmIndex.btAbreHinosN.Visible := False;

    fmIndex.imgImagemCapaModel.Picture := fmIndex.imgImagemCapaModelES.Picture;
  end;


  fmIndex.desenvolvedor(paramexec.Strings.Values['des'] = '1');
  fmIndex.usaFontes(true);



  //**DETECTA MONITORES*********************************************************
  fmIndex.monitores;

  {LAZARUS: bloco "CARREGA SKIN" removido — skin engine não portada para LCL}

  //**CARREGA CONFIGURAÇÕES GLOBAIS*********************************************
  fmIndex.ckMonitorJanela.Checked := (fmIndex.lerParam('Config', 'MonitorTelaCheia', '1') = '1');
  fmIndex.ckFadeForm.Checked := (fmIndex.lerParam('Config', 'FadeForm', '1') = '1');
  fmIndex.ckMesmaJanela.Checked := false;// (fmIndex.lerParam('Config', 'ckMesmaJanela', '0') = '1');
  fmIndex.ckMusicaJanela.Checked := (fmIndex.lerParam('Musicas', 'MonitorTelaCheia', '1') = '1');
  fmIndex.ckMusicaTopo.Checked := (fmIndex.lerParam('Musicas', 'Topo', '1') = '1');
  fmIndex.ckMusicaOperador.Checked := (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1');
  fmIndex.ckMusicaRetorno.Checked := (fmIndex.lerParam('Musicas', 'ModoRetorno', '0') = '1');
  fmIndex.ckMusicaTituloSlide.Checked := (fmIndex.lerParam('Musicas', 'TituloSlide', '1') = '1');
  fmIndex.ckVideoOnJanela.Checked := (fmIndex.lerParam('Videos Online', 'MonitorTelaCheia', '1') = '1');
  fmIndex.sbVideoOnAbreLiturgia.ItemIndex := StrToInt(fmIndex.lerParam('Videos Online', 'Player Liturgia', '1'));
  fmIndex.sbAlinhMusica.ItemIndex := StrToInt(fmIndex.lerParam('Musicas', 'Alinhamento', '1'));
  fmIndex.ckPlayerTelaCheia.Checked := (fmIndex.lerParam('Player', 'MonitorTelaCheia', '1') = '1');
  fmIndex.ckPlayerVideo.Checked := (fmIndex.lerParam('Player', 'Video', '0') = '1');
  fmIndex.ckPlayerAudio.Checked := (fmIndex.lerParam('Player', 'Audio', '0') = '1');
  fmIndex.ckSlideTxtFormatPerso.Checked := (fmIndex.lerParam('Musicas', 'TextoPersonalizado', '0') = '1');
  fmIndex.ckSlideImgFormatPerso.Checked := (fmIndex.lerParam('Musicas', 'FundoPersonalizado', '0') = '1');
  fmIndex.ckSlideFormatPersoExt.Checked := (fmIndex.lerParam('Musicas', 'ExternoPersonalizado', '1') = '1');
  fmIndex.corFundoMusica.ButtonColor := StringToColor( {LAZARUS: TbsSkinColorButton.ColorValue→TColorButton.ButtonColor}fmIndex.lerParam('Musicas', 'Cor Fundo', '$0000000'));
  fmIndex.corTituloMusica.ButtonColor := StringToColor( {LAZARUS: TbsSkinColorButton.ColorValue→TColorButton.ButtonColor}fmIndex.lerParam('Musicas', 'Cor Titulo', '$000b4ef'));
  fmIndex.corTextoMusica.ButtonColor := StringToColor( {LAZARUS: TbsSkinColorButton.ColorValue→TColorButton.ButtonColor}fmIndex.lerParam('Musicas', 'Cor Texto', '$0FFFFFF'));
  fmIndex.corTextoRepetido.ButtonColor := StringToColor( {LAZARUS: TbsSkinColorButton.ColorValue→TColorButton.ButtonColor}fmIndex.lerParam('Musicas', 'Cor Texto Repetido', '$000b4ef'));
  fmIndex.corTextoAuxMusica.ButtonColor := StringToColor( {LAZARUS: TbsSkinColorButton.ColorValue→TColorButton.ButtonColor}fmIndex.lerParam('Musicas', 'Cor Texto Aux', '$000b4ef'));
  fmIndex.ckMusicaFundoTransparente.Checked := (fmIndex.lerParam('Musicas', 'FundoTransparente', '0') = '1');
  fmIndex.ckFundoTransparente.Checked := (fmIndex.lerParam('Musicas', 'FundoTelaTransparente', '0') = '1');
  fmIndex.bsFormatSlideImgPerso2.Visible := (not fmIndex.ckFundoTransparente.Checked);
  fmIndex.seTamanhoTitulo.Text := fmIndex.lerParam('Musicas', 'Tamanho Titulo', '18');
  fmIndex.seTamanhoTexto.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto', '14');
  fmIndex.seTamanhoTextoAux.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto Aux', '10');
  fmIndex.seTamanhoTextoRetorno.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto Retorno', '17');
  fmIndex.imgFundoMusica.Text := fmIndex.lerParam('Musicas', 'Imagem Fundo', '');
  fmIndex.txtImgFundoMusicaInfo.Text := fmIndex.lerParam('Musicas', 'Imagem Fundo Info', '');
  fmIndex.posicaoFundo.ItemIndex := StrToInt(fmIndex.lerParam('Musicas', 'Imagem Fundo Posicao', '5'))-1;
  if fmIndex.ckSlideTxtFormatPerso.Checked
    then fmIndex.bsFormatSlPerso.Height := 72
    else fmIndex.bsFormatSlPerso.Height := 24;
  if fmIndex.ckSlideImgFormatPerso.Checked
    then fmIndex.bsFormatSlImgPerso.Height := 48
    else fmIndex.bsFormatSlImgPerso.Height := 24;
  if fmIndex.ckMusicaRetorno.Checked
    then fmIndex.bsFormatSlRetorno.Height := 48
    else fmIndex.bsFormatSlRetorno.Height := 24;

  //**SERVIDOR****************************************
  AppCreateForm(TfTransmitir, fTransmitir);
  fTransmitir.seSrvUrl.Text := fmIndex.lerParam('Servidor', 'URL', fmIndex.GetIP());
  fTransmitir.seSrvPorta.Text := fmIndex.lerParam('Servidor', 'Porta', '7070');
  fTransmitir.seSrvToken.Text := fmIndex.lerParam('Servidor', 'Token', fTransmitir.geraToken());
  fTransmitir.seSrvToken.OnExit(nil);
  fTransmitir.ckSrvConectar.Checked := (fmIndex.lerParam('Servidor', 'Conectar', '0') = '1');
  fTransmitir.ckSrvAltIPPorta.Checked := (fmIndex.lerParam('Servidor', 'AltPortaIP', '1') = '1');

  //**AJUSTA SCROLLBOX****************************************
  fmIndex.ScrollBox1.VertScrollBar.Position := 0;
  fmIndex.ScrollBox2.VertScrollBar.Position := 0;
  fmIndex.ScrollBox3.VertScrollBar.Position := 0;
  fmIndex.ScrollBox5.VertScrollBar.Position := 0;
  fmIndex.ScrollBox6.VertScrollBar.Position := 0;
  fmIndex.ScrollBox7.VertScrollBar.Position := 0;



  if externo then
  begin
    //**SE ARQUIVO EXTERNO, ABRE ARQUIVO****************************************
    fmIndex.processaArquivo(ParamStr(1));
    fIniciando.Visible := False;
  end
  else
  begin
    //**BORDAS E TAMANHO DO FORM************************************************
    fmIndex.carrega_opc := false;

    fmIndex.BorderStyle := bsSizeable;
    fmIndex.Width := Round(Screen.Width * 0.75);
    fmIndex.height := Round(Screen.height * 0.85);
    {LAZARUS: btwsMaximizedClick removido — bsNone+wsMaximized não funciona sem skin engine (resulta em janela 1x1 em WMs tiling/compositors GTK2); forma abre maximizada via wsMaximized+bsSizeable abaixo}
    fmIndex.WindowState := wsMaximized;
    if fmIndex.lerParam('Desenvolvedor', 'Width', '') <> ''
      then fmIndex.Width := strtoint(fmIndex.lerParam('Desenvolvedor', 'Width', ''));
    if fmIndex.lerParam('Desenvolvedor', 'Height', '') <> ''
      then fmIndex.Height := strtoint(fmIndex.lerParam('Desenvolvedor', 'Height', ''));


    //**MENUS E ABAS************************************************************
    {LAZARUS: bsAppMenu1 removido (era botão do Ribbon — sem equivalente em TPageControl)}
    fmIndex.PaginaMenuAtiva(fmIndex.tsColetaneas); {LAZARUS: bsColetaneas(TbsRibbonPage)→tsColetaneas(TTabSheet)}
    fmIndex.PageControl5.ActivePageIndex := 0;
    fmIndex.RibbonPC.Visible := True; {LAZARUS: bsRibbon1→RibbonPC (TPageControl)}
    fmIndex.ScrollBox2.Top := 0;

    for i := 0 to fmIndex.PageControl1.PageCount - 1 do
      fmIndex.PageControl1.Pages[i].TabVisible := False;


    //**IMAGEM DE FUNDO*********************************************************
    fmIndex.pnlImagemCapa.Color := StringToColor(fmIndex.lerParam('Config', 'Cor Fundo', ColorToString(fmIndex.pnlImagemCapaModel.Color)));
    fmIndex.corCapaPrograma.ButtonColor := fmIndex. {LAZARUS: ColorValue→ButtonColor}pnlImagemCapa.Color;

    fmIndex.cbAlinhamentoCapaPrograma.ItemIndex := strtoint(fmIndex.lerParam('Config', 'Alinhamento Imagem Fundo', '0'));
    fmIndex.imgImagemCapa.Stretch := (fmIndex.cbAlinhamentoCapaPrograma.ItemIndex = 1);

    fmIndex.imgCapaPrograma.Text := fmIndex.lerParam('Config', 'Imagem Fundo', '');
    fmIndex.txtImgCapaProgramaInfo.Text := fmIndex.lerParam('Config', 'Imagem Fundo Info', '');
    if trim(fmIndex.imgCapaPrograma.Text) <> '' then
    begin
      try
        fmIndex.imgImagemCapa.Picture.LoadFromFile(fmIndex.imgCapaPrograma.Text);
      except
        fmIndex.imgImagemCapa.Picture := fmIndex.imgImagemCapaModel.Picture;
//        fmIndex.imgCapaPrograma.Text := '';
//        fmIndex.txtImgCapaProgramaInfo.Text := '';
      end;
    end
    else
      fmIndex.imgImagemCapa.Picture := fmIndex.imgImagemCapaModel.Picture;


    //**CARREGA TÍTULOS DO PROGRAMA
    application.Title := TITULO;
    fmIndex.Caption := TITULO;
    fmIndex.pnlTitForm.Caption := TITULO;

    fmIndex.tCronoT := 0;

    //**CARREGA INFORMAÇÕES DO COMPUTADOR E RELÓGIO*****************************
    DM.tmrRelogio.Enabled := True;
    fmIndex.paramtemp.Lines.Clear;
    fmIndex.paramtemp.Text := fmIndex.GetComputerNameFunc;
    fmIndex.spNomePC.Text {LAZARUS: TStatusPanel.Caption→.Text} := ' '+trim(fmIndex.paramtemp.Lines[0]);

    //**ATUALIZA BD COM COLETANEAS ATIVAS/INATIVAS******************************
    DM.qrALBUM_ATIV.Close;
    DM.qrALBUM_ATIV.Open;
    DM.qrALBUM_INATIV.Close;
    DM.qrALBUM_INATIV.Open;

    //**ATUALIZA COLETANEAS PERSONALIZADAS**************************************
    fmIndex.importColetaneasPerso;


    //**MOSTRA FORM*************************************************************
    fmIndex.Show;
    Application.ProcessMessages; {LAZARUS: drena fila de eventos GTK pendentes após Show() — necessário pois o fade-in foi removido}
    {LAZARUS: esconder splash ANTES de carregaParams — evita janela em branco bloqueando input
     durante chamada de rede de até 12s (ConnectTimeout 5s + Sleep 2s + retry 5s)}
    {LAZARUS: fIniciando é o Application.MainForm (1ª form visível criada). Em compositores
     Wayland/COSMIC (XWayland), uma janela bsNone só com Visible:=False permanece como janela
     vazia fantasma (o compositor remapeia a janela do MainForm). Encolhe p/ 1x1 fora da tela
     ENQUANTO ainda visível (para o widget GTK aplicar o novo tamanho) e só então oculta —
     assim, mesmo que o compositor a remapeie, ela fica 1x1 invisível.}
    fIniciando.ShowInTaskBar := stNever;
    fIniciando.SetBounds(-30000, -30000, 1, 1);
    Application.ProcessMessages;
    fIniciando.Visible := False;
    Application.ProcessMessages;

    //**CARREGA PARAMETROS DA WEB***********************************************
    fmIndex.carregaParams();

    {LAZARUS: parâmetro editor=1 abre o editor de slides automaticamente — útil para testes sem XTest/xdotool}
    if paramexec.Strings.Values['editor'] = '1' then
    begin
      AppCreateForm(TfEditorSlides, fEditorSlides);
      fEditorSlides.Show;
      fEditorSlides.WindowState := wsMaximized; {LAZARUS: LCL/GTK2 ignora wsMaximized do LFM em Show() programático; forçar aqui}
      Application.ProcessMessages; {drena eventos GTK pendentes}
      fEditorSlides.BringToFront; {faz o WM focar a janela, disparando FormActivate naturalmente}
    end;

    {LAZARUS: editor_divide=1 testa btDivideSlide: coloca texto com | no slide 1 e chama divisão}
    if paramexec.Strings.Values['editor_divide'] = '1' then
    begin
      if fEditorSlides = nil then
      begin
        AppCreateForm(TfEditorSlides, fEditorSlides);
        fEditorSlides.Show;
        Application.ProcessMessages;
      end;
      {slide 1 é CAPA — ir para slide 2 (LETRA) e dividir}
      DM.cdsSLIDE_MUSICA2.RecNo := 2;
      fEditorSlides.param.Values['slide'] := '2';
      fEditorSlides.carregaSlide();
      Application.ProcessMessages;
      {cada linha de textoLetra vira um slide separado no btDivideSlide}
      fEditorSlides.textoLetra.Lines.Clear;
      fEditorSlides.textoLetra.Lines.Add('Primeira estrofe');
      fEditorSlides.textoLetra.Lines.Add('Segunda estrofe');
      Application.ProcessMessages;
      fEditorSlides.btDivideSlideClick(nil);
      Application.ProcessMessages;
    end;

    {LAZARUS: editor_save=<path> salva a apresentação atual para arquivo — testa CDS2Text sem UI}
    if paramexec.Strings.Values['editor_save'] <> '' then
    begin
      if fEditorSlides = nil then
      begin
        AppCreateForm(TfEditorSlides, fEditorSlides);
        fEditorSlides.Show;
        Application.ProcessMessages;
      end;
      fEditorSlides.param.Values['arquivo'] := paramexec.Strings.Values['editor_save'];
      fEditorSlides.CDS2Text();
      Application.ProcessMessages;
    end;

    {LAZARUS: editor_load=<path> carrega arquivo de apresentação — testa Text2CDS sem UI}
    if paramexec.Strings.Values['editor_load'] <> '' then
    begin
      if fEditorSlides = nil then
      begin
        AppCreateForm(TfEditorSlides, fEditorSlides);
        fEditorSlides.Show;
        Application.ProcessMessages;
      end;
      fEditorSlides.param.Values['arquivo'] := paramexec.Strings.Values['editor_load'];
      fEditorSlides.Text2CDS();
      Application.ProcessMessages;
    end;

    {LAZARUS: parâmetro exportar=ID exporta música para /tmp/lj_export_test.slja — teste headless do export}
    if paramexec.Strings.Values['exportar'] <> '' then
    begin
      Application.ProcessMessages;
      fmIndex.exportarMusicaParaArquivo(
        StrToIntDef(paramexec.Strings.Values['exportar'], 1),
        true, '/tmp/lj_export_test.slja', '');
      Application.ProcessMessages;
    end;

    {LAZARUS: parâmetro projecao=ID projeta música automaticamente — útil para testes headless}
    if paramexec.Strings.Values['projecao'] <> '' then
    begin
      Application.ProcessMessages;
      fmIndex.abreLetraMusica('BD', '', StrToIntDef(paramexec.Strings.Values['projecao'], 1), true);
    end;

    {LAZARUS: parâmetro autoslide=1 avança slide a cada 6s via main thread — teste headless de repaint}
    if paramexec.Strings.Values['autoslide'] <> '' then
    begin
      with TTimer.Create(fIniciando) do
      begin
        Interval := 6000;
        OnTimer := fmIndex.avancaSlideHeadless;
        Enabled := True;
      end;
    end;

    {LAZARUS: parâmetro servidor=1 inicia servidor HTTP automaticamente — útil para testes headless}
    if paramexec.Strings.Values['servidor'] = '1' then
    begin
      Application.ProcessMessages;
      fTransmitir.Show;
      Application.ProcessMessages;
      fTransmitir.btServidorClick(nil);
    end;

    {LAZARUS: parâmetros de aba para testes headless}
    if paramexec.Strings.Values['hinario_n'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsHinarioN);
    end;

    if paramexec.Strings.Values['letra'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abreLetra(1, '');
    end;

    if paramexec.Strings.Values['sorteio'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsSorteio);
    end;

    if paramexec.Strings.Values['relogio'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsRelogio);
    end;

    if paramexec.Strings.Values['cronometro'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsCronometro);
    end;

    if paramexec.Strings.Values['liturgia'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsLiturgia);
    end;

    {LAZARUS: parâmetro liturgia_form=<tipo|1> abre fmLiturgia para testes headless}
    {tipos válidos: 1, Anotação, Arquivo/Diretório, Categoria, Itens Agendados, Música, Site}
    if paramexec.Strings.Values['liturgia_form'] <> '' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsLiturgia);
      Application.ProcessMessages;
      AppCreateForm(TfLiturgia, fLiturgia); {criação lazy — não está no auto-create}
      fLiturgia.Caption := 'Adicionar Item';
      fLiturgia.id := '';
      fLiturgia.Show;
      Application.ProcessMessages;
      if paramexec.Strings.Values['liturgia_form'] <> '1' then
      begin
        {aceita índice numérico (0-5) ou nome do tipo}
        if paramexec.Strings.Values['liturgia_form'][1] in ['0'..'9'] then
          fLiturgia.cbItens.ItemIndex :=
            StrToIntDef(paramexec.Strings.Values['liturgia_form'], 0)
        else
          fLiturgia.cbItens.ItemIndex :=
            fLiturgia.cbItens.Items.IndexOf(paramexec.Strings.Values['liturgia_form']);
        fLiturgia.cbItensChange(nil);
        Application.ProcessMessages;
      end;
    end;

    {LAZARUS: parâmetro atualiza=1 abre fmAtualiza diretamente para testes headless}
    if paramexec.Strings.Values['atualiza'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.carregaParams(); {garante que Param.Strings tem conn_ftp + credenciais}
      Application.ProcessMessages;
      AppCreateForm(TfAtualiza, fAtualiza);
      fAtualiza.arquivos := TStringList.Create;
      fAtualiza.arquivos.Add('config\' + LANG + '_database.db');
      fAtualiza.ShowModal;
    end;

    {LAZARUS: parâmetro biblia=1 abre aba Bíblia para testes headless}
    if paramexec.Strings.Values['biblia'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsBiblia);
    end;

    {LAZARUS: parâmetro buscamusica=1 abre aba Busca de Músicas para testes headless}
    if paramexec.Strings.Values['buscamusica'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsBuscaMusica);
    end;

    {LAZARUS: parâmetro itensagendados=1 abre aba Itens Agendados para testes headless}
    if paramexec.Strings.Values['itensagendados'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abrePagina(fmIndex.tsItensAgendados);
    end;

    {LAZARUS: parâmetro formatacao=1 abre fmFormatacao com fonte de teste para validação headless}
    if paramexec.Strings.Values['formatacao'] = '1' then
    begin
      Application.ProcessMessages;
      AppCreateForm(TfFormatacao, fFormatacao);
      SetLength(fFormatacao.fonte, 1);
      fFormatacao.fonte[0] := TFont.Create;
      fFormatacao.fonte[0].Name := 'Sans Serif';
      fFormatacao.fonte[0].Size := 14;
      SetLength(fFormatacao.abas, 1);
      fFormatacao.abas[0] := 'FONTE;Título';
      fFormatacao.ShowModal;
    end;

    {LAZARUS: parâmetro player=URL toca arquivo de áudio e abre fmPlayer — testes headless}
    if paramexec.Strings.Values['player'] <> '' then
    begin
      Application.ProcessMessages;
      fmIndex.player(paramexec.Strings.Values['player'], False);
    end;

    {LAZARUS: parâmetro help=1 abre fmHelp para testes headless}
    if paramexec.Strings.Values['help'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abreHelp;
    end;

    {LAZARUS: parâmetro arquivos_excesso=1 abre fmArquivosExcesso para testes headless}
    if paramexec.Strings.Values['arquivos_excesso'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abreArquivosExcesso;
    end;

    {LAZARUS: parâmetro arquivos_falta=1 abre fmArquivosFalta para testes headless}
    if paramexec.Strings.Values['arquivos_falta'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abreArquivosFalta;
    end;

    {LAZARUS: parâmetro favoritos=1 abre fmFavoritos para testes headless}
    if paramexec.Strings.Values['favoritos'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.abreFavoritosManager;
    end;

    {LAZARUS: parâmetro identifica=1 abre fmIdentificaMonitores para testes headless}
    if paramexec.Strings.Values['identifica'] = '1' then
    begin
      Application.ProcessMessages;
      fmIndex.identifica_monitores(nil);
    end;

    {LAZARUS: parâmetro monitor=nome abre formulário de monitor headless — testes}
    {  Valores: sorteio, sorteio_nomes, cronometro, relogio, painel, texto,  }
    {           biblia, biblia_busca, crono_culto, menu_musicas              }
    if paramexec.Strings.Values['monitor'] <> '' then
    begin
      Application.ProcessMessages;
      fmIndex.abreMonitorHeadless(paramexec.Strings.Values['monitor']);
    end;

    {LAZARUS: parâmetro nova_versao=1 abre fmNovaVersao para testes headless}
    if paramexec.Strings.Values['nova_versao'] = '1' then
    begin
      Application.ProcessMessages;
      AppCreateForm(TfNovaVersao, fNovaVersao);
      fNovaVersao.lblVAtu.Caption := '26.6';
      fNovaVersao.lblVNova.Caption := '99.0';
      fNovaVersao.ShowModal;
    end;

    {LAZARUS: parâmetro lista_musica=N abre fmListaMusica com id_album=N para testes headless}
    if paramexec.Strings.Values['lista_musica'] <> '' then
    begin
      Application.ProcessMessages;
      fmIndex.abreListaMusicaHeadless(
        StrToIntDef(paramexec.Strings.Values['lista_musica'], 1),
        'Teste ListaMusica (album=' + paramexec.Strings.Values['lista_musica'] + ')');
    end;

    {LAZARUS: parâmetro lista_dir=/caminho abre fmListaMusica em modo arquivo p/ testes headless}
    if paramexec.Strings.Values['lista_dir'] <> '' then
    begin
      Application.ProcessMessages;
      fmIndex.abreListaDirHeadless(paramexec.Strings.Values['lista_dir']);
    end;

    {LAZARUS: parâmetro videoon=1 abre fmVideoOn stub para testes headless}
    if paramexec.Strings.Values['videoon'] = '1' then
    begin
      Application.ProcessMessages;
      AppCreateForm(TfVideoOn, fVideoOn);
      fVideoOn.videoID := 'dQw4w9WgXcQ';
      fVideoOn.Caption := 'Teste VideoOn';
      fVideoOn.AlphaBlendValue := 255;
      fVideoOn.Show;
    end;

    //**CHECA VERSÃO E NOVAS VERSÕES********************************************
    fmIndex.gravaParam('Config','VersaoExe',fmIndex.VersaoExe);
    DM.tmrVersao.Enabled := True;
    fmIndex.carrega_opc := true;
  end;
  fIniciando.Visible := False;
  if DM.tmrSair.Enabled = True then
    Exit;
  Timer1.Destroy;
end;

function TfIniciando.Translate(txt: string):string;
var
  tra:string;
begin
  if Trim(LANG) = '' then
  begin
    Result := txt;
    Exit;
  end;

  if (Trim(txt) <> '') then
  begin
    tra := vLang.Strings.Values[txt];
    if (trim(tra) <> '') then
    begin
      Result := tra;
//      Result := 'ZZZ';
    end
    else
    begin
      vLang.Strings.Values[txt] := txt;
      Result := txt;
//      Result := 'YYY';
      if (paramexec.Strings.Values['lang'] <> '') then
      begin
        vLang.Strings.SaveToFile(ExtractFilePath(application.exename)+'lang/'+paramexec.Strings.Values['lang']+'.txt');
      end;
      //vLang.Strings.SaveToFile(ExtractFilePath(application.exename)+'.translate');
    end;
  end;
end;

procedure TfIniciando.TranslateForm(Form: TForm);
var
  i,j: integer;
begin
  Form.Caption := Translate(Form.Caption);
  for i := fmIndex.ComponentCount -1 downto 0 do
  begin
    try
      try
        if (GetPropInfo(Form.Components[i].ClassInfo, 'Caption') <> nil) and (trim(TLabel(Form.Components[i]).Caption) <> '') then
          TLabel(Form.Components[i]).Caption := Translate(TLabel(Form.Components[i]).Caption);
      except
        //
      end;

      {LAZARUS: TbsRibbon→TPageControl, TbsAppMenu→removido, TbsSkin*→LCL}
      if (Form.Components[i] is TPageControl) then
      begin
        for j := 0 to TPageControl(Form.Components[i]).PageCount-1 do
        begin
          if TPageControl(Form.Components[i]).Pages[j].Caption <> '' then
            TPageControl(Form.Components[i]).Pages[j].Caption :=
              Translate(TPageControl(Form.Components[i]).Pages[j].Caption);
        end;
      end
      else
      if (Form.Components[i] is TRadioGroup) then
      begin
        for j := 0 to TRadioGroup(Form.Components[i]).Items.Count-1 do
          TRadioGroup(Form.Components[i]).Items[j] := Translate(TRadioGroup(Form.Components[i]).Items[j]);
      end
      else
      if (Form.Components[i] is TCheckGroup) then
      begin
        for j := 0 to TCheckGroup(Form.Components[i]).Items.Count-1 do
          TCheckGroup(Form.Components[i]).Items[j] := Translate(TCheckGroup(Form.Components[i]).Items[j]);
      end
      else
      if (Form.Components[i] is TPopupMenu) then
      begin
        for j := 0 to TPopupMenu(Form.Components[i]).Items.Count-1 do
          TPopupMenu(Form.Components[i]).Items[j].Caption := Translate(TPopupMenu(Form.Components[i]).Items[j].Caption);
      end
      else
      if (Form.Components[i] is TDBGrid) then
      begin
        for j := 0 to TDBGrid(Form.Components[i]).Columns.Count-1 do
          TDBGrid(Form.Components[i]).Columns[j].Title.Caption := Translate(TDBGrid(Form.Components[i]).Columns[j].Title.Caption);
      end
      else
      if (Form.Components[i] is TTabControl) then
      begin
        for j := 0 to TTabControl(Form.Components[i]).Tabs.Count-1 do
          TTabControl(Form.Components[i]).Tabs[j] := Translate(TTabControl(Form.Components[i]).Tabs[j]);
      end;
    except
      //
    end;
  end;
end;

initialization
  {$I fmIniciando.lrs}

end.

(*
|-------------------------------------------------------------------------------
|
|
|---------------|
| ATUALIZAÇÕES: |
|---------------|
|
|- Ajuste na letra no servidor de transmissão
|
|------------|
| CORREÇÕES: |
|------------|
|
|- Ver erro ao desconectar monitor 2 durante musica
|- Na liturgia, correção de bug ao selecionar um arquivo que tenha acentuações e 'é' pois o sistema não consegue fazer o encode correto
|- Bug na tela de help. As vezes não fecha
|- Bug nos itens agendados - CDS
|- Os slides com playback do cd jovem 2011 estão todos fora de tempo!
|- Depois de clicar no campo Geral "Ligar", com a contagem do tempo, se já tiver tocado alguma das músicas, minimizando e retgornando ao programa Louvor JA, a música pára.
|- Bug ao fechar/minimizar algumas janela (como lista de músicas, por exemplo)
|- Problema ao cancelar download (não fecha a janela, tendo que fechar pelo gerenciador de tarefas)
|
|------------|
| MELHORIAS: |
|------------|
|
|- Agrupar hinos do hinário por temas
|- Fazer sumir o ponteiro do mouse durante apresentação da musica (ser parametrizavel = sim/nao)
|- Colocar número do hino no slide e no título
|- Playlist personalizada
|- Wallpaper agendado
|- Mesclar módulos Cronometro e Escola Sabatina
|- Dar a opção de selecionar alguns blocos para a tela de início (talvez contendo os favoritos caso não seja possível movê-los)
|- Ao abrir programa, abrir as abas favoritas
|- As músicas estão com tempo sem áudio extenso no final: Coração aberto e Eu sou a mensagem, principalmente, do cd jovem Eu sou a mensagem.
|- Na liturgia, correção de bug ao selecionar um arquivo que tenha acentuações e 'é' pois o sistema não consegue fazer o encode correto
|- Dar a opção de selecionar alguns blocos para a tela de início (talvez contendo os favoritos caso não seja possível movê-los)
|- Música para sorteio
|- Criar categoria Desbravadores e Aventureiros
|- Colocar texto no cronometro
|- Mudar posição do cronometro
|- Colocar opção do usuario colcoar audio no sorteio
|
|-------------------------------------------------------------------------------

*)
