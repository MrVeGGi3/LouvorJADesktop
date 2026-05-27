unit fmEditorSlides;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/bsribbon/bsColorCtrls/bsSkinShellCtrls}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids, DBCtrls,
  DB, ValEdit, IniFiles, ColorBox, CheckLst, Spin, MaskEdit,
  zipper, Bass, LCLIntf, LCLType, LResources;

type
  TfEditorSlides = class(TForm)
    bsRibbon1: TPageControl {LAZARUS: TbsRibbon};
    bsArquivo: TTabSheet {LAZARUS: TbsRibbonPage → TTabSheet};
    bsRibbonGroup1: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    bsRibbonPage2: TTabSheet {LAZARUS: TbsRibbonPage → TTabSheet};
    bsRibbonPage3: TTabSheet {LAZARUS: TbsRibbonPage → TTabSheet};
    bsRibbonPage4: TTabSheet {LAZARUS: TbsRibbonPage → TTabSheet};
    btSalvar: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btAbrir: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider1: TBevel {LAZARUS: TbsRibbonDivider → TBevel};
    btSalvarComo: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btNovo: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup3: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    bsSkinSpeedButton9: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton11: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider4: TBevel {LAZARUS: TbsRibbonDivider → TBevel};
    bsSkinSpeedButton12: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton13: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup4: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    btNovoSlide: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btExcluiSlide: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup7: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    btGravaA: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btGravaR: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btPausePlay2: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider5: TBevel {LAZARUS: TbsRibbonDivider → TBevel};
    btGravaI: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup8: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    bsRibbonGroup9: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    param: TValueListEditor;
    dbGrid: TDBGrid {LAZARUS: TbsSkinDBGrid};
    Panel2: TPanel;
    DBGrid1: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar7: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsRibbonGroup12: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    Panel4: TPanel {LAZARUS: TbsSkinPanel};
    Panel5: TPanel {LAZARUS: TbsSkinPanel};
    textoLetra: TMemo {LAZARUS: TbsSkinMemo};
    bsSkinScrollBar1: TScrollBar {LAZARUS: TbsSkinScrollBar};
    textoLetraAux: TMemo {LAZARUS: TbsSkinMemo};
    bsSkinScrollBar2: TScrollBar {LAZARUS: TbsSkinScrollBar};
    tmrSlideCarregado: TTimer;
    GridPanel1: TPanel {LAZARUS: TGridPanel};
    tamanhoLetra: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    GridPanel3: TPanel {LAZARUS: TGridPanel};
    tamanhoLetra_aux: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    corLetra: TColorButton {LAZARUS: TbsSkinColorButton};
    corLetra_aux: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinStdLabel1: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel2: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel5: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinStdLabel6: TLabel {LAZARUS: TbsSkinLabel};
    GridPanel4: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel8: TLabel {LAZARUS: TbsSkinStdLabel};
    posicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx → TComboBox};
    bsSkinStdLabel9: TLabel {LAZARUS: TbsSkinStdLabel};
    corFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    bsRibbonGroup13: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    bsSkinSpeedButton2: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton8: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton10: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup14: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    bsSkinSpeedButton17: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton18: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton23: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    tmrTempo: TTimer;
    Panel6: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel10: TLabel {LAZARUS: TbsSkinLabel};
    bsRibbonGroup15: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    fundoTransparente: TCheckBox {LAZARUS: TbsSkinCheckBox};
    btDuplicaSlide: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider2: TBevel {LAZARUS: TbsRibbonDivider → TBevel};
    btDivideSlide: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btMesclaSlide: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider3: TBevel {LAZARUS: TbsRibbonDivider → TBevel};
    brImportar: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider6: TBevel {LAZARUS: TbsRibbonDivider → TBevel};
    bsRibbonGroup2: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    bsRibbonDivider7: TBevel {LAZARUS: TbsRibbonDivider → TBevel};
    btRemoveGr: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lbTempos: TListBox;
    bsRibbonGroup5: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    btProjeta: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonPage1: TTabSheet {LAZARUS: TbsRibbonPage → TTabSheet};
    bsRibbonGroup6: TPanel {LAZARUS: TbsRibbonGroup → TPanel};
    btRes169: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btRes0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btRes43: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    Panel7: TPanel;
    pnlProgress: TPanel {LAZARUS: TGridPanel};
    gSlide: TProgressBar {LAZARUS: TbsSkinGauge};
    gSlideTotal: TProgressBar {LAZARUS: TbsSkinGauge};
    lblTempo: TLabel {LAZARUS: TbsSkinStdLabel};
    areaPanel: TPanel;
    Panel: TPanel;
    pnlLetra: TPanel;
    imgFundo: TImage;
    imgFundoTexto: TImage;
    lblLetra: TLabel {LAZARUS: TbsSkinStdLabel};
    lblLetra_aux: TLabel {LAZARUS: TbsSkinStdLabel};
    Panel3: TPanel;
    GridPanel2: TPanel {LAZARUS: TGridPanel};
    bsSkinSpeedButton1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btPausePlay: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton3: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton4: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton5: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    Panel1: TPanel;
    lblSlides: TLabel {LAZARUS: TbsSkinLabel};
    bsSkinSpeedButton6: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btRemoveImagem: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btAudio: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btRemoveAudio: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btNovoClick(Sender: TObject);
    procedure geraTitulo();
    procedure modifica();
    procedure btSalvarClick(Sender: TObject);
    procedure btSalvarComoClick(Sender: TObject);
    procedure CDS2Text();
    procedure Text2CDS();
    procedure btAbrirClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
    procedure carregaSlide(setPosicao: Boolean = True);
    procedure DBGrid1CellClick(Column: TColumn {LAZARUS: TbsColumn});
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acaoSlide(acao:string; setPosicao: Boolean = True);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ajustaTexto();
    procedure tamanhoLetraChange(Sender: TObject);
    procedure textoLetraChange(Sender: TObject);
    procedure tmrSlideCarregadoTimer(Sender: TObject);
    procedure textoLetraAuxChange(Sender: TObject);
    procedure tamanhoLetra_auxChange(Sender: TObject);
    procedure corLetraChangeColor(Sender: TObject);
    procedure corLetra_auxChangeColor(Sender: TObject);
    procedure corFundoChangeColor(Sender: TObject);
    procedure posicaoFundoClick(Sender: TObject);
    procedure dbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
    procedure carregaImagem(dir: string);
    procedure replicaFormatacaoFundo(Sender: TObject);
    procedure replicaFormatacaoTexto(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure bsSkinSpeedButton5Click(Sender: TObject);
    procedure bsSkinSpeedButton3Click(Sender: TObject);
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure pauseplay();
    procedure acaoPauseplay(liga: Boolean);
    procedure btPausePlayClick(Sender: TObject);
    procedure btNovoSlideClick(Sender: TObject);
    procedure fundoTransparenteClick(Sender: TObject);
    procedure btExcluiSlideClick(Sender: TObject);
    procedure btDivideSlideClick(Sender: TObject);
    procedure brImportarClick(Sender: TObject);
    procedure btMesclaSlideClick(Sender: TObject);
    procedure tmrTempoTimer(Sender: TObject);
    procedure carregaMusica();
    procedure Error(msg: string);
    procedure btRemoveGrClick(Sender: TObject);
    procedure btGravaAClick(Sender: TObject);
    procedure btGravaIClick(Sender: TObject);
    procedure btGravaRClick(Sender: TObject);
    procedure btProjetaClick(Sender: TObject);
    procedure btRes0Click(Sender: TObject);
    procedure bsSkinSpeedButton6Click(Sender: TObject);
    procedure btRemoveImagemClick(Sender: TObject);
    procedure btAudioClick(Sender: TObject);
    procedure btRemoveAudioClick(Sender: TObject);
  private
    { Private declarations }
    carregando_slide: Boolean;
    pause: Boolean;
    bass_musica: HSAMPLE;
    bass_channel: HCHANNEL;

    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fEditorSlides: TfEditorSlides;

implementation


uses dmComponentes, fmMenu;

procedure TfEditorSlides.acaoPauseplay(liga: Boolean);
begin
  if (liga) then
  begin
    if param.Values['audio_rep'] <> param.Values['audio'] then
    begin
      carregaMusica;
    end;
    BASS_ChannelPlay(bass_channel, False);
    btPausePlay.ImageIndex := 9;
    btPausePlay2.Caption := 'Parar';
  end
  else
  begin
    BASS_ChannelPause(bass_channel);
    btPausePlay.ImageIndex := 8;
    btPausePlay2.Caption := 'Reproduzir';
  end;
  btPausePlay2.ImageIndex := btPausePlay.ImageIndex;
  btGravaA.Enabled := liga;
  btGravaI.Enabled := liga;
  btGravaR.Enabled := liga;
  btAudio.Enabled := not liga;
  btRemoveAudio.Enabled := not liga;
  btRemoveGr.Enabled := not liga;
  btProjeta.Enabled := not liga;
  lblTempo.Visible := liga;
end;

procedure TfEditorSlides.acaoSlide(acao: string; setPosicao: Boolean);
var
  tempo: integer;
begin
  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);

  if (acao = 'pri') then DM.cdsSLIDE_MUSICA2.First
  else if (acao = 'ult') then DM.cdsSLIDE_MUSICA2.Last
  else if (acao = 'prox') then DM.cdsSLIDE_MUSICA2.Next
  else if (acao = 'ant') then DM.cdsSLIDE_MUSICA2.Prior
  else if (acao = 'prox_grava') then
  begin
    tempo := BASS_ChannelGetPosition(bass_channel, BASS_POS_BYTE);
    acaoSlide('prox',false);
    DM.cdsSLIDE_MUSICA2.Edit;
    DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').Value := tempo;
    DM.cdsSLIDE_MUSICA2.Post;
    lbTempos.Items[DM.cdsSLIDE_MUSICA2.RecNo-1] := IntToStr(tempo);
    modifica;
    Exit;
  end;

  if (acao <> 'prox_grava') then
  begin
    if setPosicao = true then tmrTempo.Enabled := False;

    param.Values['slide'] := IntToStr(DBGrid1.DataSource.DataSet.RecNo);
    carregaSlide(setPosicao);
  end;
end;

procedure TfEditorSlides.ajustaTexto;
begin
  lblLetra.Font.Height := Trunc((Panel.Height/100)*tamanhoLetra.Value);
  lblLetra.Top := Panel.Height;
  lblLetra.Left := Panel.Width;
  lblLetra.AutoSize := False;
  lblLetra.Height := 1;
  lblLetra.Width := Panel.Width;
  lblLetra.AutoSize := True;
  lblLetra.Refresh;

  lblLetra.Top := Trunc((pnlLetra.Height/2) - (lblLetra.Height/2));
  lblLetra.Left := Trunc((pnlLetra.Width/2) - (lblLetra.Width/2));

  imgFundoTexto.Top := lblLetra.Top-5;
  imgFundoTexto.Left := lblLetra.Left-10;
  imgFundoTexto.Width := lblLetra.Width+20;
  imgFundoTexto.Height := lblLetra.Height+10;

  if (Trim(lblLetra_aux.Caption) <> '') then
  begin
    lblLetra_aux.Font.Height := Trunc((Panel.Height/100)*tamanhoLetra_aux.Value);

    lblLetra_aux.AutoSize := False;
    lblLetra_aux.Height := 1;
    lblLetra_aux.Width := lblLetra.Width;
    lblLetra_aux.AutoSize := True;
    lblLetra_aux.Refresh;

    lblLetra_aux.Top := lblLetra.Top-lblLetra_aux.Height;
    lblLetra_aux.Left := lblLetra.Left;

    imgFundoTexto.Top := lblLetra_aux.Top-5;
    imgFundoTexto.Height := lblLetra_aux.Height + lblLetra.Height+10;
  end;
end;

procedure TfEditorSlides.replicaFormatacaoTexto(Sender: TObject);
var
  ctag: Integer;
  i,ini,fin: Integer;
begin
  ctag := TComponent(Sender).Tag;

  with DM.cdsSLIDE_MUSICA2 do
  begin
    if ctag = 1 then
    begin
      ini := StrToInt('0'+param.Values['slide']);
      fin := ini+1;
    end
    else if ctag = 2 then
    begin
      ini := StrToInt('0'+param.Values['slide']);
      fin := RecordCount;
    end
    else if ctag = 3 then
    begin
      ini := 1;
      fin := RecordCount;
    end
    else
    begin
      ini := 0;
      fin := 0;
    end;

    if (fin > RecordCount) then fin := RecordCount;


    RecNo := ini;
    param.Values['_TAMANHO_LETRA'] := FieldByName('TAMANHO_LETRA').Value;
    param.Values['_TAMANHO_LETRA_AUX'] := FieldByName('TAMANHO_LETRA_AUX').Value;
    param.Values['_COR_LETRA'] := FieldByName('COR_LETRA').Value;
    param.Values['_COR_LETRA_AUX'] := FieldByName('COR_LETRA_AUX').Value;
    param.Values['_FUNDO_LETRA'] := FieldByName('FUNDO_LETRA').Value;

    for i := ini to fin do
    begin
      RecNo := i;
      Edit;
      FieldByName('TAMANHO_LETRA').Value := param.Values['_TAMANHO_LETRA'];
      FieldByName('TAMANHO_LETRA_AUX').Value := param.Values['_TAMANHO_LETRA_AUX'];
      FieldByName('COR_LETRA').Value := param.Values['_COR_LETRA'];
      FieldByName('COR_LETRA_AUX').Value := param.Values['_COR_LETRA_AUX'];
      FieldByName('FUNDO_LETRA').Value := param.Values['_FUNDO_LETRA'];
      Post;
    end;

    RecNo := StrToInt('0'+param.Values['slide']);

  end;

  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.btNovoSlideClick(Sender: TObject);
var
  i: integer;
  ordem,ordem_p: Integer;
begin
  with DM.cdsSLIDE_MUSICA2 do
  begin
    RecNo := StrToInt('0'+param.Values['slide']);

    ordem := FieldByName('ORDEM').Value;
    param.Values['_LOCAL'] := FieldByName('LOCAL').Value;
    param.Values['_MUSICA_ID'] := FieldByName('MUSICA_ID').Value;
    param.Values['_LETRA_ID'] := FieldByName('LETRA_ID').Value;
    param.Values['_URL_MUSICA'] := FieldByName('URL_MUSICA').Value;
    param.Values['_IMAGEM'] := FieldByName('IMAGEM').Value;
    param.Values['_IMAGEM_POSICAO'] := FieldByName('IMAGEM_POSICAO').Value;
    param.Values['_COR_FUNDO'] := FieldByName('COR_FUNDO').Value;
    param.Values['_FUNDO_LETRA'] := FieldByName('FUNDO_LETRA').Value;
    param.Values['_TAMANHO_LETRA'] := FieldByName('TAMANHO_LETRA').Value;
    param.Values['_TAMANHO_LETRA_AUX'] := FieldByName('TAMANHO_LETRA_AUX').Value;
    param.Values['_COR_LETRA'] := FieldByName('COR_LETRA').Value;
    param.Values['_COR_LETRA_AUX'] := FieldByName('COR_LETRA_AUX').Value;
    param.Values['_LETRA'] := FieldByName('LETRA').Value;
    param.Values['_LETRA_UCASE'] := FieldByName('LETRA_UCASE').Value;
    param.Values['_LETRA_AUX'] := FieldByName('LETRA_AUX').Value;

    if RecNo < RecordCount then
    begin
      for i := RecordCount downto RecNo+1 do
      begin
        RecNo := i;
        ordem_p := FieldByName('ORDEM').AsInteger;
        Edit;
        FieldByName('ORDEM').AsInteger := ordem_p+1;
        Post;
      end;
    end;

    Append;
    FieldByName('LOCAL').Value := param.Values['_LOCAL'];
    FieldByName('TIPO').Value := 'LETRA';
    FieldByName('MUSICA_ID').Value := param.Values['_MUSICA_ID'];
    FieldByName('LETRA_ID').Value := param.Values['_LETRA_ID'];
    FieldByName('URL_MUSICA').Value := param.Values['_URL_MUSICA'];
    FieldByName('ORDEM').Value := ordem+1;
    FieldByName('IMAGEM').Value := param.Values['_IMAGEM'];
    FieldByName('IMAGEM_POSICAO').Value := param.Values['_IMAGEM_POSICAO'];
    FieldByName('COR_FUNDO').Value := param.Values['_COR_FUNDO'];
    FieldByName('TEMPO').Value := '0';
    FieldByName('FUNDO_LETRA').Value := param.Values['_FUNDO_LETRA'];
    FieldByName('TAMANHO_LETRA').Value := param.Values['_TAMANHO_LETRA'];
    FieldByName('TAMANHO_LETRA_AUX').Value := param.Values['_TAMANHO_LETRA_AUX'];
    FieldByName('COR_LETRA').Value := param.Values['_COR_LETRA'];
    FieldByName('COR_LETRA_AUX').Value := param.Values['_COR_LETRA_AUX'];

    if TComponent(Sender).Tag = 2 then
    begin
      FieldByName('LETRA').Value := param.Values['_LETRA'];
      FieldByName('LETRA_UCASE').Value := param.Values['_LETRA_UCASE'];
      FieldByName('LETRA_AUX').Value := param.Values['_LETRA_AUX'];
    end
    else
    begin
      FieldByName('LETRA').Value := '';
      FieldByName('LETRA_UCASE').Value := '';
      FieldByName('LETRA_AUX').Value := '';
    end;
    Post;

    RecNo := StrToInt('0'+param.Values['slide']);
    lbTempos.Items.Insert(RecNo,'0');
  end;

  acaoSlide('prox');
  modifica();
end;

procedure TfEditorSlides.brImportarClick(Sender: TObject);
var
  arquivo: string;
  fileStream: TFileStream;
  utf8Stream: TStringStream;
begin
  try
    fmIndex.Visible := False;
    arquivo := fmIndex.openDialog('geral', 'Arquivo de Texto (*.txt)|*.txt', '');
    fmIndex.Visible := True;
    BringToFront;
    if arquivo <> '' then
    begin
      btNovoSlideClick(btNovoSlide);
      textoLetra.Lines := fmIndex.arquivoCodificado(arquivo);


      DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
      DM.cdsSLIDE_MUSICA2.Edit;
      DM.cdsSLIDE_MUSICA2.FieldByName('LETRA').Value := textoLetra.Text;
      DM.cdsSLIDE_MUSICA2.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(textoLetra.Text);
      DM.cdsSLIDE_MUSICA2.Post;

      btDivideSlideClick(btDivideSlide);

//      modifica();
//      carregaSlide();
    end;
  except
    //
  end;
end;

procedure TfEditorSlides.btProjetaClick(Sender: TObject);
var
  audio: boolean;
  arq: string;
begin
  if btProjeta.Enabled = false then exit;

  if (param.Values['audio']) <> ''
    then audio := true
    else audio := false;

  arq := fmIndex.dir_temp+'~cds.tmp';
  DM.cdsSLIDE_MUSICA2.SaveToFile(arq);

  fmIndex.abreLetraMusica('CDS',arq,-1,audio);
end;

procedure TfEditorSlides.btRemoveAudioClick(Sender: TObject);
begin
  DM.cdsSLIDE_MUSICA2.RecNo := 1;
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('URL_MUSICA').Value := '';
  DM.cdsSLIDE_MUSICA2.Post;
  param.Values['audio'] := '';
  if (btPausePlay.ImageIndex = 9)
    then btRemoveAudio.Enabled := false
    else btRemoveAudio.Enabled := (param.Values['audio'] <> '');
  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.bsSkinSpeedButton1Click(Sender: TObject);
begin
  acaoSlide('ant');
end;

procedure TfEditorSlides.bsSkinSpeedButton3Click(Sender: TObject);
begin
  acaoSlide('prox');
end;

procedure TfEditorSlides.bsSkinSpeedButton4Click(Sender: TObject);
begin
  acaoSlide('ult');
end;

procedure TfEditorSlides.bsSkinSpeedButton5Click(Sender: TObject);
begin
  acaoSlide('pri');
end;

procedure TfEditorSlides.bsSkinSpeedButton6Click(Sender: TObject);
var
  arq: string;
begin
  fmIndex.Visible := False;
  arq := fmIndex.openDialog('imagem');
  fmIndex.Visible := True;
  BringToFront;

  if (arq <> '') then
  begin
    DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
    DM.cdsSLIDE_MUSICA2.Edit;
    DM.cdsSLIDE_MUSICA2.FieldByName('IMAGEM').Value := arq;
    DM.cdsSLIDE_MUSICA2.Post;
    carregaSlide();
    modifica();
  end;
end;

procedure TfEditorSlides.btAudioClick(Sender: TObject);
var
  arq: string;
begin
  fmIndex.Visible := False;
  arq := fmIndex.openDialog('musica_mp3');
  fmIndex.Visible := True;
  BringToFront;

  if (arq <> '') then
  begin
    DM.cdsSLIDE_MUSICA2.RecNo := 1;
    DM.cdsSLIDE_MUSICA2.Edit;
    DM.cdsSLIDE_MUSICA2.FieldByName('URL_MUSICA').Value := arq;
    DM.cdsSLIDE_MUSICA2.Post;
    param.Values['audio'] := arq;
    if (btPausePlay.ImageIndex = 9)
      then btRemoveAudio.Enabled := false
      else btRemoveAudio.Enabled := (param.Values['audio'] <> '');
    DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
    carregaSlide();
    modifica();
  end;
end;

procedure TfEditorSlides.btRemoveImagemClick(Sender: TObject);
begin
  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('IMAGEM').Value := '';
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.btExcluiSlideClick(Sender: TObject);
begin
  with DM.cdsSLIDE_MUSICA2 do
  begin
    RecNo := StrToInt('0'+param.Values['slide']);
    if RecordCount <= 1 then
    begin
      lbTempos.Items[RecNo-1] := '0';
      Edit;
      FieldByName('LETRA').Value := '';
      FieldByName('LETRA_UCASE').Value := '';
      FieldByName('LETRA_AUX').Value := '';
      Post;
    end
    else
    begin
      lbTempos.Items.Delete(RecNo-1);
      Delete;
    end;

    if StrToInt('0'+param.Values['slide']) > RecordCount then
      param.Values['slide'] := IntToStr(RecordCount);

    RecNo := StrToInt('0'+param.Values['slide']);
  end;

  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.btGravaAClick(Sender: TObject);
begin
  if btGravaA.Enabled = false then exit;

  acaoSlide('prox_grava');
end;

procedure TfEditorSlides.btGravaIClick(Sender: TObject);
var
  tempo: Integer;
begin
  if btGravaI.Enabled = false then exit;

  tempo := BASS_ChannelGetPosition(bass_channel, BASS_POS_BYTE);
  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').Value := tempo;
  DM.cdsSLIDE_MUSICA2.Post;
  gSlide.Min {LAZARUS: TProgressBar.MinValue->Min} := tempo;
  lbTempos.Items[DM.cdsSLIDE_MUSICA2.RecNo-1] := IntToStr(tempo);
  modifica;
end;

procedure TfEditorSlides.btGravaRClick(Sender: TObject);
var
  tempo: Integer;
begin
  if btGravaR.Enabled = false then exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  if DM.cdsSLIDE_MUSICA2.RecNo = 1 then
  begin
    gSlide.Min {LAZARUS: TProgressBar.MinValue->Min} := 0;
    BASS_ChannelSetPosition(bass_channel, 0, BASS_POS_BYTE);
    Exit;
  end;

  tempo := StrToInt(lbTempos.Items[DM.cdsSLIDE_MUSICA2.RecNo-1])-100000;
  if tempo <= 0 then
    tempo := 0;

  gSlide.Min {LAZARUS: TProgressBar.MinValue->Min} := tempo;
  BASS_ChannelSetPosition(bass_channel, tempo, BASS_POS_BYTE);

  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').Value := tempo;
  DM.cdsSLIDE_MUSICA2.Post;
  lbTempos.Items[DM.cdsSLIDE_MUSICA2.RecNo-1] := IntToStr(tempo);
  modifica;
end;

procedure TfEditorSlides.btMesclaSlideClick(Sender: TObject);
var
  reg: Integer;
begin
  with DM.cdsSLIDE_MUSICA2 do
  begin
    reg := StrToInt('0'+param.Values['slide']);
    RecNo := reg;

    if RecNo < RecordCount then
    begin
      acaoSlide('prox');

      param.Values['_LOCAL'] := FieldByName('LOCAL').Value;
      param.Values['_MUSICA_ID'] := FieldByName('MUSICA_ID').Value;
      param.Values['_LETRA_ID'] := FieldByName('LETRA_ID').Value;
      param.Values['_URL_MUSICA'] := FieldByName('URL_MUSICA').Value;
      param.Values['_IMAGEM'] := FieldByName('IMAGEM').Value;
      param.Values['_IMAGEM_POSICAO'] := FieldByName('IMAGEM_POSICAO').Value;
      param.Values['_COR_FUNDO'] := FieldByName('COR_FUNDO').Value;
      param.Values['_FUNDO_LETRA'] := FieldByName('FUNDO_LETRA').Value;
      param.Values['_TAMANHO_LETRA'] := FieldByName('TAMANHO_LETRA').Value;
      param.Values['_TAMANHO_LETRA_AUX'] := FieldByName('TAMANHO_LETRA_AUX').Value;
      param.Values['_COR_LETRA'] := FieldByName('COR_LETRA').Value;
      param.Values['_COR_LETRA_AUX'] := FieldByName('COR_LETRA_AUX').Value;
      param.Values['_LETRA'] := FieldByName('LETRA').Value;
      param.Values['_LETRA_UCASE'] := FieldByName('LETRA_UCASE').Value;
      param.Values['_LETRA_AUX'] := FieldByName('LETRA_AUX').Value;

      btExcluiSlideClick(btExcluiSlide);
      RecNo := reg;

      param.Values['_LETRA'] := FieldByName('LETRA').Value+#13#10+param.Values['_LETRA'];

      Edit;
      FieldByName('LETRA').Value := param.Values['_LETRA'];
      FieldByName('LETRA_UCASE').Value := AnsiUpperCase(param.Values['_LETRA']);
      Post;

      param.Values['slide'] := IntToStr(reg);
    end;
  end;

  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.btAbrirClick(Sender: TObject);
var
  arquivo: string;
  msg: integer;
begin
  if (param.Values['modifica'] = '1') then
  begin
    msg := application.MessageBox('Deseja salvar as modifica��es deste arquivo?', fmIndex.titulo, mb_yesnocancel + mb_iconquestion);
    if (msg = 2) then exit;
    if (msg = 6) then
    begin
      btSalvarClick(Sender);
      if (param.Values['modifica'] = '1') then Exit;
    end;
  end;
  try
    fmIndex.Visible := False;
    arquivo := fmIndex.openDialog('geral', 'Apresenta��o LouvorJA (*.slja;*.lja)|*.slja;*.lja', '');
    fmIndex.Visible := True;
    BringToFront;
    if arquivo <> '' then
    begin
      param.Values['novo'] := '0';
      param.Values['arquivo'] := arquivo;
      param.Values['modifica'] := '0';
      geraTitulo();
      Text2CDS();
      param.Values['slide'] := '1';
      carregaSlide();
    end;
  except
    //
  end;
end;

procedure TfEditorSlides.btDivideSlideClick(Sender: TObject);
var
  i: integer;
  ordem,ordem_p: Integer;
begin
  with DM.cdsSLIDE_MUSICA2 do
  begin
    RecNo := StrToInt('0'+param.Values['slide']);

    fmIndex.paramtemp.Lines.Clear;
    fmIndex.paramtemp.Text := textoLetra.Text;

    ordem := FieldByName('ORDEM').Value;
    param.Values['_LOCAL'] := FieldByName('LOCAL').Value;
    param.Values['_MUSICA_ID'] := FieldByName('MUSICA_ID').Value;
    param.Values['_LETRA_ID'] := FieldByName('LETRA_ID').Value;
    param.Values['_URL_MUSICA'] := FieldByName('URL_MUSICA').Value;
    param.Values['_IMAGEM'] := FieldByName('IMAGEM').Value;
    param.Values['_IMAGEM_POSICAO'] := FieldByName('IMAGEM_POSICAO').Value;
    param.Values['_COR_FUNDO'] := FieldByName('COR_FUNDO').Value;
    param.Values['_FUNDO_LETRA'] := FieldByName('FUNDO_LETRA').Value;
    param.Values['_TAMANHO_LETRA'] := FieldByName('TAMANHO_LETRA').Value;
    param.Values['_TAMANHO_LETRA_AUX'] := FieldByName('TAMANHO_LETRA_AUX').Value;
    param.Values['_COR_LETRA'] := FieldByName('COR_LETRA').Value;
    param.Values['_COR_LETRA_AUX'] := FieldByName('COR_LETRA_AUX').Value;
    param.Values['_LETRA'] := FieldByName('LETRA').Value;
    param.Values['_LETRA_UCASE'] := FieldByName('LETRA_UCASE').Value;
    param.Values['_LETRA_AUX'] := FieldByName('LETRA_AUX').Value;

    if RecNo < RecordCount then
    begin
      for i := RecordCount downto RecNo+1 do
      begin
        RecNo := i;
        ordem_p := FieldByName('ORDEM').AsInteger;
        Edit;
        FieldByName('ORDEM').AsInteger := ordem_p+fmIndex.paramtemp.Lines.Count;
        Post;
      end;
    end;

    for i := 0 to fmIndex.paramtemp.Lines.Count-1 do
    begin
      if i = 0 then
      begin
        RecNo := StrToInt('0'+param.Values['slide']);
        Edit;
      end
      else
      begin
        lbTempos.Items.Insert(RecNo,'0');
        Append;
        FieldByName('LOCAL').Value := param.Values['_LOCAL'];
        FieldByName('TIPO').Value := 'LETRA';
        FieldByName('MUSICA_ID').Value := param.Values['_MUSICA_ID'];
        FieldByName('LETRA_ID').Value := param.Values['_LETRA_ID'];
        FieldByName('URL_MUSICA').Value := param.Values['_URL_MUSICA'];
        FieldByName('ORDEM').Value := ordem+i;
        FieldByName('IMAGEM').Value := param.Values['_IMAGEM'];
        FieldByName('IMAGEM_POSICAO').Value := param.Values['_IMAGEM_POSICAO'];
        FieldByName('COR_FUNDO').Value := param.Values['_COR_FUNDO'];
        FieldByName('TEMPO').Value := '0';
        FieldByName('FUNDO_LETRA').Value := param.Values['_FUNDO_LETRA'];
        FieldByName('TAMANHO_LETRA').Value := param.Values['_TAMANHO_LETRA'];
        FieldByName('TAMANHO_LETRA_AUX').Value := param.Values['_TAMANHO_LETRA_AUX'];
        FieldByName('COR_LETRA').Value := param.Values['_COR_LETRA'];
        FieldByName('COR_LETRA_AUX').Value := param.Values['_COR_LETRA_AUX'];
      end;
      FieldByName('LETRA').Value := StringReplace(fmIndex.paramtemp.Lines[i],'|', #13#10, [rfIgnoreCase, rfReplaceAll]);
      FieldByName('LETRA_UCASE').Value := AnsiUpperCase(StringReplace(fmIndex.paramtemp.Lines[i],'|', #13#10, [rfIgnoreCase, rfReplaceAll]));
      FieldByName('LETRA_AUX').Value := param.Values['_LETRA_AUX'];
      Post;
    end;

    RecNo := StrToInt('0'+param.Values['slide']);
  end;

  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.btNovoClick(Sender: TObject);
var
  msg: integer;
begin
  if (param.Values['modifica'] = '1') then
  begin
    msg := application.MessageBox('Deseja salvar as modifica��es deste arquivo?', fmIndex.titulo, mb_yesnocancel + mb_iconquestion);
    if (msg = 2) then exit;

    if (msg = 6) then
    begin
      btSalvarClick(Sender);
      if (param.Values['modifica'] = '1') then Exit;
    end;
  end;
  param.Values['novo'] := '1';
  param.Values['arquivo'] := '';
  param.Values['modifica'] := '0';
  param.Values['slide'] := '1';
  geraTitulo();
  Text2CDS();
  carregaSlide();
end;

procedure TfEditorSlides.btPausePlayClick(Sender: TObject);
begin
  if btPausePlay.ImageIndex = 8 then
  begin
    if (Trim(param.Values['audio']) = '') then
    begin
      application.MessageBox('Escolha um arquivo de �udio para reproduzir!', fmIndex.titulo, mb_ok + mb_iconexclamation);
      Exit;
    end
    else if not (FileExists(param.Values['audio'])) then
    begin
      application.MessageBox('Arquivo de �udio n�o localizado!', fmIndex.titulo, mb_ok + mb_iconerror);
      Exit;
    end
    else if (StrToInt('0'+param.Values['slide']) > 1) and (StrToInt(lbTempos.Items[StrToInt('0'+param.Values['slide'])-1]) <= 0) then
    begin
      application.MessageBox('N�o h� tempo gravado neste slide! Reproduza a partir do primeiro slide para come�ar a gravar os tempos.', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
      Exit;
    end
  end;
  pauseplay;
end;

procedure TfEditorSlides.btRemoveGrClick(Sender: TObject);
begin
  if (application.MessageBox('Deseja realmente remover os tempos dos slides?', fmIndex.titulo, mb_yesno + mb_iconquestion) = 6) then
  begin
    DM.cdsSLIDE_MUSICA2.First;
    while not DM.cdsSLIDE_MUSICA2.Eof do
    begin
      DM.cdsSLIDE_MUSICA2.Edit;
      DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').Value := '0';
      DM.cdsSLIDE_MUSICA2.Post;
      lbTempos.Items[DM.cdsSLIDE_MUSICA2.RecNo-1] := '0';

      if DM.cdsSLIDE_MUSICA2.RecordCount = DM.cdsSLIDE_MUSICA2.RecNo then Break;
      DM.cdsSLIDE_MUSICA2.Next;
    end;
    DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
    modifica();
  end;
end;

procedure TfEditorSlides.btRes0Click(Sender: TObject);
var
  tag: integer;
  w,h: integer;
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;

  btRes0.Down := (tag = 0);
  btRes43.Down := (tag = 43);
  btRes169.Down := (tag = 169);

  if tag = 0 then
  begin
    Panel.Align := alClient;
  end
  else
  begin
    Panel.Align := alNone;
    w := areaPanel.Width;
    if tag = 43
      then h := Trunc(w/4*3)
      else h := Trunc(w/16*9);

    if h > areaPanel.Height then
    begin
      h := areaPanel.Height;
      if tag = 43
        then w := Trunc(h/3*4)
        else w := Trunc(h/9*16);
    end;

    Panel.Width := w;
    Panel.Height := h;
    Panel.Top := trunc(areaPanel.Height/2)-trunc(Panel.Height/2);
    Panel.Left := trunc(areaPanel.Width/2)-trunc(Panel.Width/2);
  end;
  carregaSlide();
  fmIndex.ajustaImagem(imgFundo,pnlLetra,StrToInt('0'+param.Values['posicao']));
end;

procedure TfEditorSlides.btSalvarClick(Sender: TObject);
begin
  if (param.Values['arquivo'] = '') then
  begin
    btSalvarComoClick(Sender);
    Exit;
  end;

  if (LowerCase(ExtractFileExt(param.Values['arquivo'])) <> '.slja') then
  begin
    btSalvarComoClick(Sender);
    Exit;
  end;

  try
    CDS2Text();
    param.Values['novo'] := '0';
    param.Values['modifica'] := '0';
  except
    //
  end;
  geraTitulo();
end;

procedure TfEditorSlides.btSalvarComoClick(Sender: TObject);
var
  arquivo: string;
begin
  fmIndex.Visible := False;
  arquivo := fmIndex.saveDialog('geral', 'Apresenta��o LouvorJA (*.slja)|*.slja');
  fmIndex.Visible := True;
  BringToFront;
  if arquivo <> '' then
  begin
    try
      param.Values['arquivo'] := arquivo;
      CDS2Text();
      param.Values['novo'] := '0';
      param.Values['modifica'] := '0';
    except
      param.Values['arquivo'] := '';
    end;
  end;
  geraTitulo();
end;

procedure TfEditorSlides.carregaImagem(dir: string);
var
  Bitmap : TBitMap;
begin
  imgFundo.Visible := false;
  if not (FileExists(dir))
    then imgFundo.Picture := nil
  else
  begin
    imgFundo.Picture.LoadFromFile(dir);
    fmIndex.ajustaImagem(imgFundo,pnlLetra,StrToInt('0'+param.Values['posicao']));

    Bitmap := TBitmap.Create;
    Bitmap.Assign(imgFundo.Picture.Graphic);
    try
      with Bitmap do begin
        Canvas.Draw(0,0,BitMap);
      end;
    finally
      Bitmap.Free;
    end;
  end;

  imgFundo.Visible := true;
end;

procedure TfEditorSlides.carregaMusica;
var
  f: PChar;
  musica: string;
begin
  musica := param.Values['audio'];
  musica := StringReplace(musica,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
  {LAZARUS: removidas conversões '/' → '\' — inválidas no Linux}
  // check the correct BASS was loaded
  if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
  begin
    application.MessageBox('A vers�o do seu arquivo "libbass.so" est� incorreta!', fmIndex.titulo, mb_ok + mb_iconerror);
    Exit;
    //Halt;
  end;

  // Initialize audio - default device, 44100hz, stereo, 16 bits
  if not BASS_Init(-1, 44100, 0, nil, nil) {LAZARUS: Handle→nil (Linux BASS_Init)} then
  begin
    Error('Erro ao iniciar �udio "'+musica+'"!');
    Exit;
  end;

  f := PChar(musica);
  try
    bass_musica := BASS_SampleLoad(FALSE, PChar(f), 0, 0, 3, BASS_SAMPLE_OVER_POS); {LAZARUS: removido BASS_UNICODE — flag Windows-only; Linux BASS usa UTF-8 nativo}
    bass_channel := BASS_SampleGetChannel(bass_musica, False);
//      BASS_ChannelSetAttribute(bass_channel, BASS_ATTRIB_PAN, 0);
//      BASS_ChannelSetAttribute(bass_channel, BASS_ATTRIB_VOL, 1);
    if not BASS_ChannelPlay(bass_channel, False) then
    begin
      Error('Erro ao reproduzir �udio "'+musica+'"!');
      Exit;
    end;
  except
    Application.MessageBox(PChar('O programa travou ao tentar reproduzir �udio "'+musica+'"'),fmIndex.TITULO,MB_OK+MB_ICONERROR);
    Exit;
  end;

  param.Values['audio_rep'] := musica;

end;

procedure TfEditorSlides.carregaSlide(setPosicao: Boolean);
var
  posT: integer;
  nslide: Integer;
  txt: TStringList;
  stempo: string;
begin
  carregando_slide := True;

  DBGrid1.DataSource.DataSet.RecNo := StrToInt('0'+param.Values['slide']);
  DBGrid1.Refresh;

  lblLetra.Visible := False;
  lblLetra_aux.Visible := False;
  imgFundoTexto.Visible := False;

  with DM.cdsSLIDE_MUSICA2 do
  begin
    if RecNo = 1 then
    begin
      param.Values['audio'] := StringReplace(FieldByName('URL_MUSICA').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
      {LAZARUS: removidas conversões '/' → '\' — inválidas no Linux}
      if (btPausePlay.ImageIndex = 9)
        then btRemoveAudio.Enabled := false
        else btRemoveAudio.Enabled := (param.Values['audio'] <> '');
    end;
    textoLetra.Text := FieldByName('LETRA').AsString;
    textoLetraAux.Text := FieldByName('LETRA_AUX').AsString;
    tamanhoLetra.Value := FieldByName('TAMANHO_LETRA').AsInteger;
    tamanhoLetra_aux.Value := FieldByName('TAMANHO_LETRA_AUX').AsInteger;
    corLetra.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(FieldByName('COR_LETRA').AsString);
    corLetra_aux.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(FieldByName('COR_LETRA_AUX').AsString);
    corFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(FieldByName('COR_FUNDO').AsString);
    btRemoveImagem.Enabled := (FieldByName('IMAGEM').AsString <> '');
    posicaoFundo.ItemIndex := FieldByName('IMAGEM_POSICAO').AsInteger - 1; {LAZARUS: .Value→.AsInteger evita Null variant}
    fundoTransparente.Checked := not FieldByName('FUNDO_LETRA').AsBoolean;

    param.Values['imagem'] := StringReplace(FieldByName('IMAGEM').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
    param.Values['posicao'] := FieldByName('IMAGEM_POSICAO').AsString;
    if (param.Values['imagem'] <> '') then
    begin
      if (param.Values['imagem'] <> param.Values['u_imagem']) then
      begin
        param.Values['u_imagem'] := param.Values['imagem'];
        param.Values['u_posicao'] := param.Values['posicao'];
        {LAZARUS: removidas conversões '/' → '\' — inválidas no Linux}

        carregaImagem(param.Values['imagem']);
      end
      else if param.Values['u_posicao'] <> param.Values['posicao'] then
      begin
        param.Values['u_posicao'] := param.Values['posicao'];
        fmIndex.ajustaImagem(imgFundo,pnlLetra,StrToInt('0'+param.Values['posicao']));
      end;
    end
    else
    begin
      imgFundo.Picture := nil;
      param.Values['u_imagem'] := '';
      param.Values['u_posicao'] := '';
    end;

    if (tamanhoLetra.Value <= 0) then
    begin
      if FieldByName('TIPO').AsString = 'CAPA'
        then tamanhoLetra.Value := 18
        else tamanhoLetra.Value := 14
    end;
    if (tamanhoLetra_aux.Value <= 0) then tamanhoLetra_aux.Value := 10;
    lblLetra.Caption := Ansiuppercase(textoLetra.Text);
    lblLetra_aux.Caption := Ansiuppercase(textoLetraAux.Text);
    lblLetra.Font.Color := corLetra.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    lblLetra_aux.Font.Color := corLetra_aux.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlLetra.Color := corFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    lblSlides.Caption := 'SLIDE    '+inttostr(RecNo)+' / '+inttostr(RecordCount);
  end;

  if Trim(lblLetra.Caption) <> '' then
  begin
    ajustaTexto();
    lblLetra.Visible := True;
    if Trim(lblLetra_aux.Caption) <> '' then
      lblLetra_aux.Visible := True;
    imgFundoTexto.Visible := not fundoTransparente.Checked;
  end;

  if (setPosicao) and not(pause) then
  begin
    nslide := StrToInt(param.Values['slide'])-1;
    stempo := lbTempos.Items[nslide];
    if Pos(':',stempo) > 0 then
    begin
      txt := TStringList.Create;
      ExtractStrings([':'], [], PChar(stempo), txt);
      stempo := inttostr((StrToInt('0'+txt[0])*60)+StrToInt('0'+txt[1]));
      stempo := IntToStr(BASS_ChannelSeconds2Bytes(bass_channel,StrToFloat(stempo)));
      lbTempos.Items[nslide] := stempo;
    end;
    posT := strtoint(StringReplace(lbTempos.Items[nslide],':','', [rfIgnoreCase, rfReplaceAll]));

    if (nslide > 0) and (posT = 0) then
    begin
      gSlide.Position {LAZARUS: TProgressBar.Value->Position} := 0;
      pauseplay;
    end
    else
    begin
      gSlide.Min {LAZARUS: TProgressBar.MinValue->Min} := posT;
      BASS_ChannelSetPosition(bass_channel, posT, BASS_POS_BYTE);
      tmrTempo.Enabled := True;
    end;
  end
  else
  begin
    gSlide.Position {LAZARUS: TProgressBar.Value->Position} := 0;
    gSlideTotal.Max {LAZARUS: TProgressBar.MaxValue->Max} := DM.cdsSLIDE_MUSICA2.RecordCount;
    gSlideTotal.Position {LAZARUS: TProgressBar.Value->Position} := StrToInt(param.Values['slide'])-1;
  end;

  tmrSlideCarregado.Enabled := True;
//  carregando_slide := False;
end;

procedure TfEditorSlides.CDS2Text;
var
  arquivo: string;
begin
  arquivo := param.Values['arquivo'];
  fmIndex.copiaSlidesParaArquivo(arquivo,DM.cdsSLIDE_MUSICA2);
end;

procedure TfEditorSlides.corFundoChangeColor(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('COR_FUNDO').Value := ColorToString(corFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.corLetraChangeColor(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('COR_LETRA').Value := ColorToString(corLetra.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.corLetra_auxChangeColor(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('COR_LETRA_AUX').Value := ColorToString(corLetra_aux.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  if not FileExists(ParamStr(1))
    then Params.WndParent := 0;
end;

procedure TfEditorSlides.DBGrid1CellClick(Column: TColumn {LAZARUS: TbsColumn});
begin
  param.Values['slide'] := IntToStr(DBGrid1.DataSource.DataSet.RecNo);
  carregaSlide();
end;

procedure TfEditorSlides.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn};
  State: TGridDrawState);
var
  R: TRect;
begin
  if DM.cdsSLIDE_MUSICA2.RecNo = 1 then
    DBGrid1.Canvas.Font.Color := $02AC3F6;
  DBGrid1.Canvas.Brush.Color := $00353535;

  if DM.cdsSLIDE_MUSICA2.RecNo = StrToInt('0'+param.Values['slide']) then
  begin
    DBGrid1.Canvas.Brush.Color := $00FFFFFF;
    DBGrid1.Canvas.Font.Color := $00353535;
  end;

  if (Column.Index = 2)
    and (DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').AsString <> '')
    and (DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').AsString <> '0')
  then
  begin
    DBGrid1.Canvas.Brush.Color := $000C6FD;
  end;

  R := Rect;
  Dec(R.Bottom, 0);
  R.Top := R.Top + 10;
  R.Left := R.Left + 10;

  if Column.Index = 0 then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    DrawText(DBGrid1.Canvas.Handle, PChar(IntToStr(DM.cdsSLIDE_MUSICA2.RecNo)), Length(IntToStr(DM.cdsSLIDE_MUSICA2.RecNo)), R, DT_WORDBREAK);
  end
  else if Column.Field = DM.cdsSLIDE_MUSICA2.FieldByName('LETRA_UCASE') then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    DrawText(DBGrid1.Canvas.Handle, PChar(DM.cdsSLIDE_MUSICA2.FieldByName('LETRA_UCASE').AsString), Length(DM.cdsSLIDE_MUSICA2.FieldByName('LETRA_UCASE').AsString), R, DT_WORDBREAK);
  end
  else
  begin
    DBGrid1.Canvas.FillRect(Rect);
    DrawText(DBGrid1.Canvas.Handle, '', 40, R, DT_WORDBREAK);
  end;
end;

procedure TfEditorSlides.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TfEditorSlides.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfEditorSlides.dbGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn};
  State: TGridDrawState);
begin
  fmIndex.DBGridDrawColumnCell(Sender,Rect,DataCol,Column,State);
end;

procedure TfEditorSlides.Error(msg: string);
var
	s: string;
begin
	s := msg + #13#10 + 'Verifique se o dispositivo de �udio est� conectado em seu computador.' + #13#10 + '(C�digo do Erro: ' + IntToStr(BASS_ErrorGetCode) + ')';
  application.MessageBox(PChar(s), fmIndex.titulo, mb_ok + mb_iconerror);
end;

procedure TfEditorSlides.FormActivate(Sender: TObject);
begin
//  fmIndex.WindowState := wsMinimized;
  if (param.Values['load'] <> '1') then
  begin
    bsRibbon1.ActivePage := bsArquivo;
    pause := true;
    acaoPauseplay(false);

    fmIndex.desenvolvedor(fmIndex.pnlModDes.Visible);

    if not DM.cdsSLIDE_MUSICA2.Active then
    begin
      DM.cdsSLIDE_MUSICA2.CreateDataSet;
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges}
    end;
    DM.cdsSLIDE_MUSICA2.Open;
    {LAZARUS: EmptyDataSet -> loop de delecao (TBufDataset)}
    DM.cdsSLIDE_MUSICA2.First;
    while not DM.cdsSLIDE_MUSICA2.EOF do DM.cdsSLIDE_MUSICA2.Delete;

    {LAZARUS: DIN Condensed só existe no Windows; no Linux usa Fira Sans Condensed como fallback}
    if Screen.Fonts.IndexOf('DIN Condensed') >= 0
      then lblLetra.Font.Name := 'DIN Condensed'
      else lblLetra.Font.Name := 'Fira Sans Condensed';
    lblLetra_aux.Font.Name := lblLetra.Font.Name;
    carregando_slide := True;

    btNovoClick(Sender);
    param.Values['load'] := '1';
  end;
end;

procedure TfEditorSlides.FormClose(Sender: TObject; var Action: TCloseAction);
var
  msg: integer;
begin
  if (btPausePlay.ImageIndex <> 8) then
  begin
    pauseplay;
  end;

  if (param.Values['modifica'] = '1') then
  begin
    msg := application.MessageBox('Deseja salvar as modifica��es deste arquivo?', fmIndex.titulo, mb_yesnocancel + mb_iconquestion);
    if (msg = 2) then
    begin
      Action := caNone;
      exit;
    end;

    if (msg = 6) then
    begin
      btSalvarClick(Sender);
      if (param.Values['modifica'] = '1') then Action := caNone;
    end;
  end;

  param.Values['load'] := '';
end;

procedure TfEditorSlides.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfEditorSlides.fundoTransparenteClick(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('FUNDO_LETRA').AsBoolean := not fundoTransparente.Checked;
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.geraTitulo;
var
  titulo: string;
begin
  titulo := '';

  if (param.Values['modifica'] = '1') then
    titulo := titulo + '* ';

  if (param.Values['arquivo'] <> '') then
    titulo := titulo + '['+param.Values['arquivo']+']'
  else
    titulo := titulo + 'Novo';

  titulo := titulo + ' - Editor de M�sicas';
  Caption := titulo;
end;

procedure TfEditorSlides.modifica;
begin
  param.Values['modifica'] := '1';
  geraTitulo();
end;

procedure TfEditorSlides.pauseplay;
begin
  acaoPauseplay(pause);

  pause := not pause;
  if not pause then
    carregaSlide(True);
  tmrTempo.Enabled := not pause;
end;

procedure TfEditorSlides.posicaoFundoClick(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('IMAGEM_POSICAO').Value := IntToStr(posicaoFundo.ItemIndex+1);
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.replicaFormatacaoFundo(Sender: TObject);
var
  ctag: Integer;
  i,ini,fin: Integer;
begin
  ctag := TComponent(Sender).Tag;

  with DM.cdsSLIDE_MUSICA2 do
  begin
    if ctag = 1 then
    begin
      ini := StrToInt('0'+param.Values['slide']);
      fin := ini+1;
    end
    else if ctag = 2 then
    begin
      ini := StrToInt('0'+param.Values['slide']);
      fin := RecordCount;
    end
    else if ctag = 3 then
    begin
      ini := 1;
      fin := RecordCount;
    end
    else
    begin
      ini := 0;
      fin := 0;
    end;

    if (fin > RecordCount) then fin := RecordCount;


    RecNo := ini;
    param.Values['_COR_FUNDO'] := FieldByName('COR_FUNDO').Value;
    param.Values['_IMAGEM'] := FieldByName('IMAGEM').Value;
    param.Values['_IMAGEM_POSICAO'] := FieldByName('IMAGEM_POSICAO').Value;

    for i := ini to fin do
    begin
      RecNo := i;
      Edit;
      FieldByName('COR_FUNDO').Value := param.Values['_COR_FUNDO'];
      FieldByName('IMAGEM').Value := param.Values['_IMAGEM'];
      FieldByName('IMAGEM_POSICAO').Value := param.Values['_IMAGEM_POSICAO'];
      Post;
    end;

    RecNo := StrToInt('0'+param.Values['slide']);

  end;

  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.tamanhoLetraChange(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('TAMANHO_LETRA').Value := tamanhoLetra.Value;
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.tamanhoLetra_auxChange(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('TAMANHO_LETRA_AUX').Value := tamanhoLetra_aux.Value;
  DM.cdsSLIDE_MUSICA2.Post;
  carregaSlide();
  modifica();
end;

procedure TfEditorSlides.Text2CDS;
var
  arquivo: string;
  arquivo_tmp: TStringList;
  Unzip: TUnZipper; {LAZARUS: TZipFile → TUnZipper (zipper unit)}
  dir_t: string;
begin
  {LAZARUS: EmptyDataSet -> loop de delecao (TBufDataset)}
    DM.cdsSLIDE_MUSICA2.First;
    while not DM.cdsSLIDE_MUSICA2.EOF do DM.cdsSLIDE_MUSICA2.Delete;

  arquivo := param.Values['arquivo'];
  if (Trim(arquivo) = '') then
  begin
    arquivo := fmIndex.dir_temp+'~editor.tmp';
    arquivo_tmp := TStringList.Create();
    arquivo_tmp.Clear;
    arquivo_tmp.Add('[Geral]');
    arquivo_tmp.Add('slides=3');
    arquivo_tmp.Add('[Slide:1]');
    arquivo_tmp.Add('tipo=CAPA');
    arquivo_tmp.Add('letra=Título');
    arquivo_tmp.Add('fundo_letra=1');
    arquivo_tmp.Add('tamanho_letra=18');
    arquivo_tmp.Add('tamanho_letra_aux=10');
    arquivo_tmp.Add('cor_letra=#efb400');
    arquivo_tmp.Add('cor_letra_aux=#efb400');
    arquivo_tmp.Add('[Slide:2]');
    arquivo_tmp.Add('tipo=LETRA');
    arquivo_tmp.Add('letra=Texto');
    arquivo_tmp.Add('fundo_letra=1');
    arquivo_tmp.Add('tamanho_letra=14');
    arquivo_tmp.Add('tamanho_letra_aux=10');
    arquivo_tmp.Add('cor_letra=#FFFFFF');
    arquivo_tmp.Add('cor_letra_aux=#efb400');
    arquivo_tmp.Add('[Slide:3]');
    arquivo_tmp.Add('tipo=LETRA');
    arquivo_tmp.Add('letra=');
    arquivo_tmp.Add('fundo_letra=1');
    arquivo_tmp.Add('tamanho_letra=14');
    arquivo_tmp.Add('tamanho_letra_aux=10');
    arquivo_tmp.Add('cor_letra=#FFFFFF');
    arquivo_tmp.Add('cor_letra_aux=#efb400');
    arquivo_tmp.SaveToFile(arquivo);

    param.Values['arquivo_temp'] := arquivo;
  end
  else if (ExtractFileExt(arquivo) = '.slja') then
  begin
    Unzip := TUnZipper.Create; {LAZARUS: TZipFile.Create → TUnZipper.Create}
    try
      dir_t := fmIndex.dir_temp+'~edit_'+FormatDateTime('yyyymmddHHMMSSZZZ', now());
      Unzip.FileName := arquivo;
      Unzip.OutputPath := dir_t;
      Unzip.Examine;
      Unzip.UnZipAllFiles;
      arquivo := dir_t+'/slides.lja'; {LAZARUS: '\' → '/' (Linux path)}
    finally
      Unzip.Free;
    end;
  end;

  lbTempos.items.Clear;
  fmIndex.copiaArquivoParaSlides(arquivo,DM.cdsSLIDE_MUSICA2,false,lbTempos,true);

  if dbGrid.Visible then fmIndex.AjustaLarguraCamposDBGrid(dbGrid);
end;

procedure TfEditorSlides.textoLetraAuxChange(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('LETRA_AUX').Value := textoLetraAux.Text;
  DM.cdsSLIDE_MUSICA2.Post;
//  carregaSlide();

  lblLetra_aux.Caption := AnsiUpperCase(textoLetraAux.Text);

  lblLetra.Visible := False;
  lblLetra_aux.Visible := False;
  imgFundoTexto.Visible := False;
  if Trim(lblLetra.Caption) <> '' then
  begin
    ajustaTexto();
    lblLetra.Visible := True;
    if Trim(lblLetra_aux.Caption) <> '' then
      lblLetra_aux.Visible := True;
    imgFundoTexto.Visible := not fundoTransparente.Checked;
  end;

  modifica();
end;

procedure TfEditorSlides.textoLetraChange(Sender: TObject);
begin
  if carregando_slide then Exit;

  DM.cdsSLIDE_MUSICA2.RecNo := StrToInt('0'+param.Values['slide']);
  DM.cdsSLIDE_MUSICA2.Edit;
  DM.cdsSLIDE_MUSICA2.FieldByName('LETRA').Value := textoLetra.Text;
  DM.cdsSLIDE_MUSICA2.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(textoLetra.Text);
  DM.cdsSLIDE_MUSICA2.Post;
//  carregaSlide();

  lblLetra.Caption := AnsiUpperCase(textoLetra.Text);

  lblLetra.Visible := False;
  lblLetra_aux.Visible := False;
  imgFundoTexto.Visible := False;
  if Trim(lblLetra.Caption) <> '' then
  begin
    ajustaTexto();
    lblLetra.Visible := True;
    if Trim(lblLetra_aux.Caption) <> '' then
      lblLetra_aux.Visible := True;
    imgFundoTexto.Visible := not fundoTransparente.Checked;
  end;

  modifica();
end;

procedure TfEditorSlides.tmrSlideCarregadoTimer(Sender: TObject);
begin
  carregando_slide := false;
  tmrSlideCarregado.Enabled := False;
end;

procedure TfEditorSlides.tmrTempoTimer(Sender: TObject);
var
  B: Boolean;
  posT,len: DWORD;
  nslide,next_time: Integer;
  txt: TStringList;
  stempo: string;
begin
  if (Trim(param.Values['audio']) = '') then
  begin
    tmrTempo.Enabled := false;
    pauseplay;
    application.MessageBox('Escolha um arquivo de�udio para reproduzir!', fmIndex.titulo, mb_ok + mb_iconexclamation);
    Exit;
  end
  else if not (FileExists(param.Values['audio'])) then
  begin
    tmrTempo.Enabled := false;
    pauseplay;
    application.MessageBox('Arquivo de �udio n�o localizado!', fmIndex.titulo, mb_ok + mb_iconerror);
    Exit;
  end
  else if param.Values['audio_rep'] <> param.Values['audio'] then
  begin
    tmrTempo.Enabled := false;
    pauseplay;
    Exit;
  end;

  B := BASS_ChannelIsActive(bass_channel) = BASS_ACTIVE_Playing;
  if B then
  begin
    posT := BASS_ChannelGetPosition(bass_channel, BASS_POS_BYTE);
    len := BASS_ChannelGetLength(bass_channel, BASS_POS_BYTE);
    nslide := StrToInt(param.Values['slide']);
    if nslide < lbTempos.Items.Count then
    begin
      stempo := lbTempos.Items[nslide];
      if Pos(':',stempo) > 0 then
      begin
        txt := TStringList.Create;
        ExtractStrings([':'], [], PChar(stempo), txt);
        stempo := inttostr((StrToInt('0'+txt[1])*60)+StrToInt('0'+txt[2]));
        stempo := IntToStr(BASS_ChannelSeconds2Bytes(bass_channel,StrToFloat(stempo)));
        lbTempos.Items[nslide] := stempo;
      end;
      next_time := StrToInt(lbTempos.Items[nslide]);
    end
    else
    begin
      next_time := 0;
    end;
    param.Values['prox_tempo'] := IntToStr(next_time);

    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
    begin
      if next_time < 0
        then gSlide.Max {LAZARUS: TProgressBar.MaxValue->Max} := len
        else gSlide.Max {LAZARUS: TProgressBar.MaxValue->Max} := next_time;
      gSlide.Position {LAZARUS: TProgressBar.Value->Position} := posT;
      gSlideTotal.Max {LAZARUS: TProgressBar.MaxValue->Max} := len;
      gSlideTotal.Position {LAZARUS: TProgressBar.Value->Position} := posT;
      lblTempo.Caption := fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,posT)))
                                       // +'-'+inttostr(pos)
                                       +' / '
                                       +fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,len)));
    end;
//    Edit3.Text := IntToStr(pos)+' / '+IntToStr(len);//+' / '+FormatDateTime('dd/mm/yyyy HH:MM:SS.ZZZ', now());

    if (next_time > 0) and (posT >= next_time) then
    begin
      gSlide.Min {LAZARUS: TProgressBar.MinValue->Min} := next_time;
//      tmrTempo.Enabled := False;
      acaoSlide('prox',False);
    end;
  end
  else
  begin
    tmrTempo.Enabled := false;
    pauseplay;
  end;
end;


initialization
  {$I fmEditorSlides.lrs}

end.
