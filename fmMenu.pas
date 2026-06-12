unit fmMenu;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/MPlayer/ADODB/MidasLib}
  {LAZARUS: TbsRibbon→TPageControl(RibbonPC), TbsSkin*→LCL equivalentes}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ComCtrls, ImgList, Grids,
  DBGrids, IniFiles, Menus, ExtCtrls, ValEdit, MaskEdit, DateUtils,
  DBCtrls, CheckLst, ClipBrd, Math,
  LCLIntf, LCLType, LMessages, BufDataset,
  FPHTTPClient, opensslsockets, zipper, regexpr, base64,
  FileUtil, LazFileUtils, Process,
  Bass, Generics.Collections, Generics.Defaults,
  RichMemo, FileCtrl, EditBtn, Spin, ColorBox, Calendar,
  ZDataset, LResources;

type
  TMonitorInfo = record
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
  end;
  TMonitorInfoArray = array of TMonitorInfo; {LAZARUS: TArray<TMonitorInfo>}
  TParamItem = record
    Grupo: string;
    Param: string;
    Valor: string;
  end;
  TfmIndex = class(TForm)
    {LAZARUS: IdAntiFreeze1 removido — não necessário no LCL}
    RibbonPC: TPageControl {LAZARUS: TbsRibbon};
    tsColetaneas: TTabSheet {LAZARUS: TbsRibbonPage};
    bsBiblia: TTabSheet {LAZARUS: TbsRibbonPage};
    bsHinario: TTabSheet {LAZARUS: TbsRibbonPage};
    pnlImagemCapa: TPanel;
    imgImagemCapa: TImage;
    PageControl1: TPageControl {LAZARUS: TbsSkinPageControl};
    TabSheet14: TTabSheet {LAZARUS: TbsSkinTabSheet};
    tsJA: TTabSheet {LAZARUS: TbsSkinTabSheet};
    sbColJA: TScrollBox {LAZARUS: TbsSkinScrollBox};
    tsDiversas: TTabSheet {LAZARUS: TbsSkinTabSheet};
    sbColDIV: TScrollBox {LAZARUS: TbsSkinScrollBox};
    tsPersonalizadas: TTabSheet {LAZARUS: TbsSkinTabSheet};
    tsHinario: TTabSheet {LAZARUS: TbsSkinTabSheet};
    DBGrid1: TDBGrid {LAZARUS: TbsSkinDBGrid};
    tsBuscaMusica: TTabSheet {LAZARUS: TbsSkinTabSheet};
    tsBiblia: TTabSheet {LAZARUS: TbsSkinTabSheet};
    tsBuscaBiblica: TTabSheet {LAZARUS: TbsSkinTabSheet};
    tsCronoCulto: TTabSheet {LAZARUS: TbsSkinTabSheet};
    {LAZARUS: mpMusica (TMediaPlayer) removido — audio via BASS (BassPreviewChannel)}
    tsSorteio: TTabSheet {LAZARUS: TbsSkinTabSheet};
    pnlSorteio: TPanel;
    lmdSorteio: TLabel;
    gSorteio: TProgressBar {LAZARUS: TbsSkinGauge};
    opNumSorteado: TEdit {LAZARUS: TbsSkinEdit};
    opNumIndice: TEdit {LAZARUS: TbsSkinEdit};
    tsCronometro: TTabSheet {LAZARUS: TbsSkinTabSheet};
    pnlCrono: TPanel;
    lmdCrono: TLabel;
    gCrono: TProgressBar {LAZARUS: TbsSkinGauge};
    bsButtonModel: TSpeedButton {LAZARUS: TbsSkinButtonEx};
    bsPopupMenuRibon: TPopupMenu {LAZARUS: TbsSkinPopupMenu};
    mnFechaAba: TMenuItem;
    mnFechaTodasAbas: TMenuItem;
    N1: TMenuItem;
    bsSkinScrollBar1: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinScrollBar2: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinScrollBar7: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsRibbonGroup5: TPanel {LAZARUS: TbsRibbonGroup};
    bsBuscaMusica: TTabSheet {LAZARUS: TbsRibbonPage};
    bsSkinPanel1: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel2: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonGroup7: TPanel {LAZARUS: TbsRibbonGroup};
    btAbreColJA: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup8: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton14: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinDBText1: TDBText {LAZARUS: TbsSkinDBText};
    bsRibbonGroup11: TPanel {LAZARUS: TbsRibbonGroup};
    ckgFiltros: TCheckGroup {LAZARUS: TbsSkinCheckGroup};
    bsRibbonGroup2: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton10: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton9: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsConfBiblia: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup3: TPanel {LAZARUS: TbsRibbonGroup};
    btLimpar: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup10: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_Biblia: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonGroup14: TPanel {LAZARUS: TbsRibbonGroup};
    sButton7: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsUtilitarios: TTabSheet {LAZARUS: TbsRibbonPage};
    bsConfBuscaBiblica: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup15: TPanel {LAZARUS: TbsRibbonGroup};
    btLimparBBusca: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup17: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton19: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup18: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_BibliaBusca: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonGroup19: TPanel {LAZARUS: TbsRibbonGroup};
    ckLivros: TCheckListBox {LAZARUS: TbsSkinCheckListBox};
    bsRibbonGroup20: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton20: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsColetPerso: TTabSheet {LAZARUS: TbsRibbonPage};
    ppColetaneasPerso: TPopupMenu {LAZARUS: TbsSkinPopupMenu};
    Modificar1: TMenuItem;
    Excluir1: TMenuItem;
    bsRibbonGroup22: TPanel {LAZARUS: TbsRibbonGroup};
    btAddColPerso: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btAltColPerso: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton24: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    txtUrlInfoColetV: TEdit {LAZARUS: TbsSkinEdit};
    pnlreHino: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinScrollBar11: TScrollBar {LAZARUS: TbsSkinScrollBar};
    reHino: TRichMemo {LAZARUS: TbsSkinRichEdit};
    bsRibbonGroup23: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton25: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton26: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup24: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton28: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton30: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    GridPanel2: TPanel {LAZARUS: TGridPanel};
    txtHino: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinStdLabel3: TLabel {LAZARUS: TbsSkinStdLabel};
    bsLiturgia: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup25: TPanel {LAZARUS: TbsRibbonGroup};
    bsRibbonGroup27: TPanel {LAZARUS: TbsRibbonGroup};
    cbMarcarConc: TCheckBox {LAZARUS: TbsSkinCheckBox};
    pnLivros: TPanel {LAZARUS: TbsSkinExPanel};
    GridPanel15: TPanel {LAZARUS: TGridPanel};
    Button5: TButton {LAZARUS: TbsSkinButton};
    Button6: TButton {LAZARUS: TbsSkinButton};
    Button9: TButton {LAZARUS: TbsSkinButton};
    GridPanel14: TPanel {LAZARUS: TGridPanel};
    Button7: TButton {LAZARUS: TbsSkinButton};
    Button8: TButton {LAZARUS: TbsSkinButton};
    GridPanel13: TPanel {LAZARUS: TGridPanel};
    ckLivros2: TCheckListBox {LAZARUS: TbsSkinCheckListBox};
    pnlAltColPerso: TPanel {LAZARUS: TbsSkinExPanel};
    pnlAddColPerso: TPanel {LAZARUS: TbsSkinExPanel};
    GridPanel18: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel24: TLabel {LAZARUS: TbsSkinStdLabel};
    txtAbrirColet: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    bsSkinStdLabel25: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel26: TLabel {LAZARUS: TbsSkinStdLabel};
    txtCapaColet: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    txtImgInfoColet: TEdit {LAZARUS: TbsSkinEdit};
    txtColetanea: TEdit {LAZARUS: TbsSkinEdit};
    txtUrlInfoColet: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel19: TPanel {LAZARUS: TGridPanel};
    btAddColetPerso: TButton {LAZARUS: TbsSkinButton};
    GridPanel22: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel28: TLabel {LAZARUS: TbsSkinStdLabel};
    txtAbrirColet2: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    bsSkinStdLabel29: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel30: TLabel {LAZARUS: TbsSkinStdLabel};
    txtCapaColet2: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    txtImgInfoColet2: TEdit {LAZARUS: TbsSkinEdit};
    txtColetanea2: TEdit {LAZARUS: TbsSkinEdit};
    txtUrlInfoColet2: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinStdLabel31: TLabel {LAZARUS: TbsSkinStdLabel};
    cbColetaneasPerso: TDBLookupComboBox {LAZARUS: TbsSkinDBLookupComboBox};
    GridPanel17: TPanel {LAZARUS: TGridPanel};
    bsSkinButton1: TButton {LAZARUS: TbsSkinButton};
    bsCronoCulto: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup28: TPanel {LAZARUS: TbsRibbonGroup};
    btLigar: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup30: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton33: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup31: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_EscolaSabatina: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    rbgAudioES: TPanel {LAZARUS: TbsRibbonGroup};
    cgEscSBAudio: TCheckGroup {LAZARUS: TbsSkinCheckGroup};
    bsRibbonDivider11: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel21: TPanel {LAZARUS: TGridPanel};
    cbMusica: TComboBox {LAZARUS: TbsSkinComboBox};
    btOuvir: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup33: TPanel {LAZARUS: TbsRibbonGroup};
    bsRibbonGroup34: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton31: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton27: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSorteio: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup35: TPanel {LAZARUS: TbsRibbonGroup};
    btLimpaSorteio: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider14: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel25: TPanel {LAZARUS: TGridPanel};
    btLimpaSorteioReinicia: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btLimpaSorteioLimpa: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup36: TPanel {LAZARUS: TbsRibbonGroup};
    btAddSorteio: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    pnlSorteioE: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteio: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    pnlSorteioD: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteado: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    GridPanel26: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel41: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel42: TLabel {LAZARUS: TbsSkinStdLabel};
    opSort_Ini: TEdit {LAZARUS: TbsSkinEdit};
    opSort_Fin: TEdit {LAZARUS: TbsSkinEdit};
    bsRibbonGroup37: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_Sorteio: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonGroup38: TPanel {LAZARUS: TbsRibbonGroup};
    btSortear: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup39: TPanel {LAZARUS: TbsRibbonGroup};
    bsRibbonDivider16: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel29: TPanel {LAZARUS: TGridPanel};
    lblNumSortDisp: TLabel {LAZARUS: TbsSkinStdLabel};
    lblNumSortSort: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider18: TBevel {LAZARUS: TbsRibbonDivider};
    ckSorteioExp: TCheckGroup {LAZARUS: TbsSkinCheckGroup};
    bsRibbonGroup41: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton32: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btFormatBiblia: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    pnlFormatBibliaB: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel2: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinDivider2: TBevel {LAZARUS: TbsSkinDivider};
    bsSkinPanel5: TPanel {LAZARUS: TbsSkinPanel};
    btFormatBibliaB: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btFormatEscSB: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    pnlFormatEscSB: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel3: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinDivider7: TBevel {LAZARUS: TbsSkinDivider};
    bsSkinPanel6: TPanel {LAZARUS: TbsSkinPanel};
    gEscSbR: TProgressBar {LAZARUS: TbsSkinGauge};
    pnlEscSB: TPanel;
    pnlFormatSorteio: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel4: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinGroupBox8: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinGroupBox9: TGroupBox {LAZARUS: TbsSkinGroupBox};
    btFormatSorteio: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup13: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton29: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    tsSorteioNM: TTabSheet {LAZARUS: TbsSkinTabSheet};
    pnlFormatSorteioNM: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel5: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinDivider13: TBevel {LAZARUS: TbsSkinDivider};
    pnlSorteioNME: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteioNM: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    pnlSorteioNMD: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteadoNM: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    pnlSorteioNM: TPanel;
    lmdSorteioNM: TLabel;
    gSorteioNM: TProgressBar {LAZARUS: TbsSkinGauge};
    opNumSorteadoNM: TEdit {LAZARUS: TbsSkinEdit};
    opNumIndiceNM: TEdit {LAZARUS: TbsSkinEdit};
    bsSorteioNM: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup16: TPanel {LAZARUS: TbsRibbonGroup};
    btLimpaSorteioNM: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider1: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel44: TPanel {LAZARUS: TGridPanel};
    btLimpaSorteioReiniciaNM: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btLimpaSorteioLimpaNM: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup29: TPanel {LAZARUS: TbsRibbonGroup};
    bsRibbonDivider5: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel46: TPanel {LAZARUS: TGridPanel};
    lblNumSortDispNM: TLabel {LAZARUS: TbsSkinStdLabel};
    lblNumSortSortNM: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonGroup40: TPanel {LAZARUS: TbsRibbonGroup};
    btSortearNM: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup42: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton40: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btFormatSorteioNM: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup43: TPanel {LAZARUS: TbsRibbonGroup};
    bsRibbonGroup44: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_SorteioNM: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonDivider6: TBevel {LAZARUS: TbsRibbonDivider};
    ckSorteioExpNM: TCheckGroup {LAZARUS: TbsSkinCheckGroup};
    GridPanel47: TPanel {LAZARUS: TGridPanel};
    bsSkinButton3: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton4: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton5: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton6: TButton {LAZARUS: TbsSkinButton};
    GridPanel48: TPanel {LAZARUS: TGridPanel};
    bsSkinButton9: TButton {LAZARUS: TbsSkinButton};
    GridPanel49: TPanel {LAZARUS: TGridPanel};
    bsSkinButton7: TButton {LAZARUS: TbsSkinButton};
    GridPanel50: TPanel {LAZARUS: TGridPanel};
    bsSkinButton8: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton10: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton11: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton12: TButton {LAZARUS: TbsSkinButton};
    GridPanel51: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel48: TLabel {LAZARUS: TbsSkinStdLabel};
    opSort_Nm: TEdit {LAZARUS: TbsSkinEdit};
    btAddSorteioNM: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider7: TBevel {LAZARUS: TbsRibbonDivider};
    btImpSorteioNM: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsCronometro: TTabSheet {LAZARUS: TbsRibbonPage};
    pnlFormatCrono: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel6: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinDivider18: TBevel {LAZARUS: TbsSkinDivider};
    pnlTempoGravado: TPanel {LAZARUS: TbsSkinExPanel};
    GridPanel56: TPanel {LAZARUS: TGridPanel};
    bsSkinButton13: TButton {LAZARUS: TbsSkinButton};
    lbCrono: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    bsRibbonGroup46: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_Cronometro: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonDivider12: TBevel {LAZARUS: TbsRibbonDivider};
    cbCronoEl: TCheckGroup {LAZARUS: TbsSkinCheckGroup};
    bsRibbonGroup45: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton35: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btFormatCrono: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup47: TPanel {LAZARUS: TbsRibbonGroup};
    btIniciarCrono: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btZerarCrono: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup48: TPanel {LAZARUS: TbsRibbonGroup};
    rbDirecao: TRadioGroup {LAZARUS: TbsSkinRadioGroup};
    GridPanel57: TPanel {LAZARUS: TGridPanel};
    txtDecr: TMaskEdit {LAZARUS: TbsSkinMaskEdit};
    bsRibbonDivider20: TBevel {LAZARUS: TbsRibbonDivider};
    btAnotTempo: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    tsPainelD: TTabSheet {LAZARUS: TbsSkinTabSheet};
    pnlFormatPainelD: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel7: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinDivider21: TBevel {LAZARUS: TbsSkinDivider};
    pnlTxtPainelD: TPanel;
    lmdTxtPainelD: TLabel;
    bsPainelD: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup49: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton36: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btFormatPainelD: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup50: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_PainelD: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonGroup51: TPanel {LAZARUS: TbsRibbonGroup};
    btExibeTxtPainelD: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel7: TPanel {LAZARUS: TbsSkinPanel};
    mmPainelD: TMemo {LAZARUS: TbsSkinMemo};
    tsTextoInterativo: TTabSheet {LAZARUS: TbsSkinTabSheet};
    RichEdit0: TRichMemo {LAZARUS: TbsSkinRichEdit};
    bsTextoInterativo: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup52: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_TextoInterativo: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonGroup53: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel62: TPanel {LAZARUS: TGridPanel};
    fcTxtI0: TComboBox {LAZARUS: TbsSkinFontComboBox};
    btfsBold0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btfsItalic0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btfsUnderline0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btfsStrikeOut0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    cbFontSizeModel: TComboBox {LAZARUS: TbsSkinComboBox};
    GridPanel63: TPanel {LAZARUS: TGridPanel};
    seTxtITamanho0: TComboBox {LAZARUS: TbsSkinComboBox};
    bsRibbonDivider22: TBevel {LAZARUS: TbsRibbonDivider};
    cbColorTxtI0: TColorButton {LAZARUS: TbsSkinColorButton};
    cbColorFTxtI0: TColorButton {LAZARUS: TbsSkinColorButton};
    bsRibbonGroup54: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel64: TPanel {LAZARUS: TGridPanel};
    bsSkinSpeedButton39: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton41: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton42: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup55: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton38: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton43: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinScrollBar12: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinScrollBar13: TScrollBar {LAZARUS: TbsSkinScrollBar};
    cbColorRTxtI0: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinSpeedButton44: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider23: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonGroup56: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton45: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider24: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel65: TPanel {LAZARUS: TGridPanel};
    bttaLeftJustify0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bttaRightJustify0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bttaCenter0: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsAppMenu1: TPageControl {LAZARUS: TbsAppMenu removido};
    bsSkinTabSheet3: TTabSheet {LAZARUS: TbsSkinTabSheet};
    ampAbout: TTabSheet {LAZARUS: TbsAppMenuPage removido};
    ampOpcoes: TTabSheet {LAZARUS: TbsAppMenuPage removido};
    bsSkinPanel8: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel9: TPanel {LAZARUS: TbsSkinPanel};
    Image19: TImage {LAZARUS: TbsPngImageView};
    bsSkinStdLabel75: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel28: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel29: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel77: TLabel {LAZARUS: TbsSkinStdLabel};
    ScrollBox2: TScrollBox;
    bsSkinPanel46: TPanel {LAZARUS: TbsSkinPanel};
    ckMonitorJanela: TCheckBox {LAZARUS: TbsSkinCheckBox};
    ampDesenvolvedor: TTabSheet {LAZARUS: TbsAppMenuPage removido};
    bsSkinPanel34: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel82: TLabel {LAZARUS: TbsSkinStdLabel};
    ScrollBox4: TPanel {LAZARUS: TbsSkinPanel};
    PageControl5: TPageControl {LAZARUS: TbsSkinPageControl};
    sTabSheet9: TTabSheet {LAZARUS: TbsSkinTabSheet};
    loadCol: TValueListEditor;
    sTabSheet10: TTabSheet {LAZARUS: TbsSkinTabSheet};
    param: TValueListEditor;
    sTabSheet11: TTabSheet {LAZARUS: TbsSkinTabSheet};
    paramAtualiz: TValueListEditor;
    sTabSheet16: TTabSheet {LAZARUS: TbsSkinTabSheet};
    sTabSheet13: TTabSheet {LAZARUS: TbsSkinTabSheet};
    mmConfigJA: TMemo {LAZARUS: TbsSkinMemo};
    sPanel22: TPanel {LAZARUS: TbsSkinPanel};
    sTabSheet12: TTabSheet {LAZARUS: TbsSkinTabSheet};
    sTabSheet14: TTabSheet {LAZARUS: TbsSkinTabSheet};
    sTabSheet15: TTabSheet {LAZARUS: TbsSkinTabSheet};
    lvMonitores: TListView {LAZARUS: TbsSkinListView};
    sTabSheet17: TTabSheet {LAZARUS: TbsSkinTabSheet};
    sTabSheet18: TTabSheet {LAZARUS: TbsSkinTabSheet};
    Splitter1: TSplitter;
    slbTabelas: TListBox {LAZARUS: TbsSkinListBox};
    bsSkinTabSheet1: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinTabSheet2: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinPanel36: TPanel {LAZARUS: TbsSkinPanel};
    lblVersao: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel85: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider33: TBevel {LAZARUS: TbsRibbonDivider};
    gpSobre: TPanel {LAZARUS: TGridPanel};
    ScrollBox1: TScrollBox;
    bsSkinPanel37: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel86: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel38: TPanel {LAZARUS: TbsSkinPanel};
    Image29: TImage {LAZARUS: TbsPngImageView};
    bsSkinLinkLabel10: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsSkinPanel39: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel11: TLabel {LAZARUS: TbsSkinLinkLabel};
    Image30: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel40: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel89: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel41: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel12: TLabel {LAZARUS: TbsSkinLinkLabel};
    Image31: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel42: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel13: TLabel {LAZARUS: TbsSkinLinkLabel};
    Image32: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel43: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel92: TLabel {LAZARUS: TbsSkinStdLabel};
    ScrollBox5: TScrollBox;
    bsSkinPanel22: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel69: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel23: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel70: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel24: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel7: TLabel {LAZARUS: TbsSkinLinkLabel};
    Image25: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel25: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel8: TLabel {LAZARUS: TbsSkinLinkLabel};
    Image20: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel10: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel1: TLabel {LAZARUS: TbsSkinLinkLabel};
    Image21: TImage {LAZARUS: TbsPngImageView};
    bsErroHino: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton23: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsErroMusica: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton37: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    sButton10: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton14: TButton {LAZARUS: TbsSkinButton};
    mmParam: TMemo {LAZARUS: TbsSkinMemo};
    DBGrid3: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar16: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinScrollBar17: TScrollBar {LAZARUS: TbsSkinScrollBar};
    paramtemp: TMemo {LAZARUS: TbsSkinMemo};
    bsSkinPanel11: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinScrollBar20: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinScrollBar21: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinDBGrid2: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinPanel12: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton15: TButton {LAZARUS: TbsSkinButton};
    bsSkinTabSheet4: TTabSheet {LAZARUS: TbsSkinTabSheet};
    mmLog: TMemo {LAZARUS: TbsSkinMemo};
    bsSkinScrollBar22: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsRibbonDivider40: TBevel {LAZARUS: TbsRibbonDivider};
    ppExcluirPersonalizadas: TPopupMenu {LAZARUS: TbsSkinPopupMenu};
    Excluir2: TMenuItem;
    ExcluirTodas1: TMenuItem;
    bsSkinSpeedButton46: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonGroup26: TPanel {LAZARUS: TbsRibbonGroup};
    cbBibliaHistorico: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinTabSheet5: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinSpeedButton50: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    tsRelogio: TTabSheet {LAZARUS: TbsSkinTabSheet};
    pnlFormatRelogio: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel8: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinDivider24: TBevel {LAZARUS: TbsSkinDivider};
    pnlRelogio: TPanel;
    lmdRelogio: TLabel;
    bsRelogio: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup57: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton51: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btFormatRelogio: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup58: TPanel {LAZARUS: TbsRibbonGroup};
    btExp_Relogio: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    pnlImagemCapaModel: TPanel;
    imgImagemCapaModel: TImage;
    bsSkinPanel18: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel59: TLabel {LAZARUS: TbsSkinStdLabel};
    corCapaPrograma: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinPanel19: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel63: TLabel {LAZARUS: TbsSkinStdLabel};
    imgCapaPrograma: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    bsSkinPanel21: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel60: TLabel {LAZARUS: TbsSkinStdLabel};
    cbAlinhamentoCapaPrograma: TComboBox {LAZARUS: TbsSkinComboBox};
    btRestaurarCapaPrograma: TButton {LAZARUS: TbsSkinButton};
    txtImgCapaProgramaInfo: TEdit {LAZARUS: TbsSkinEdit};
    bsRibbonGroup59: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel75: TPanel {LAZARUS: TGridPanel};
    bsSkinSpeedButton53: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton54: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton55: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider43: TBevel {LAZARUS: TbsRibbonDivider};
    btApagaLitSel: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    imgCrono: TImage;
    imgEscSB: TImage;
    lmdEscSb: TLabel;
    lmdEscSbR: TLabel;
    imgSorteio: TImage;
    imgSorteioNM: TImage;
    imgTxtPainelD: TImage;
    imgRelogio: TImage;
    bsColetaneasOnline: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup60: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton58: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    tsColetaneasOnline: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinExPanel6: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinButton25: TButton {LAZARUS: TbsSkinButton};
    bgOnlCanais: TToolBar {LAZARUS: TbsButtonGroup};
    imgYoutubeCapa: TImage;
    pnlOnlPlaylists: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinButton24: TButton {LAZARUS: TbsSkinButton};
    bgOnlPlaylists: TToolBar {LAZARUS: TbsButtonGroup};
    pnlOnlVideos: TPanel {LAZARUS: TbsSkinExPanel};
    GridPanel81: TPanel {LAZARUS: TGridPanel};
    bsSkinButton26: TButton {LAZARUS: TbsSkinButton};
    lbbgOnlCanais: TListBox {LAZARUS: TbsSkinListBox};
    lbbgOnlPlaylists: TListBox {LAZARUS: TbsSkinListBox};
    lbbgOnlVideos: TListBox {LAZARUS: TbsSkinListBox};
    gaOnlVideos: TProgressBar {LAZARUS: TbsSkinGauge};
    bgOnlVideos: TToolBar {LAZARUS: TbsButtonGroup};
    bsSkinPanel13: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel96: TLabel {LAZARUS: TbsSkinStdLabel};
    sbVideoOnAreaExtendida: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinPanel48: TPanel {LAZARUS: TbsSkinPanel};
    ckVideoOnJanela: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsConfigColetaneasOnline: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup61: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton60: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup62: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton62: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btUrlVideoOn: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider42: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel82: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel97: TLabel {LAZARUS: TbsSkinStdLabel};
    txtUrlVideoOn: TEdit {LAZARUS: TbsSkinEdit};
    Image37: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel49: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel98: TLabel {LAZARUS: TbsSkinStdLabel};
    sbVideoOnAbreLiturgia: TComboBox {LAZARUS: TbsSkinComboBox};
    bsRibbonGroup63: TPanel {LAZARUS: TbsRibbonGroup};
    bsRibbonGroup64: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton59: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton61: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup65: TPanel {LAZARUS: TbsRibbonGroup};
    btColetaneasOnlinePerso: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup66: TPanel {LAZARUS: TbsRibbonGroup};
    btUrlVideoOn2: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton66: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    GridPanel83: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel99: TLabel {LAZARUS: TbsSkinStdLabel};
    txtUrlVideoOn2: TEdit {LAZARUS: TbsSkinEdit};
    Image23: TImage {LAZARUS: TbsPngImageView};
    tsColetaneasOnlinePerso: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsConfigColetaneasOnlinePerso: TTabSheet {LAZARUS: TbsRibbonPage};
    DBGrid4: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar24: TScrollBar {LAZARUS: TbsSkinScrollBar};
    stVideosOnPerso: TStatusBar {LAZARUS: TbsSkinStatusBar};
    bsRibbonGroup67: TPanel {LAZARUS: TbsRibbonGroup};
    btAddVideoOn3: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    GridPanel84: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel100: TLabel {LAZARUS: TbsSkinStdLabel};
    txtUrlVideoOn3: TEdit {LAZARUS: TbsSkinEdit};
    txtNomeVideoOn3: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinStdLabel101: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinSpeedButton68: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinTabSheet6: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinDBGrid3: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar25: TScrollBar {LAZARUS: TbsSkinScrollBar};
    ppVideosOnPerso: TPopupMenu {LAZARUS: TbsSkinPopupMenu};
    Excluir3: TMenuItem;
    N3: TMenuItem;
    Executar1: TMenuItem;
    CopiarLink1: TMenuItem;
    AbrirnoNavegador1: TMenuItem;
    pnlfmBarraTituloForm: TPanel;
    bsFmIndex: TForm {LAZARUS: TbsBusinessSkinForm removido};
    btwsformBotoes: TToolBar {LAZARUS: TbsSkinToolBar};
    btwsMinimize: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btwsMaximized: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btwsClose: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    pnlfmTituloRib: TPanel;
    pnlTitForm: TPanel;
    btwsspDownload: TBevel {LAZARUS: TbsSkinBevel};
    btwsDownload: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lblfmTituloRib: TLabel {LAZARUS: TbsSkinStdLabel};
    bsFavoritos: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup68: TPanel {LAZARUS: TbsRibbonGroup};
    ogFavoritos: TListView {LAZARUS: TbsSkinOfficeGallery};
    bsRibbonGroup69: TPanel {LAZARUS: TbsRibbonGroup};
    btAddFav: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinTabSheet7: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinDBGrid4: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsPopupMenuFavoritos: TPopupMenu {LAZARUS: TbsSkinPopupMenu};
    MenuItem1: TMenuItem;
    miAddFav: TMenuItem;
    miDelFav: TMenuItem;
    GridPanel85: TPanel {LAZARUS: TGridPanel};
    btDelFav: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btOrdFav: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    AlterarOrdem1: TMenuItem;
    pnlfmSubTituloRib: TPanel;
    pnlModDes: TPanel;
    bsSkinPanel15: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel2: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView1: TImage {LAZARUS: TbsPngImageView};
    bsRibbonDivider44: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinSpeedButton63: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton64: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider45: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel16: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinScrollBar9: TScrollBar {LAZARUS: TbsSkinScrollBar};
    sbColPERSO: TScrollBox {LAZARUS: TbsSkinScrollBox};
    GridPanel86: TPanel {LAZARUS: TGridPanel};
    txtBuscaColetPeso: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinStdLabel57: TLabel {LAZARUS: TbsSkinStdLabel};
    stColetPerso: TStatusBar {LAZARUS: TbsSkinStatusBar};
    bsSkinScrollBar14: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinScrollBar15: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinPanel14: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel71: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel17: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel3: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView2: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel50: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel4: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView3: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel20: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider30: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel52: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel72: TLabel {LAZARUS: TbsSkinStdLabel};
    sbMusicaAreaExtendida: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinPanel53: TPanel {LAZARUS: TbsSkinPanel};
    ckMusicaJanela: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsRibbonGroup21: TPanel {LAZARUS: TbsRibbonGroup};
    btAbreHinos: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton4: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel54: TPanel {LAZARUS: TbsSkinPanel};
    ckMusicaOperador: TCheckBox {LAZARUS: TbsSkinCheckBox};
    btAddItemLiturgia: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    ampImpExp: TTabSheet {LAZARUS: TbsAppMenuPage removido};
    bsSkinPanel31: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel32: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel1: TLabel {LAZARUS: TbsSkinStdLabel};
    ScrollBox3: TScrollBox;
    bsSkinPanel62: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton17: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton18: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel56: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton16: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton19: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel57: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton28: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton29: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel58: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton30: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton31: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel60: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton32: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton33: TButton {LAZARUS: TbsSkinButton};
    ampDoe: TTabSheet {LAZARUS: TbsAppMenuPage removido};
    bsSkinPanel33: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel6: TLabel {LAZARUS: TbsSkinStdLabel};
    ScrollBox6: TScrollBox;
    bsSkinPanel61: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel83: TLabel {LAZARUS: TbsSkinStdLabel};
    tsDoxologia: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinExPanel1: TPanel {LAZARUS: TbsSkinExPanel};
    bgDoxologiaCate: TToolBar {LAZARUS: TbsButtonGroup};
    lbbgDoxologiaCate: TListBox {LAZARUS: TbsSkinListBox};
    pnlDoxologiaMusicas: TPanel {LAZARUS: TbsSkinExPanel};
    dbctrlDoxologiaMusicas: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    Panel6: TPanel;
    bsSkinDBText4: TDBText {LAZARUS: TbsSkinDBText};
    bsSkinPanel64: TPanel {LAZARUS: TbsSkinPanel};
    imgDoxologiaCate: TImage;
    lblDoxologiaCate: TLabel {LAZARUS: TbsSkinLabel};
    btErro: TButton {LAZARUS: TbsSkinButton};
    tsLiturgia: TTabSheet {LAZARUS: TbsSkinTabSheet};
    sbLiturgia: TScrollBox {LAZARUS: TbsSkinScrollBox};
    bsSkinScrollBar3: TScrollBar {LAZARUS: TbsSkinScrollBar};
    GridPanel23: TPanel {LAZARUS: TGridPanel};
    lcal_2: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lcal_3: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lcal_4: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lcal_5: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lcal_6: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lcal_7: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    lcal_1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider9: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonDivider13: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonDivider15: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonDivider17: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonDivider19: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonDivider21: TBevel {LAZARUS: TbsRibbonDivider};
    lit_modItem: TPanel {LAZARUS: TbsSkinPanel};
    lit_modItem_icomus6: TImage {LAZARUS: TbsPngImageView};
    lit_modItem_icomus4: TImage {LAZARUS: TbsPngImageView};
    lit_modItem_icomus3: TImage {LAZARUS: TbsPngImageView};
    lit_modItem_icomus1: TImage {LAZARUS: TbsPngImageView};
    lit_modItem_btedit: TImage {LAZARUS: TbsPngImageView};
    lit_modItem_divider: TBevel {LAZARUS: TbsRibbonDivider};
    lit_modItem_btmove: TPanel;
    lit_modItem_bticon: TPanel;
    lit_modItem_bticon_img: TImage {LAZARUS: TbsPngImageView};
    lit_modItem_checkb: TCheckBox {LAZARUS: TbsSkinCheckBox};
    lit_modItem_texto: TPanel {LAZARUS: TbsSkinPanel};
    lit_modItem_subtitulo: TLabel {LAZARUS: TbsSkinStdLabel};
    lit_modItem_titulo: TLabel {LAZARUS: TbsSkinStdLabel};
    lit_modItem_btmove_img: TImage {LAZARUS: TbsPngImageView};
    mmLiturgia: TMemo {LAZARUS: TbsSkinMemo};
    bsSkinPanel3: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton34: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton35: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel65: TPanel {LAZARUS: TbsSkinPanel};
    ckMusicaTituloSlide: TCheckBox {LAZARUS: TbsSkinCheckBox};
    ampSincroniza: TTabSheet {LAZARUS: TbsAppMenuPage removido};
    bsSkinPanel66: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel67: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel33: TLabel {LAZARUS: TbsSkinStdLabel};
    ScrollBox7: TScrollBox;
    tabLetras: TTabControl {LAZARUS: TbsSkinTabControl};
    DBGrid2: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar8: TScrollBar {LAZARUS: TbsSkinScrollBar};
    pnlreBusca: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinScrollBar10: TScrollBar {LAZARUS: TbsSkinScrollBar};
    reBusca: TRichMemo {LAZARUS: TbsSkinRichEdit};
    GridPanel3: TPanel {LAZARUS: TGridPanel};
    txtBusca: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinStdLabel5: TLabel {LAZARUS: TbsSkinStdLabel};
    txtIDMusica: TDBText {LAZARUS: TbsSkinDBText};
    bsFormatSlPerso: TPanel {LAZARUS: TbsSkinPanel};
    ckSlideTxtFormatPerso: TCheckBox {LAZARUS: TbsSkinCheckBox};
    GridPanel1: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel103: TLabel {LAZARUS: TbsSkinStdLabel};
    seSorteioTempo: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    GridPanel4: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel104: TLabel {LAZARUS: TbsSkinStdLabel};
    seSorteioTempoNM: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    bsRibbonGroup1: TPanel {LAZARUS: TbsRibbonGroup};
    btExportarHino: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsExportarMusica: TPopupMenu {LAZARUS: TbsSkinPopupMenu};
    miOpcExportar1: TMenuItem;
    miOpcExportar3: TMenuItem;
    bsRibbonGroup4: TPanel {LAZARUS: TbsRibbonGroup};
    btExportarMusica: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsFormatSlidePerso: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinSpeedButton1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    rbHinoTipo: TRadioGroup {LAZARUS: TbsSkinRadioGroup};
    lit_modItem_icomus2: TImage {LAZARUS: TbsPngImageView};
    bsRibbonGroup71: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel27: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel107: TLabel {LAZARUS: TbsSkinStdLabel};
    cbFormatoHora: TComboBox {LAZARUS: TbsSkinComboBox};
    tsMusicasInfantis: TTabSheet {LAZARUS: TbsSkinTabSheet};
    dbctrlMusicasInfantis: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    Panel1: TPanel;
    bsSkinDBText3: TDBText {LAZARUS: TbsSkinDBText};
    bsPngImageView6: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView7: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView8: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView9: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView10: TImage {LAZARUS: TbsPngImageView};
    bsSkinStdLabel108: TLabel {LAZARUS: TbsSkinStdLabel};
    fcSorteioFonte: TComboBox {LAZARUS: TbsSkinFontComboBox};
    GridPanel28: TPanel {LAZARUS: TGridPanel};
    Panel2: TPanel;
    Panel3: TPanel;
    bsSkinStdLabel18: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel109: TLabel {LAZARUS: TbsSkinStdLabel};
    csSorteioCor: TColorButton {LAZARUS: TbsSkinColorButton};
    seSorteioTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    bsSkinStdLabel19: TLabel {LAZARUS: TbsSkinStdLabel};
    tsSorteioImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsSorteioImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel38: TPanel {LAZARUS: TGridPanel};
    Panel4: TPanel;
    bsSkinStdLabel37: TLabel {LAZARUS: TbsSkinStdLabel};
    Panel5: TPanel;
    bsSkinStdLabel110: TLabel {LAZARUS: TbsSkinStdLabel};
    csSorteioCorFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    cbSorteioPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    bsSkinDivider12: TBevel {LAZARUS: TbsSkinDivider};
    bsSkinGroupBox1: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel12: TLabel {LAZARUS: TbsSkinStdLabel};
    fcSorteioFonteNM: TComboBox {LAZARUS: TbsSkinFontComboBox};
    GridPanel10: TPanel {LAZARUS: TGridPanel};
    Panel7: TPanel;
    bsSkinStdLabel14: TLabel {LAZARUS: TbsSkinStdLabel};
    seSorteioTamanhoNM: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel8: TPanel;
    bsSkinStdLabel15: TLabel {LAZARUS: TbsSkinStdLabel};
    csSorteioCorNM: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox11: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel16: TLabel {LAZARUS: TbsSkinStdLabel};
    tsSorteioNMImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsSorteioNMImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel20: TPanel {LAZARUS: TGridPanel};
    Panel9: TPanel;
    bsSkinStdLabel17: TLabel {LAZARUS: TbsSkinStdLabel};
    cbSorteioNMPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    Panel10: TPanel;
    bsSkinStdLabel38: TLabel {LAZARUS: TbsSkinStdLabel};
    csSorteioCorFundoNM: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox10: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel13: TLabel {LAZARUS: TbsSkinStdLabel};
    tsEscSBImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsEscSBImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel16: TPanel {LAZARUS: TGridPanel};
    Panel11: TPanel;
    bsSkinStdLabel39: TLabel {LAZARUS: TbsSkinStdLabel};
    cbEscsbPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    Panel12: TPanel;
    bsSkinStdLabel43: TLabel {LAZARUS: TbsSkinStdLabel};
    csEscsbCorFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox18: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel64: TLabel {LAZARUS: TbsSkinStdLabel};
    tsCronoImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsCronoImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel30: TPanel {LAZARUS: TGridPanel};
    Panel13: TPanel;
    bsSkinStdLabel65: TLabel {LAZARUS: TbsSkinStdLabel};
    cbCronoPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    Panel14: TPanel;
    bsSkinStdLabel111: TLabel {LAZARUS: TbsSkinStdLabel};
    csCronoCorFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox19: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel112: TLabel {LAZARUS: TbsSkinStdLabel};
    tsTxtPainelDImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsTxtPainelDImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel40: TPanel {LAZARUS: TGridPanel};
    Panel16: TPanel;
    bsSkinStdLabel113: TLabel {LAZARUS: TbsSkinStdLabel};
    cbTxtPainelDPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    Panel17: TPanel;
    bsSkinStdLabel114: TLabel {LAZARUS: TbsSkinStdLabel};
    csPainelDCorFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox20: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel115: TLabel {LAZARUS: TbsSkinStdLabel};
    tsRelogioImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsRelogioImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel41: TPanel {LAZARUS: TGridPanel};
    Panel18: TPanel;
    bsSkinStdLabel116: TLabel {LAZARUS: TbsSkinStdLabel};
    cbRelogioPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    Panel19: TPanel;
    bsSkinStdLabel117: TLabel {LAZARUS: TbsSkinStdLabel};
    csRelogioCorFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox21: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel118: TLabel {LAZARUS: TbsSkinStdLabel};
    fcRelogioFonte: TComboBox {LAZARUS: TbsSkinFontComboBox};
    GridPanel42: TPanel {LAZARUS: TGridPanel};
    Panel20: TPanel;
    bsSkinStdLabel119: TLabel {LAZARUS: TbsSkinStdLabel};
    seRelogioTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel21: TPanel;
    bsSkinStdLabel120: TLabel {LAZARUS: TbsSkinStdLabel};
    csRelogioCor: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox16: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel21: TLabel {LAZARUS: TbsSkinStdLabel};
    fcPainelDFonte: TComboBox {LAZARUS: TbsSkinFontComboBox};
    GridPanel43: TPanel {LAZARUS: TGridPanel};
    Panel22: TPanel;
    bsSkinStdLabel22: TLabel {LAZARUS: TbsSkinStdLabel};
    sePainelDTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel23: TPanel;
    bsSkinStdLabel27: TLabel {LAZARUS: TbsSkinStdLabel};
    csPainelDCor: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox14: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel32: TLabel {LAZARUS: TbsSkinStdLabel};
    fcCronoFonte: TComboBox {LAZARUS: TbsSkinFontComboBox};
    GridPanel45: TPanel {LAZARUS: TGridPanel};
    Panel24: TPanel;
    bsSkinStdLabel34: TLabel {LAZARUS: TbsSkinStdLabel};
    seCronoTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel25: TPanel;
    bsSkinStdLabel36: TLabel {LAZARUS: TbsSkinStdLabel};
    csCronoCor: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox12: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel44: TLabel {LAZARUS: TbsSkinStdLabel};
    GridPanel52: TPanel {LAZARUS: TGridPanel};
    Panel26: TPanel;
    bsSkinStdLabel45: TLabel {LAZARUS: TbsSkinStdLabel};
    seEscsbTamanho2: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel27: TPanel;
    bsSkinStdLabel46: TLabel {LAZARUS: TbsSkinStdLabel};
    csEscsbCor2: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinStdLabel47: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel49: TLabel {LAZARUS: TbsSkinStdLabel};
    GridPanel53: TPanel {LAZARUS: TGridPanel};
    Panel28: TPanel;
    bsSkinStdLabel50: TLabel {LAZARUS: TbsSkinStdLabel};
    seEscsbTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel29: TPanel;
    bsSkinStdLabel51: TLabel {LAZARUS: TbsSkinStdLabel};
    csEscsbCor: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinSpeedButton5: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    tsItensAgendados: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinExPanel4: TPanel {LAZARUS: TbsSkinExPanel};
    pnlItensAgendados: TPanel {LAZARUS: TbsSkinExPanel};
    dbctrlCategoriasItensAgendados: TScrollBox {LAZARUS: TDBCtrlGrid sem equiv LCL};
    Panel30: TPanel;
    Panel31: TPanel;
    bsItensAgendados: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup72: TPanel {LAZARUS: TbsRibbonGroup};
    btAddCategoriaAgendados: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup73: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton8: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    cbRemoveItensAgendados: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsRibbonDivider26: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel9: TPanel {LAZARUS: TGridPanel};
    bsSkinDBText5: TDBText {LAZARUS: TbsSkinDBText};
    bsPngImageView13: TImage {LAZARUS: TbsPngImageView};
    Panel34: TPanel;
    dbctrlItensAgendados: TScrollBox {LAZARUS: TDBCtrlGrid sem equiv LCL};
    Panel32: TPanel;
    GridPanel11: TPanel {LAZARUS: TGridPanel};
    bsSkinDBText6: TDBText {LAZARUS: TbsSkinDBText};
    bsPngImageView11: TImage {LAZARUS: TbsPngImageView};
    bsSkinDBText7: TDBText {LAZARUS: TbsSkinDBText};
    Panel33: TPanel;
    Panel35: TPanel;
    bsSkinDBText8: TDBText {LAZARUS: TbsSkinDBText};
    bsRibbonDivider28: TBevel {LAZARUS: TbsRibbonDivider};
    Panel36: TPanel;
    MonthCalendar1: TCalendar {LAZARUS: TMonthCalendar};
    bsSkinStdLabel52: TLabel {LAZARUS: TbsSkinStdLabel};
    txtCategoria: TEdit;
    bsSkinPanel68: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton37: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton39: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel71: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton40: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton41: TButton {LAZARUS: TbsSkinButton};
    cbAnotacoesLiturgia: TCheckBox {LAZARUS: TbsSkinCheckBox};
    pnlAnotacoesLiturgia: TPanel {LAZARUS: TbsSkinExPanel};
    RichEdit1: TRichMemo {LAZARUS: TbsSkinRichEdit};
    bsSkinScrollBar5: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsPopupExpand: TPopupMenu {LAZARUS: TbsSkinPopupMenu};
    mmPopMonitor1: TMenuItem;
    bsRibbonGroup70: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel59: TPanel {LAZARUS: TGridPanel};
    cbFormatoHoraES: TComboBox {LAZARUS: TbsSkinComboBox};
    Panel15: TPanel;
    GridPanel60: TPanel {LAZARUS: TGridPanel};
    fcTxtI1: TComboBox {LAZARUS: TbsSkinFontComboBox};
    btfsBold1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btfsItalic1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btfsUnderline1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btfsStrikeOut1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    GridPanel61: TPanel {LAZARUS: TGridPanel};
    seTxtITamanho1: TComboBox {LAZARUS: TbsSkinComboBox};
    bsRibbonDivider55: TBevel {LAZARUS: TbsRibbonDivider};
    cbColorTxtI1: TColorButton {LAZARUS: TbsSkinColorButton};
    cbColorRTxtI1: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinSpeedButton34: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider57: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinSpeedButton47: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinScrollBar6: TScrollBar {LAZARUS: TbsSkinScrollBar};
    GridPanel66: TPanel {LAZARUS: TGridPanel};
    bttaLeftJustify1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bttaRightJustify1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bttaCenter1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinTabSheet8: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinPanel72: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton43: TButton {LAZARUS: TbsSkinButton};
    GridPanel68: TPanel {LAZARUS: TGridPanel};
    Label3: TLabel;
    Label1: TLabel;
    lbHlpArquivos: TListBox;
    lbHlpImagens: TListBox;
    lblStatusHlp: TLabel;
    Label4: TLabel;
    lbHlpFalta: TListBox;
    lbHlpTemp: TMemo;
    bsSkinStatusBar1: TStatusBar {LAZARUS: TbsSkinStatusBar};
    spVersao: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    spRelogio: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    spData: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    spNomePC: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    bsPngImageView12: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView5: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView14: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView15: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView16: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView17: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView18: TImage {LAZARUS: TbsPngImageView};
    lit_modItem_icomus5: TImage {LAZARUS: TbsPngImageView};
    gpLiturgiaDes: TPanel {LAZARUS: TGridPanel};
    lbLiturgia: TListBox;
    lbLiturgiaPos: TListBox;
    mmBD: TMemo;
    btExecSQL: TButton {LAZARUS: TbsSkinButton};
    GridPanel71: TPanel {LAZARUS: TGridPanel};
    Label5: TLabel;
    Label6: TLabel;
    GridPanel72: TPanel {LAZARUS: TGridPanel};
    Label7: TLabel;
    Label8: TLabel;
    vlSorteioNM: TValueListEditor;
    vlSorteadosNM: TValueListEditor;
    vlSorteio: TValueListEditor;
    vlSorteados: TValueListEditor;
    stHinos: TStatusBar {LAZARUS: TbsSkinStatusBar};
    stHinos0: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    stHinos1: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    pnlStatusBuscaMusicas: TStatusBar {LAZARUS: TbsSkinStatusBar};
    pnlStatusBuscaMusicas0: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    pnlStatusBuscaMusicas1: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    miOpcExportar2: TMenuItem;
    bsRibbonGroup75: TPanel {LAZARUS: TbsRibbonGroup};
    cbEscSBZerarTempo: TCheckBox {LAZARUS: TbsSkinCheckBox};
    cbEscSBRelogioFunc: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsRibbonGroup76: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel73: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel73: TLabel {LAZARUS: TbsSkinStdLabel};
    cbFormatoTempoCrono: TComboBox {LAZARUS: TbsSkinComboBox};
    cbFormatoTempoES: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinStdLabel131: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel132: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel26: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider62: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel27: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel129: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel35: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel5: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView4: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel73: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel6: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView19: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel74: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel9: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView20: TImage {LAZARUS: TbsPngImageView};
    Panel52: TPanel;
    bsSkinStdLabel133: TLabel {LAZARUS: TbsSkinStdLabel};
    csEscsbCor3: TColorButton {LAZARUS: TbsSkinColorButton};
    fcEscsbFonte: TComboBox {LAZARUS: TbsSkinFontComboBox};
    pnlFormatBiblia: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinScrollPanel1: TScrollBox {LAZARUS: TbsSkinScrollPanel};
    bsSkinDivider1: TBevel {LAZARUS: TbsSkinDivider};
    GridPanel74: TPanel {LAZARUS: TGridPanel};
    bsSkinExPanel7: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinExPanel8: TPanel {LAZARUS: TbsSkinExPanel};
    bsSkinExPanel5: TPanel {LAZARUS: TbsSkinExPanel};
    DBCtrlGridBibliaLivro: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    DBCtrlGridBibliaCapitulo: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    DBCtrlGridBibliaVersiculo: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    bsSkinStdLabel137: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel136: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel138: TLabel {LAZARUS: TbsSkinStdLabel};
    busBibliaVersiculo: TEdit {LAZARUS: TbsSkinEdit};
    bsRibbonGroup77: TPanel {LAZARUS: TbsRibbonGroup};
    pnlBibliaHistorico: TPanel {LAZARUS: TbsSkinExPanel};
    DBCtrlGridBibliaHistorico: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    GridPanel70: TPanel {LAZARUS: TGridPanel};
    bsSkinButton20: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel4: TPanel {LAZARUS: TbsSkinPanel};
    pnlBiblia: TPanel;
    imgBiblia: TImage;
    lmdBibliaTxt: TLabel;
    lmdBibliaInfo: TLabel;
    bsSkinGroupBox15: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel7: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel8: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel9: TLabel {LAZARUS: TbsSkinStdLabel};
    GridPanel76: TPanel {LAZARUS: TGridPanel};
    Panel56: TPanel;
    bsSkinStdLabel140: TLabel {LAZARUS: TbsSkinStdLabel};
    seBibliaTamanho2: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel57: TPanel;
    bsSkinStdLabel141: TLabel {LAZARUS: TbsSkinStdLabel};
    csBibliaCor2: TColorButton {LAZARUS: TbsSkinColorButton};
    fcBibliaFonte: TComboBox {LAZARUS: TbsSkinFontComboBox};
    GridPanel77: TPanel {LAZARUS: TGridPanel};
    Panel58: TPanel;
    bsSkinStdLabel142: TLabel {LAZARUS: TbsSkinStdLabel};
    seBibliaTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel59: TPanel;
    bsSkinStdLabel143: TLabel {LAZARUS: TbsSkinStdLabel};
    csBibliaCor: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox3: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel10: TLabel {LAZARUS: TbsSkinStdLabel};
    tsBibliaImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsBibliaImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel5: TPanel {LAZARUS: TGridPanel};
    Panel53: TPanel;
    bsSkinStdLabel11: TLabel {LAZARUS: TbsSkinStdLabel};
    cbBibliaPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    Panel54: TPanel;
    bsSkinStdLabel139: TLabel {LAZARUS: TbsSkinStdLabel};
    csBibliaCorFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    bsRibbonGroup78: TPanel {LAZARUS: TbsRibbonGroup};
    btBibVersAnt: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btBibVersSeg: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup79: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinExPanel9: TPanel {LAZARUS: TbsSkinExPanel};
    GridPanel12: TPanel {LAZARUS: TGridPanel};
    bsSkinStdLabel20: TLabel {LAZARUS: TbsSkinStdLabel};
    btBibLocaliza: TButton {LAZARUS: TbsSkinButton};
    txtBibLocaliza: TEdit {LAZARUS: TbsSkinEdit};
    DBCtrlGridBibliaBusca: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    pnlBibliaBusca: TPanel;
    imgBibliaBusca: TImage;
    lmdBibliaBuscaTxt: TLabel;
    lmdBibliaBuscaInfo: TLabel;
    bsSkinGroupBox2: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel23: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel144: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel145: TLabel {LAZARUS: TbsSkinStdLabel};
    GridPanel31: TPanel {LAZARUS: TGridPanel};
    Panel55: TPanel;
    bsSkinStdLabel146: TLabel {LAZARUS: TbsSkinStdLabel};
    seBibliabTamanho2: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel60: TPanel;
    bsSkinStdLabel147: TLabel {LAZARUS: TbsSkinStdLabel};
    csBibliabCor2: TColorButton {LAZARUS: TbsSkinColorButton};
    fcBibliabFonte: TComboBox {LAZARUS: TbsSkinFontComboBox};
    GridPanel32: TPanel {LAZARUS: TGridPanel};
    Panel61: TPanel;
    bsSkinStdLabel148: TLabel {LAZARUS: TbsSkinStdLabel};
    seBibliabTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel62: TPanel;
    bsSkinStdLabel149: TLabel {LAZARUS: TbsSkinStdLabel};
    csBibliabCor: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinGroupBox5: TGroupBox {LAZARUS: TbsSkinGroupBox};
    bsSkinStdLabel150: TLabel {LAZARUS: TbsSkinStdLabel};
    tsBibliabImagem: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    tsBibliabImagemInfo: TEdit {LAZARUS: TbsSkinEdit};
    GridPanel8: TPanel {LAZARUS: TGridPanel};
    Panel63: TPanel;
    bsSkinStdLabel151: TLabel {LAZARUS: TbsSkinStdLabel};
    cbBibliabPosicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    Panel64: TPanel;
    bsSkinStdLabel152: TLabel {LAZARUS: TbsSkinStdLabel};
    csBibliabCorFundo: TColorButton {LAZARUS: TbsSkinColorButton};
    bsRibbonGroup80: TPanel {LAZARUS: TbsRibbonGroup};
    btBibBusVersAnt: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btBibBusVersSeg: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel80: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel153: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel81: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider64: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel82: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel18: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView24: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel83: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel19: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView25: TImage {LAZARUS: TbsPngImageView};
    bsSkinSpeedButton18: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup81: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel6: TPanel {LAZARUS: TGridPanel};
    btVidOnlPExcluir: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btVidOnlPCopiarLink: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btVidOnlPAbrirNaveg: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btVidOnlPExec: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider65: TBevel {LAZARUS: TbsRibbonDivider};
    ampAtivDesAlbum: TTabSheet {LAZARUS: TbsAppMenuPage removido};
    bsSkinPanel84: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel154: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel63: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel85: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel91: TLabel {LAZARUS: TbsSkinStdLabel};
    GridPanel7: TPanel {LAZARUS: TGridPanel};
    Panel65: TPanel;
    Panel66: TPanel;
    bsSkinSpeedButton17: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton21: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    Panel67: TPanel;
    gridAlbAt: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar18: TScrollBar {LAZARUS: TbsSkinScrollBar};
    Panel68: TPanel;
    gridAlbInat: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar19: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinPanel75: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel134: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel76: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel135: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel79: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel17: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView23: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel77: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel15: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView21: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel78: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel16: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView22: TImage {LAZARUS: TbsPngImageView};
    imagemFundoInfo: TEdit {LAZARUS: TbsSkinEdit};
    audioFundoInfo: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinTabSheet9: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinPanel86: TPanel {LAZARUS: TbsSkinPanel};
    Label2: TLabel;
    bsSkinButton21: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton22: TButton {LAZARUS: TbsSkinButton};
    lvArquivos: TListView {LAZARUS: TbsSkinListView};
    gProgresso: TProgressBar {LAZARUS: TbsSkinGauge};
    bsSkinButton23: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton27: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel59: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel56: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider51: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel88: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel66: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel68: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider67: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonDivider68: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinStdLabel102: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider69: TBevel {LAZARUS: TbsRibbonDivider};
    corTextoMusica: TColorButton {LAZARUS: TbsSkinColorButton};
    corTextoAuxMusica: TColorButton {LAZARUS: TbsSkinColorButton};
    ckMusicaFundoTransparente: TCheckBox {LAZARUS: TbsSkinCheckBox};
    seTamanhoTexto: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    bsSkinStdLabel106: TLabel {LAZARUS: TbsSkinStdLabel};
    seTamanhoTextoAux: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    bsSkinStdLabel61: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider54: TBevel {LAZARUS: TbsRibbonDivider};
    seTamanhoTitulo: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    corTituloMusica: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinPanel89: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel121: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel90: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider70: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel91: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel20: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView26: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel92: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel21: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView27: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel93: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel22: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView28: TImage {LAZARUS: TbsPngImageView};
    bsSkinStdLabel122: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider71: TBevel {LAZARUS: TbsRibbonDivider};
    corTextoRepetido: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinTabSheet10: TTabSheet {LAZARUS: TbsSkinTabSheet};
    lbTempos: TListBox;
    Panel37: TPanel;
    Label9: TLabel {LAZARUS: TbsSkinLabel};
    idMusica: TEdit {LAZARUS: TbsSkinEdit};
    Button1: TButton {LAZARUS: TbsSkinButton};
    dbGrid: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinPanel44: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel93: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel45: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel94: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel47: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel14: TLabel {LAZARUS: TbsSkinLinkLabel};
    Image33: TImage {LAZARUS: TbsPngImageView};
    bsSkinTabSheet11: TTabSheet {LAZARUS: TbsSkinTabSheet};
    cboard: TListBox;
    bsRibbonDivider72: TBevel {LAZARUS: TbsRibbonDivider};
    btPersoClipBoard: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel51: TPanel {LAZARUS: TbsSkinPanel};
    ckFadeForm: TCheckBox {LAZARUS: TbsSkinCheckBox};
    btLitClipBoard: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    cbBloqItens: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinPanel94: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel124: TLabel {LAZARUS: TbsSkinStdLabel};
    cbLayout: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinPanel95: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel78: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel96: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel125: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel98: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider8: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel97: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider73: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel99: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider48: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel100: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider31: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel101: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider74: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel102: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel123: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel103: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel67: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel104: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel58: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel105: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider35: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel106: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider36: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel107: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider41: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel108: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider29: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel109: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider34: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel110: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider2: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel111: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider32: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel112: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider37: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel113: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider49: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel114: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider39: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel115: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider46: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel116: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel84: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel117: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel81: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel118: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel126: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel119: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel127: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel120: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel128: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel121: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel130: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel122: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel155: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel124: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel74: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel70: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton38: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel127: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel35: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel130: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider38: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel126: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel54: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel69: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton36: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel128: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel90: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel123: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider27: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel125: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel129: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel131: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel132: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel133: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider52: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel134: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinTabSheet12: TTabSheet {LAZARUS: TbsSkinTabSheet};
    layoutValue: TValueListEditor;
    bsSkinPanel135: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel53: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel136: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider56: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel138: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel24: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView30: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel139: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider59: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel140: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel79: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel141: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel25: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView31: TImage {LAZARUS: TbsPngImageView};
    bsFormatSlImgPerso: TPanel {LAZARUS: TbsSkinPanel};
    ckSlideImgFormatPerso: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsFormatSlideImgPerso: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel87: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel105: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider10: TBevel {LAZARUS: TbsRibbonDivider};
    corFundoMusica: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinStdLabel55: TLabel {LAZARUS: TbsSkinStdLabel};
    imgFundoMusica: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    bsSkinStdLabel62: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider66: TBevel {LAZARUS: TbsRibbonDivider};
    txtImgFundoMusicaInfo: TEdit {LAZARUS: TbsSkinEdit};
    posicaoFundo: TComboBox {LAZARUS: TbsSkinComboBoxEx};
    bsSkinButton2: TButton {LAZARUS: TbsSkinButton};
    bsRibbonGroup9: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton2: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider25: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinSpeedButton16: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel142: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider63: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel143: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel87: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel144: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel26: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView32: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel145: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel27: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView33: TImage {LAZARUS: TbsPngImageView};
    stColetPerso_0: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    stColetPerso_1: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    stVideosOnPerso_1: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    DBCtrlGridBibliaLivro_pnl: TPanel;
    txtdbBibliaLivro: TDBText {LAZARUS: TbsSkinDBText};
    txtdbBibliaLivroSg: TDBText {LAZARUS: TbsSkinDBText};
    DBCtrlGridBibliaCapitulo_pnl: TPanel;
    txtdbBibliaCapitulo: TDBText {LAZARUS: TbsSkinDBText};
    DBCtrlGridBibliaVersiculo_pnl: TPanel;
    txtdbBibliaVersiculoTxt: TDBText {LAZARUS: TbsSkinDBText};
    txtdbBibliaVersiculo: TDBText {LAZARUS: TbsSkinDBText};
    DBCtrlGridBibliaHistorico_pnl: TPanel;
    txtBibliaHistoricoPassagem: TDBText {LAZARUS: TbsSkinDBText};
    txtBibliaHistorico: TDBText {LAZARUS: TbsSkinDBText};
    DBCtrlGridBibliaBusca_pnl: TPanel;
    txtBibliaBusca: TDBText {LAZARUS: TbsSkinDBText};
    txtBibliaBuscaPassagem: TDBText {LAZARUS: TbsSkinDBText};
    txtdbBibliaLivroNm: TDBText {LAZARUS: TbsSkinDBText};
    bsSkinPanel146: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel95: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel147: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider47: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel148: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider53: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel149: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider58: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel150: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel88: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel151: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel156: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel152: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel28: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView34: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel153: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel29: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView35: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel154: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel30: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView36: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel155: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel31: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView37: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel156: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel32: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView38: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel157: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel33: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView39: TImage {LAZARUS: TbsPngImageView};
    pnlPlayer: TPanel {LAZARUS: TbsSkinPanel};
    {LAZARUS: MediaPlayer1 (TMediaPlayer) removido — usar PlayerStream (BASS)}
    lblPlayer: TLabel {LAZARUS: TbsSkinLabel};
    btplPlay: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btplPause: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider60: TBevel {LAZARUS: TbsRibbonDivider};
    btplFechar: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    pbPlayer: TProgressBar {LAZARUS: TbsSkinGauge};
    bsSkinPanel158: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider61: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel159: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel157: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel160: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel158: TLabel {LAZARUS: TbsSkinStdLabel};
    sbPlayerAreaExtendida: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinPanel161: TPanel {LAZARUS: TbsSkinPanel};
    ckPlayerTelaCheia: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinPanel162: TPanel {LAZARUS: TbsSkinPanel};
    ckPlayerVideo: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinPanel163: TPanel {LAZARUS: TbsSkinPanel};
    ckPlayerAudio: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinPanel164: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel159: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonDivider75: TBevel {LAZARUS: TbsRibbonDivider};
    bsRibbonGroup12: TPanel {LAZARUS: TbsRibbonGroup};
    btHinoSlideMusica: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    GridPanel69: TPanel {LAZARUS: TGridPanel};
    btHinoSlideMusicaPB: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btHinoSlideMusicaSA: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup74: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel87: TPanel {LAZARUS: TGridPanel};
    bsSkinSpeedButton13: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton3: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton12: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup82: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinPanel2: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel4: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinDBText2: TDBText {LAZARUS: TbsSkinDBText};
    bsRibbonDivider4: TBevel {LAZARUS: TbsRibbonDivider};
    btMusicaLetra: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup83: TPanel {LAZARUS: TbsRibbonGroup};
    btMusicaSlideMusica: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    GridPanel33: TPanel {LAZARUS: TGridPanel};
    btMusicaSlideMusicaPB: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btMusicaSlideMusicaSA: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup84: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel34: TPanel {LAZARUS: TGridPanel};
    btMusicaAudioMusicaPB: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btMusicaAudioMusica: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton6: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider3: TBevel {LAZARUS: TbsRibbonDivider};
    dblBibVersao: TDBLookupComboBox {LAZARUS: TbsSkinDBLookupComboBox};
    bsSkinStdLabel160: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel161: TLabel {LAZARUS: TbsSkinStdLabel};
    dblBibVersao2: TDBLookupComboBox {LAZARUS: TbsSkinDBLookupComboBox};
    busBibliaLivro: TComboBox {LAZARUS: TbsSkinComboBox};
    busBibliaCapitulo: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinDBGrid1: TDBGrid {LAZARUS: TbsSkinDBGrid};
    bsSkinScrollBar4: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsSkinScrollBar23: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsRibbonGroup6: TPanel {LAZARUS: TbsRibbonGroup};
    opcCronoCTempo: TRadioGroup {LAZARUS: TbsSkinRadioGroup};
    GridPanel35: TPanel {LAZARUS: TGridPanel};
    meESHora: TMaskEdit {LAZARUS: TbsSkinMaskEdit};
    meESDuracao: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    bsSkinPanel165: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel40: TLabel {LAZARUS: TbsSkinStdLabel};
    lblCronoCFim: TLabel {LAZARUS: TbsSkinStdLabel};
    bsRibbonGroup85: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel24: TPanel {LAZARUS: TGridPanel};
    bsAddT1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsAddT5: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsAddT10: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsAddTm1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsAddTm5: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsAddTm10: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinStdLabel162: TLabel {LAZARUS: TbsSkinStdLabel};
    paramexec: TValueListEditor;
    Label10: TLabel {LAZARUS: TbsSkinLabel};
    idAlbum: TEdit {LAZARUS: TbsSkinEdit};
    Label11: TLabel {LAZARUS: TbsSkinLabel};
    idFaixa: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinPanel166: TPanel {LAZARUS: TbsSkinPanel};
    ckMesmaJanela: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinPanel167: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel76: TLabel {LAZARUS: TbsSkinStdLabel};
    sbAlinhMusica: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinStdLabel163: TLabel {LAZARUS: TbsSkinStdLabel};
    cbRelogioAlinhamento: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinStdLabel164: TLabel {LAZARUS: TbsSkinStdLabel};
    cbPainelDAlinhamento: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinStdLabel165: TLabel {LAZARUS: TbsSkinStdLabel};
    cbCronometroAlinhamento: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinStdLabel166: TLabel {LAZARUS: TbsSkinStdLabel};
    cbSorteioNMAlinhamento: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinStdLabel167: TLabel {LAZARUS: TbsSkinStdLabel};
    cbSorteioAlinhamento: TComboBox {LAZARUS: TbsSkinComboBox};
    bsSkinPanel168: TPanel {LAZARUS: TbsSkinPanel};
    ckMusicaTopo: TCheckBox {LAZARUS: TbsSkinCheckBox};
    spServer: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    bsSkinPanel170: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider76: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel171: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel168: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel172: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel34: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView40: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel173: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel35: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView41: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView42: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView43: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView44: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView45: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView46: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView47: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView48: TImage {LAZARUS: TbsPngImageView};
    bsPngImageView49: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel174: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider77: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel175: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel169: TLabel {LAZARUS: TbsSkinStdLabel};
    bsPngImageView50: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel176: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel36: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView51: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel177: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel37: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView52: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel178: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel170: TLabel {LAZARUS: TbsSkinStdLabel};
    bsPngImageView53: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel179: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel38: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView54: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel180: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel39: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView55: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel181: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider78: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel182: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider79: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel183: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel171: TLabel {LAZARUS: TbsSkinStdLabel};
    bsPngImageView56: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel184: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel40: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView57: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel185: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel41: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView58: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel186: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel172: TLabel {LAZARUS: TbsSkinStdLabel};
    bsPngImageView59: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel187: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel42: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView60: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel188: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel43: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView61: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel189: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider80: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinTabSheet13: TTabSheet {LAZARUS: TbsSkinTabSheet};
    erro_log: TMemo {LAZARUS: TbsSkinMemo};
    Panel38: TPanel;
    Button2: TButton;
    bsSkinPanel137: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider81: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel190: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel173: TLabel {LAZARUS: TbsSkinStdLabel};
    bsPngImageView29: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel191: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel23: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView62: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel192: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel44: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView63: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel30: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton42: TButton {LAZARUS: TbsSkinButton};
    sbMusicaOperadorAreaExtendida: TComboBox {LAZARUS: TbsSkinComboBox};
    ckFundoTransparente: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsFormatSlideImgPerso2: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider82: TBevel {LAZARUS: TbsRibbonDivider};
    btAbreHinosN: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    tsHinarioN: TTabSheet {LAZARUS: TbsSkinTabSheet};
    GridPanel36: TPanel {LAZARUS: TGridPanel};
    txtHinoN: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinStdLabel80: TLabel {LAZARUS: TbsSkinStdLabel};
    rbHinoTipoN: TRadioGroup {LAZARUS: TbsSkinRadioGroup};
    DBGrid1N: TDBGrid {LAZARUS: TbsSkinDBGrid};
    pnlreHinoN: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinScrollBar26: TScrollBar {LAZARUS: TbsSkinScrollBar};
    reHinoN: TRichMemo {LAZARUS: TbsSkinRichEdit};
    stHinosN: TStatusBar {LAZARUS: TbsSkinStatusBar};
    stHinos0N: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    stHinos1N: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    bsSkinScrollBar7N: TScrollBar {LAZARUS: TbsSkinScrollBar};
    bsHinarioN: TTabSheet {LAZARUS: TbsRibbonPage};
    bsRibbonGroup32: TPanel {LAZARUS: TbsRibbonGroup};
    bsRibbonDivider83: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinSpeedButton12N: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel193: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel174: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinDBText1N: TDBText {LAZARUS: TbsSkinDBText};
    bsRibbonGroup86: TPanel {LAZARUS: TbsRibbonGroup};
    btHinoSlideMusicaN: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton6N: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonDivider84: TBevel {LAZARUS: TbsRibbonDivider};
    GridPanel37: TPanel {LAZARUS: TGridPanel};
    btHinoSlideMusicaPBN: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btHinoSlideMusicaSAN: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup87: TPanel {LAZARUS: TbsRibbonGroup};
    GridPanel39: TPanel {LAZARUS: TGridPanel};
    bsSkinSpeedButton13N: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton3N: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsRibbonGroup88: TPanel {LAZARUS: TbsRibbonGroup};
    btExportarHinoN: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsRibbonGroup89: TPanel {LAZARUS: TbsRibbonGroup};
    bsSkinSpeedButton23N: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinTabSheet14: TTabSheet {LAZARUS: TbsSkinTabSheet};
    bsSkinPanel194: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton44: TButton {LAZARUS: TbsSkinButton};
    Memo1: TMemo;
    bsSkinButton45: TButton {LAZARUS: TbsSkinButton};
    pnlHinario1996Ativo: TPanel;
    pnlHinario1996Inativo: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel175: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinStdLabel176: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinButton46: TButton {LAZARUS: TbsSkinButton};
    bsSkinStdLabel177: TLabel {LAZARUS: TbsSkinStdLabel};
    ckgColetaneas: TCheckGroup {LAZARUS: TbsSkinCheckGroup};
    bsSkinPanel195: TPanel {LAZARUS: TbsSkinPanel};
    GridPanel54: TPanel {LAZARUS: TGridPanel};
    bsknbtn1: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel55: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider50: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel196: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel178: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel197: TPanel {LAZARUS: TbsSkinPanel};
    ctrlMonitores: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
    Panel39: TPanel;
    GridPanel55: TPanel {LAZARUS: TGridPanel};
    bsSkinDBText9: TDBText {LAZARUS: TbsSkinDBText};
    bsSkinDBText10: TDBText {LAZARUS: TbsSkinDBText};
    bsSkinDBText11: TDBText {LAZARUS: TbsSkinDBText};
    bsSkinPanel198: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider85: TBevel {LAZARUS: TbsRibbonDivider};
    bsSkinPanel199: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel179: TLabel {LAZARUS: TbsSkinStdLabel};
    bsPngImageView64: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel200: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel45: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView65: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel201: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel46: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView66: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel202: TPanel {LAZARUS: TbsSkinPanel};
    bsPngImageView67: TImage {LAZARUS: TbsPngImageView};
    bsSkinLinkLabel47: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsSkinPanel203: TPanel {LAZARUS: TbsSkinPanel};
    bsPngImageView68: TImage {LAZARUS: TbsPngImageView};
    bsSkinLinkLabel48: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsSkinPanel204: TPanel {LAZARUS: TbsSkinPanel};
    bsPngImageView69: TImage {LAZARUS: TbsPngImageView};
    bsSkinLinkLabel49: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsSkinPanel205: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel180: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinDBText12: TDBText {LAZARUS: TbsSkinDBText};
    bsSkinSpeedButton7: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel206: TPanel {LAZARUS: TbsSkinPanel};
    ckSlideFormatPersoExt: TCheckBox {LAZARUS: TbsSkinCheckBox};
    ckMusicaRetorno: TCheckBox {LAZARUS: TbsSkinCheckBox};
    sbMusicaRetornoAreaExtendida: TComboBox {LAZARUS: TbsSkinComboBox};
    bsFormatSlRetorno: TPanel {LAZARUS: TbsSkinPanel};
    bsFormatSlideRetorno: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel207: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel183: TLabel {LAZARUS: TbsSkinStdLabel};
    seTamanhoTextoRetorno: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    bsSkinButton47: TButton {LAZARUS: TbsSkinButton};
    pnlImagemCapaModelES: TPanel;
    imgImagemCapaModelES: TImage;
    bsSkinPanel169: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLinkLabel50: TLabel {LAZARUS: TbsSkinLinkLabel};
    bsPngImageView70: TImage {LAZARUS: TbsPngImageView};
    function VersaoExe: String;
    procedure FormCreate(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String); {LAZARUS: port b09c49b}
    procedure fExibeColetaneas(Tipo: string; ScrollBox: TScrollBox {LAZARUS: TbsSkinScrollBox});
    procedure fExibeColetaneasPerso(ScrollBox: TScrollBox {LAZARUS: TbsSkinScrollBox});
    procedure sbClick(Sender: TObject);
    procedure sbClickPerso(Sender: TObject);
    procedure abreListaMusicaHeadless(id_album: integer; titulo: string = 'Álbum');
    procedure abreListaDirHeadless(dir: string); {LAZARUS: param headless lista_dir=}
    procedure avancaSlideHeadless(Sender: TObject); {LAZARUS: param headless autoslide=1}
    procedure FormActivate(Sender: TObject);
    procedure tsHinarioShow(Sender: TObject);
    procedure txtHinoChange(Sender: TObject);
    procedure corCampoBusca(Query: TDataSet {LAZARUS: TZQuery→TDataSet}; Campo: TEdit {LAZARUS: TbsSkinEdit}; DBGrid: TDBGrid {LAZARUS: TbsSkinDBGrid});
    function qtItens(Query: TDataSet {LAZARUS: TZQuery/TFDQuery→TDataSet};texto_sing,texto_plu,texto_nenh:string): string;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure txtHinoKeyPress(Sender: TObject; var Key: Char);
    procedure abreLetra(ID: integer; BUSCA: string = '');
    procedure tsJAShow(Sender: TObject);
    procedure tsDiversasShow(Sender: TObject);
    procedure tsBuscaMusicaShow(Sender: TObject);
    procedure txtBuscaChange(Sender: TObject);
    procedure buscaMusicas();
    procedure DBGrid2DblClick(Sender: TObject);
    procedure txtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure SorteioContador();
    function isFolderEmpty(szPath: string): Boolean;
    function IsNumeric(S: string): boolean;
    function verVersao():Boolean;
    procedure tsSorteioShow(Sender: TObject);
    procedure tsCronometroShow(Sender: TObject);
    procedure tsCronoCultoShow(Sender: TObject);
    procedure txtDecrExit(Sender: TObject);
    function lerParam(Grupo, Param, Valor: string;Arquivo: string = ''; Diretorio:string = ''): string;
    procedure gravaParam(Grupo, Param, Valor: string;Arquivo: string = '');
    procedure gravaParamLote(const Arquivo: string; const Itens: array of TParamItem);
    procedure gravaParamServer(Grupo, Param, Valor: string);
    procedure apagaParam(Grupo: string; Param: string = '';Arquivo: string = '');
    procedure cbMusicaChange(Sender: TObject);
    procedure selMusica();
    procedure meESHoraChange(Sender: TObject);
    procedure tsBuscaBiblicaShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Link(Sender: TObject);
    procedure tsPersonalizadasShow(Sender: TObject);
    procedure btOuvirClick(Sender: TObject);
    procedure btLigarClick(Sender: TObject);
    procedure btIniciarCronoClick(Sender: TObject);
    procedure btZerarCronoClick(Sender: TObject);
    procedure btAnotTempoClick(Sender: TObject);
    procedure btSortearClick(Sender: TObject);
    procedure Localizar(ValorBusca: string; RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit}; recolore: boolean);
    procedure formataTexto(RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit});
    procedure FormResize(Sender: TObject);
    procedure tsBibliaShow(Sender: TObject);
    function ExtraiTexto(const Str, Str1, Str2: string): string;
    procedure carregaParams();
    function GetComputerNameFunc: string;
    procedure BitmapFileToPNG(const Source, Dest: string);
    procedure LiturgiaCalendarClick(Sender: TObject);
    function verificaURL(url: string; input: TCustomEdit {LAZARUS: TbsSkinEdit→TCustomEdit}; reverso: Boolean = False): string; overload;
    function verificaURL(url: string; input: TFileNameEdit {LAZARUS: TbsSkinFileEdit overload}; reverso: Boolean = False): string; overload;
    procedure sListView1DblClick(Sender: TObject);
    procedure expandirArea(Sender: TObject);
    procedure copiaDadosTelaExtendida();
    procedure fcOpcFonteChange(Sender: TObject);
    procedure seOpcTamanhoChange(Sender: TObject);
    procedure csOpcCorChange(Sender: TObject);
    procedure btOpcResetClick(Sender: TObject);
    procedure btOpcFileNameEditExit(Sender: TObject);
    function ColorToHtml(DColor: TColor): string;
    function termo_busca(busca: string): string;
    procedure sButton10Click(Sender: TObject);
    procedure sTabSheet15Show(Sender: TObject);
    procedure sTabSheet16Show(Sender: TObject);
    procedure sTabSheet13Show(Sender: TObject);
    procedure sTabSheet18Show(Sender: TObject);
    procedure abrePagina(TabSheet: TTabSheet {LAZARUS: TbsSkinTabSheet});
    procedure btAbreHinosClick(Sender: TObject);
    procedure mnFechaAbaClick(Sender: TObject);
    procedure mnFechaTodasAbasClick(Sender: TObject);
    procedure confereAbasAbertas();
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure btAbreColJAClick(Sender: TObject);
    procedure PaginaMenuAtiva(page: TTabSheet {LAZARUS: TbsRibbonPage};tabvinc: TTabSheet {LAZARUS: TbsSkinTabSheet} = nil);
    procedure marcaAbaAberta(TabSheet: TTabSheet {LAZARUS: TbsSkinTabSheet});
    procedure mnSelecionaAbaClick(Sender: TObject);
    procedure mnAbreFavoritoClick(Sender: TObject);
    procedure btHinoSlideMusicaClick(Sender: TObject);
    procedure bsSkinSpeedButton13Click(Sender: TObject);
    procedure bsSkinSpeedButton12Click(Sender: TObject);
    procedure bsSkinSpeedButton14Click(Sender: TObject);
    procedure PageControl1Close(Sender: TObject; var CanClose: Boolean);
    procedure PageControl1Change(Sender: TObject); {LAZARUS: TTabSheet.OnShow não dispara no LCL ao trocar aba — chamamos via OnChange}
    procedure bsSkinSpeedButton9Click(Sender: TObject);
    procedure ShowTrackMenu(Sender: TObject);
    function RemoveTags(const s: string): string;
    procedure carregaConfiguracoes(pagina: string);
    procedure bsSkinSpeedButton10Click(Sender: TObject);
    procedure bsRibbonGroup19DialogButtonClick(Sender: TObject);
    procedure ckLivrosClickCheck(Sender: TObject);
    procedure ckLivros2ClickCheck(Sender: TObject);
    procedure bsSkinSpeedButton20Click(Sender: TObject);
    procedure txtAbrirColetExit(Sender: TObject);
    procedure txtCapaColetExit(Sender: TObject);
    procedure txtCapaColetEnter(Sender: TObject);
    procedure txtAbrirColetEnter(Sender: TObject);
    procedure btOpcFileNameEditEnter(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure btAddColPersoClick(Sender: TObject);
    procedure btAddColetPersoClick(Sender: TObject);
    procedure btAltColPersoClick(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure txtAbrirColet2Enter(Sender: TObject);
    procedure txtAbrirColet2Exit(Sender: TObject);
    procedure txtCapaColet2Enter(Sender: TObject);
    procedure txtCapaColet2Exit(Sender: TObject);
    procedure cbColetaneasPersoChange(Sender: TObject);
    procedure bsSkinSpeedButton24Click(Sender: TObject);
    procedure bsSkinSpeedButton26Click(Sender: TObject);
    procedure cbMarcarConcClick(Sender: TObject);
    procedure pnlAddColPersoClose(Sender: TObject);
    procedure pnlAltColPersoClose(Sender: TObject);
    procedure bsSkinSpeedButton25Click(Sender: TObject);
    procedure ckMonitorJanelaClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cgEscSBAudioClick(Sender: TObject);
    procedure meESHoraExit(Sender: TObject);
    procedure bsSkinSpeedButton30Click(Sender: TObject);
    procedure opSortKeyPress(Sender: TObject; var Key: Char);
    procedure lbSorteioItemCheckClick(Sender: TObject);
    procedure btAddSorteioClick(Sender: TObject);
    procedure btLimpaSorteioReiniciaClick(Sender: TObject);
    procedure btLimpaSorteioLimpaClick(Sender: TObject);
    procedure btLimpaSorteioClick(Sender: TObject);
    procedure ckSorteioExpClick(Sender: TObject);
    procedure btFormatClick(Sender: TObject);
    procedure pnlFormatClose(Sender: TObject);
    procedure bsSkinSpeedButton28Click(Sender: TObject);
    procedure tsSorteioNMShow(Sender: TObject);
    procedure bsSkinButton3Click(Sender: TObject);
    procedure bsSkinButton4Click(Sender: TObject);
    procedure bsSkinButton6Click(Sender: TObject);
    procedure bsSkinButton5Click(Sender: TObject);
    procedure bsSkinButton9Click(Sender: TObject);
    procedure bsSkinButton8Click(Sender: TObject);
    procedure lbSorteioNMItemCheckClick(Sender: TObject);
    procedure bsSkinButton10Click(Sender: TObject);
    procedure bsSkinButton12Click(Sender: TObject);
    procedure bsSkinButton11Click(Sender: TObject);
    procedure bsSkinButton7Click(Sender: TObject);
    procedure opSort_IniKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure opSort_NmKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btAddSorteioNMClick(Sender: TObject);
    procedure btImpSorteioNMClick(Sender: TObject);
    procedure btSortearNMClick(Sender: TObject);
    procedure ckSorteioExpNMClick(Sender: TObject);
    procedure btLimpaSorteioLimpaNMClick(Sender: TObject);
    procedure btLimpaSorteioReiniciaNMClick(Sender: TObject);
    procedure btLimpaSorteioNMClick(Sender: TObject);
    procedure cbCronoElClick(Sender: TObject);
    procedure bsSkinSpeedButton29Click(Sender: TObject);
    procedure bsSkinButton13Click(Sender: TObject);
    procedure rbDirecaoClick(Sender: TObject);
    procedure txtDecrChange(Sender: TObject);
    procedure bsSkinSpeedButton27Click(Sender: TObject);
    procedure tsPainelDShow(Sender: TObject);
    procedure btExibeTxtPainelDClick(Sender: TObject);
    procedure bsSkinSpeedButton31Click(Sender: TObject);
    procedure tsTextoInterativoShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure RichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RichEditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RichEditEnter(Sender: TObject);
    procedure fcTxtIChange(Sender: TObject);
    procedure seTxtITamanhoChange(Sender: TObject);
    procedure btfsStrikeOutClick(Sender: TObject);
    procedure btfsUnderlineClick(Sender: TObject);
    procedure btfsItalicClick(Sender: TObject);
    procedure btfsBoldClick(Sender: TObject);
    procedure cbColorTxtIChangeColor(Sender: TObject);
    procedure cbColorFTxtIChangeColor(Sender: TObject);
    procedure bsSkinSpeedButton42Click(Sender: TObject);
    procedure bsSkinSpeedButton41Click(Sender: TObject);
    procedure bsSkinSpeedButton39Click(Sender: TObject);
    procedure bsSkinSpeedButton38Click(Sender: TObject);
    procedure bsSkinSpeedButton43Click(Sender: TObject);
    procedure cbColorRTxtIChangeColor(Sender: TObject);
    procedure RE_SetSelBgColor(RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit}; AColor: TColor);
    procedure bsSkinSpeedButton44Click(Sender: TObject);
    procedure bsSkinSpeedButton45Click(Sender: TObject);
    procedure bttaLeftJustifyClick(Sender: TObject);
    procedure bttaRightJustifyClick(Sender: TObject);
    procedure bttaCenterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmPainelDKeyPress(Sender: TObject; var Key: Char);
    function GetEnvVarValue(const VarName: string): string;
    procedure bsAppMenu1Items6Click(Sender: TObject);
    procedure bsSkinSpeedButton23Click(Sender: TObject);
    procedure bsSkinSpeedButton37Click(Sender: TObject);
    procedure sTabSheet12Show(Sender: TObject);
    procedure sTabSheet14Show(Sender: TObject);
    procedure slbTabelasListBoxClick(Sender: TObject);
    procedure bsSkinButton15Click(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
    procedure AjustaLarguraCamposDBGrid(DBGrid: TDBGrid {LAZARUS: TbsSkinDbGrid});
    procedure abrirArquivo(url: string;externo: Boolean = false);
    procedure bsSkinSpeedButton46Click(Sender: TObject);
    procedure RibbonPCButtons3Click(Sender: TObject);
    procedure ExcluirTodas1Click(Sender: TObject);
    procedure inputOpenDialog(Sender: TObject);
    procedure inputOpenPictureDialog(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheel(Direction: string; Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure cbBibliaHistoricoClick(Sender: TObject);
    procedure bsSkinSpeedButton50Click(Sender: TObject);
    procedure tsRelogioShow(Sender: TObject);
    procedure imgCapaProgramaEnter(Sender: TObject);
    procedure imgCapaProgramaExit(Sender: TObject);
    procedure corCapaProgramaChangeColor(Sender: TObject);
    procedure btRestaurarCapaProgramaClick(Sender: TObject);
    procedure cbAlinhamentoCapaProgramaChange(Sender: TObject);
    procedure bsSkinSpeedButton53Click(Sender: TObject);
    procedure bsSkinSpeedButton54Click(Sender: TObject);
    procedure bsSkinSpeedButton55Click(Sender: TObject);
    procedure btCopiaLitSelClick(Sender: TObject); {LAZARUS: port upstream 1570e57}
    procedure copiaItensLiturgiaParaDias(const diasDestino: array of Integer; sobrescrever: Boolean); {LAZARUS: port upstream 1570e57}
    procedure GridPanel23Resize(Sender: TObject); {LAZARUS: distribui lcal_1..7 (ex-TGridPanel)}
    procedure btApagaLitSelClick(Sender: TObject);
    procedure bsSkinSpeedButton58Click(Sender: TObject);
    procedure bsSkinButton25Click(Sender: TObject);
    procedure atualiza_coletaneas_web(p: string; id: string = '');
    procedure lista_coletaneas_web(p: string; id: string = '');
    procedure tsColetaneasOnlineShow(Sender: TObject);
    function DownloadArquivo(const Origem, Destino: string): Boolean;
    procedure bgOnlCanaisButtonClicked(Sender: TObject; Index: Integer);
    procedure pnlOnlPlaylistsClose(Sender: TObject);
    procedure bsSkinButton24Click(Sender: TObject);
    procedure bgOnlPlaylistsButtonClicked(Sender: TObject; Index: Integer);
    procedure pnlOnlVideosClose(Sender: TObject);
    procedure bsSkinButton26Click(Sender: TObject);
    procedure bgOnlVideosButtonClicked(Sender: TObject; Index: Integer);
    procedure abreVideoOn(videoID: string; videoTITULO: string = '');
    procedure abreLetraMusica(tipo: string;param: string;musicaID: Integer;audio: boolean = True);
    procedure abreLetraMusicaAlbum(albumID: Integer;musicaID: Integer = 0);
    procedure abreArquivoMusica(musicaID: Integer;album: string = '';url: string = '');
    procedure player(url: string;video: Boolean = true);
    procedure sbVideoOnAreaExtendidaChange(Sender: TObject);
    procedure ckVideoOnJanelaClick(Sender: TObject);
    procedure bsSkinSpeedButton60Click(Sender: TObject);
    procedure bsSkinSpeedButton62Click(Sender: TObject);
    procedure btUrlVideoOnClick(Sender: TObject);
    procedure btExecVideoOn(campo: TEdit {LAZARUS: TbsSkinEdit}; limpa: Boolean = true);
    function getVideoID(link: string):string;
    procedure btAbreSaveVideoOn(campo: TEdit {LAZARUS: TbsSkinEdit});
    procedure txtUrlVideoOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbVideoOnAbreLiturgiaChange(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
    procedure bsSkinSpeedButton59Click(Sender: TObject);
    procedure btUrlVideoOn2Click(Sender: TObject);
    procedure bsSkinSpeedButton66Click(Sender: TObject);
    procedure bsSkinSpeedButton61Click(Sender: TObject);
    procedure btColetaneasOnlinePersoClick(Sender: TObject);
    procedure tsColetaneasOnlinePersoShow(Sender: TObject);
    procedure bsSkinSpeedButton68Click(Sender: TObject);
    procedure btAddVideoOn3Click(Sender: TObject);
    procedure txtUrlVideoOn2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtUrlVideoOn3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid4DblClick(Sender: TObject);
    procedure bsSkinTabSheet6Show(Sender: TObject);
    procedure Excluir3Click(Sender: TObject);
    procedure CopiarLink1Click(Sender: TObject);
    procedure AbrirnoNavegador1Click(Sender: TObject);
    procedure btwsCloseClick(Sender: TObject);
    procedure btwsMinimizeClick(Sender: TObject);
    procedure btwsMaximizedClick(Sender: TObject);
    procedure pnlfmBarraTituloFormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlfmBarraTituloFormDblClick(Sender: TObject);
    procedure focoAplicacao(acao: Boolean);
    procedure btwsDownloadClick(Sender: TObject);
    procedure RibbonPCChangePage(Sender: TObject);
    procedure carregaFavoritos();
    procedure btAddFavClick(Sender: TObject);
    procedure bsSkinTabSheet7Show(Sender: TObject);
    procedure ogFavoritosItemClick(Sender: TObject);
    procedure btDelFavClick(Sender: TObject);
    procedure RibbonPCButtons4Click(Sender: TObject);
    procedure btwsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btwsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure botoesFavoritos(acao: string);
    procedure btOrdFavClick(Sender: TObject);
    procedure pnlfmSubTituloRibMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlfmSubTituloRibMouseLeave(Sender: TObject);
    procedure pnlfmSubTituloRibClick(Sender: TObject);
    procedure desenvolvedor(ativo: boolean);
    procedure txtBuscaColetPesoChange(Sender: TObject);
    procedure sbMusicaAreaExtendidaChange(Sender: TObject);
    procedure ckMusicaJanelaClick(Sender: TObject);
    procedure edtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure usaFontes(usar: Boolean = true);
    procedure ckMusicaOperadorClick(Sender: TObject);
    procedure btMusicaSlideMusicaClick(Sender: TObject);
    procedure btMusicaLetraClick(Sender: TObject);
    procedure btMusicaAudioMusicaClick(Sender: TObject);
    procedure btAddItemLiturgiaClick(Sender: TObject);
    function FonteExiste(Fonte:STring):Boolean;
    procedure FormDestroy(Sender: TObject);
    procedure ImpExpClick(Sender: TObject);
    procedure bsSkinSpeedButton16Click(Sender: TObject);
    procedure tsDoxologiaShow(Sender: TObject);
    procedure bgDoxologiaCateButtonClicked(Sender: TObject; Index: Integer);
    procedure pnlDoxologiaMusicasClose(Sender: TObject);
    procedure btErroClick(Sender: TObject);
    procedure move_MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure move_MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure move_MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelColorClick(Sender: TObject);
    procedure tsLiturgiaShow(Sender: TObject);
    procedure carregaLiturgia(semana: Integer);
    procedure carregaItemLiturgia(item: string;ordem: Integer = 0);
    procedure apagaItemLiturgia(item: string);
    procedure salvaItensLiturgia();
    function CopyComponent(Component,AParent: TComponent; NewComponentName: String): TComponent;
    procedure lit_modItem_checkbClick(Sender: TObject);
    procedure lit_modItem_bteditClick(Sender: TObject);
    procedure lit_modItem_textoClick(Sender: TObject);
    procedure bsSkinButton34Click(Sender: TObject);
    procedure RibbonPCButtons5Click(Sender: TObject);
    procedure RibbonPCButtons0Click(Sender: TObject);
    procedure ckMusicaTituloSlideClick(Sender: TObject);
    procedure bsSkinButton38Click(Sender: TObject);
    procedure bsSkinButton36Click(Sender: TObject);
    procedure tabLetrasChange(Sender: TObject);
    procedure ckSlideTxtFormatPersoClick(Sender: TObject);
    procedure seSorteioTempoChange(Sender: TObject);
    procedure seSorteioTempoNMChange(Sender: TObject);
    function diretorio(dir:string):string;
    procedure processaArquivo(arq: string);
    procedure ExportarMusicaClick(Sender: TObject);
    procedure miOpcExportar1Click(Sender: TObject);
    procedure exportarMusica(id:integer;audio:boolean;nome:string = '';param:string = '');
    procedure exportarMusicaParaArquivo(id:integer;audio:boolean;url:string;param:string = ''); {LAZARUS: corpo do export sem dialog (testável headless)}
    function SegundosToTime( Segundos : Cardinal ) : String;
    procedure gravaLog(txt:string);
    procedure corFundoMusicaChangeColor(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid2CellClick(Column: TColumn {LAZARUS: TbsColumn});
    procedure cbFormatoChange(Sender: TObject);
    procedure tsMusicasInfantisShow(Sender: TObject);
    procedure bsSkinSpeedButton2Click(Sender: TObject);
    procedure dbctrlMusicasClick(Sender: TObject);
    procedure cbPosicaoFundoClick(Sender: TObject);
    procedure ajustaImagem(imagem:TImage;panel:TPanel;posicao:integer);
    function RemoveAcento(Str: string): string;
    procedure tsItensAgendadosShow(Sender: TObject);
    procedure bsSkinSpeedButton5Click(Sender: TObject);
    procedure MonthCalendar1GetMonthInfo(Sender: TObject; Month: Cardinal;
      var MonthBoldInfo: Cardinal);
    procedure btAddCategoriaAgendadosClick(Sender: TObject);
    procedure bsPngImageView13Click(Sender: TObject);
    procedure categoriasItensAgendadosClick(Sender: TObject);
    procedure itensAgendadosClick(Sender: TObject);
    procedure MonthCalendar1DblClick(Sender: TObject);
    procedure bsPngImageView11Click(Sender: TObject);
    procedure bsSkinSpeedButton8Click(Sender: TObject);
    procedure removeItensAgendadosPassados();
    procedure cbRemoveItensAgendadosClick(Sender: TObject);
    procedure refreshCalendar();
    procedure copiaTextoParaSlides(texto: string; cds: TBufDataset); {LAZARUS: TClientDataSet→TBufDataset}
    procedure copiaArquivoParaSlides(url: string; cds: TBufDataset; fechaerro: boolean = true; ListBox: TListBox = nil; editor: boolean = false); {LAZARUS: TClientDataSet→TBufDataset}
    procedure copiaSlidesParaArquivo(url: string; cds: TBufDataset); {LAZARUS: TClientDataSet→TBufDataset}
    function cds2texto(cds: TBufDataset;campo: string): TStringList; {LAZARUS: TClientDataSet→TBufDataset}
    function HtmlToColor(Color: string): String;
    procedure cbAnotacoesLiturgiaClick(Sender: TObject);
    procedure pnlAnotacoesLiturgiaClose(Sender: TObject);
    procedure RichEdit1Exit(Sender: TObject);
    procedure mmPopMonitorClick(Sender: TObject);
    procedure identifica_monitores(Sender: TObject);
    function lista_monitores(): TMonitorInfoArray; {LAZARUS: TArray<TMonitorInfo>→TMonitorInfoArray}
    procedure carrega_monitores();
    procedure ppVideosOnPersoPopup(Sender: TObject);
    procedure bsPopupMenuFavoritosPopup(Sender: TObject);
    procedure carregaComboFormatoTempo(combo:TComboBox {LAZARUS: TbsSkinComboBox};formato:string);
    function openDialog(tipo:string = '';filtros:string = '';param:string = '';multiplos:boolean = False;diretorio_inicial:string = '';titulo_dialog: string = '';nome_arquivo:string = ''):string;
    function saveDialog(tipo:string = '';filtros:string = '';param:string = '';diretorio_inicial:string = '';titulo_dialog: string = '';nome_arquivo:string = ''):string;
    procedure bsSkinButton43Click(Sender: TObject);
    procedure bsAppMenu1Items7Click(Sender: TObject);
    procedure btExecSQLClick(Sender: TObject);
    procedure mmBDKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEscSBRelogioFuncClick(Sender: TObject);
    procedure cbEscSBZerarTempoClick(Sender: TObject);
    procedure escSBTempo();
    procedure DBCtrlGridBibliaLivroClick(Sender: TObject);
    procedure carregaBiblia(tipo:string);
    procedure DBCtrlGridBibliaCapituloClick(Sender: TObject);
    procedure DBCtrlGridBibliaVersiculoClick(Sender: TObject);
    procedure busBibliaVersiculoChange(Sender: TObject);
    function GetStrNumber(const S: string): string;
    function GetStrNumber2(const S: string): string;
    function geraIntervaloNum(S: string): string;
    function formataIntervaloNum(S: string): string;
    function maiorLista(L: string): string;
    function menorLista(L: string): string;
    procedure DBCtrlGridBibliaHistoricoClick(Sender: TObject);
    procedure bsSkinButton20Click(Sender: TObject);
    procedure pnlBibliaHistoricoClose(Sender: TObject);
    procedure ajustaTexto(pagina:string;areaExpandida: Boolean = false);
    procedure btLimparClick(Sender: TObject);
    procedure busBibliaVersiculoKeyPress(Sender: TObject; var Key: Char);
    procedure btBibVersAntClick(Sender: TObject);
    procedure btBibVersSegClick(Sender: TObject);
    procedure btBibLocalizaClick(Sender: TObject);
    procedure txtBibLocalizaKeyPress(Sender: TObject; var Key: Char);
    procedure dblBibVersao2Click(Sender: TObject);
    procedure DBCtrlGridBibliaBuscaClick(Sender: TObject);
    procedure btLimparBBuscaClick(Sender: TObject);
    procedure btBibBusVersSegClick(Sender: TObject);
    procedure btBibBusVersAntClick(Sender: TObject);
    procedure pnLivrosClose(Sender: TObject);
    procedure ckgFiltrosClick(Sender: TObject);
    procedure aSort(var Vetor: Array of Integer);
    procedure atualizaIgnoreAlbum();
    procedure gridAlbAtDblClick(Sender: TObject);
    procedure gridAlbInatDblClick(Sender: TObject);
    procedure bsSkinButton21Click(Sender: TObject);
    function FileSize(const FileName: string): Int64;
    procedure corTituloMusicaChangeColor(Sender: TObject);
    procedure corTextoMusicaChangeColor(Sender: TObject);
    procedure corTextoAuxMusicaChangeColor(Sender: TObject);
    procedure ckMusicaFundoTransparenteClick(Sender: TObject);
    procedure seTamanhoTituloChange(Sender: TObject);
    procedure seTamanhoTextoChange(Sender: TObject);
    procedure seTamanhoTextoAuxChange(Sender: TObject);
    procedure imgFundoMusicaEnter(Sender: TObject);
    procedure imgFundoMusicaExit(Sender: TObject);
    procedure posicaoFundoClick(Sender: TObject);
    procedure corTextoRepetidoChangeColor(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure getClipboard();
    procedure btPersoClipBoardClick(Sender: TObject);
    procedure ckFadeFormClick(Sender: TObject);
    function RecursiveDelete(FullPath: String;nivel: integer = 0): Boolean;
    procedure btLitClipBoardClick(Sender: TObject);
    procedure cbBloqItensClick(Sender: TObject);
    procedure cbLayoutChange(Sender: TObject);
    procedure ckSlideImgFormatPersoClick(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure DBCtrlGridBibliaLivroPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaCapituloPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaVersiculoPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaHistoricoPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaBuscaPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox};
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    {LAZARUS: ajustaBibliaLayout — reposiciona painéis da aba Bíblia que originalmente usavam
     TbsSkinExPanel com tile-grid; agora usa posicionamento explícito pois alClient em múltiplos
     filhos do GridPanel74 faz sobreposição no LCL}
    procedure ajustaBibliaLayout;
    procedure GridPanel74Resize(Sender: TObject);
    procedure bsAppMenu1Click(Sender: TObject);
    procedure bsAppMenu1Items1Click(Sender: TObject);
    procedure bsAppMenu1ChangePage(Sender: TObject);
    procedure pbPlayerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btplPlayClick(Sender: TObject);
    procedure btplPauseClick(Sender: TObject);
    procedure btplFecharClick(Sender: TObject);
    procedure sbPlayerAreaExtendidaChange(Sender: TObject);
    procedure ckPlayerTelaCheiaClick(Sender: TObject);
    procedure ckPlayerVideoClick(Sender: TObject);
    procedure ckPlayerAudioClick(Sender: TObject);
    procedure bsSkinSpeedButton6Click(Sender: TObject);
    procedure dblBibVersaoClick(Sender: TObject);
    procedure busBibliaLivroChange(Sender: TObject);
    procedure busBibliaLivroExit(Sender: TObject);
    procedure busBibliaCapituloExit(Sender: TObject);
    procedure busBibliaCapituloChange(Sender: TObject);
    procedure bsSkinTabSheet5Show(Sender: TObject);
    procedure opcCronoCTempoClick(Sender: TObject);
    procedure meESDuracaoChange(Sender: TObject);
    procedure bsAddTClick(Sender: TObject);
    procedure ckMesmaJanelaClick(Sender: TObject);
    procedure sbAlinhMusicaChange(Sender: TObject);
    procedure cbRelogioAlinhamentoChange(Sender: TObject);
    procedure bsAppMenu1Items10Click(Sender: TObject);
    procedure bsAppMenu1Items3Click(Sender: TObject);
    procedure ckMusicaTopoClick(Sender: TObject);
    procedure spServerClick(Sender: TObject);
    procedure ckMusicaRetornoClick(Sender: TObject);
    procedure sbMusicaRetornoAreaExtendidaChange(Sender: TObject);
    function GetIP(): string;
    function enumerarInterfacesRede: TStringList; {LAZARUS: port 32c09b8 — pares nome=ip}
    procedure Button2Click(Sender: TObject);
    procedure monitores(padrao: integer = -1);
    procedure monitor_bt_label(botao: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton});
    function monitor_tp_config(botao: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}):string;
    procedure sbMusicaOperadorAreaExtendidaChange(Sender: TObject);
    procedure ckFundoTransparenteClick(Sender: TObject);
    procedure btAbreHinosNClick(Sender: TObject);
    procedure tsHinarioNShow(Sender: TObject);
    procedure txtHinoNKeyPress(Sender: TObject; var Key: Char);
    procedure txtHinoNChange(Sender: TObject);
    procedure DBGrid1NDblClick(Sender: TObject);
    procedure bsSkinSpeedButton13NClick(Sender: TObject);
    procedure bsSkinSpeedButton3NClick(Sender: TObject);
    procedure bsSkinSpeedButton6NClick(Sender: TObject);
    procedure btHinoSlideMusicaNClick(Sender: TObject);
    procedure bsSkinSpeedButton12NClick(Sender: TObject);
    procedure bsSkinButton44Click(Sender: TObject);
    procedure bsSkinButton45Click(Sender: TObject);
    procedure bsSkinButton46Click(Sender: TObject);
    function monitorInfo(index: integer): TMonitorInfo;
    procedure importColetaneasPerso();
    procedure ckgColetaneasClick(Sender: TObject);
    function arquivoCodificado(arq: string): TStringList;
    procedure bsknbtn1Click(Sender: TObject);
    procedure bsSkinSpeedButton7Click(Sender: TObject);
    procedure ckSlideFormatPersoExtClick(Sender: TObject);
    procedure bsSkinButton47Click(Sender: TObject);
    procedure seTamanhoTextoRetornoChange(Sender: TObject);
    function removeTagsHTML(texto: string): string;
    procedure SaveBase64ImageToFile(const Base64String, FilePath: string);
    function ExtractBase64Data(const Base64String: string): string;
    procedure RestartApplication;
  private
    { Private declarations }
    move_x,move_y:integer;
    move_panel: TPanel;
    move: Boolean;
    FLogChamadas: Integer;  // contador para checagem de truncamento do louvorja.log

    const
      VERSAO_MIN_BD: integer = 140;
      fonte: string = 'Arial Rounded MT Bold';

    {LAZARUS: WMNCHitTest e WMGetMinmaxInfo removidos — Windows-only}

    //Define as ações para quando perder ou receber o foco
    procedure ApplicationDeactivate(Sender: TObject);
    procedure ApplicationActivate(Sender: TObject);
    procedure ForceDirectoriesRecursive(const Path: string);

    //Helpers internos para acesso ao liturgia.ja (UTF-8 garantido + migração on-demand)
    function caminhoLiturgia: string;
    procedure garanteUtf8Liturgia;
    function abreIniLiturgia: TMemIniFile;
    procedure invalidateLiturgiaCache;

  public
    { Public declarations }
    dir_dados: string;
    dir_temp: string;
    dir_config: string;
    url_params: string;
    api_token: string;

    carrega_opc: Boolean;

    vSorteioAnimFim, vSorteioAnimFimNM: TDateTime;
    tCrono: TDateTime;
    tCronoOld: TDateTime;
    tCronoT: TDateTime;

    tEscSBCrono: TDateTime;

    buffer: integer;
    botao_trmenu: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};


    TITULO: PChar;
    arq_liturgia: string;
    senha_bd: string;

    {LAZARUS: port upstream 1570e57 — copiar itens da liturgia p/ outros dias.
     btCopiaLitSel é criado em runtime (LFM é gerado pela IDE; ver FormCreate)}
    FLitClipboard: TStringList;
    FLitClipboardSemana: Integer;
    btCopiaLitSel: TSpeedButton;

    {LAZARUS: cache do TMemIniFile de liturgia.ja para evitar múltiplas leituras de disco}
    FLiturgiaIniCache: TMemIniFile;

    externo: Boolean;

    {LAZARUS: campos BASS — player principal e preview de música}
    PlayerStream: HSTREAM;
    BassPreviewChannel: HCHANNEL;
    BassPreviewFile: string; {LAZARUS: mpMusica.FileName substituido}

    procedure criaBotaoCopiaLiturgia; {LAZARUS: port 1570e57 — botão runtime no ribbon}

    {LAZARUS: métodos públicos para testes headless}
    procedure abreHelp;
    procedure abreArquivosExcesso;
    procedure abreArquivosFalta;
    procedure abreFavoritosManager;
    procedure abreMonitorHeadless(botao: string);

  end;

var
  fmIndex: TfmIndex;

implementation

uses
  {LAZARUS: removidos units Windows-específicas da seção implementation}
  fmLetra, fmAtualiza, StrUtils, fmNovaVersao,
  fmHelp, fmVideoOn, fmFavoritos, fmMusica, fmListaMusica,
  fmMusicaOperador, fmLiturgia, fmArquivosFalta, fmBuscaMusica, fmArquivosExcesso,
  fmItensAgendados, dmComponentes, fmEditorSlides, fmPlayer, fmIniciando,
  fmTransmitir, fmMusicaRetorno, fmMonitorRelogio, fmMonitorTextoInterativo,
  fmMonitorPainelDinamico, fmMonitorCronometro, fmMonitorSorteioNomes,
  fmMonitorSorteio, fmMonitorCronometroCulto, fmMonitorBibliaBusca,
  fmMonitorBiblia, fmMonitorMenuMusicas, fmIdentificaMonitores,
  fmCopiaLiturgiaDia;

Function TfmIndex.VersaoExe: String;
{LAZARUS: GetFileVersionInfoSize/VerQueryValue removidos — Windows API}
begin
  Result := lblVersao.Caption; {LAZARUS: versao lida de lblVersao}
end;

procedure TfmIndex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {LAZARUS: proteger o save das anotações — se SaveToFile falhar, NÃO pode bloquear o
   encerramento do app (era causa de "o botão fechar não funciona")}
  try
    RichEdit1Exit(RichEdit1);
  except
  end;
  DM.tmrSair.Enabled := true;
end;

procedure TfmIndex.FormCreate(Sender: TObject);
var
  iComp: Integer;
  sb: TSpeedButton;
  grp: TPanel;
  lbl: TLabel;
begin
  { TButtonGlyph.Draw exits early when FOriginal=nil; populate Glyph from
    Images+ImageIndex so drawing proceeds to the ImageList path. }
  for iComp := 0 to ComponentCount - 1 do
    if Components[iComp] is TSpeedButton then begin
      sb := TSpeedButton(Components[iComp]);
      if (sb.Images <> nil) and (sb.ImageIndex >= 0)
         and (sb.Images.Count > sb.ImageIndex) then
        sb.Images.GetBitmap(sb.ImageIndex, sb.Glyph);
    end;

  {LAZARUS: bsRibbonGroup* panels têm Caption que renderiza centralizado no TPanel (padrão),
   mas no ribbon o label do grupo deve aparecer no RODAPÉ do painel (abaixo dos ícones).
   Cria TLabel alBottom com o caption e limpa o Caption do painel.}
  for iComp := 0 to ComponentCount - 1 do
    if Components[iComp] is TPanel then
    begin
      grp := TPanel(Components[iComp]);
      if (Pos('bsRibbonGroup', grp.Name) = 1) and (Trim(grp.Caption) <> '') then
      begin
        lbl := TLabel.Create(grp);
        lbl.Parent := grp;
        lbl.Align := alBottom;
        lbl.Alignment := taCenter;
        lbl.Caption := grp.Caption;
        lbl.Font.Size := 7;
        lbl.AutoSize := False;
        lbl.Height := 16;
        grp.Caption := ' '; {espaço — manter borda do TPanel consistente}
      end;
    end;
  Application.OnDeactivate := ApplicationDeactivate;
  Application.OnActivate := ApplicationActivate;
  SysUtils.FormatSettings.DecimalSeparator := '.';

  {LAZARUS: conectar TStatusPanel fields ao Panels collection criado pelo LFM}
  if stHinos.Panels.Count >= 2 then begin
    stHinos0 := stHinos.Panels[0];
    stHinos1 := stHinos.Panels[1];
  end;
  if stHinosN.Panels.Count >= 2 then begin
    stHinos0N := stHinosN.Panels[0];
    stHinos1N := stHinosN.Panels[1];
  end;
  if stColetPerso.Panels.Count >= 2 then begin
    stColetPerso_0 := stColetPerso.Panels[0];
    stColetPerso_1 := stColetPerso.Panels[1];
  end;
  if stVideosOnPerso.Panels.Count >= 1 then
    stVideosOnPerso_1 := stVideosOnPerso.Panels[0];
  if pnlStatusBuscaMusicas.Panels.Count >= 2 then begin
    pnlStatusBuscaMusicas0 := pnlStatusBuscaMusicas.Panels[0];
    pnlStatusBuscaMusicas1 := pnlStatusBuscaMusicas.Panels[1];
  end;
  if bsSkinStatusBar1.Panels.Count >= 5 then begin
    spNomePC  := bsSkinStatusBar1.Panels[0];
    spServer  := bsSkinStatusBar1.Panels[1];
    spData    := bsSkinStatusBar1.Panels[2];
    spRelogio := bsSkinStatusBar1.Panels[3];
    spVersao  := bsSkinStatusBar1.Panels[4];
  end;
  {LAZARUS: SetWindowLong/GetWindowLong removidos — Windows API}

  {LAZARUS: port upstream b09c49b — DragAcceptFiles/WM_DROPFILES (ShellApi) →
   AllowDropFiles+OnDropFiles (LCL, cross-platform)}
  Self.AllowDropFiles := True;
  Self.OnDropFiles := FormDropFiles;

  {LAZARUS: port upstream 1570e57 — botão "Copiar Selecionados" no ribbon da
   liturgia. No upstream o botão vem do DFM; aqui é criado em runtime (LFM é
   gerado pela IDE). Ícone 056.png embutido via icone056.lrs → DM.ico_40x40.}
  FLitClipboard := TStringList.Create;
  FLitClipboardSemana := 0;
  criaBotaoCopiaLiturgia;

  {LAZARUS: layout das 7 colunas do calendário da liturgia (ex-TGridPanel)}
  GridPanel23.OnResize := GridPanel23Resize;
  GridPanel23Resize(nil);
end;

{LAZARUS: port upstream 1570e57 — cria btCopiaLitSel espelhando btApagaLitSel}
procedure TfmIndex.criaBotaoCopiaLiturgia;
var
  png: TPortableNetworkGraphic;
  bmp: Graphics.TBitmap;
  idx: Integer;
begin
  idx := -1;
  png := TPortableNetworkGraphic.Create;
  try
    try
      png.LoadFromLazarusResource('056');
      {ícone é 40x39 — centraliza num bitmap 40x40 do tamanho do ImageList}
      bmp := Graphics.TBitmap.Create;
      try
        bmp.PixelFormat := pf32bit;
        bmp.SetSize(DM.ico_40x40.Width, DM.ico_40x40.Height);
        bmp.Canvas.Brush.Color := clFuchsia;
        bmp.Canvas.FillRect(0, 0, bmp.Width, bmp.Height);
        bmp.Canvas.Draw((bmp.Width - png.Width) div 2,
                        (bmp.Height - png.Height) div 2, png);
        idx := DM.ico_40x40.AddMasked(bmp, clFuchsia);
      finally
        bmp.Free;
      end;
    except
      idx := -1; {sem ícone — botão só com caption}
    end;
  finally
    png.Free;
  end;

  btCopiaLitSel := TSpeedButton.Create(Self);
  btCopiaLitSel.Name := 'btCopiaLitSel';
  btCopiaLitSel.Parent := btApagaLitSel.Parent;
  btCopiaLitSel.Width := btApagaLitSel.Width;
  btCopiaLitSel.Left := btApagaLitSel.Left - 1; {antes do Apagar na pilha alRight}
  btCopiaLitSel.Top := btApagaLitSel.Top;
  btCopiaLitSel.Height := btApagaLitSel.Height;
  btCopiaLitSel.Caption := 'Copiar Selecionados';
  btCopiaLitSel.Layout := blGlyphTop;
  btCopiaLitSel.Spacing := 1;
  btCopiaLitSel.Flat := btApagaLitSel.Flat;
  btCopiaLitSel.Transparent := btApagaLitSel.Transparent;
  if idx >= 0 then
  begin
    btCopiaLitSel.Images := DM.ico_40x40;
    btCopiaLitSel.ImageIndex := idx;
    DM.ico_40x40.GetBitmap(idx, btCopiaLitSel.Glyph); {mesmo workaround do FormCreate}
  end;
  btCopiaLitSel.OnClick := btCopiaLitSelClick;
  btCopiaLitSel.Align := alRight;
  {alarga o grupo do ribbon para caber o novo botão (235→342 no upstream)}
  btApagaLitSel.Parent.Width := btApagaLitSel.Parent.Width + btCopiaLitSel.Width;
end;

{LAZARUS: TGridPanel → TPanel perdeu as células; os 7 botões lcal_* ficavam com
 Align=alClient sobrepostos (só o último, "Domingo", aparecia). Distribui em 7 colunas}
procedure TfmIndex.GridPanel23Resize(Sender: TObject);
var
  i, w: Integer;
  bt: TSpeedButton;
begin
  w := GridPanel23.ClientWidth div 7;
  for i := 1 to 7 do
  begin
    bt := TSpeedButton(FindComponent('lcal_' + IntToStr(i)));
    if bt <> nil then
      bt.SetBounds((i - 1) * w + 5, 10, w - 10, 29);
  end;
end;

procedure TfmIndex.FormDestroy(Sender: TObject);
begin
  RichEdit1Exit(Sender);
  usaFontes(false);
  RecursiveDelete(dir_temp);
  FreeAndNil(FLiturgiaIniCache); {LAZARUS: libera cache do TMemIniFile de liturgia.ja}
  FreeAndNil(FLitClipboard); {LAZARUS: port 1570e57}
end;

procedure TfmIndex.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  t: integer;
begin
  if (Key = VK_ESCAPE) then
  begin
    {LAZARUS: RibbonPC.AppMenu removido - TPageControl nao tem AppMenu}
    if (Screen.ActiveForm.Name <> 'fmIndex') then
      Screen.ActiveForm.Close
    else
    begin
      if (fMusica <> nil) and (fMusica.Visible) then
        fMusica.Close
      else if (fVideoOn <> nil) and (fVideoOn.Visible) then
        fVideoOn.Close
      ;
    end;
  end
  else if (((Chr(Key) = 'V') or (Chr(Key) = 'v')) and (Shift = [ssCtrl])) then
  begin
    cboard.Items.Clear;
    getClipboard();
    if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsPersonalizadas)
      then btPersoClipBoardClick(Sender)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsLiturgia)
      then btLitClipBoardClick(Sender);
  end
  else if (((Chr(Key) = 'W') or (Chr(Key) = 'w')) and (Shift = [ssCtrl])) then
  begin
    if ((Screen.ActiveForm.Name = 'fmIndex') and (PageControl1.Visible = True)) then
    begin
      t := TTabSheet {LAZARUS: TbsSkinTabSheet}(PageControl1.ActivePage).Tag;
      PageControl1.ActivePage.TabVisible := False;
      bsPopupMenuRibon.Items.Delete(t);
      confereAbasAbertas();
    end;
  end
  else if (((Chr(Key) = 'F') or (Chr(Key) = 'f')) and (Shift = [ssCtrl])) then
  begin
    RibbonPCButtons0Click(Sender);
  end
  else if (Key = VK_F2) and (Shift = [ssShift,ssCtrl]) then
  begin
    if pnlModDes.Visible then
    begin
      desenvolvedor(false);
      if not pnlModDes.Visible then Application.MessageBox(PChar('Modo ''Desenvolvedor'' desativado!'), TITULO, mb_ok + mb_iconinformation);
    end
    else
    begin
      desenvolvedor(true);
      if pnlModDes.Visible then Application.MessageBox(PChar('Modo ''Desenvolvedor'' ativado!'), TITULO, mb_ok + mb_iconinformation);
    end;
  end
  else if (Key = VK_F1) then
    RibbonPCButtons5Click(Sender)

  {LAZARUS: Ctrl+Shift+H abre fTransmitir (Servidor HTTP) — app menu original indisponível no port}
  else if (((Chr(Key) = 'H') or (Chr(Key) = 'h')) and (Shift = [ssCtrl, ssShift])) then
    bsAppMenu1Items3Click(Sender)

  {LAZARUS: Ctrl+Shift+E abre fEditorSlides — app menu original indisponível no port}
  else if (((Chr(Key) = 'E') or (Chr(Key) = 'e')) and (Shift = [ssCtrl, ssShift])) then
    bsSkinSpeedButton1Click(Sender)

  else if ((Key = VK_F5) or (Key = VK_F9)) then
  begin
    if (fListaMusica <> nil) and (fListaMusica.Visible) and (fListaMusica.Active) and (fListaMusica.btExp_MenuMusicas.ImageIndex = 53)
      then fListaMusica.btExp_MenuMusicasClick(fListaMusica.btExp_MenuMusicas)

    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsHinario)
      then DBGrid1DblClick(DBGrid1)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsBuscaMusica)
      then DBGrid2DblClick(DBGrid2)

    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsBiblia) and (btExp_Biblia.ImageIndex = 10)
      then expandirArea(btExp_Biblia)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsBuscaBiblica) and (btExp_BibliaBusca.ImageIndex = 10)
      then expandirArea(btExp_BibliaBusca)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronoCulto) and (btExp_EscolaSabatina.ImageIndex = 10)
      then expandirArea(btExp_EscolaSabatina)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteio) and (btExp_Sorteio.ImageIndex = 10)
      then expandirArea(btExp_Sorteio)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteioNM) and (btExp_SorteioNM.ImageIndex = 10)
      then expandirArea(btExp_SorteioNM)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronometro) and (btExp_Cronometro.ImageIndex = 10)
      then expandirArea(btExp_Cronometro)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsPainelD) and (btExp_PainelD.ImageIndex = 10)
      then expandirArea(btExp_PainelD)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsTextoInterativo) and (btExp_TextoInterativo.ImageIndex = 10)
      then expandirArea(btExp_TextoInterativo)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsRelogio) and (btExp_Relogio.ImageIndex = 10)
      then expandirArea(btExp_Relogio)

    else if (fMusica <> nil) and (fMusica.Visible) and (pnlModDes.Visible)
      then fMusica.btRefreshClick(Sender)

    else if (fEditorSlides <> nil) and (fEditorSlides.Visible)
      then fEditorSlides.btProjetaClick(Sender);

  end

  else if (fMusica <> nil) and (fMusica.Visible) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if (fMusica.Active) or (fMusicaOperador.Active) then
      begin
        if (Key = VK_DOWN) and (Shift = [ssCtrl])  then
          fMusica.btProxGravaClick(Sender)
        else if (Key = VK_UP) and (Shift = [ssCtrl])  then
          fMusica.btGravaRClick(Sender)
        else if (Key = VK_LEFT) and (Shift = [ssCtrl])  then
          fMusica.btGravaAClick(Sender)
        else if (Key = VK_F5) then
          fMusica.refresh
        else if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then
          fMusica.acaoSlide('ant')
        else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then
          fMusica.acaoSlide('prox')
        else if (Key = VK_HOME) then
          fMusica.acaoSlide('pri')
        else if (Key = VK_END) then
          fMusica.acaoSlide('ult')
        else if (Key = VK_PAUSE) or (Key = VK_SPACE) or (Key = VK_PLAY) or ((Shift = [ssCtrl]) and ((Key = 50) or (Key = 80))) then
          fMusica.pauseplay
        ;
      end;
    end;

  end

  else if (fEditorSlides <> nil) and (fEditorSlides.Visible) and (fEditorSlides.Active) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if ((Key = VK_RIGHT) and (Shift = [ssCtrl])) or ((Key = VK_DOWN) and (Shift = [ssCtrl]))  then
        fEditorSlides.btGravaAClick(Sender)
      else if ((Key = VK_LEFT) and (Shift = [ssCtrl])) or ((Key = VK_UP) and (Shift = [ssCtrl]))  then
        fEditorSlides.btGravaRClick(Sender)

      else if (Key = VK_F5) then
        fEditorSlides.carregaSlide
      else if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then
        fEditorSlides.acaoSlide('ant')
      else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then
        fEditorSlides.acaoSlide('prox')
      else if (Key = VK_HOME) then
        fEditorSlides.acaoSlide('pri')
      else if (Key = VK_END) then
        fEditorSlides.acaoSlide('ult')
      else if (Key = VK_PAUSE) or (Key = VK_SPACE) or (Key = VK_PLAY) or ((Shift = [ssCtrl]) and ((Key = 50) or (Key = 80))) then
        fEditorSlides.pauseplay
      else if (((Chr(Key) = 'N') or (Chr(Key) = 'n')) and (Shift = [ssShift,ssCtrl])) then
        fEditorSlides.btNovoClick(fEditorSlides.btNovo)
      else if (((Chr(Key) = 'N') or (Chr(Key) = 'n')) and (Shift = [ssCtrl])) then
        fEditorSlides.btNovoSlideClick(fEditorSlides.btNovoSlide)
      else if (((Chr(Key) = 'S') or (Chr(Key) = 's')) and (Shift = [ssCtrl])) then
        fEditorSlides.btSalvarClick(fEditorSlides.btSalvar)
      else if (((Chr(Key) = 'A') or (Chr(Key) = 'a')) and (Shift = [ssCtrl])) then
        fEditorSlides.btAbrirClick(fEditorSlides.btAbrir)
      else if (((Chr(Key) = 'D') or (Chr(Key) = 'd')) and (Shift = [ssCtrl])) then
        fEditorSlides.btNovoSlideClick(fEditorSlides.btDuplicaSlide)
      else if (Key = VK_DELETE) then
        fEditorSlides.btExcluiSlideClick(fEditorSlides.btExcluiSlide)
      ;
    end;

  end

  else if (PageControl1.Visible) and (PageControl1.ActivePage = tsBiblia) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then
      begin
        btBibVersAntClick(Sender)
      end
      else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then
      begin
        btBibVersSegClick(Sender);
      end;
    end;
  end
  else if (PageControl1.Visible) and (PageControl1.ActivePage = tsBuscaBiblica) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then btBibBusVersAntClick(Sender)
      else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then btBibBusVersSegClick(Sender);
    end;
  end

  else if (Key = VK_PRIOR) then  //PASSADOR DE SLIDES
  begin
    if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronoCulto)
      then bsAddTClick(bsAddTm1)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteio)
      then btLimpaSorteioReiniciaClick(btLimpaSorteioReinicia)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteioNM)
      then btLimpaSorteioReiniciaNMClick(btLimpaSorteioReiniciaNM)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronometro)
      then btZerarCronoClick(btZerarCrono);
  end
  else if (Key = VK_NEXT) then  //PASSADOR DE SLIDES
  begin
    if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronoCulto)
      then bsAddTClick(bsAddT1)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteio)
      then btSortearClick(btSortear)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteioNM)
      then btSortearNMClick(btSortearNM)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronometro)
      then btIniciarCronoClick(btIniciarCrono);
  end;
end;

procedure TfmIndex.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  MouseWheel('Down', Sender, Shift, MousePos, Handled);
end;

procedure TfmIndex.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  MouseWheel('Up', Sender, Shift, MousePos, Handled);
end;

procedure TfmIndex.fExibeColetaneas(Tipo: string; ScrollBox: TScrollBox {LAZARUS: TbsSkinScrollBox});
var
  Button: TSpeedButton {LAZARUS: TbsSkinButtonEx};
  gLeft, gTop, gWidth, gHeight: Integer;
  mLeft: integer;
  dirIMG: string;
  id: string;
  formWidth: Integer;
  bitmap: TBitmap;
  idimg: Integer;
begin
  DM.qrALBUNS.Close;
  DM.qrALBUNS.ParamByName('TIPO').Value := Tipo;
  DM.qrALBUNS.Open;

  formWidth := ScrollBox.Width;

  ScrollBox.VertScrollBar.Position := 0; {LAZARUS: VScroll->VertScrollBar.Position}
  gLeft := 0;
  gTop := 10;
  gWidth := 165;
  gHeight := 190;

  while ((gLeft + gWidth + 10 + gWidth + 20) < formWidth) do
    gLeft := gLeft + gWidth + 10;
  mLeft := trunc((formWidth - (gLeft + gWidth + 10)) / 2);
  gLeft := mLeft;


  while not DM.qrALBUNS.Eof do
  begin
    id := DM.qrALBUNS.FieldByName('ID').AsString;

    Button := TSpeedButton {LAZARUS: TbsSkinButtonEx}(FindComponent('gb_' + Tipo + '_' + id));
    Button.Free;
    if Assigned(Button) then
      continue;

    try
      Button := TSpeedButton {LAZARUS: TbsSkinButtonEx}.Create(ScrollBox);
      Button.Visible := False;
      dirIMG := dir_config + 'capas/' {LAZARUS: '\' → '/' separador Linux} + DM.qrALBUNS.FieldByName('IMAGEM').AsString;
      with Button do
      begin
        Parent := ScrollBox;
        Name := 'gb_' + Tipo + '_' + id;
        Tag := DM.qrALBUNS.FieldByName('ID_ALBUM').AsInteger;
        Caption := ' ' + DM.qrALBUNS.FieldByName('NOME').AsString + ' '; {LAZARUS: TbsSkinButtonEx.Title->Caption}
        {subtitulo: DM.qrALBUNS.FieldByName('SUBTITULO').AsString + ' ';}
        OnClick := sbClick;
        {LAZARUS: TbsSkinButtonEx.Layout removido}
        {LAZARUS: TbsSkinButtonEx.SkinData removido}
        {LAZARUS: TbsSkinButtonEx.ImageList removido}
        if (fileexists(dirIMG) and (UpperCase(copy(dirIMG, length(dirIMG) - 3, 4)) = '.BMP')) then
        begin
          bitmap := TBitmap.Create;
          bitmap.LoadFromFile(dirIMG);
          bitmap.TransparentColor := clFuchsia;
          bitmap.Transparent := false;
          idimg := DM.imCapas.Add(bitmap, nil);
          ImageIndex := idimg;
          bitmap.Free;
        end;
        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    except
      with Button do
      begin
        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    end;
    Button.Visible := True;

    if ((gLeft + gWidth + 10 + gWidth + 20) >= formWidth) then
    begin
      gLeft := mLeft;
      gTop := gTop + gHeight + 10;
    end
    else
      gLeft := gLeft + gWidth + 10;

    DM.qrALBUNS.Next;
  end;

  ScrollBox.VertScrollBar.Position := 0; {LAZARUS: VScroll->VertScrollBar.Position}
  ScrollBox.VertScrollBar.Visible := True; {LAZARUS: VScrollBar->VertScrollBar}
  ScrollBox.VertScrollBar.Position := 0; {LAZARUS: VScrollBar->VertScrollBar}
end;

procedure TfmIndex.salvaItensLiturgia;
var
  semana: string;
  itens: array[0..1] of TParamItem;
begin
  semana := fmIndex.loadCol.Strings.Values['LITURGIA:SEMANA'];

  itens[0].Grupo := 'Geral';
  itens[0].Param := semana;
  {LAZARUS: #13#10 → LineEnding — no Linux TStringList.Text usa #10; com #13#10 o
   replace não achava nada e o INI só persistia o primeiro item da lista}
  itens[0].Valor := StringReplace(lbLiturgia.Items.Text, LineEnding, ';', [rfIgnoreCase, rfReplaceAll]);

  itens[1].Grupo := 'Geral';
  itens[1].Param := 'AlteraOrdem-' + semana;
  itens[1].Valor := FormatDateTime('dd/mm/yyyy hh:mm:ss', now());

  gravaParamLote(arq_liturgia, itens);
end;

procedure TfmIndex.SaveBase64ImageToFile(const Base64String, FilePath: string);
{LAZARUS: TBase64Encoding/TBytesStream (Delphi) -> DecodeStringBase64/TStringStream (FPC)}
{LAZARUS: TPngImage -> TPortableNetworkGraphic; String.ToLower -> LowerCase}
var
  DecodedStr: string;
  InputStream: TStringStream;
  OutputStream: TFileStream;
  Image: TImage;
  Graphic: TGraphic;
  ext: string;
begin
  DecodedStr := DecodeStringBase64(Base64String);
  InputStream := TStringStream.Create(DecodedStr);
  try
    Image := TImage.Create(nil);
    try
      InputStream.Position := 0;
      Image.Picture.LoadFromStream(InputStream);

      ext := LowerCase(ExtractFileExt(FilePath));
      if ext = '.jpg' then
        Graphic := TJPEGImage.Create
      else if ext = '.png' then
        Graphic := TPortableNetworkGraphic.Create
      else
        raise Exception.Create('Formato de imagem nao suportado');

      ForceDirectoriesRecursive(ExtractFilePath(FilePath));

      try
        Graphic.Assign(Image.Picture.Graphic);
        OutputStream := TFileStream.Create(FilePath, fmCreate);
        try
          Graphic.SaveToStream(OutputStream);
        finally
          OutputStream.Free;
        end;
      finally
        Graphic.Free;
      end;
    finally
      Image.Free;
    end;
  finally
    InputStream.Free;
  end;
end;

procedure TfmIndex.sbAlinhMusicaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Alinhamento', inttostr(sbAlinhMusica.ItemIndex));
end;

procedure TfmIndex.sbClick(Sender: TObject);
var
  id_album: integer;
  titulo_album: string;
  subtitulo_album: string;
  titulo_form: string;
begin
  id_album := TComponent(Sender).Tag;
  titulo_album := TSpeedButton {LAZARUS: TbsSkinButtonEx}(Sender).Caption; {LAZARUS: .Title->.Caption}
  subtitulo_album := TSpeedButton {LAZARUS: TbsSkinButtonEx}(Sender).Caption;
  titulo_form := titulo_album;
  if (trim(subtitulo_album) <> '') then
    titulo_form := titulo_form+' ('+trim(subtitulo_album)+')';

  fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
  fListaMusica.id_album := id_album;
  fListaMusica.inicio := false;
  fListaMusica.Caption := titulo_form;
  fListaMusica.lblTitulo.Caption := titulo_album;
  fListaMusica.lblSubtitulo.Caption := subtitulo_album;
  fListaMusica.dir := '';
  fListaMusica.DataSource := DM.dsMUSICAS; {LAZARUS: DBCtrlGrid.DataSource->campo DataSource}
  fListaMusica.pnlBotoes.Visible := True;
  {LAZARUS: TbsSkinButtonEx.ImageList.GetBitmap removido - TSpeedButton nao tem ImageList}
  fListaMusica.showmodal;
end;

procedure TfmIndex.abreListaMusicaHeadless(id_album: integer; titulo: string);
begin
  fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
  fListaMusica.id_album := id_album;
  fListaMusica.inicio := false;
  fListaMusica.Caption := titulo;
  fListaMusica.lblTitulo.Caption := titulo;
  fListaMusica.lblSubtitulo.Caption := '';
  fListaMusica.dir := '';
  fListaMusica.DataSource := DM.dsMUSICAS;
  fListaMusica.pnlBotoes.Visible := True;
  fListaMusica.ShowModal;
end;

{LAZARUS: abre fmListaMusica em modo arquivo (dsArquivos) — param headless lista_dir=}
procedure TfmIndex.abreListaDirHeadless(dir: string);
begin
  fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
  fListaMusica.id_album := 0;
  fListaMusica.inicio := false;
  fListaMusica.Caption := 'Teste ListaDir';
  fListaMusica.lblTitulo.Caption := 'Teste ListaDir';
  fListaMusica.lblSubtitulo.Caption := '';
  fListaMusica.dir := dir;
  fListaMusica.DataSource := DM.dsArquivos;
  fListaMusica.pnlBotoes.Visible := False;
  fListaMusica.ShowModal;
end;

{LAZARUS: avança slide via TTimer da main thread — usado pelo parâmetro headless autoslide=1}
procedure TfmIndex.avancaSlideHeadless(Sender: TObject);
begin
  if (fMusica <> nil) and fMusica.Visible then
    fMusica.acaoSlide('prox');
end;

function TfmIndex.FonteExiste(Fonte: STring): Boolean;
begin
  with Screen.Fonts do
    Result := IndexOf(Trim(Fonte)) > 0;
end;

procedure TfmIndex.ForceDirectoriesRecursive(const Path: string);
begin
  if not DirectoryExists(Path) {LAZARUS: TDirectory.Exists→DirectoryExists} then
    ForceDirectories(Path);
end;

procedure TfmIndex.FormActivate(Sender: TObject);
begin
  //ROTINAS DE INICIALIZAÇÃO NO FORM FMINICANDO....
end;

procedure TfmIndex.tsHinarioNShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsHinarioN,tsHinarioN);
  marcaAbaAberta(tsHinarioN);
  DM.qrALBUM_IGNORAR.Close;
  DM.qrALBUM_IGNORAR.ParamByName('ID').Value := 629;
  DM.qrALBUM_IGNORAR.Open;

  if (DM.qrALBUM_IGNORAR.RecordCount > 0) then
  begin
    pnlHinario1996Ativo.Visible := False;
    pnlHinario1996Inativo.Visible := True;
    pnlHinario1996Inativo.Align := alClient;
  end
  else
  begin
    pnlHinario1996Ativo.Visible := True;
    pnlHinario1996Inativo.Visible := False;
    {LAZARUS: guarda bounds — Columns pode ter apenas 1 item se LFM foi parseado parcialmente}
    if dbGrid1N.Columns.Count >= 2 then
      dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;
    txtHinoNChange(Sender);
    txtHinoN.SetFocus;
  end;
end;

procedure TfmIndex.tsHinarioShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsHinario,tsHinario);
  marcaAbaAberta(tsHinario);
  {LAZARUS: guarda bounds — Columns pode ter apenas 1 item se LFM foi parseado parcialmente}
  if dbGrid1.Columns.Count >= 2 then
    dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;

  txtHinoChange(Sender);
  txtHino.SetFocus;
end;

procedure TfmIndex.tsItensAgendadosShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsItensAgendados,tsItensAgendados);
  marcaAbaAberta(tsItensAgendados);
  carrega_opc := True;

  if (loadCol.Strings.Values['ITENS_AGENDADOS'] <> 'okf') then
  begin
    loadCol.Strings.Values['ITENS_AGENDADOS'] := 'okf';
    cbRemoveItensAgendados.Checked := (lerParam('Itens Agendados', 'RemovePassados', '1') = '1');

    if not DM.cdsCategoriasItensAgendados.Active then
    begin
      DM.cdsCategoriasItensAgendados.CreateDataSet;
      DM.cdsCategoriasItensAgendados.IndexName := '';
      DM.cdsCategoriasItensAgendados.IndexFieldNames := 'NOME';
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsCategoriasItensAgendados.LogChanges := False;)}
    end;

    if (FileExists(dir_dados + 'itensAgendadosCategorias.xml')) then
      DM.cdsCategoriasItensAgendados.LoadFromFile(dir_dados + 'itensAgendadosCategorias.xml');
    DM.cdsCategoriasItensAgendados.Open;


    if not DM.cdsItensAgendados.Active then
    begin
      DM.cdsItensAgendados.CreateDataSet;
      DM.cdsItensAgendados.IndexName := '';
      DM.cdsItensAgendados.IndexFieldNames := 'DATA';
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsItensAgendados.LogChanges := False;)}
    end;

    if not DM.cdsItensAgendadosClone.Active then
    begin
      DM.cdsItensAgendadosClone.CreateDataSet;
      DM.cdsItensAgendadosClone.IndexName := '';
      DM.cdsItensAgendadosClone.IndexFieldNames := 'DATA';
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsItensAgendadosClone.LogChanges := False;)}
    end;

    if (FileExists(dir_dados + 'itensAgendados.xml')) then
    begin
      DM.cdsItensAgendados.LoadFromFile(dir_dados + 'itensAgendados.xml');
      DM.cdsItensAgendadosClone.LoadFromFile(dir_dados + 'itensAgendados.xml');
    end;
    DM.cdsItensAgendados.Open;
    DM.cdsItensAgendadosClone.Open;

    if cbRemoveItensAgendados.Checked  then removeItensAgendadosPassados;
  end;

  {LAZARUS: TScrollBox nao tem RowCount — stub}
  {LAZARUS: TScrollBox nao tem ColCount — stub}

  carrega_opc := False;
end;

procedure TfmIndex.txtHinoChange(Sender: TObject);
var
  valor: string;
  nr: integer;
  c: integer;
  letra: string;
begin
  pnlreHino.Visible := False;
  bsSkinScrollBar7.Visible := true;
  {LAZARUS: guarda bounds}
  if dbGrid1.Columns.Count >= 2 then
    dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;
  valor := trim(txtHino.Text);
  stHinos0.Text {LAZARUS: TStatusPanel.Caption→.Text} := '';
  if trim(valor) <> '' then
  begin
    val(txtHino.Text, nr, c);
    if c = 0 then
    begin
      stHinos0.Text {LAZARUS: TStatusPanel.Caption→.Text} := fIniciando.Translate('Buscando nº: ') + valor;
    end
    else
    begin
      stHinos0.Text {LAZARUS: TStatusPanel.Caption→.Text} := fIniciando.Translate('Buscando nome: ')+'''' + valor + '''';
    end;
  end;

  {LAZARUS: DisableControls/EnableControls evita que TDBGrid receba deLayoutChange durante Close+Open
   (sem isso, Lazarus reconstrói Columns e acessa Columns[0] quando Count=0 → crash)}
  DM.qrHINOS.DisableControls;
  try
    DM.qrHINOS.Close;
    DM.qrHINOS.ParamByName('VALOR').AsString := fmIndex.termo_busca(valor);
    DM.qrHINOS.Open;
  finally
    DM.qrHINOS.EnableControls;
  end;

  if (DM.qrHINOS.RecordCount = 1) then
  begin
    reHino.Lines.Clear;
    {LAZARUS: DisableControls previne eventos de layout enquanto reopen}
    DM.qrLETRA.DisableControls;
    try
      DM.qrLETRA.Close;
      DM.qrLETRA.ParamByName('MUSICA').Value := DM.qrHINOS.fieldbyname('ID').AsInteger;
      DM.qrLETRA.Open;
    finally
      DM.qrLETRA.EnableControls;
    end;
    while not DM.qrLETRA.Eof do
    begin
      letra := '';
      if (DM.qrLETRA.fieldbyname('LETRA_AUX').AsString <> '') then
        letra := letra+'['+DM.qrLETRA.fieldbyname('LETRA_AUX').AsString+'] ';

      letra := letra+DM.qrLETRA.fieldbyname('LETRA').AsString;
      letra := StringReplace(letra, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]);
      reHino.Lines.Add(letra);
      DM.qrLETRA.Next;
    end;

    pnlreHino.Height := DBGrid1.Height - stHinos.Height - 22;
    pnlreHino.Top := 0;
    formataTexto(reHino);
    pnlreHino.Visible := true;
    bsSkinScrollBar7.Visible := False;
    {LAZARUS: guarda bounds}
    if dbGrid1.Columns.Count >= 2 then
      dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;
  end
  else
  begin
    pnlreHino.Visible := False;
  end;

  corCampoBusca(DM.qrHinos, txtHino, DBGrid1);
  stHinos1.Text {LAZARUS: TStatusPanel.Caption→.Text} := qtItens(DM.qrHinos,'hino encontrado','hinos encontrados','Nenhum hino encontrado');;
  {LAZARUS: guarda bounds}
  if dbGrid1.Columns.Count >= 2 then
    dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;
end;

procedure TfmIndex.corCampoBusca(Query: TDataSet {LAZARUS: TZQuery→TDataSet}; Campo: TEdit {LAZARUS: TbsSkinEdit}; DBGrid: TDBGrid {LAZARUS: TbsSkinDBGrid});
begin
  if DBGrid <> nil then
    {LAZARUS: DBGrid.VScrollBar removido - TDBGrid nao tem VScrollBar}

  if (Query.Active = false) or (Query.RecordCount > 0) then
  begin
    if layoutValue.Strings.Values['cor_texto_input'] <> '' then
      Campo.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_input']);
    if (DBGrid <> nil) and (Query.RecordCount > 1) then
      {LAZARUS: DBGrid.VScrollBar removido - TDBGrid nao tem VScrollBar}
  end
  else
  begin
    Campo.Font.Color := clRed;
  end;
end;

procedure TfmIndex.corCapaProgramaChangeColor(Sender: TObject);
begin
  pnlImagemCapa.Color := TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor};
  gravaParam('Config', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
end;


procedure TfmIndex.corFundoMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
end;

procedure TfmIndex.corTextoAuxMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Texto Aux', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
end;

procedure TfmIndex.corTextoMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Texto', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
end;

procedure TfmIndex.corTextoRepetidoChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Texto Repetido', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
end;

procedure TfmIndex.corTituloMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Titulo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
end;

function TfmIndex.qtItens(Query: TDataSet {LAZARUS: TZQuery/TFDQuery→TDataSet}; texto_sing,
  texto_plu,texto_nenh: string): string;
begin
  if Query.Active = false then
    result := texto_nenh
  else if Query.RecordCount > 1 then
//    result := inttostr(Query.RecordCount) +' '+ texto_plu
    result := ''
  else if Query.RecordCount = 1 then
    result := inttostr(Query.RecordCount) +' '+ texto_sing
  else
    result := texto_nenh;
end;

procedure TfmIndex.DBGrid1DblClick(Sender: TObject);
begin
  if (rbHinoTipo.ItemIndex = 0) then btHinoSlideMusicaClick(btHinoSlideMusica)
  else if (rbHinoTipo.ItemIndex = 1) then btHinoSlideMusicaClick(btHinoSlideMusicaPB)
  else if (rbHinoTipo.ItemIndex = 2) then btHinoSlideMusicaClick(btHinoSlideMusicaSA)
  else btHinoSlideMusicaClick(Sender);
end;

procedure TfmIndex.DBGrid1NDblClick(Sender: TObject);
begin
  if (rbHinoTipoN.ItemIndex = 0) then btHinoSlideMusicaNClick(btHinoSlideMusica)
  else if (rbHinoTipoN.ItemIndex = 1) then btHinoSlideMusicaNClick(btHinoSlideMusicaPB)
  else if (rbHinoTipoN.ItemIndex = 2) then btHinoSlideMusicaNClick(btHinoSlideMusicaSA)
  else btHinoSlideMusicaNClick(Sender);
end;

procedure TfmIndex.txtHinoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid1DblClick(Sender);
  end;
end;

procedure TfmIndex.txtHinoNChange(Sender: TObject);
var
  valor: string;
  nr: integer;
  c: integer;
  letra: string;
begin
  pnlreHinoN.Visible := False;
  bsSkinScrollBar7N.Visible := true;
  {LAZARUS: guarda bounds}
  if dbGrid1N.Columns.Count >= 2 then
    dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;
  valor := trim(txtHinoN.Text);
  stHinos0N.Text {LAZARUS: TStatusPanel.Caption→.Text} := '';
  if trim(valor) <> '' then
  begin
    val(txtHinoN.Text, nr, c);
    if c = 0 then
    begin
      stHinos0N.Text {LAZARUS: TStatusPanel.Caption→.Text} := fIniciando.Translate('Buscando nº: ') + valor;
    end
    else
    begin
      stHinos0N.Text {LAZARUS: TStatusPanel.Caption→.Text} := fIniciando.Translate('Buscando nome: ')+'''' + valor + '''';
    end;
  end;

  {LAZARUS: DisableControls/EnableControls evita crash de Columns no TDBGrid durante Close+Open}
  DM.qrHINOSN.DisableControls;
  try
    DM.qrHINOSN.Close;
    DM.qrHINOSN.ParamByName('VALOR').AsString := fmIndex.termo_busca(valor);
    DM.qrHINOSN.Open;
  finally
    DM.qrHINOSN.EnableControls;
  end;

  if (DM.qrHINOSN.RecordCount = 1) then
  begin
    reHinoN.Lines.Clear;
    {LAZARUS: DisableControls previne eventos de layout enquanto reopen}
    DM.qrLETRA.DisableControls;
    try
      DM.qrLETRA.Close;
      DM.qrLETRA.ParamByName('MUSICA').Value := DM.qrHINOSN.fieldbyname('ID').AsInteger;
      DM.qrLETRA.Open;
    finally
      DM.qrLETRA.EnableControls;
    end;
    while not DM.qrLETRA.Eof do
    begin
      letra := '';
      if (DM.qrLETRA.fieldbyname('LETRA_AUX').AsString <> '') then
        letra := letra+'['+DM.qrLETRA.fieldbyname('LETRA_AUX').AsString+'] ';

      letra := letra+DM.qrLETRA.fieldbyname('LETRA').AsString;
      letra := StringReplace(letra, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]);
      reHinoN.Lines.Add(letra);
      DM.qrLETRA.Next;
    end;

    pnlreHinoN.Height := DBGrid1N.Height - stHinosN.Height - 22;
    pnlreHinoN.Top := 0;
    formataTexto(reHinoN);
    pnlreHinoN.Visible := true;
    bsSkinScrollBar7N.Visible := False;
    {LAZARUS: guarda bounds}
    if dbGrid1N.Columns.Count >= 2 then
      dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;
  end
  else
  begin
    pnlreHinoN.Visible := False;
  end;

  corCampoBusca(DM.qrHinosN, txtHinoN, DBGrid1N);
  stHinos1N.Text {LAZARUS: TStatusPanel.Caption→.Text} := qtItens(DM.qrHinosN,'hino encontrado','hinos encontrados','Nenhum hino encontrado');
  {LAZARUS: guarda bounds}
  if dbGrid1N.Columns.Count >= 2 then
    dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;
end;

procedure TfmIndex.txtHinoNKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid1NDblClick(Sender);
  end;
end;

procedure TfmIndex.txtBibLocalizaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btBibLocalizaClick(Sender);
  end;
end;

procedure TfmIndex.abreArquivoMusica(musicaID: Integer; album, url: string);
var
  musica: string;
  lista: TStringList;
begin
  if (url = '') then
  begin
    DM.qrMUSICA.Close;
    DM.qrMUSICA.ParamByName('ID').Value := musicaID;
    DM.qrMUSICA.Open;
    album := DM.qrMUSICA.FieldByName('ALBUM').AsString;
    url := DM.qrMUSICA.FieldByName('URL').AsString;
    DM.qrMUSICA.Close;
  end;
  musica := dir_config+'musicas/'+album+'/'+url; {LAZARUS: fix separadores Windows→Linux}
  if not (FileExists(musica)) then
  begin
    if (application.MessageBox(PChar('Arquivo "'+musica+'" não encontrado! Deseja baixar este arquivo agora?'), fmIndex.titulo, mb_yesno + mb_iconerror) = 6) then
    begin
      lista := TStringList.Create;
      lista.Clear;
      lista.Add('config/musicas/'+album+'/'+url); {LAZARUS: fix separadores Windows→Linux}

      fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
      fAtualiza.arquivos := lista;
      fAtualiza.ShowModal;

      if not (FileExists(musica))
        then application.MessageBox(PChar('Não foi possível baixar o arquivo "'+ExtractFilePath(application.ExeName)+musica+'"!'), fmIndex.titulo, mb_ok + mb_iconerror)
        else fmIndex.abrirArquivo(musica);
    end;
  end
  else
    fmIndex.abrirArquivo(musica);
end;

procedure TfmIndex.abreLetra(ID: integer; BUSCA: string);
begin
  fIniciando.AppCreateForm(TfLetra, fLetra);
  fLetra.id_mus := ID;
  fLetra.txtLocaliz.Text := BUSCA;
  fLetra.txtLocalizChange(nil);
  fLetra.ShowModal;
end;

procedure TfmIndex.abreLetraMusica(tipo: string;param: string;musicaID: Integer;audio:boolean);
var
  monitor,monitor_ret,monitor_ope: integer;
  i: Integer;
begin
  monitor := strtoint(lerParam('Musicas', 'Monitor', '2'));
  monitor_ret := strtoint(lerParam('Musicas', 'MonitorRetorno', '3'));
  monitor_ope := strtoint(lerParam('Musicas', 'MonitorOperador', '1'));

  if (Screen.MonitorCount < monitor) then
    monitor := 0
  else
    monitor := monitor - 1;

  if (Screen.MonitorCount < monitor_ret) then
    monitor_ret := 0
  else
    monitor_ret := monitor_ret - 1;

  if (Screen.MonitorCount < monitor_ope) then
    monitor_ope := 0
  else
    monitor_ope := monitor_ope - 1;

  {LAZARUS: FreeAndNil — Close com caHide deixa forms antigas vivas causando AV na 2ª abertura.
   Sequência correta:
   1. fMusica: fecharSlides+fecharSlidesRetorno:=True evita que FormClose chame Close nos filhos
   2. fMusicaOperador/Retorno: guard (fMusica=nil) já cobre o caso — FreeAndNil sai limpo}
  if fMusica <> nil then
  begin
    fMusica.fecharSlides := True;
    fMusica.fecharSlidesRetorno := True;
    try FreeAndNil(fMusica); except fMusica := nil; end;
  end;
  if fMusicaOperador <> nil then
  begin
    fMusicaOperador.Tag := 0;
    try FreeAndNil(fMusicaOperador); except fMusicaOperador := nil; end;
  end;
  if fMusicaRetorno <> nil then
  begin
    fMusicaRetorno.Tag := 0;
    try FreeAndNil(fMusicaRetorno); except fMusicaRetorno := nil; end;
  end;

  fIniciando.AppCreateForm(TfMusicaOperador, fMusicaOperador);
  fIniciando.AppCreateForm(TfMusicaRetorno, fMusicaRetorno);

  if (lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    fMusicaOperador.lblTempo.Caption := '';
    fMusicaOperador.gSlide.Position {LAZARUS: TProgressBar.Value->Position} := 0;
    fMusicaOperador.gSlideTotal.Position {LAZARUS: TProgressBar.Value->Position} := 0;
    fMusicaOperador.lblSlides.Caption := '';
    fMusicaOperador.pnlProgress.Visible := audio;
    fMusicaOperador.btPausePlay.Visible := audio;
    fMusicaOperador.Show;

    fMusicaOperador.Left := monitorInfo(monitor_ope).Left;
    fMusicaOperador.Top := monitorInfo(monitor_ope).Top;
    fMusicaOperador.Width := monitorInfo(monitor_ope).Width;
    fMusicaOperador.Height := monitorInfo(monitor_ope).Height;
  end;

  if (lerParam('Musicas', 'ModoRetorno', '1') = '1') then
  begin
    fMusicaRetorno.lblTempo.Caption := '';
    fMusicaRetorno.gSlide.Position {LAZARUS: TProgressBar.Value->Position} := 0;
    fMusicaRetorno.gSlideTotal.Position {LAZARUS: TProgressBar.Value->Position} := 0;
    fMusicaRetorno.lblSlides.Caption := '';
    fMusicaRetorno.pnlProgress.Visible := audio;
    fMusicaRetorno.Show;

    fMusicaRetorno.Left := monitorInfo(monitor_ret).Left;
    fMusicaRetorno.Top := monitorInfo(monitor_ret).Top;
    fMusicaRetorno.Width := monitorInfo(monitor_ret).Width;
    fMusicaRetorno.Height := monitorInfo(monitor_ret).Height;
  end;

  fIniciando.AppCreateForm(TfMusica, fMusica);
  fMusica.AlphaBlend := True;
  fMusica.AlphaBlendValue := 0;

  fMusica.tipo := tipo;
  fMusica.param := param;
  fMusica.musicaID := musicaID;
  fMusica.albumID := 0;
  fMusica.audio := audio;
  fMusica.inicio := false;
  fMusica.monitor := monitor;

  if ckMusicaJanela.Checked then
    fMusica.BorderStyle := bsNone
  else
    fMusica.BorderStyle := bsSizeable;

  fMusica.show;

  if (pnlModDes.Visible) then
  begin
    fMusica.Left := StrToInt(lerParam('Desenvolvedor', 'SlideLeft', IntToStr(monitorInfo(monitor).Left)));
    fMusica.Top := StrToInt(lerParam('Desenvolvedor', 'SlideTop', IntToStr(monitorInfo(monitor).Top)));
    fMusica.Width := StrToInt(lerParam('Desenvolvedor', 'SlideWidth', IntToStr(monitorInfo(monitor).Width)));
    fMusica.Height := StrToInt(lerParam('Desenvolvedor', 'SlideHeight', IntToStr(monitorInfo(monitor).Height)));
  end
  else
  begin
    if (fMusica.BorderStyle = bsNone) then
    begin
      fMusica.Left := monitorInfo(monitor).Left;
      fMusica.Top := monitorInfo(monitor).Top;
      fMusica.Width := monitorInfo(monitor).Width;
      fMusica.Height := monitorInfo(monitor).Height;
    end
    else
    begin
      fMusica.Left := monitorInfo(monitor).Left;
      fMusica.Top := monitorInfo(monitor).Top;
      fMusica.Width := 800;
      fMusica.Height := 600;
    end;
  end;


  if ckFadeForm.Checked then
  begin
    for i := 0 to 255 do
    begin
      fMusica.AlphaBlendValue := i;
      sleep(1);
    end;
  end
  else fMusica.AlphaBlendValue := 255;
end;

procedure TfmIndex.abreLetraMusicaAlbum(albumID: Integer;musicaID: Integer);
var
  monitor: integer;
  i: integer;
begin
  monitor := strtoint(lerParam('Musicas', 'Monitor', '2'));
  if (Screen.MonitorCount < monitor) then
    monitor := 0
  else
    monitor := monitor - 1;

  if fMusica <> nil then
    fMusica.Close;


  if fMusicaOperador <> nil then
    fMusicaOperador.Close;

  fIniciando.AppCreateForm(TfMusicaOperador, fMusicaOperador);

  if (lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    fMusicaOperador.pnlErroMsg.Visible := false;
    fMusicaOperador.lblTempo.Caption := '';
    fMusicaOperador.gSlide.Position {LAZARUS: TProgressBar.Value->Position} := 0;
    fMusicaOperador.gSlideTotal.Position {LAZARUS: TProgressBar.Value->Position} := 0;
    fMusicaOperador.lblSlides.Caption := '';
    fMusicaOperador.pnlProgress.Visible := true;
    fMusicaOperador.btPausePlay.Visible := true;
    fMusicaOperador.Show;
  end;

  fIniciando.AppCreateForm(TfMusica, fMusica);
  fMusica.AlphaBlend := True;
  fMusica.AlphaBlendValue := 0;

  fMusica.musicaID := musicaID;
  fMusica.albumID := albumID;
  fMusica.tipo := 'BD';
  fMusica.audio := true;
  fMusica.inicio := false;
  fMusica.monitor := monitor;

  if ckMusicaJanela.Checked then
    fMusica.BorderStyle := bsNone
  else
    fMusica.BorderStyle := bsSizeable;

  fMusica.show;


  if pnlModDes.Visible then
  begin
    fMusica.Left := StrToInt(lerParam('Desenvolvedor', 'SlideLeft', IntToStr(monitorInfo(monitor).Left)));
    fMusica.Top := StrToInt(lerParam('Desenvolvedor', 'SlideTop', IntToStr(monitorInfo(monitor).Top)));
    fMusica.Width := StrToInt(lerParam('Desenvolvedor', 'SlideWidth', IntToStr(monitorInfo(monitor).Width)));
    fMusica.Height := StrToInt(lerParam('Desenvolvedor', 'SlideHeight', IntToStr(monitorInfo(monitor).Height)));
  end
  else
  begin
    fMusica.Left := monitorInfo(monitor).Left;
    fMusica.Top := monitorInfo(monitor).Top;
    fMusica.Width := monitorInfo(monitor).Width;
    fMusica.Height := monitorInfo(monitor).Height;
  end;


  if ckFadeForm.Checked then
  begin
    for i := 0 to 255 do
    begin
      fMusica.AlphaBlendValue := i;
      sleep(1);
    end;
  end
  else fMusica.AlphaBlendValue := 255;
end;

procedure TfmIndex.abrePagina(TabSheet: TTabSheet {LAZARUS: TbsSkinTabSheet});
var
  item: TMenuItem;
begin
  PageControl1.Visible := True;
  TabSheet.Tag := -1;
  if TabSheet.TabVisible = False then
  begin
    TabSheet.TabVisible := True;
    PageControl1.ActivePage := TabSheet;
    PageControl1.Pages[PageControl1.ActivePageIndex].PageIndex := PageControl1.PageCount - 1;

    item := TMenuItem.Create(bsPopupMenuRibon);
    item.Caption := TabSheet.Caption;
    item.ImageIndex := TabSheet.ImageIndex;
    item.OnClick := mnSelecionaAbaClick;
    item.Checked := False;
    item.RadioItem := True;

    bsPopupMenuRibon.Items.Insert(bsPopupMenuRibon.Items.Count - 3, item);
  end
  else
    PageControl1.ActivePage := TabSheet;

  confereAbasAbertas();
  marcaAbaAberta(TabSheet);

  {LAZARUS: TTabSheet.OnShow não dispara no LCL ao mudar ActivePage programaticamente.
   Chamamos o OnShow manualmente para preservar comportamento Delphi/VCL.}
  if Assigned(TabSheet.OnShow) then
    TabSheet.OnShow(TabSheet);
end;

procedure TfmIndex.abreVideoOn(videoID, videoTITULO: string);
var
  monitor: integer;
  Flags: Cardinal;
  i: integer;
begin
  if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  if (trim(param.Strings.Values['embed_youtube']) = '') then
  begin
    gravaParam('Config', 'UltimaConexao', '-');
    carregaParams;
  end;

  monitor := strtoint(lerParam('Videos Online', 'Monitor', '2'));
  if (Screen.MonitorCount < monitor) then
    monitor := 0
  else
    monitor := monitor - 1;

  if fVideoOn <> nil then
    fVideoOn.Close;

  fIniciando.AppCreateForm(TfVideoOn, fVideoOn);
  fVideoOn.videoID := videoID;
  fVideoOn.Caption := videoTITULO;

  if ckVideoOnJanela.Checked then
    fVideoOn.BorderStyle := bsNone
  else
    fVideoOn.BorderStyle := bsSizeable;

  fVideoOn.AlphaBlend := True;
  fVideoOn.AlphaBlendValue := 0;
  fVideoOn.show;

  fVideoOn.Left := monitorInfo(monitor).Left;
  fVideoOn.Top := monitorInfo(monitor).Top;
  fVideoOn.Width := monitorInfo(monitor).Width;
  fVideoOn.Height := monitorInfo(monitor).Height;


  if ckFadeForm.Checked then
  begin
    for i := 0 to 255 do
    begin
      fVideoOn.AlphaBlendValue := i;
      sleep(1);
    end;
  end
  else fVideoOn.AlphaBlendValue := 255;

end;

procedure TfmIndex.abrirArquivo(url: string;externo: Boolean);
var
  ext: string;
begin
  if url <> '' then
  begin
    gravaLog('Abrindo arquivo: '+url);
    ext := (ExtractFileExt(url));
    if externo
      then OpenURL(url) {LAZARUS: ShellExecute→OpenURL}
    else if (ext = '.slja') or (ext = '.lja')
      then processaArquivo(url)
    else if (ckPlayerAudio.Checked)
      and ((ext = '.mp3') or (ext = '.wma') or (ext = '.wav')) then
    begin
      player(url,false);
    end
    else if (ckPlayerVideo.Checked)
      and ((ext = '.mp4') or (ext = '.avi') or (ext = '.wmv') or (ext = '.mkv')) then
    begin
      player(url);
    end
    else
      OpenURL(url) {LAZARUS: ShellExecute→OpenURL};
  end;
end;

procedure TfmIndex.AbrirnoNavegador1Click(Sender: TObject);
var
  txt: string;
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  txt := DM.cdsVideosOnPerso.FieldByName('URL').AsString;
  OpenURL(txt); {LAZARUS: HlinkNavigateString -> OpenURL (LCLIntf)}
end;

procedure TfmIndex.ajustaImagem(imagem: TImage; panel: TPanel;
  posicao: integer);
var
  w,h: integer;
begin
  w := imagem.Picture.Width;
  h := imagem.Picture.Height;

  imagem.Width := panel.Width;
  imagem.Height := Trunc(imagem.Width*h/w);

  if (imagem.Height < panel.Height) then
  begin
    imagem.Height := panel.Height;
    imagem.Width := Trunc(imagem.Height*w/h);
  end;

  case posicao of
    1: begin
         imagem.Top := 0;
         imagem.Left := 0;
       end;
    2: begin
         imagem.Top := 0;
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
       end;
    3: begin
         imagem.Top := 0;
         imagem.Left := (panel.Width-imagem.Width);
       end;
    4: begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := 0;
       end;
    5: begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
       end;
    6: begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := (panel.Width-imagem.Width);
       end;
    7: begin
         imagem.Top := (panel.Height-imagem.Height);
         imagem.Left := 0;
       end;
    8: begin
         imagem.Top := (panel.Height-imagem.Height);
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
       end;
    9: begin
         imagem.Top := (panel.Height-imagem.Height);
         imagem.Left := (panel.Width-imagem.Width);
       end;
    else
      begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
      end;
  end;
end;

procedure TfmIndex.AjustaLarguraCamposDBGrid(DBGrid: TDBGrid {LAZARUS: TbsSkinDbGrid});
var
  i: integer;
begin
  for i := 0 to DBGrid.Columns.Count - 1 do
    DBGrid.Columns[i].Width := 5 + DBGrid.Canvas.TextWidth(DBGrid.Columns[i].title.caption)
end;

procedure TfmIndex.tsJAShow(Sender: TObject);
var
  i: Integer;
begin
  PaginaMenuAtiva(tsColetaneas);
  marcaAbaAberta(tsJA);
  if (loadCol.Strings.Values['JA'] <> 'ok') then
  begin
    loadCol.Strings.Values['JA'] := 'ok';

    for i := sbColJA.ComponentCount - 1 downto 0 do
      sbColJA.Components[i].Free;

    fExibeColetaneas('JA_ANO', sbColJA);
  end;
end;

procedure TfmIndex.tsLiturgiaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsLiturgia,tsLiturgia);
  marcaAbaAberta(tsLiturgia);

  if (loadCol.Strings.Values['LITURGIA'] <> 'okf') then
  begin
    loadCol.Strings.Values['LITURGIA'] := 'okf';

    cbMarcarConc.Checked := (lerParam('Liturgia', 'MarcarConcluido', '1') = '1');
    cbBloqItens.Checked := (lerParam('Liturgia', 'BloquearItens', '0') = '1');
    cbAnotacoesLiturgia.Checked := (lerParam('Liturgia', 'ExibirAnotacoes', '1') = '1');

    {LAZARUS: chamada explícita — o original dependia do OnClick disparado por
     cbBloqItens.Checked:=... ("ESTÁ DENTRO DE BLOQUEAR ITENS"); no LCL o evento
     não dispara quando o valor não muda e a liturgia do dia nunca era carregada}
    LiturgiaCalendarClick(nil);
  end;
end;

procedure TfmIndex.tsMusicasInfantisShow(Sender: TObject);
begin
  marcaAbaAberta(tsMusicasInfantis);
  carrega_opc := True;

  if (loadCol.Strings.Values['INFANTIS'] <> 'okf') then
  begin
    loadCol.Strings.Values['INFANTIS'] := 'okf';

    DM.qrMUSICAS_INFANTIS.Close;
    DM.qrMUSICAS_INFANTIS.Open;
  end;

  {LAZARUS: dbctrlMusicasInfantis.RowCount — TScrollBox nao tem RowCount}
  {LAZARUS: dbctrlMusicasInfantis.ColCount — TScrollBox nao tem ColCount}

  carrega_opc := False;
end;

procedure TfmIndex.tsColetaneasOnlinePersoShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfigColetaneasOnlinePerso,tsColetaneasOnlinePerso);
  marcaAbaAberta(tsColetaneasOnlinePerso);
  dbGrid4.Columns[1].Width := dbGrid4.Width - dbGrid4.Columns[0].Width;
  carrega_opc := True;

  if (loadCol.Strings.Values['COLETANEAS_PERSO_ONL'] <> 'okf') then
  begin
    loadCol.Strings.Values['COLETANEAS_PERSO_ONL'] := 'okf';
    bsSkinScrollBar24.Visible := True;

    if not DM.cdsVideosOnPerso.Active then
    begin
      DM.cdsVideosOnPerso.CreateDataSet;
      DM.cdsVideosOnPerso.IndexName := '';
      DM.cdsVideosOnPerso.IndexFieldNames := 'NOME';
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsVideosOnPerso.LogChanges := False;)}
    end;

    if (FileExists(dir_dados + 'videosOnUsuario.xml')) then
      DM.cdsVideosOnPerso.LoadFromFile(dir_dados + 'videosOnUsuario.xml');
    DM.cdsVideosOnPerso.Open;

    if (DM.cdsVideosOnPerso.RecordCount <= 1) then
    begin
      bsSkinScrollBar24.Visible := False;
      dbGrid4.Columns[1].Width := dbGrid4.Width - dbGrid4.Columns[0].Width;
    end;

    btVidOnlPExcluir.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
    btVidOnlPCopiarLink.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
    btVidOnlPAbrirNaveg.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
    btVidOnlPExec.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));


    stVideosOnPerso_1.Text {LAZARUS: TStatusPanel.caption->Text} := qtItens(DM.cdsVideosOnPerso,'vídeo encontrado','vídeos encontrados','Nenhum vídeo encontrado');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsColetaneasOnlineShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfigColetaneasOnline,tsColetaneasOnline);
  marcaAbaAberta(tsColetaneasOnline);
  carrega_opc := True;

  if (loadCol.Strings.Values['COLETANEAS_ONL'] <> 'okf') then
  begin
    loadCol.Strings.Values['COLETANEAS_ONL'] := 'okf';

    DM.qrONL_CANAIS.Close;
    DM.qrONL_CANAIS.Open;
    if DM.qrONL_CANAIS.RecordCount <= 0 then
      atualiza_coletaneas_web('canais')
    else
      lista_coletaneas_web('canais');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsDiversasShow(Sender: TObject);
var
  i: integer;
begin
  PaginaMenuAtiva(tsColetaneas);
  marcaAbaAberta(tsDiversas);
  if (loadCol.Strings.Values['DIV'] <> 'ok') then
  begin
    loadCol.Strings.Values['DIV'] := 'ok';

    for i := sbColDIV.ComponentCount - 1 downto 0 do
      sbColDIV.Components[i].Free;

    fExibeColetaneas('DIV', sbColDIV);
  end;
end;

procedure TfmIndex.tsDoxologiaShow(Sender: TObject);
var
  Jpg: TJPEGImage;
  bmp: TBitmap;
  i: integer;
  dir: string;
begin
  marcaAbaAberta(tsDoxologia);
  carrega_opc := True;

  if (loadCol.Strings.Values['DOXOLOGIA'] <> 'okf') then
  begin
    loadCol.Strings.Values['DOXOLOGIA'] := 'okf';

    DM.qrDOXOLOGIA_CATE.Close;
    DM.qrDOXOLOGIA_CATE.Open;
    {LAZARUS: bgDoxologiaCate.Items.Clear — TToolBar diferente de TbsButtonGroup}
    {LAZARUS: bgDoxologiaCate.ItemIndex — TToolBar nao tem ItemIndex}
    lbbgDoxologiaCate.Items.Clear;
    pnlDoxologiaMusicas.Visible := False;
    DM.ico_doxologia.Clear;
    while not DM.qrDOXOLOGIA_CATE.eof do
    begin
      dir := dir_config + 'capas/' {LAZARUS: '\' → '/' separador Linux};
      {LAZARUS: bgDoxologiaCate.Items.Add.Caption — TToolBar nao tem Items.Add.Caption}
      lbbgDoxologiaCate.Items.Add(DM.qrDOXOLOGIA_CATE.FieldByName('ID').AsString);
      i := lbbgDoxologiaCate.Items.Count - 1; {LAZARUS: bgDoxologiaCate.Items.Count -> lbbgDoxologiaCate.Items.Count}

      Jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      if FileExists(dir + DM.qrDOXOLOGIA_CATE.FieldByName('IMAGEM').AsString) then
        Jpg.LoadFromFile(dir + DM.qrDOXOLOGIA_CATE.FieldByName('IMAGEM').AsString);
      bmp.Assign(Jpg);
      bmp.Height := 88;
      bmp.Width := 88;
      DM.ico_doxologia.Add(bmp, nil);

      {LAZARUS: bgDoxologiaCate.Items[i].ImageIndex — TToolBar stub}

      DM.qrDOXOLOGIA_CATE.Next;
    end;
  end;

  if (loadCol.Strings.Values['DOXOLOGIA_MUSICAS'] <> 'ok') then
  begin
    {LAZARUS: dbctrlDoxologiaMusicas.RowCount — TScrollBox nao tem RowCount}
    {LAZARUS: dbctrlDoxologiaMusicas.ColCount — TScrollBox nao tem ColCount}
  end;
  carrega_opc := False;
end;

procedure TfmIndex.ApplicationActivate(Sender: TObject);
begin
  focoAplicacao(true);
end;

procedure TfmIndex.ApplicationDeactivate(Sender: TObject);
begin
  focoAplicacao(false);
end;

function TfmIndex.arquivoCodificado(arq: string): TStringList;
var
  fileStream: TFileStream;
  utf8Stream: TStringStream;
  lista: TStringList;
begin
  lista := TStringList.Create;

  try
    fileStream := TFileStream.Create(arq, fmOpenRead);
    try
      utf8Stream := TStringStream.Create('') {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
      try
        try
          utf8Stream.CopyFrom(fileStream, 0);
          lista.Text := utf8Stream.DataString;
        except
          // Se ocorrer uma exceção durante a conversão para UTF-8, carregue o arquivo sem a conversão
          fileStream.Position := 0; // Volte ao início do arquivo
          lista.LoadFromStream(fileStream);
        end;
      finally
        utf8Stream.Free;
      end;
    finally
      fileStream.Free;
    end;
  except
    lista.LoadFromStream(fileStream);
  end;

  Result := lista;
end;

procedure TfmIndex.aSort(var Vetor: array of Integer);
var
  i, temp: Integer;
  changed: Boolean;
begin
  changed := True;

  while changed do
  begin
    changed := False;
    for i := Low(Vetor) to High(Vetor)-1 do
    begin
      if (Vetor[i] > Vetor[i+1]) then // Para ordem crescente altere o sinal para ">" nesta linha
      begin
        temp := Vetor[i+1];
        Vetor[i+1] := Vetor[i];
        Vetor[i] := temp;
        changed := True;
      end;
    end;
  end;
end;

procedure TfmIndex.atualizaIgnoreAlbum;
var
  ids: string;
begin
  if lerParam('Config','IgnorarAlbumHASD1996','1') = '1' then
  begin
    ids := lerParam('Config','IgnorarAlbuns','');
    if ids <> '' then ids := ids+',';
    ids := ids+'629';
    gravaParam('Config','IgnorarAlbuns',ids);
  end;

  DM.qrDEL_ALBUM_IGNORAR.ExecSQL;
  if lerParam('Config','IgnorarAlbuns','0') <> '0' then
  begin
    DM.qrADD_ALBUM_IGNORAR.SQL.Clear;
    DM.qrADD_ALBUM_IGNORAR.SQL.Add('INSERT INTO _ALBUM_IGNORAR (ID) SELECT ID FROM ALBUM WHERE ID IN (0'+lerParam('Config','IgnorarAlbuns','0')+')');
    DM.qrADD_ALBUM_IGNORAR.ExecSQL;
  end;

  if lerParam('Config','IgnorarAlbumHASD1996','1') = '1' then
  begin
    gravaParam('Config','IgnorarAlbumHASD1996','0');
    DM.qrALBUM_ATIV.Close;
    DM.qrALBUM_ATIV.Open;
    DM.qrALBUM_INATIV.Close;
    DM.qrALBUM_INATIV.Open;
  end;
end;

procedure TfmIndex.atualiza_coletaneas_web(p: string; id: string);
var
  Flags: Cardinal;
  url_conexao: string;
  txt: TStringList;
  sql: string;
  i: integer;
  dir: string;
  QUERY: TZQuery {LAZARUS: TFDQuery};
begin
  if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  {LAZARUS: DM.progressDialog.Caption := 'Coletânea JA'; — progressDialog removido}
  {LAZARUS: DM.progressDialog.LabelCaption := 'Atualizando... Aguarde...'; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Value := 0; — progressDialog removido}
  {LAZARUS: DM.progressDialog.MaxValue := 100; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Execute; — progressDialog removido}

  url_conexao := Trim(param.Strings.Values['coletaneas_online']);
  if (url_conexao = '') then
  begin
    gravaParam('Config', 'UltimaConexao', '-');
    carregaParams;
  end;

  url_conexao := Trim(param.Strings.Values['coletaneas_online']);
  if (url_conexao = '') then
  begin
    application.messagebox(PChar('Não foi possível atualizar coletâneas on-line! Algum firewall ou antivírus pode estar impedidno o programa de se conectar a internet!'), TITULO, MB_OK + mb_iconerror);
    {LAZARUS: DM.progressDialog.MaxValue := 1; — progressDialog removido}
    {LAZARUS: DM.progressDialog.Value := DM.progressDialog.MaxValue — progressDialog removido}
    {LAZARUS: DM.progressDialog.Close; — progressDialog removido}
    Exit;
  end;

  {LAZARUS: DM.progressDialog.MaxValue := 100; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Value := 20; — progressDialog removido}

  txt := TStringList.Create;
  DM.FHttp.AddHeader('Api-Token', api_token); {LAZARUS: IdHTTP1.Request.CustomHeaders → FHttp.AddHeader}

  try
    sql := DM.FHttp.Get( {LAZARUS: IdHTTP1.Get→FHttp.Get} url_conexao + '?tipo=' + p + '&id=' + id + '&atualiza_playlist=1&lang=' + fIniciando.LANG);
  except
    try
      url_conexao := StringReplace(url_conexao, 'https://', 'http://', [rfIgnoreCase, rfReplaceAll]);
      sql := DM.FHttp.Get( {LAZARUS: IdHTTP1.Get→FHttp.Get} url_conexao + '?tipo=' + p + '&id=' + id + '&atualiza_playlist=1');
    except
      application.messagebox(PChar('O sistema não conseguiu se conectar ao servidor! Tente novamente mais tarde.'), TITULO, MB_OK + mb_iconerror);
      {LAZARUS: DM.progressDialog.MaxValue := 1; — progressDialog removido}
      {LAZARUS: DM.progressDialog.Value := DM.progressDialog.MaxValue — progressDialog removido}
      {LAZARUS: DM.progressDialog.Close; — progressDialog removido}
      Exit;
    end;
  end;

  {LAZARUS: DM.progressDialog.MaxValue := 100; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Value := 50; — progressDialog removido}
  ExtractStrings(['|'], [], PChar(sql), txt);
  try
    for i := 0 to txt.Count - 1 do
    begin
      if Trim(txt[i]) <> '' then
      begin
        DM.ADOQuery.SQL.Text := txt[i];
        DM.ADOQuery.ExecSQL;
      end;
    end;
  except
    application.messagebox(PChar('Houve um erro ao tentar atualizar! Tente novamente mais tarde.'), TITULO, MB_OK + mb_iconerror);
    {LAZARUS: DM.progressDialog.MaxValue := 1; — progressDialog removido}
    {LAZARUS: DM.progressDialog.Value := DM.progressDialog.MaxValue — progressDialog removido}
    {LAZARUS: DM.progressDialog.Close; — progressDialog removido}
    Exit;
  end;

  {LAZARUS: DM.progressDialog.MaxValue := 100; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Value := 100; — progressDialog removido}

  if (p = 'canais') then
    application.messagebox(PChar('Canais atualizados com sucesso!'), TITULO, MB_OK + mb_iconinformation);
  if (p = 'playlists') then
    application.messagebox(PChar('Listas de Reprodução atualizadas com sucesso!'), TITULO, MB_OK + mb_iconinformation);
  if (p = 'videos') then
    application.messagebox(PChar('Vídeos atualizadas com sucesso!'), TITULO, MB_OK + mb_iconinformation);
  if (p = 'tudo') then
    application.messagebox(PChar('Vídeos atualizadas com sucesso!'), TITULO, MB_OK + mb_iconinformation);

  {LAZARUS: DM.progressDialog.MaxValue := 1; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Value := DM.progressDialog.MaxValue — progressDialog removido}
  {LAZARUS: DM.progressDialog.Close; — progressDialog removido}

  if (p = 'tudo') then
    p := 'canais';

  lista_coletaneas_web(p, id);
end;

procedure TfmIndex.bgDoxologiaCateButtonClicked(Sender: TObject;
  Index: Integer);
begin
  DM.qrMUSICAS.Close;
  DM.qrMUSICAS.ParamByName('ID_ALBUM').Value := lbbgDoxologiaCate.Items[Index];
  DM.qrMUSICAS.Open;
  lblDoxologiaCate.Caption := '' {LAZARUS: bgDoxologiaCate.Items[Index].Caption — TToolBar stub};
  pnlDoxologiaMusicas.Visible := True;

  imgDoxologiaCate.Picture.Bitmap:= nil;
  DM.ico_doxologia.GetBitmap(Index, imgDoxologiaCate.Picture.Bitmap);
  dbctrlDoxologiaMusicas.Visible := (DM.qrMUSICAS.RecordCount > 0);

  loadCol.Strings.Values['DOXOLOGIA_MUSICAS'] := '';
  tsDoxologiaShow(Sender);
end;

procedure TfmIndex.bgOnlCanaisButtonClicked(Sender: TObject; Index: Integer);
begin
  {LAZARUS: bgOnlPlaylists.Items.Clear — TToolBar stub}
  pnlOnlPlaylists.Visible := True;

  DM.qrONL_PLAYLISTS.Close;
  DM.qrONL_PLAYLISTS.ParamByName('CANAL_ID').Value := lbbgOnlCanais.Items[Index];
  DM.qrONL_PLAYLISTS.Open;
  if DM.qrONL_PLAYLISTS.RecordCount <= 0 then
    atualiza_coletaneas_web('playlists', lbbgOnlCanais.Items[Index])
  else
    lista_coletaneas_web('playlists', lbbgOnlCanais.Items[Index]);
end;

procedure TfmIndex.bgOnlPlaylistsButtonClicked(Sender: TObject; Index: Integer);
begin
  {LAZARUS: bgOnlVideos.Items.Clear — TToolBar stub}
  pnlOnlVideos.Visible := True;
  imgYoutubeCapa.Visible := not pnlOnlVideos.Visible;

  DM.qrONL_VIDEOS.Close;
  DM.qrONL_VIDEOS.ParamByName('PLAYLIST_ID').Value := lbbgOnlPlaylists.Items[Index];
  DM.qrONL_VIDEOS.Open;
  if DM.qrONL_VIDEOS.RecordCount <= 0 then
    atualiza_coletaneas_web('videos', lbbgOnlPlaylists.Items[Index])
  else
    lista_coletaneas_web('videos', lbbgOnlPlaylists.Items[Index]);
end;

procedure TfmIndex.bgOnlVideosButtonClicked(Sender: TObject; Index: Integer);
begin
  abreVideoOn(lbbgOnlVideos.Items[Index], lbbgOnlVideos.Items[Index]); {LAZARUS: bgOnlVideos.Items[Index].Caption -> lbbgOnlVideos.Items[Index]}
end;

procedure TfmIndex.tsBuscaMusicaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsBuscaMusica,tsBuscaMusica);
  marcaAbaAberta(tsBuscaMusica);
  carrega_opc := true;
  dbGrid2.Columns[2].Width := dbGrid2.Width - dbGrid2.Columns[0].Width - dbGrid2.Columns[1].Width - dbGrid2.Columns[3].Width;

  loadCol.Strings.Values['BUSCA:CARREGADO'] := 'N';
  if (loadCol.Strings.Values['BUSCA'] <> 'okf') then
  begin
//    loadCol.Strings.Values['BUSCA'] := 'okf';
    txtBusca.Text := '';
    DM.tmrBusca.Enabled := False;

    ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[0] := (lerParam('Busca', 'Filtro 1', '1') = '1');
    ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[1] := (lerParam('Busca', 'Filtro 2', '0') = '1');
    ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[2] := (lerParam('Busca', 'Filtro 3', '0') = '1');

    ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[0] := (lerParam('Busca', 'Baixadas', '1') = '1');
    ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[1] := (lerParam('Busca', 'Web', '0') = '1');
    ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[2] := (lerParam('Busca', 'Personalizadas', '0') = '1');

//    ckgIdiomas.Checked {LAZARUS: ItemChecked->Checked}[0] := True;
//    ckgIdiomas.Checked {LAZARUS: ItemChecked->Checked}[1] := True;
//    ckgIdiomas.Checked {LAZARUS: ItemChecked->Checked}[2] := True;
    DM.tmrBusca.Enabled := False;

//    buscaMusicas;
  end;
  loadCol.Strings.Values['BUSCA:CARREGADO'] := 'S';
  txtBusca.SetFocus;
  carrega_opc := false;
  DM.tmrBusca.Enabled := False;

  if (loadCol.Strings.Values['BUSCA'] <> 'okf') then
  begin
    loadCol.Strings.Values['BUSCA'] := 'okf';
    buscaMusicas;
  end;
end;

procedure TfmIndex.txtAbrirColet2Enter(Sender: TObject);
begin
  txtAbrirColet2.Text := verificaURL(txtAbrirColet2.Text, txtUrlInfoColet2, true);
end;

procedure TfmIndex.txtAbrirColet2Exit(Sender: TObject);
begin
  if trim(txtColetanea2.Text) = '' then
    txtColetanea2.Text := ChangeFileExt(ExtractFileName(txtAbrirColet2.Text), '');
  txtAbrirColet2.Text := verificaURL(txtAbrirColet2.Text, txtUrlInfoColet2);
end;

procedure TfmIndex.txtAbrirColetEnter(Sender: TObject);
begin
  txtAbrirColet.Text := verificaURL(txtAbrirColet.Text, txtUrlInfoColet, true);
end;

procedure TfmIndex.txtAbrirColetExit(Sender: TObject);
begin
  if trim(txtColetanea.Text) = '' then
    txtColetanea.Text := ChangeFileExt(ExtractFileName(txtAbrirColet.Text), '');
  txtAbrirColet.Text := verificaURL(txtAbrirColet.Text, txtUrlInfoColet);
end;

procedure TfmIndex.txtBuscaChange(Sender: TObject);
begin
  if carrega_opc then exit;

  if ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[1] then
  begin
    DM.tmrBusca.Enabled := False;
    DM.tmrBusca.Enabled := True;
  end
  else buscaMusicas();
end;

procedure TfmIndex.txtBuscaColetPesoChange(Sender: TObject);
begin
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
end;

procedure TfmIndex.DBGrid2CellClick(Column: TColumn {LAZARUS: TbsColumn});
begin
  if (DM.qrBUSCA.Active = false) then Exit;
  if (DM.qrBUSCA.RecordCount <= 0) then Exit;

  btExportarMusica.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');

  btMusicaSlideMusicaPB.Enabled := (DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '');
  btMusicaAudioMusicaPB.Enabled := (DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '');
  btMusicaSlideMusicaSA.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');
  btMusicaAudioMusica.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');
  btMusicaLetra.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');
end;

procedure TfmIndex.DBGrid2DblClick(Sender: TObject);
begin
  btMusicaSlideMusicaClick(Sender);
end;

procedure TfmIndex.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
var
  fixRect: TRect;
begin
  Canvas.Brush.Style := bsClear; {LAZARUS: TPngImage/PngImages -> TImageList.Draw}
  if (DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and (Column.FieldName = 'ICONE1') then
  begin
    fixRect := Rect;
      fixRect.Top := Rect.Top + 1;
      fixRect.Bottom := Rect.Top + 17;
      fixRect.Left := Rect.Left + 1;
      fixRect.Right := Rect.Left + 17;
      DM.ico_16x16.Draw(TDBGrid(Sender).Canvas, fixRect.Left, fixRect.Top, 82);
  end;
  if (DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S') and (Column.FieldName = 'ICONE1') then
  begin
    fixRect := Rect;
      fixRect.Top := Rect.Top + 1;
      fixRect.Bottom := Rect.Top + 17;
      fixRect.Left := Rect.Left + 1;
      fixRect.Right := Rect.Left + 17;
      DM.ico_16x16.Draw(TDBGrid(Sender).Canvas, fixRect.Left, fixRect.Top, 37);
  end;
  if (DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '') and (Column.FieldName = 'ICONE2') then
  begin
    fixRect := Rect;
      fixRect.Top := Rect.Top + 1;
      fixRect.Bottom := Rect.Top + 17;
      fixRect.Left := Rect.Left + 1;
      fixRect.Right := Rect.Left + 17;
      DM.ico_16x16.Draw(TDBGrid(Sender).Canvas, fixRect.Left, fixRect.Top, 103);
  end;
end;

procedure TfmIndex.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid2CellClick(nil);
end;

procedure TfmIndex.DBGrid4DblClick(Sender: TObject);
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  abreVideoOn(DM.cdsVideosOnPerso.FieldByName('VIDEOID').AsString, DM.cdsVideosOnPerso.fieldbyname('NOME').AsString);
end;

procedure TfmIndex.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
var
  w: Integer;
begin
  w := 10 + TDBGrid {LAZARUS: TbsSkinDBGrid}(Sender).Canvas.TextExtent(Column.Field.DisplayText).cx;
  if w > Column.Width then
    Column.Width := w;
end;

procedure TfmIndex.txtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid2DblClick(Sender);
  end;
end;

function TfmIndex.RemoveAcento(Str: string): string;
const
  ComAcento = 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
  SemAcento = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';
var
   x: Integer;
begin;
  for x := 1 to Length(Str) do
  if Pos(Str[x],ComAcento) <> 0 then
    Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  Result := Str;
end;

procedure TfmIndex.removeItensAgendadosPassados;
{LAZARUS: TBufDataset nao suporta operadores '<' em Filter (interpreta como nome de campo);
 substituido por loop manual comparando datas}
var
  dataItem: TDate;
begin
  DM.cdsItensAgendados.First;
  while not DM.cdsItensAgendados.Eof do
  begin
    try
      dataItem := StrToDate(DM.cdsItensAgendados.FieldByName('DATA').AsString);
      if dataItem < Date then
        DM.cdsItensAgendados.Delete
      else
        DM.cdsItensAgendados.Next;
    except
      DM.cdsItensAgendados.Next;
    end;
  end;
end;


function TfmIndex.RemoveTags(const s: string): string;
var
  i: Integer;
  InTag: Boolean;
begin
  Result := '';
  InTag := False;
  for i := 1 to Length(s) do
  begin
    if s[i] = '<' then
      InTag := True
    else if s[i] = '>' then
      InTag := False
    else if not InTag then
      Result := Result + s[i];
  end;
end;

function TfmIndex.removeTagsHTML(texto: string): string;
begin
  result := ReplaceRegExpr('<[^>]+>', texto, '', True) {LAZARUS: TRegEx→regexpr};
end;

procedure TfmIndex.RichEditChange(Sender: TObject);
begin
  copiaDadosTelaExtendida;
  RichEditEnter(Sender);
end;

procedure TfmIndex.RichEditEnter(Sender: TObject);
var
  tag: Integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
  fcTxtI:  TComboBox {LAZARUS: TbsSkinFontComboBox};
  seTxtITamanho: TComboBox {LAZARUS: TbsSkinComboBox};
  btfsBold: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
  btfsItalic: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
  btfsUnderline: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
  btfsStrikeOut: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
  cbColorFTxtI: TColorButton {LAZARUS: TbsSkinColorButton};
  cbColorTxtI: TColorButton {LAZARUS: TbsSkinColorButton};
  bttaLeftJustify: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
  bttaCenter: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
  bttaRightJustify: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
begin
  if carrega_opc = True then
    Exit;

  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(Sender);
  tag := RichEdit.Tag;

  fcTxtI := TComboBox {LAZARUS: TbsSkinFontComboBox}(FindComponent('fcTxtI'+inttostr(tag)));
  if (Assigned(fcTxtI))
    then fcTxtI.Text := RichEdit.Font.Name; {LAZARUS: FontName->Text; SelAttributes.Name->Font.Name}

  seTxtITamanho := TComboBox {LAZARUS: TbsSkinComboBox}(FindComponent('seTxtITamanho'+inttostr(tag)));
  if (Assigned(seTxtITamanho))
    then seTxtITamanho.Text := IntToStr(RichEdit.Font.Size); {LAZARUS: SelAttributes.Size->Font.Size}

  btfsBold := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('btfsBold'+inttostr(tag)));
  if (Assigned(btfsBold)) then
  begin
    if fsBold in RichEdit.Font.Style then {LAZARUS: SelAttributes.Style->Font.Style}
      btfsBold.Down := true
    else
      btfsBold.Down := false;
  end;

  btfsItalic := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('btfsItalic'+inttostr(tag)));
  if (Assigned(btfsItalic)) then
  begin
    if fsItalic in RichEdit.Font.Style then {LAZARUS: SelAttributes.Style->Font.Style}
      btfsItalic.Down := true
    else
      btfsItalic.Down := false;
  end;

  btfsUnderline := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('btfsUnderline'+inttostr(tag)));
  if (Assigned(btfsUnderline)) then
  begin
    if fsUnderline in RichEdit.Font.Style then {LAZARUS: SelAttributes.Style->Font.Style}
      btfsUnderline.Down := true
    else
      btfsUnderline.Down := false;
  end;

  btfsStrikeOut := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('btfsStrikeOut'+inttostr(tag)));
  if (Assigned(btfsStrikeOut)) then
  begin
    if fsStrikeOut in RichEdit.Font.Style then {LAZARUS: SelAttributes.Style->Font.Style}
      btfsStrikeOut.Down := true
    else
      btfsStrikeOut.Down := false;
  end;

  cbColorFTxtI := TColorButton {LAZARUS: TbsSkinColorButton}(FindComponent('cbColorFTxtI'+inttostr(tag)));
  if (Assigned(cbColorFTxtI))
    then cbColorFTxtI.ButtonColor := RichEdit.Color; {LAZARUS: ColorValue->ButtonColor}

  cbColorTxtI := TColorButton {LAZARUS: TbsSkinColorButton}(FindComponent('cbColorTxtI'+inttostr(tag)));
  if (Assigned(cbColorTxtI))
    then cbColorTxtI.ButtonColor := RichEdit.Font.Color; {LAZARUS: SelAttributes.Color->Font.Color; ColorValue->ButtonColor}

  bttaLeftJustify := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('bttaLeftJustify'+inttostr(tag)));
  if (Assigned(bttaLeftJustify)) then
  begin
    if True then {LAZARUS: RichEdit.Paragraph.Alignment - TRichMemo usa GetParaAlignment - stub}
      bttaLeftJustify.Down := true
    else
      bttaLeftJustify.Down := false;
  end;

  bttaCenter := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('bttaCenter'+inttostr(tag)));
  if (Assigned(bttaCenter)) then
  begin
    if False then {LAZARUS: RichEdit.Paragraph.Alignment - TRichMemo usa GetParaAlignment - stub}
      bttaCenter.Down := true
    else
      bttaCenter.Down := false;
  end;

  bttaRightJustify := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('bttaRightJustify'+inttostr(tag)));
  if (Assigned(bttaRightJustify)) then
  begin
    if False then {LAZARUS: RichEdit.Paragraph.Alignment - TRichMemo usa GetParaAlignment - stub}
      bttaRightJustify.Down := true
    else
      bttaRightJustify.Down := false;
  end;

end;

procedure TfmIndex.RichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  RichEditEnter(Sender);
end;

procedure TfmIndex.RichEditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RichEditEnter(Sender);
end;

procedure TfmIndex.RestartApplication;
var
  ExeName, Params, _out: string;
  I: Integer;
begin
  ExeName := ParamStr(0);
  Params := '';

  for I := 1 to ParamCount do
  begin
    Params := Params + ' "' + ParamStr(I) + '"';
  end;

  {LAZARUS: SysUtils.SplitString -> stub; RunCommand requer var output}
  RunCommand(ExeName, [''], _out);

  DM.tmrSair.enabled := true;
  Halt;
end;

procedure TfmIndex.RE_SetSelBgColor(RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit}; AColor: TColor);
{LAZARUS: CHARFORMAT2/CFM_BACKCOLOR/EM_SETCHARFORMAT — Windows RichEdit API removido}
begin
  {LAZARUS: TRichMemo nao suporta cor de fundo de selecao via Windows API — stub}
end;

procedure TfmIndex.SorteioContador;
begin
  lblNumSortDisp.Caption := 'Disponíveis: ' + IntToStr(vlSorteio.Strings.Count);
  lblNumSortSort.Caption := 'Sorteados: ' + IntToStr(vlSorteados.Strings.Count);

  lblNumSortDispNM.Caption := 'Disponíveis: ' + IntToStr(vlSorteioNM.Strings.Count);
  lblNumSortSortNM.Caption := 'Sorteados: ' + IntToStr(vlSorteadosNM.Strings.Count);
end;

procedure TfmIndex.tabLetrasChange(Sender: TObject);
begin
  txtBuscaChange(Sender);
end;

function TfmIndex.termo_busca(busca: string): string;
var
  busca_ori: string;
begin
  busca_ori := busca;
  busca := RemoveAcento(busca);
  busca := StringReplace(busca,'*','%',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'a','[aáàâãä]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'e','[eéèêë]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'i','[iíìîï]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'o','[oóòôõö]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'u','[uúùûü]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'c','[cç]',[rfIgnoreCase, rfReplaceAll]);
//  loadCol.Strings.Values['BUSCA:'+busca_ori] := busca;
  busca := LowerCase(busca);
  Result := busca;
end;

procedure TfmIndex.ogFavoritosItemClick(Sender: TObject);
var
  i: Integer;
  tabsheet: TTabSheet {LAZARUS: TbsSkinTabSheet};
  nome,nome_aba: string;
begin
  if carrega_opc = true then Exit;

  i := ogFavoritos.ItemIndex+1;
  DM.cdsFavoritos.RecNo := i;

  tabsheet := TTabSheet {LAZARUS: TbsSkinTabSheet}(FindComponent(DM.cdsFavoritos.FieldByName('NOME_ABA').AsString));
  if assigned(tabsheet)
    then abrePagina(tabsheet)
  else
  begin
    nome_aba := DM.cdsFavoritos.FieldByName('NOME_ABA').AsString;
    nome := DM.cdsFavoritos.FieldByName('NOME').AsString;
    if (application.MessageBox(PChar('Esta página não existe ou foi removida nesta versão! Deseja remover '''+nome+''' dos favoritos?'), titulo, mb_yesno + mb_iconquestion) = 6) then
    begin
      DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, []);
      DM.cdsFavoritos.Delete;

      carregaFavoritos();
      botoesFavoritos('add');
      application.messagebox(PChar('Página '''+nome+''' removida com sucesso dos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
      exit;
    end
    else
    begin
      carregaFavoritos();
      botoesFavoritos('add');
    end;
  end;

end;

function TfmIndex.openDialog(tipo, filtros, param: string;
  multiplos: boolean;diretorio_inicial:string;titulo_dialog:string;nome_arquivo:string): string;
var
  titulo_dialog_def: string;
  filtros_def: string;
  param_def: string;
  dir,arq,a: string;
  i: Integer;
begin
  if (tipo = 'arquivo') then
  begin
    titulo_dialog_def := 'Abrir arquivo';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end
  else
  if (tipo = 'imagem') then
  begin
    titulo_dialog_def := 'Abrir imagem';
    filtros_def := 'Arquivos de Imagem (*.png_old;*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*.ico;*.emf;*.wmf)|*.png_old;*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*.ico;*.emf;*.wmf';
    param_def := 'GeralImagem';
  end
  else
  if (tipo = 'musica_mp3') then
  begin
    titulo_dialog_def := 'Abrir música';
    filtros_def := 'Arquivos de Áudio MP3 (*.mp3)|*.mp3';
    param_def := 'GeralAudio';
  end
  else
  if (tipo = 'texto') then
  begin
    titulo_dialog_def := 'Abrir arquivo de texto';
    filtros_def := 'Arquivo de Texto (*.txt)|*.txt|Arquivo CSV (*.csv)|*.csv|Todos os Arquivos (*.*)|*.*';
    param_def := 'GeralTexto';
  end
  else
  if (tipo = 'pasta') then
  begin
    titulo_dialog_def := 'Selecione o Diretório';
    filtros_def := '';
    param_def := 'GeralPasta';
  end
  else
  begin
    titulo_dialog_def := 'Abrir';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end;

  if trim(filtros) = '' then filtros := filtros_def;
  if trim(param) = '' then param := param_def;
  if trim(titulo_dialog) = '' then titulo_dialog := titulo_dialog_def;
  nome_arquivo := Trim(nome_arquivo);

  dir := '';
  arq := '';
  if (trim(diretorio_inicial) <> '') then
  begin
    dir := diretorio(diretorio_inicial);
    if not DirectoryExists(dir) then dir := '';
  end;
  if (Trim(dir) <> '') and (DirectoryExists(ExtractFilePath(Application.ExeName)+dir))
    then dir := ExtractFilePath(Application.ExeName)+dir;
  if Trim(dir) = '' then
  begin
    dir := lerParam('OpenDialog', param, param_def);
    dir := diretorio(dir);
    if not DirectoryExists(dir) then dir := '';
  end;

  if (tipo = 'imagem') then
  begin
    DM.OpenPictureDialog.Title := titulo_dialog; {LAZARUS: TDialog.Title corrigido}
    DM.OpenPictureDialog.Filter := filtros;
    if (multiplos)
      then DM.OpenPictureDialog.Options := DM.OpenPictureDialog.Options + [ofAllowMultiSelect]
      else DM.OpenPictureDialog.Options := DM.OpenPictureDialog.Options - [ofAllowMultiSelect];
    DM.OpenPictureDialog.FileName := nome_arquivo;
    DM.OpenPictureDialog.InitialDir := dir;
    if (DM.OpenPictureDialog.Execute) then
    begin
      for i := 0 to DM.OpenPictureDialog.Files.Count - 1 do
      begin
        a := DM.OpenPictureDialog.Files[i];
        a := diretorio(a);

        if not FileExists(a) then
        begin
          if DM.OpenPictureDialog.Files.Count = 1
            then application.messagebox(PChar('Imagem '+arq+' não localizada!'), TITULO, MB_ok + mb_iconerror);
          a := '';
        end;

        if a <> '' then
        begin
          if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(a)+'\'));
          if arq <> '' then arq := arq + '|';
          arq := arq + a;
        end;
      end;
    end;
  end
  else
  if (tipo = 'texto') then
  begin
    DM.OpenTextFileDialog.Title := titulo_dialog; {LAZARUS: TDialog.Title corrigido}
    DM.OpenTextFileDialog.Filter := filtros;
    if (multiplos)
      then DM.OpenTextFileDialog.Options := DM.OpenTextFileDialog.Options + [ofAllowMultiSelect]
      else DM.OpenTextFileDialog.Options := DM.OpenTextFileDialog.Options - [ofAllowMultiSelect];
    DM.OpenTextFileDialog.FileName := nome_arquivo;
    DM.OpenTextFileDialog.InitialDir := dir;
    if (DM.OpenTextFileDialog.Execute) then
    begin
      for i := 0 to DM.OpenTextFileDialog.Files.Count - 1 do
      begin
        a := DM.OpenTextFileDialog.Files[i];
        a := diretorio(a);

        if not FileExists(a) then
        begin
          if DM.OpenTextFileDialog.Files.Count = 1
            then application.messagebox(PChar('Arquivo '+arq+' não localizado!'), TITULO, MB_ok + mb_iconerror);
          a := '';
        end;

        if a <> '' then
        begin
          if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(a)+'\'));
          if arq <> '' then arq := arq + '|';
          arq := arq + a;
        end;
      end;
    end;
  end
  else
  if (tipo = 'pasta') then
  begin
    DM.DirectoryDialog.Title := titulo_dialog; {LAZARUS: TDialog.Title corrigido} {LAZARUS: TSelectDirectoryDialog}
    DM.DirectoryDialog.FileName := dir; {LAZARUS: TSelectDirectoryDialog.Directory->FileName}
    if (DM.DirectoryDialog.Execute) then
    begin
      a := DM.DirectoryDialog.FileName; {LAZARUS: TSelectDirectoryDialog.Directory->FileName}
      a := diretorio(a+'\');

      if not DirectoryExists(a) then
      begin
        application.messagebox(PChar('Diretório '+arq+' não localizado!'), TITULO, MB_ok + mb_iconerror);
        a := '';
      end;

      if a <> '' then
      begin
        if param <> '' then gravaParam('OpenDialog', param, diretorio(a+'\'));
        arq := a;
      end;
    end;
  end
  else
  begin
    DM.OpenDialog.Title := titulo_dialog; {LAZARUS: TDialog.Title corrigido}
    DM.OpenDialog.Filter := filtros;
    if (multiplos)
      then DM.OpenDialog.Options := DM.OpenDialog.Options + [ofAllowMultiSelect]
      else DM.OpenDialog.Options := DM.OpenDialog.Options - [ofAllowMultiSelect];
    DM.OpenDialog.FileName := nome_arquivo;
    DM.OpenDialog.InitialDir := dir;
    if (DM.OpenDialog.Execute) then
    begin
      for i := 0 to DM.OpenDialog.Files.Count - 1 do
      begin
        a := DM.OpenDialog.Files[i];
        a := diretorio(a);

        if not FileExists(a) then
        begin
          if DM.OpenDialog.Files.Count = 1
            then application.messagebox(PChar('Arquivo '+arq+' não localizado!'), TITULO, MB_ok + mb_iconerror);
          a := '';
        end;

        if a <> '' then
        begin
          if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(a)+'\'));
          if arq <> '' then arq := arq + '|';
          arq := arq + a;
        end;
      end;
    end;
  end;

  if (Trim(arq) = '') then arq := Trim(arq);

  Result := arq;
end;

function TfmIndex.saveDialog(tipo, filtros, param, diretorio_inicial,
  titulo_dialog: string;nome_arquivo:string): string;
var
  titulo_dialog_def: string;
  filtros_def: string;
  param_def: string;
  dir,arq: string;
  ext: TStringList;
  ext_info: string;
begin
  if (tipo = 'arquivo') then
  begin
    titulo_dialog_def := 'Salvar arquivo';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end
  else
  if (tipo = 'imagem') then
  begin
    titulo_dialog_def := 'Salvar imagem';
    filtros_def := 'PNG (*.png)|*.png|GIF (*.gif)|*.gif|JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|BMP (*.bmp)|*.bmp|TIFF (*.tif;*.tiff)|*.tif;*.tiff|ICO (*.ico)|*.ico|EMF (*.emf)|*.emf|WMF (*.wmf)|*.wmf';
    param_def := 'GeralImagem';
  end
  else
  if (tipo = 'texto') then
  begin
    titulo_dialog_def := 'Salvar arquivo de texto';
    filtros_def := 'Arquivo de Texto (*.txt)|*.txt|Arquivo CSV (*.csv)';
    param_def := 'GeralTexto';
  end
  else
  begin
    titulo_dialog_def := 'Salvar';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end;

  if trim(filtros) = '' then filtros := filtros_def;
  if trim(param) = '' then param := param_def;
  if trim(titulo_dialog) = '' then titulo_dialog := titulo_dialog_def;
  nome_arquivo := Trim(nome_arquivo);

  ext := TStringList.Create;
  ExtractStrings(['|'], [], PChar(filtros), ext);

  dir := '';
  arq := '';
  if (trim(diretorio_inicial) <> '') then
  begin
    dir := diretorio(diretorio_inicial);
    if not DirectoryExists(dir) then dir := '';
  end;
  if (Trim(dir) <> '') and (DirectoryExists(ExtractFilePath(Application.ExeName)+dir))
    then dir := ExtractFilePath(Application.ExeName)+dir;
  if Trim(dir) = '' then
  begin
    dir := lerParam('OpenDialog', param, param_def);
    dir := diretorio(dir);
    if not DirectoryExists(dir) then dir := '';
  end;

  if (tipo = 'imagem') then
  begin
    DM.SavePictureDialog.Title := titulo_dialog; {LAZARUS: TDialog.Title corrigido}
    DM.SavePictureDialog.Filter := filtros;
    DM.SavePictureDialog.FileName := nome_arquivo;
    DM.SavePictureDialog.InitialDir := dir;
    if (DM.SavePictureDialog.Execute) then
    begin
      arq := DM.SavePictureDialog.FileName;
      arq := diretorio(arq);

      if ExtractFileExt(arq) = '' then
      begin
        ext_info := ext[(DM.SavePictureDialog.FilterIndex*2)-1]+';';
        ext_info := Copy(ext_info,1,Pos(';',ext_info)-1);
        if Pos('.',ext_info) > 0
          then ext_info := Copy(ext_info,Pos('.',ext_info)+1,length(ext_info));
        ext_info := StringReplace(ext_info, '*', '', [rfIgnoreCase, rfReplaceAll]);

        if ext_info <> ''
          then arq := arq+'.'+ext_info;
      end;

      if FileExists(arq) then
        if application.messagebox(PChar('Já existe uma imagem com este nome neste diretório. Deseja substituir a imagem?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
          arq := '';

      if arq <> '' then
        if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(arq)+'\'));
    end;
  end
  else
  if (tipo = 'texto') then
  begin
    DM.SaveTextFileDialog.Title := titulo_dialog; {LAZARUS: TDialog.Title corrigido}
    DM.SaveTextFileDialog.Filter := filtros;
    DM.SaveTextFileDialog.FileName := nome_arquivo;
    DM.SaveTextFileDialog.InitialDir := dir;
    if (DM.SaveTextFileDialog.Execute) then
    begin
      arq := DM.SaveTextFileDialog.FileName;
      arq := diretorio(arq);

      if ExtractFileExt(arq) = '' then
      begin
        ext_info := ext[(DM.SaveTextFileDialog.FilterIndex*2)-1]+';';
        ext_info := Copy(ext_info,1,Pos(';',ext_info)-1);
        if Pos('.',ext_info) > 0
          then ext_info := Copy(ext_info,Pos('.',ext_info)+1,length(ext_info));
        ext_info := StringReplace(ext_info, '*', '', [rfIgnoreCase, rfReplaceAll]);

        if ext_info <> ''
          then arq := arq+'.'+ext_info;
      end;

      if FileExists(arq) then
        if application.messagebox(PChar('Já existe um arquivo com este nome neste diretório. Deseja substituir o arquivo?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
          arq := '';

      if arq <> '' then
        if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(arq)+'\'));
    end;
  end
  else
  begin
    DM.SaveDialog.Title := titulo_dialog; {LAZARUS: TDialog.Title corrigido}
    DM.SaveDialog.Filter := filtros;
    DM.SaveDialog.FileName := nome_arquivo;
    DM.SaveDialog.InitialDir := dir;
    if (DM.SaveDialog.Execute) then
    begin
      arq := DM.SaveDialog.FileName;
      arq := diretorio(arq);

      if ExtractFileExt(arq) = '' then
      begin
        ext_info := ext[(DM.SaveDialog.FilterIndex*2)-1]+';';
        ext_info := Copy(ext_info,1,Pos(';',ext_info)-1);
        if Pos('.',ext_info) > 0
          then ext_info := Copy(ext_info,Pos('.',ext_info)+1,length(ext_info));
        ext_info := StringReplace(ext_info, '*', '', [rfIgnoreCase, rfReplaceAll]);

        if ext_info <> ''
          then arq := arq+'.'+ext_info;
      end;

      if FileExists(arq) then
        if application.messagebox(PChar('Já existe um arquivo com este nome neste diretório. Deseja substituir o arquivo?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
          arq := '';

      if arq <> '' then
        if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(arq)+'\'));
    end;
  end;

  if (Trim(arq) = '') then arq := Trim(arq);

  Result := arq;
end;

procedure TfmIndex.opSortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(Key,['0'..'9',#8])) then
    Key := #0;
end;

procedure TfmIndex.opSort_IniKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btAddSorteioClick(nil);
end;

procedure TfmIndex.PageControl1Close(Sender: TObject; var CanClose: Boolean);
var
  t: integer;
begin
  t := TTabSheet {LAZARUS: TbsSkinTabSheet}(Sender).Tag;
  PageControl1.Pages[TTabSheet {LAZARUS: TbsSkinTabSheet}(Sender).PageIndex].TabVisible := False;
  bsPopupMenuRibon.Items.Delete(t);
  confereAbasAbertas();
end;

procedure TfmIndex.PageControl1Change(Sender: TObject);
begin
  {LAZARUS: No LCL, TTabSheet.OnShow não dispara automaticamente quando a aba ativa muda
   via PageControl1.ActivePage := xxx. Chamamos o OnShow manualmente aqui.
   O guard carrega_opc evita disparo durante a inicialização do formulário.}
  if carrega_opc and (PageControl1.ActivePage <> nil) and
     Assigned(PageControl1.ActivePage.OnShow) then
    PageControl1.ActivePage.OnShow(Sender);
end;

procedure TfmIndex.PaginaMenuAtiva(page: TTabSheet {LAZARUS: TbsRibbonPage};tabvinc: TTabSheet {LAZARUS: TbsSkinTabSheet});
var
  i: integer;
  tl,idx: integer;
begin
  if page <> nil then
  begin
    page.Visible := True;
    RibbonPC.ActivePage := page;
  end;

  RibbonPC.Refresh;
  tl := 0;
  idx := -1;
  for i := 0 to RibbonPC.PageCount - 1 {LAZARUS: Tabs.Count->PageCount} do
  begin
    if (RibbonPC.Pages[i] {LAZARUS: Tabs[i].page->Pages[i]}.Tag = -1) then
    begin
      if ((page <> nil) and (RibbonPC.Pages[i] {LAZARUS: Tabs[i].page->Pages[i]} <> page) or (page = nil)) then
        RibbonPC.Pages[i].TabVisible := False; {LAZARUS: Tabs[i].Visible->Pages[i].TabVisible}

      if (page <> nil) and (RibbonPC.Pages[i] {LAZARUS: Tabs[i].page->Pages[i]} = page) and (RibbonPC.Pages[i].TabVisible {LAZARUS: Tabs[i].Visible->Pages[i].TabVisible}) then
        idx := i;
    end
    else tl := tl + RibbonPC.Pages[i].Width+1 {LAZARUS: Tabs[i].Width->Pages[i].Width};
  end;

  pnlfmSubTituloRib.Visible := false;
  if idx >= 0 then
  begin
    pnlTitForm.Align := alLeft;
    pnlTitForm.Width := tl+0 {LAZARUS: AppButtonWidth nao existe em TPageControl}-2;

    if tabvinc <> nil then lblfmTituloRib.Caption := tabvinc.Caption
    else lblfmTituloRib.Caption := '';

    pnlfmTituloRib.width := RibbonPC.Pages[idx].Width {LAZARUS: Tabs[idx].Width->Pages[idx].Width};
    pnlfmTituloRib.Left := pnlTitForm.Width;
    pnlfmTituloRib.Visible := true;

    pnlfmSubTituloRib.width := pnlfmTituloRib.width;
    pnlfmSubTituloRib.Left := pnlfmTituloRib.Left;
    pnlfmSubTituloRib.Top := pnlfmTituloRib.Top+pnlfmTituloRib.height;
    pnlfmSubTituloRib.Height := 31;
    pnlfmSubTituloRib.Caption := RibbonPC.ActivePage.Caption;
    pnlfmSubTituloRib.Tag := 1;
  end
  else
  begin
    pnlTitForm.Align := alClient;
    pnlfmTituloRib.Visible := false;
    pnlfmSubTituloRib.Caption := '';
    pnlfmSubTituloRib.Tag := 0;
  end;

end;

procedure TfmIndex.PanelColorClick(Sender: TObject);
var
  Panel: TPanel;
begin
  if Sender is TPanel
    then Panel := TPanel(TPanel(Sender))
    else Panel := TPanel(TPanel(Sender).Parent);

  DM.ColorDialog.Color := Panel.Color;
  DM.ColorDialog.Execute;
  Panel.Color := DM.ColorDialog.Color;

  gravaParam(Panel.Parent.Name, 'cor', ColorToString(DM.ColorDialog.Color), arq_liturgia);
end;

procedure TfmIndex.pnlfmBarraTituloFormDblClick(Sender: TObject);
begin
  btwsMaximizedClick(Sender);
end;

procedure TfmIndex.pnlfmBarraTituloFormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (fmIndex.WindowState = wsMaximized) then Exit;
  if (Button = mbLeft) then
  begin
    {LAZARUS: ReleaseCapture/WM_SYSCOMMAND/Perform — drag de janela sem borda removido}
  end;
end;

procedure TfmIndex.pnlfmSubTituloRibClick(Sender: TObject);
begin
  if PageControl1.Visible = true then
  begin
    try
      PageControl1.Pages[PageControl1.ActivePageIndex].OnShow(Sender);
    except
      //
    end;
  end;
end;

procedure TfmIndex.pnlfmSubTituloRibMouseLeave(Sender: TObject);
begin
  pnlfmSubTituloRib.Color := pnlfmTituloRib.Color;
  if layoutValue.Strings.Values['cor_texto_marc'] <> '' then
    pnlfmSubTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_marc']);
end;

procedure TfmIndex.pnlfmSubTituloRibMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if layoutValue.Strings.Values['cor_sel'] <> '' then
    pnlfmSubTituloRib.Color := StringToColor(layoutValue.Strings.Values['cor_sel']);
  if layoutValue.Strings.Values['cor_texto_sel'] <> '' then
    pnlfmSubTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_sel']);
end;

function TfmIndex.isFolderEmpty(szPath: string): Boolean;
var
  res: TSearchRec;
begin
  szPath := IncludeTrailingPathDelimiter(szPath);
  Result := (FindFirst(szPath + '*.*', faAnyFile - faDirectory, res) <> 0);
  FindClose(res);
end;

procedure TfmIndex.carregaBiblia(tipo: string);
var
  bus,busp:string;
  i:integer;
begin
  if (tipo = 'VER') then
  begin
    DM.qrBIBLIA_VERSAO.Close;
    DM.qrBIBLIA_VERSAO.Open;
    dblBibVersao.KeyValue := loadCol.Strings.Values['BIBLIA_VERSAO'];
  end
  else if (tipo = 'VER2') then
  begin
    DM.qrBIBLIA_VERSAO_2.Close;
    DM.qrBIBLIA_VERSAO_2.Open;
    dblBibVersao2.KeyValue := loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'];
  end
  else if (tipo = 'LIV') then
  begin
    DM.qrBIBLIA_LIVROS.Close;
    DM.qrBIBLIA_LIVROS.Open;
    DM.qrBIBLIA_LIVROS.Locate('ID',loadCol.Strings.Values['BIBLIA_LIVRO'],[]);
    busBibliaLivro.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_LIVRO'])-1;
  end
  else if (tipo = 'CAP') then
  begin
    DM.qrBIBLIA_CAPITULOS.Close;
    DM.qrBIBLIA_CAPITULOS.ParamByName('LIVRO').Value := StrToInt('0'+loadCol.Strings.Values['BIBLIA_LIVRO']);
    DM.qrBIBLIA_CAPITULOS.ParamByName('VERSAO').Value := loadCol.Strings.Values['BIBLIA_VERSAO'];
    DM.qrBIBLIA_CAPITULOS.Open;
    busBibliaCapitulo.Items.Clear;
    for i := 1 to DM.qrBIBLIA_LIVROS.FieldByName('CAPITULOS').AsInteger do
    begin
      busBibliaCapitulo.Items.Add(IntToStr(i));
    end;
    DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_CAPITULO'],[]);
    busBibliaCapitulo.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_CAPITULO'])-1;
  end
  else if (tipo = 'VSC') then
  begin
    DM.qrBIBLIA_VERSICULOS.Close;
    DM.qrBIBLIA_VERSICULOS.SQL.Clear;

    if (trim(busBibliaVersiculo.Text) <> '') then
    begin
      busp := geraIntervaloNum(GetStrNumber2(trim(busBibliaVersiculo.Text)));
      bus := termo_busca(trim(busBibliaVersiculo.Text));
      DM.qrBIBLIA_VERSICULOS.SQL.Add('SELECT ID, LIVRO, CAPITULO, VERSICULO, VERSICULO || " " AS VERSICULO_TXT, PASSAGEM || "" AS PASSAGEM, PASSAGEM AS PASSAGEM_ORI FROM BIBLIA');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('WHERE LIVRO = 0'+loadCol.Strings.Values['BIBLIA_LIVRO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND VERSAO = '''+loadCol.Strings.Values['BIBLIA_VERSAO']+'''');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND CAPITULO = 0'+loadCol.Strings.Values['BIBLIA_CAPITULO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND (VERSICULO IN (0'+busp+')');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('OR PASSAGEM LIKE ''%'+bus+'%'')');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('ORDER BY VERSICULO');
    end
    else
    begin
      DM.qrBIBLIA_VERSICULOS.SQL.Add('SELECT ID, LIVRO, CAPITULO, VERSICULO, VERSICULO || " " AS VERSICULO_TXT, PASSAGEM || "" AS PASSAGEM, PASSAGEM AS PASSAGEM_ORI FROM BIBLIA');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('WHERE LIVRO = 0'+loadCol.Strings.Values['BIBLIA_LIVRO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND VERSAO = '''+loadCol.Strings.Values['BIBLIA_VERSAO']+'''');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND CAPITULO = 0'+loadCol.Strings.Values['BIBLIA_CAPITULO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('ORDER BY VERSICULO');
    end;
    DM.qrBIBLIA_VERSICULOS.Open;
    corCampoBusca(DM.qrBIBLIA_VERSICULOS,busBibliaVersiculo,nil);

    if (not (DM.qrBIBLIA_LIVROS.Eof)) and (trim(loadCol.Strings.Values['BIBLIA_VERSICULO']) <> '') then
      DM.qrBIBLIA_VERSICULOS.Locate('VERSICULO',loadCol.Strings.Values['BIBLIA_VERSICULO'],[]);

  end
  else if (tipo = 'BUS') then
  begin
    DM.qrBIBLIA_BUSCA.Close;
    DM.qrBIBLIA_BUSCA.SQL.Clear;
    if (Trim(txtBibLocaliza.Text) <> '') then
    begin
      bus := termo_busca(trim(txtBibLocaliza.Text));
      DM.qrBIBLIA_BUSCA.SQL.Add('SELECT "" AS BRANCO,');
      DM.qrBIBLIA_BUSCA.SQL.Add('BIBLIA.VERSAO,BIBLIA.LIVRO,');
      DM.qrBIBLIA_BUSCA.SQL.Add('BIBLIA.CAPITULO,BIBLIA.VERSICULO,BIBLIA.PASSAGEM || "" AS PASSAGEM,');
      DM.qrBIBLIA_BUSCA.SQL.Add('" " || LIVRO.LIVRO || " " || BIBLIA.CAPITULO || ":" || BIBLIA.VERSICULO || " (" || BIBLIA.VERSAO || ")" AS DESC_PASSAGEM,');
      DM.qrBIBLIA_BUSCA.SQL.Add('LIVRO.LIVRO || " " || BIBLIA.CAPITULO || ":" || BIBLIA.VERSICULO || " (" || BIBLIA.VERSAO || ")" AS DESC_PASSAGEM2');
      DM.qrBIBLIA_BUSCA.SQL.Add('FROM BIBLIA,LIVRO');
      DM.qrBIBLIA_BUSCA.SQL.Add('WHERE BIBLIA.LIVRO = LIVRO.ID');
      DM.qrBIBLIA_BUSCA.SQL.Add('AND BIBLIA.VERSAO = '''+loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO']+'''');
      DM.qrBIBLIA_BUSCA.SQL.Add('AND BIBLIA.PASSAGEM LIKE ''%'+bus+'%''');
      DM.qrBIBLIA_BUSCA.SQL.Add('AND BIBLIA.LIVRO IN (0');
      for i := 0 to ckLivros.Items.Count-1 do
      begin
        if (ckLivros.Checked[i]) then
        begin
          DM.qrBIBLIA_BUSCA.SQL.Add(','+IntToStr(i+1));
        end;
      end;
      DM.qrBIBLIA_BUSCA.SQL.Add(')');
      DM.qrBIBLIA_BUSCA.SQL.Add('ORDER BY BIBLIA.LIVRO,BIBLIA.CAPITULO,BIBLIA.VERSICULO');

      DM.qrBIBLIA_BUSCA.Open;
    end;
  end;
end;

procedure TfmIndex.carregaComboFormatoTempo(combo: TComboBox {LAZARUS: TbsSkinComboBox};
  formato: string);
begin
  combo.ItemIndex := combo.Items.IndexOf(formato);
  if combo.ItemIndex < 0 then
  begin
    combo.Items.Add(formato);
    combo.ItemIndex := combo.Items.IndexOf(formato);
  end;
end;

procedure TfmIndex.carregaConfiguracoes(pagina: string);
begin
  carrega_opc := True;
  if (pagina = 'BIBLIA') then
  begin
    monitor_bt_label(btExp_Biblia);
    cbBibliaHistorico.Checked := (lerParam('Biblia', 'Historico', '1') = '1');
    fcBibliaFonte.Text := lerParam('Biblia', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seBibliaTamanho.Text := lerParam('Biblia', 'Tamanho', '7');
    seBibliaTamanho2.Text := lerParam('Biblia', 'Tamanho Passagem', '7');
    csBibliaCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Biblia', 'Cor', 'clWhite'));
    csBibliaCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Biblia', 'Cor Passagem', '$000066FF'));
    csBibliaCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Biblia', 'Cor Fundo', 'clBlack'));

    //cbBibliaAlinhamento.ItemIndex := strtoint(lerParam('Relogio', 'Alinhamento', '1'));

    lmdBibliaTxt.Font.Name := fcBibliaFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdBibliaTxt.Font.Height := Trunc((pnlBiblia.Height/100)*seBibliaTamanho.Value);
    lmdBibliaTxt.Font.Color := csBibliaCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    lmdBibliaInfo.Font.Name := fcBibliaFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdBibliaInfo.Font.Height := Trunc((pnlBiblia.Height/100)*seBibliaTamanho2.Value);
    lmdBibliaInfo.Font.Color := csBibliaCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    pnlBiblia.Color := csBibliaCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlBiblia.DoubleBuffered := True;
    if (loadCol.Strings.Values['BIBLIA_IMG'] <> lerParam('Biblia', 'Imagem Fundo', '')) then
    begin
      tsBibliaImagem.Text := lerParam('Biblia', 'Imagem Fundo', '');
      tsBibliaImagemInfo.Text := lerParam('Biblia', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['BIBLIA_IMG'] := tsBibliaImagem.Text;
      if (Trim(tsBibliaImagem.Text) <> '') and (FileExists(tsBibliaImagem.Text)) then
        imgBiblia.Picture.LoadFromFile(tsBibliaImagem.Text)
      else
        imgBiblia.Picture := nil;
      imgBiblia.Refresh;
      imgBiblia.Repaint;
      pnlBiblia.Refresh;
      pnlBiblia.Invalidate;
      pnlBiblia.Repaint;

      cbBibliaPosicaoFundo.ItemIndex := StrToInt(lerParam('Biblia', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgBiblia,pnlBiblia,cbBibliaPosicaoFundo.ItemIndex+1);
    end;
    ajustaTexto(pagina);
  end
  else if (pagina = 'BIBLIA_BUSCA') then
  begin
    monitor_bt_label(btExp_BibliaBusca);
    fcBibliabFonte.Text := lerParam('Busca Biblica', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seBibliabTamanho.Text := lerParam('Busca Biblica', 'Tamanho', '7');
    seBibliabTamanho2.Text := lerParam('Busca Biblica', 'Tamanho Passagem', '7');
    csBibliabCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Busca Biblica', 'Cor', 'clWhite'));
    csBibliabCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Busca Biblica', 'Cor Passagem', '$000066FF'));
    csBibliabCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Busca Biblica', 'Cor Fundo', 'clBlack'));

    //cbBibliabAlinhamento.ItemIndex := strtoint(lerParam('Relogio', 'Alinhamento', '1'));

		lmdBibliaBuscaTxt.Font.Name := fcBibliabFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdBibliaBuscaTxt.Font.Height := Trunc((pnlBibliaBusca.Height/100)*seBibliabTamanho.Value);
    lmdBibliaBuscaTxt.Font.Color := csBibliabCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    lmdBibliaBuscaInfo.Font.Name := fcBibliabFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdBibliaBuscaInfo.Font.Height := Trunc((pnlBibliaBusca.Height/100)*seBibliabTamanho2.Value);
    lmdBibliaBuscaInfo.Font.Color := csBibliabCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    pnlBibliaBusca.Color := csBibliabCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlBibliaBusca.DoubleBuffered := True;
    if (loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] <> lerParam('Busca Biblica', 'Imagem Fundo', '')) then
    begin
      tsBibliabImagem.Text := lerParam('Busca Biblica', 'Imagem Fundo', '');
      tsBibliabImagemInfo.Text := lerParam('Busca Biblica', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] := tsBibliabImagem.Text;
      if (Trim(tsBibliabImagem.Text) <> '') and (FileExists(tsBibliabImagem.Text)) then
        imgBibliaBusca.Picture.LoadFromFile(tsBibliabImagem.Text)
      else
        imgBibliaBusca.Picture := nil;
      imgBibliaBusca.Refresh;
      imgBibliaBusca.Repaint;
      pnlBibliaBusca.Refresh;
      pnlBibliaBusca.Invalidate;
      pnlBibliaBusca.Repaint;

      cbBibliabPosicaoFundo.ItemIndex := StrToInt(lerParam('Busca Biblica', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgBibliaBusca,pnlBibliaBusca,cbBibliabPosicaoFundo.ItemIndex+1);
    end;
    ajustaTexto(pagina);
  end
  else if (pagina = 'ES') then
  begin
    monitor_bt_label(btExp_EscolaSabatina);
    fcEscsbFonte.Text := lerParam('Escola Sabatina', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seEscsbTamanho.Value := StrToFloat(lerParam('Escola Sabatina', 'Tamanho', '30'));
    csEscsbCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Escola Sabatina', 'Cor', 'clBlack'));
    seEscsbTamanho2.Value := StrToFloat(lerParam('Escola Sabatina', 'Tamanho 2', '20'));
    csEscsbCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Escola Sabatina', 'Cor 2', 'clBlue'));
    csEscsbCor3.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Escola Sabatina', 'Cor 3', 'clRed'));
    csEscsbCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Escola Sabatina', 'Cor Fundo', 'clWhite'));

    lmdEscSb.Top := 0;
    lmdEscSb.Left := 0;
    lmdEscSb.Width := pnlEscSB.Width;
    lmdEscSb.Height := round(pnlEscSB.Height / 2);
    lmdEscSbR.Top := round(pnlEscSB.Height / 2);
    lmdEscSbR.Left := 0;
    lmdEscSbR.Width := pnlEscSB.Width;
    lmdEscSbR.Height := round(pnlEscSB.Height / 2);


    lmdEscSb.Font.Name := fcEscsbFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdEscSb.Font.Height := Trunc((pnlEscSB.Height/100)*seEscsbTamanho.Value);
    lmdEscSb.Font.Color := csEscsbCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    lmdEscSbR.Font.Name := fcEscsbFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdEscSbR.Font.Height := Trunc((pnlEscSB.Height/100)*seEscsbTamanho2.Value);
    lmdEscSbR.Font.Color := csEscsbCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    pnlEscSB.Color := csEscsbCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    carregaComboFormatoTempo(cbFormatoHoraES,lerParam('Escola Sabatina', 'FormatoHora', 'hh:mm:ss'));
    carregaComboFormatoTempo(cbFormatoTempoES,lerParam('Escola Sabatina', 'FormatoTempo', 'hh:mm:ss'));

    //selMusica();
    opcCronoCTempo.ItemIndex := StrToInt(lerParam('Escola Sabatina', 'TempoFim', '0'));
    meESHora.text := lerParam('Escola Sabatina', 'Hora', '10:00');
    meESDuracao.Value := StrToInt(lerParam('Escola Sabatina', 'Duracao', '40'));
    opcCronoCTempoClick(nil);

    cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[0] := (lerParam('Escola Sabatina', 'Abertura', '1') = '1');
    cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[1] := (lerParam('Escola Sabatina', '5 min.', '1') = '1');
    cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[2] := (lerParam('Escola Sabatina', '1 min.', '1') = '1');

    cbEscSBRelogioFunc.Checked := (lerParam('Escola Sabatina', 'RelogioSempreAtivo', '1') = '1');
    cbEscSBZerarTempo.Checked := (lerParam('Escola Sabatina', 'DesligarZerarTempo', '1') = '1');

    pnlEscSB.DoubleBuffered := True;
    if (loadCol.Strings.Values['ES_IMG'] <> lerParam('Escola Sabatina', 'Imagem Fundo', '')) then
    begin
      tsEscSBImagem.Text := lerParam('Escola Sabatina', 'Imagem Fundo', '');
      tsEscSBImagemInfo.Text := lerParam('Escola Sabatina', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['ES_IMG'] := tsEscSBImagem.Text;
      if (Trim(tsEscSBImagem.Text) <> '') and (FileExists(tsEscSBImagem.Text)) then
        imgEscSB.Picture.LoadFromFile(tsEscSBImagem.Text)
      else
        imgEscSB.Picture := nil;
      imgEscSB.Refresh;
      imgEscSB.Repaint;
      pnlEscSB.Refresh;
      pnlEscSB.Invalidate;
      pnlEscSB.Repaint;

      cbEscSBPosicaoFundo.ItemIndex := StrToInt(lerParam('Escola Sabatina', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgEscSB,pnlEscSB,cbEscSBPosicaoFundo.ItemIndex+1);
    end;
  end
  else if (pagina = 'SORTEIO') then
  begin
    monitor_bt_label(btExp_Sorteio);
    seSorteioTempo.Value := StrToFloat(lerParam('Sorteio', 'TempoAnimacao','1.0'));

    fcSorteioFonte.Text := lerParam('Sorteio', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seSorteioTamanho.Value := StrToFloat(lerParam('Sorteio', 'Tamanho', '35'));
    csSorteioCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Sorteio', 'Cor', 'clBlack'));
    csSorteioCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Sorteio', 'Cor Fundo', 'clWhite'));

    cbSorteioAlinhamento.ItemIndex := strtoint(lerParam('Sorteio', 'Alinhamento', '1'));
    if cbSorteioAlinhamento.ItemIndex = 0 then
    begin
      lmdSorteio.Align := alTop;
      lmdSorteio.Height := Trunc(pnlSorteio.Height/2);
    end
    else
    if cbSorteioAlinhamento.ItemIndex = 1 then
    begin
      lmdSorteio.Align := alClient;
      lmdSorteio.Height := Trunc(pnlSorteio.Height);
    end
    else
    if cbSorteioAlinhamento.ItemIndex = 2 then
    begin
      lmdSorteio.Align := alBottom;
      lmdSorteio.Height := Trunc(pnlSorteio.Height/2);
    end;


    lmdSorteio.Font.Name := fcSorteioFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdSorteio.Font.Height := Trunc((pnlSorteio.Height/100)*seSorteioTamanho.Value);
    lmdSorteio.Font.Color := csSorteioCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlSorteio.Color := csSorteioCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    ckSorteioExp.Checked {LAZARUS: ItemChecked->Checked}[0] := (lerParam('Sorteio', 'Numeros Sorteio (Extendido)', '1') = '1');
    ckSorteioExp.Checked {LAZARUS: ItemChecked->Checked}[1] := (lerParam('Sorteio', 'Numeros Sorteados (Extendido)', '1') = '1');

    pnlSorteio.DoubleBuffered := True;
    if (loadCol.Strings.Values['SORTEIO_IMG'] <> lerParam('Sorteio', 'Imagem Fundo', '')) then
    begin
      tsSorteioImagem.Text := lerParam('Sorteio', 'Imagem Fundo', '');
      tsSorteioImagemInfo.Text := lerParam('Sorteio', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['SORTEIO_IMG'] := tsSorteioImagem.Text;
      if (Trim(tsSorteioImagem.Text) <> '') and (FileExists(tsSorteioImagem.Text)) then
        imgSorteio.Picture.LoadFromFile(tsSorteioImagem.Text)
      else
        imgSorteio.Picture := nil;
      imgSorteio.Refresh;
      imgSorteio.Repaint;
      pnlSorteio.Refresh;
      pnlSorteio.Invalidate;
      pnlSorteio.Repaint;

      cbSorteioPosicaoFundo.ItemIndex := StrToInt(lerParam('Sorteio', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgSorteio,pnlSorteio,cbSorteioPosicaoFundo.ItemIndex+1);
    end;
    DM.tmrSorteio.Enabled := true;
  end
  else if (pagina = 'SORTEIO_NOMES') then
  begin
    monitor_bt_label(btExp_SorteioNM);
    seSorteioTempoNM.Value := StrToFloat(lerParam('Sorteio Nomes', 'TempoAnimacao','1.0'));

    fcSorteioFonteNM.Text := lerParam('Sorteio Nomes', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seSorteioTamanhoNM.Value := StrToFloat(lerParam('Sorteio Nomes', 'Tamanho', '15'));
    csSorteioCorNM.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Sorteio Nomes', 'Cor', 'clBlack'));
    csSorteioCorFundoNM.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Sorteio Nomes', 'Cor Fundo', 'clWhite'));

    cbSorteioNMAlinhamento.ItemIndex := strtoint(lerParam('Sorteio Nomes', 'Alinhamento', '1'));
    if cbSorteioNMAlinhamento.ItemIndex = 0 then
    begin
      lmdSorteioNM.Align := alTop;
      lmdSorteioNM.Height := Trunc(pnlSorteioNM.Height/2);
    end
    else
    if cbSorteioNMAlinhamento.ItemIndex = 1 then
    begin
      lmdSorteioNM.Align := alClient;
      lmdSorteioNM.Height := Trunc(pnlSorteioNM.Height);
    end
    else
    if cbSorteioNMAlinhamento.ItemIndex = 2 then
    begin
      lmdSorteioNM.Align := alBottom;
      lmdSorteioNM.Height := Trunc(pnlSorteioNM.Height/2);
    end;

    lmdSorteioNM.Font.Name := fcSorteioFonteNM.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdSorteioNM.Font.Height := Trunc((pnlSorteioNM.Height/100)*seSorteioTamanhoNM.Value);
    lmdSorteioNM.Font.Color := csSorteioCorNM.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlSorteioNM.Color := csSorteioCorFundoNM.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    ckSorteioExpNM.Checked {LAZARUS: ItemChecked->Checked}[0] := (lerParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '1') = '1');
    ckSorteioExpNM.Checked {LAZARUS: ItemChecked->Checked}[1] := (lerParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '1') = '1');

    pnlSorteioNM.DoubleBuffered := True;
    if (loadCol.Strings.Values['SORTEIO_NOMES_IMG'] <> lerParam('Sorteio', 'Imagem Fundo', '')) then
    begin
      tsSorteioNMImagem.Text := lerParam('Sorteio Nomes', 'Imagem Fundo', '');
      tsSorteioNMImagemInfo.Text := lerParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['SORTEIO_NOMES_IMG'] := tsSorteioNMImagem.Text;

      if (Trim(tsSorteioNMImagem.Text) <> '') and (FileExists(tsSorteioNMImagem.Text)) then
        imgSorteioNM.Picture.LoadFromFile(tsSorteioNMImagem.Text)
      else
        imgSorteioNM.Picture := nil;
      imgSorteioNM.Refresh;
      imgSorteioNM.Repaint;
      pnlSorteioNM.Refresh;
      pnlSorteioNM.Invalidate;
      pnlSorteioNM.Repaint;

      cbSorteioNMPosicaoFundo.ItemIndex := StrToInt(lerParam('Sorteio Nomes', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgSorteioNM,pnlSorteioNM,cbSorteioNMPosicaoFundo.ItemIndex+1);
    end;

    DM.tmrSorteio.Enabled := true;
  end
  else if (pagina = 'CRONO') then
  begin
    monitor_bt_label(btExp_Cronometro);
    fcCronoFonte.Text := lerParam('Cronometro', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seCronoTamanho.Value := StrToFloat(lerParam('Cronometro', 'Tamanho', '22'));

    cbCronometroAlinhamento.ItemIndex := strtoint(lerParam('Cronometro', 'Alinhamento', '1'));
    if cbCronometroAlinhamento.ItemIndex = 0 then
    begin
      lmdCrono.Align := alTop;
      lmdCrono.Height := Trunc(pnlCrono.Height/2);
    end
    else
    if cbCronometroAlinhamento.ItemIndex = 1 then
    begin
      lmdCrono.Align := alClient;
      lmdCrono.Height := Trunc(pnlCrono.Height);
    end
    else
    if cbCronometroAlinhamento.ItemIndex = 2 then
    begin
      lmdCrono.Align := alBottom;
      lmdCrono.Height := Trunc(pnlCrono.Height/2);
    end;

    csCronoCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Cronometro', 'Cor', 'clBlack'));
    csCronoCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Cronometro', 'Cor Fundo', 'clWhite'));
    cbCronoEl.Checked {LAZARUS: ItemChecked->Checked}[0] := (lerParam('Cronometro', 'Tempos Gravados (Extendido)', '1') = '1');

    carregaComboFormatoTempo(cbFormatoTempoCrono,lerParam('Cronometro', 'FormatoTempo', 'hh:mm:ss.zzz'));
    txtDecr.Text := lerParam('Cronometro', 'Tempo Decrescente', '00:01:00');

    lmdCrono.Font.Name := fcCronoFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdCrono.Font.Height := Trunc((pnlCrono.Height/100)*seCronoTamanho.Value);
    lmdCrono.Font.Color := csCronoCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlCrono.Color := csCronoCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    pnlCrono.DoubleBuffered := True;
    if (loadCol.Strings.Values['CRONO_IMG'] <> lerParam('Cronometro', 'Imagem Fundo', '')) then
    begin
      tsCronoImagem.Text := lerParam('Cronometro', 'Imagem Fundo', '');
      tsCronoImagemInfo.Text := lerParam('Cronometro', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['CRONO_IMG'] := tsCronoImagem.Text;
      if (Trim(tsCronoImagem.Text) <> '') and (FileExists(tsCronoImagem.Text)) then
        imgCrono.Picture.LoadFromFile(tsCronoImagem.Text)
      else
        imgCrono.Picture := nil;
      imgCrono.Refresh;
      imgCrono.Repaint;
      pnlCrono.Refresh;
      pnlCrono.Invalidate;
      pnlCrono.Repaint;

      cbCronoPosicaoFundo.ItemIndex := StrToInt(lerParam('Cronometro', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgCrono,pnlCrono,cbCronoPosicaoFundo.ItemIndex+1);
    end;

    rbDirecao.ItemIndex := StrToInt(lerParam('Cronometro', 'Direcao', '0'));
    rbDirecaoClick(nil);
  end
  else if (pagina = 'PAINELD') then
  begin
    monitor_bt_label(btExp_PainelD);
    fcPainelDFonte.Text := lerParam('Painel Dinamico', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    sePainelDTamanho.Value := StrToFloat(lerParam('Painel Dinamico', 'Tamanho', '15'));

    cbPainelDAlinhamento.ItemIndex := strtoint(lerParam('Painel Dinamico', 'Alinhamento', '1'));
    if cbPainelDAlinhamento.ItemIndex = 0 then
    begin
      lmdTxtPainelD.Align := alTop;
      lmdTxtPainelD.Height := Trunc(pnlTxtPainelD.Height/2);
    end
    else
    if cbPainelDAlinhamento.ItemIndex = 1 then
    begin
      lmdTxtPainelD.Align := alClient;
      lmdTxtPainelD.Height := Trunc(pnlTxtPainelD.Height);
    end
    else
    if cbPainelDAlinhamento.ItemIndex = 2 then
    begin
      lmdTxtPainelD.Align := alBottom;
      lmdTxtPainelD.Height := Trunc(pnlTxtPainelD.Height/2);
    end;


    csPainelDCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Painel Dinamico', 'Cor', 'clBlack'));
    csPainelDCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Painel Dinamico', 'Cor Fundo', 'clWhite'));

    lmdTxtPainelD.Font.Name := fcPainelDFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdTxtPainelD.Font.Height := Trunc((pnlTxtPainelD.Height/100)*sePainelDTamanho.Value);
    lmdTxtPainelD.Font.Color := csPainelDCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlTxtPainelD.Color := csPainelDCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    pnlTxtPainelD.DoubleBuffered := True;
    if (loadCol.Strings.Values['PAINELD_IMG'] <> lerParam('Painel Dinamico', 'Imagem Fundo', '')) then
    begin
      tsTxtPainelDImagem.Text := lerParam('Painel Dinamico', 'Imagem Fundo', '');
      tsTxtPainelDImagemInfo.Text := lerParam('Painel Dinamico', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['PAINELD_IMG'] := tsTxtPainelDImagem.Text;
      if (Trim(tsTxtPainelDImagem.Text) <> '') and (FileExists(tsTxtPainelDImagem.Text)) then
        imgTxtPainelD.Picture.LoadFromFile(tsTxtPainelDImagem.Text)
      else
        imgTxtPainelD.Picture := nil;
      imgTxtPainelD.Refresh;
      imgTxtPainelD.Repaint;
      pnlTxtPainelD.Refresh;
      pnlTxtPainelD.Invalidate;
      pnlTxtPainelD.Repaint;

      cbTxtPainelDPosicaoFundo.ItemIndex := StrToInt(lerParam('Painel Dinamico', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgTxtPainelD,pnlTxtPainelD,cbTxtPainelDPosicaoFundo.ItemIndex+1);
    end;
  end
  else if (pagina = 'TEXTOI') then
  begin
    monitor_bt_label(btExp_TextoInterativo);
  end
  else if (pagina = 'RELOGIO') then
  begin
    monitor_bt_label(btExp_Relogio);
    fcRelogioFonte.Text := lerParam('Relogio', 'Fonte', fonte); {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seRelogioTamanho.Value := StrToFloat(lerParam('Relogio', 'Tamanho', '30'));

    cbRelogioAlinhamento.ItemIndex := strtoint(lerParam('Relogio', 'Alinhamento', '1'));
    if cbRelogioAlinhamento.ItemIndex = 0 then
    begin
      lmdRelogio.Align := alTop;
      lmdRelogio.Height := Trunc(pnlRelogio.Height/2);
    end
    else
    if cbRelogioAlinhamento.ItemIndex = 1 then
    begin
      lmdRelogio.Align := alClient;
      lmdRelogio.Height := Trunc(pnlRelogio.Height);
    end
    else
    if cbRelogioAlinhamento.ItemIndex = 2 then
    begin
      lmdRelogio.Align := alBottom;
      lmdRelogio.Height := Trunc(pnlRelogio.Height/2);
    end;

    csRelogioCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Relogio', 'Cor', 'clBlack'));
    csRelogioCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(lerParam('Relogio', 'Cor Fundo', 'clWhite'));

    lmdRelogio.Font.Name := fcRelogioFonte.Text {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text};
    lmdRelogio.Font.Height := Trunc((pnlRelogio.Height/100)*seRelogioTamanho.Value);
    lmdRelogio.Font.Color := csRelogioCor.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    pnlRelogio.Color := csRelogioCorFundo.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    carregaComboFormatoTempo(cbFormatoHora,lerParam('Relogio', 'FormatoHora', 'hh:mm:ss'));

    pnlRelogio.DoubleBuffered := True;
    if (loadCol.Strings.Values['RELOGIO_IMG'] <> lerParam('Relogio', 'Imagem Fundo', '')) then
    begin
      tsRelogioImagem.Text := lerParam('Relogio', 'Imagem Fundo', '');
      tsRelogioImagemInfo.Text := lerParam('Relogio', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['RELOGIO_IMG'] := tsRelogioImagem.Text;
      if (Trim(tsRelogioImagem.Text) <> '') and (FileExists(tsRelogioImagem.Text)) then
        imgRelogio.Picture.LoadFromFile(tsRelogioImagem.Text)
      else
        imgRelogio.Picture := nil;
      imgRelogio.Refresh;
      imgRelogio.Repaint;
      pnlRelogio.Refresh;
      pnlRelogio.Invalidate;
      pnlRelogio.Repaint;

      cbRelogioPosicaoFundo.ItemIndex := StrToInt(lerParam('Relogio', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgRelogio,pnlRelogio,cbRelogioPosicaoFundo.ItemIndex+1);
    end;
  end
  else if (pagina = 'SLIDESD') then
  begin
    //
  end
  else
    application.MessageBox(PChar('Não localizado parâmetro ''' + pagina + ''' para a função ''carregaConfiguracoes''!'), titulo, mb_ok + mb_iconerror);

  copiaDadosTelaExtendida;
  carrega_opc := False;
end;

procedure TfmIndex.carregaFavoritos();
var
  item: TListItem {LAZARUS: TbsSkinOfficeGalleryItem};
  itemMenu: TMenuItem;
  i: integer;
begin
  if not DM.cdsFavoritos.Active then
  begin
    DM.cdsFavoritos.CreateDataSet;
    DM.cdsFavoritos.IndexName := '';
    DM.cdsFavoritos.IndexFieldNames := 'ORDEM';
    {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsFavoritos.LogChanges := False;)}

    if (FileExists(dir_dados + 'favoritos.xml')) then
      DM.cdsFavoritos.LoadFromFile(dir_dados + 'favoritos.xml');
    DM.cdsFavoritos.Open;
  end;

  carrega_opc := True;
  {LAZARUS: TListView.ItemIndex := 0 crasha quando Items.Count=0}
  if ogFavoritos.Items.Count > 0 then
    ogFavoritos.ItemIndex := 0;
  carrega_opc := False;

  ogFavoritos.Items.Clear;
  for i := bsPopupMenuFavoritos.Items.Count-5 downto 0 do
    bsPopupMenuFavoritos.Items.Delete(i);


  i := DM.cdsFavoritos.RecordCount;
  DM.cdsFavoritos.First;
  while not DM.cdsFavoritos.Eof do
  begin
    item := ogFavoritos.Items.Add;
    item.Caption := DM.cdsFavoritos.FieldByName('NOME').AsString;
    item.ImageIndex := DM.cdsFavoritos.FieldByName('IMAGEM').AsInteger;

    itemMenu := TMenuItem.Create(bsPopupMenuFavoritos);
    itemMenu.Caption := item.Caption;
    itemMenu.ImageIndex := item.ImageIndex;
    itemMenu.OnClick := mnAbreFavoritoClick;
    itemMenu.Tag := ogFavoritos.Items.Count-1;
    itemMenu.Checked := false;
    itemMenu.RadioItem := True;

    if (PageControl1.Visible = true) and (DM.cdsFavoritos.FieldByName('NOME_ABA').AsString = PageControl1.ActivePage.Name) then
    begin
      i := ogFavoritos.Items.Count-1;
      itemMenu.Checked := True;
    end;

    bsPopupMenuFavoritos.Items.Insert(bsPopupMenuFavoritos.Items.Count - 4, itemMenu);
    DM.cdsFavoritos.Next;
  end;

  {LAZARUS: TListView.ItemIndex só pode ser definido quando i < Items.Count}
  if (i >= 0) and (i < ogFavoritos.Items.Count) then
    ogFavoritos.ItemIndex := i;
end;

procedure TfmIndex.carregaItemLiturgia(item: string; ordem: integer);
var
  i: integer;
  tipo,subtipo: string;
  panel,panel2: TPanel;
  image: TImage {LAZARUS: TbsPngImageView};
  checkbox: TCheckBox {LAZARUS: TbsSkinCheckBox};
  slabel: TLabel {LAZARUS: TbsSkinStdLabel};
  pb: Boolean;
begin
  tipo := lerParam(item, 'tipo', '', arq_liturgia);
  subtipo := lerParam(item, 'subtipo', '', arq_liturgia);

  panel := TPanel(FindComponent(item));
  if Assigned(Panel) then
  begin
    for i := pred(panel.ControlCount) downto 0 do
    begin
      try
        if (panel.Controls[i].Visible) and (panel.Controls[i].Tag <> 9999)
          then panel.Controls[i].Destroy;
      except
        //
      end;
    end;
  end
  else
  begin
    panel := TPanel(CopyComponent(lit_modItem,sbLiturgia,item));
    panel.OnClick := lit_modItem.OnClick;

    panel2 := TPanel(CopyComponent(lit_modItem_btmove,panel,item+'_btmove'));
    panel2.OnMouseDown := lit_modItem_btmove.OnMouseDown;
    panel2.OnMouseMove := lit_modItem_btmove.OnMouseMove;
    panel2.OnMouseUp := lit_modItem_btmove.OnMouseUp;
    panel2.Visible := not cbBloqItens.Checked;
    image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_btmove_img,panel2,item+'_btmove_img'));
    image.OnMouseDown := lit_modItem_btmove_img.OnMouseDown;
    image.OnMouseMove := lit_modItem_btmove_img.OnMouseMove;
    image.OnMouseUp := lit_modItem_btmove_img.OnMouseUp;
    image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_btedit,panel,item+'_btedit'));
    image.OnClick := lit_modItem_btedit.OnClick;
    image.Visible := not cbBloqItens.Checked;
    CopyComponent(lit_modItem_divider,panel,item+'_divider');
  end;

  if (tipo <> 'categoria') then
  begin
    panel2 := TPanel(CopyComponent(lit_modItem_bticon,panel,item+'_bticon'));
    panel2.OnClick := lit_modItem_bticon.OnClick;
    panel2.Color := StringToColor(lerParam(item, 'cor', '$004F0000', arq_liturgia));
    image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_bticon_img,panel2,item+'_bticon_img'));
    image.OnClick := lit_modItem_bticon_img.OnClick;
    panel2 := TPanel(CopyComponent(lit_modItem_texto,panel,item+'_texto'));
    panel2.OnClick := lit_modItem_texto.OnClick;
    slabel := TLabel {LAZARUS: TbsSkinStdLabel}(CopyComponent(lit_modItem_subtitulo,panel2,item+'_subtitulo'));
    slabel.OnClick := lit_modItem_subtitulo.OnClick;
    if (tipo = 'itensagendados') then
    begin
      slabel.Caption := '';
      if not DM.cdsItensAgendados.Active then
      begin
        DM.cdsItensAgendados.CreateDataSet;
        DM.cdsItensAgendados.IndexName := '';
        DM.cdsItensAgendados.IndexFieldNames := 'DATA';
        {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsItensAgendados.LogChanges := False;)}
      end;

      if (FileExists(dir_dados + 'itensAgendados.xml')) then
        DM.cdsItensAgendados.LoadFromFile(dir_dados + 'itensAgendados.xml');
      DM.cdsItensAgendados.Open;

      DM.cdsItensAgendados.Filtered := false;
      if (DM.cdsItensAgendados.Locate('CATEGORIA;DATA', VarArrayOf([lerParam(item, 'id', '', arq_liturgia),IncDay(now(),strtoint(loadCol.Strings.Values['LITURGIA:SEMANA']) - dayofweek(now()))]), []))
        then slabel.Caption := 'Arquivo '+DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString
        else slabel.Caption := 'Não há arquivo agendado para esta data!';
    end
    else slabel.Caption := lerParam(item, 'subitem', '', arq_liturgia);
    slabel := TLabel {LAZARUS: TbsSkinStdLabel}(CopyComponent(lit_modItem_titulo,panel2,item+'_titulo'));
    slabel.OnClick := lit_modItem_titulo.OnClick;
    slabel.Caption := lerParam(item, 'item', '', arq_liturgia);
    slabel.Align := alTop;
    checkbox := TCheckBox {LAZARUS: TbsSkinCheckBox}(CopyComponent(lit_modItem_checkb,panel,item+'_checkb'));
    checkbox.OnClick := lit_modItem_checkb.OnClick;
    checkbox.Checked := (lerParam(item, 'checked', '', arq_liturgia) = FormatDateTime('dd/mm/yyyy',Now()));
    {LAZARUS: panel.AlignWithMargins := false — LCL nao tem AlignWithMargins}
    panel.Height := 56;
  end
  else
  begin
    panel2 := TPanel(CopyComponent(lit_modItem_bticon,panel,item+'_bticon'));
    panel2.OnClick := PanelColorClick;
    panel2.Color := StringToColor(lerParam(item, 'cor', '$004F0000', arq_liturgia));
    panel2.Align := alClient;
//    panel.Color := StringToColor(lerParam(item, 'cor', '$004F0000', arq_liturgia));
    panel.Height := 36;
    {LAZARUS: panel.AlignWithMargins := True — LCL nao tem AlignWithMargins}
    {LAZARUS: panel.Margins.Top := 20 — LCL usa BorderSpacing}
    {LAZARUS: panel.Margins.Left := 0 — LCL usa BorderSpacing}
    {LAZARUS: panel.Margins.Right := 0 — LCL usa BorderSpacing}
    {LAZARUS: panel.Margins.Bottom := 0 — LCL usa BorderSpacing}
    //panel3 := TPanel(CopyComponent(lit_modItem_texto,panel2,item+'_texto'));
    //panel3.OnClick := lit_modItem_texto.OnClick;
    slabel := TLabel {LAZARUS: TbsSkinStdLabel}(CopyComponent(lit_modItem_titulo,panel2,item+'_titulo'));
    slabel.Align := alClient;
    {LAZARUS: slabel.UseSkinColor := false — bsSkin property removida}
    slabel.Font.Color := clWhite;
//    slabel.OnClick := lit_modItem_titulo.OnClick;
    slabel.Caption := lerParam(item, 'item', '', arq_liturgia);
    slabel.Font.Color := clWhite;
    slabel.Align := alClient;
    slabel.Alignment := taCenter;
    slabel.Layout := tlCenter;
  end;

  if (pnlModDes.Visible)
    then slabel.Caption := slabel.Caption + ' | ' + item + ' ['+inttostr(ordem)+']';

  if (tipo = 'musica') then
  begin
    if (subtipo = 'hasd')
      then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 47
    else if (subtipo = 'ja')
      then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 46
    else if (subtipo = 'div')
      then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 45
    else TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 60;

    if lerParam(item, 'musica', '0', arq_liturgia) = '-1'
      then pb := true
    else
    begin
      DM.qrMUSICA.Close;
      DM.qrMUSICA.ParamByName('ID').Value := StrToInt('0'+lerParam(item, 'musica', '0', arq_liturgia));
      DM.qrMUSICA.Open;
      if DM.qrMUSICA.RecordCount <= 0
        then pb := true
      else if (DM.qrMUSICA.FieldByName('URL_INSTRUMENTAL').AsString <> '')
        then pb := True
        else pb := False;
    end;

    image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_icomus1,panel,item+'_icomus1'));
    image.OnClick := lit_modItem_icomus1.OnClick;
    if pb then
    begin
      image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_icomus2,panel,item+'_icomus2'));
      image.OnClick := lit_modItem_icomus2.OnClick;
    end;
    image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_icomus3,panel,item+'_icomus3'));
    image.OnClick := lit_modItem_icomus3.OnClick;
    image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_icomus4,panel,item+'_icomus4'));
    image.OnClick := lit_modItem_icomus4.OnClick;
    if pb then
    begin
      image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_icomus5,panel,item+'_icomus5'));
      image.OnClick := lit_modItem_icomus5.OnClick;
    end;
    image := TImage {LAZARUS: TbsPngImageView}(CopyComponent(lit_modItem_icomus6,panel,item+'_icomus6'));
    image.OnClick := lit_modItem_icomus6.OnClick;
    TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_icomus6')).Left := 0;
    if pb then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_icomus5')).Left := 0;
    TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_icomus4')).Left := 0;
    TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_icomus3')).Left := 0;
    if pb then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_icomus2')).Left := 0;
    TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_icomus1')).Left := 0;
  end
  else if (tipo = 'site') then
  begin
    subtipo := lerParam(item, 'subitem', '', arq_liturgia);
    if  (Pos('.youtube.',subtipo) > 0)
     or (Pos('/youtube.',subtipo) > 0)
     or (Pos('.youtu.be.',subtipo) > 0)
     or (Pos('/youtu.be.',subtipo) > 0)
      then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 38
      else TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 49;
  end
  else
  if (tipo = 'arquivo') then
  begin
    if (subtipo = 'dir')
      then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 32
    else if (subtipo = 'arq')
      then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 4;
  end
  else
  if (tipo = 'anotacao')
    then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 63
  else
  if (tipo = 'itensagendados')
    then TImage {LAZARUS: TbsPngImageView}(FindComponent(item+'_bticon_img')).ImageIndex := 83;

  if (ordem > 0) then
    panel.Top := (panel.Height + 20) * (ordem + 3);

  panel.Visible := True;
end;

procedure TfmIndex.carregaLiturgia(semana: Integer);
var
  itens: TStringList;
  i: integer;
begin
  garanteUtf8Liturgia;
  itens := TStringList.Create;
  itens.Delimiter := ';';
  itens.DelimitedText := lerParam('Geral', IntToStr(semana), '', arq_liturgia);

  lbLiturgia.Items.Clear;
  lbLiturgia.Items := itens;

  for i := pred(sbLiturgia.ControlCount) downto 0 do
  begin
    if sbLiturgia.Controls[i].Visible
      then sbLiturgia.Controls[i].Destroy;
  end;

  if (lbLiturgia.Items.Count > 0) and
    (trim(lbLiturgia.Items[lbLiturgia.Items.Count-1]) = '')
    then lbLiturgia.Items.Delete(lbLiturgia.Items.Count-1);

  for i := 0 to lbLiturgia.Items.Count-1 do
  begin
    carregaItemLiturgia(lbLiturgia.Items[i],i+1);
    Application.ProcessMessages; {LAZARUS: mantém UI responsiva durante carregamento}
  end;
end;

function TfmIndex.IsNumeric(S: string): boolean;
var
  i: integer;
begin
  Result := TryStrToInt(S, i);
end;

procedure TfmIndex.btRestaurarCapaProgramaClick(Sender: TObject);
begin
  if (application.MessageBox(PChar('Deseja restaurar a imagem de fundo?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  pnlImagemCapa.Color := pnlImagemCapaModel.Color;
  corCapaPrograma.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := pnlImagemCapa.Color;
  apagaParam('Config', 'Cor Fundo');

  cbAlinhamentoCapaPrograma.ItemIndex := 0;
  imgImagemCapa.Stretch := (cbAlinhamentoCapaPrograma.ItemIndex = 1);
  apagaParam('Config', 'Alinhamento Imagem Fundo');

  imgImagemCapa.Picture := imgImagemCapaModel.Picture;
  imgCapaPrograma.Text := '';
  txtImgCapaProgramaInfo.Text := '';
  apagaParam('Config', 'Imagem Fundo');
  apagaParam('Config', 'Imagem Fundo Info');
end;

function TfmIndex.verVersao():Boolean;
var
  versao_atu: TStringList;
  versao_new: TStringList;
  param_versao: String;
  lista: TStringList;
  Flags: Cardinal;
begin
  DM.qrVERSAO.Close;
  DM.qrVERSAO.Open;

  versao_atu := TStringList.Create;
  versao_atu.Delimiter := '.';
  versao_atu.DelimitedText := VersaoExe;

  lblVersao.Caption := versao_atu[0] + '.' + versao_atu[1] + '.' + DM.qrVERSAO.fieldbyname('VERSAO_BD').AsString;
  spVersao.Text {LAZARUS: TStatusPanel.Caption→.Text} := 'versão '+lblVersao.Caption+' ';

  if (DM.qrVERSAO.fieldbyname('VERSAO_BD').AsInteger < VERSAO_MIN_BD) then
  begin
    Result := false;

    if (application.messagebox(PChar(fIniciando.Translate('Esta versão do sistema exige o banco de dados mais recente! Deseja se conectar para fazer o download do banco de dados?')), TITULO, MB_yesno + mb_iconquestion) <> 6) then
    begin
      application.terminate;
      DM.tmrSair.enabled := true;
      Exit;
    end
    else
    begin
      if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
      begin
        application.messagebox(PChar(fIniciando.Translate('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.')), TITULO, MB_OK + mb_iconerror);
        DM.tmrSair.enabled := true;
        application.terminate;
        Exit;
      end;

      lista := TStringList.Create;
      {LAZARUS: FTP tem pt_database.db/es_database.db — ftp_baixa renomeia para database.db localmente}
      lista.Add('config\' + fIniciando.LANG + '_database.db');

      fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
      fAtualiza.arquivos := lista;
      fAtualiza.ShowModal;

      if not FileExists(dir_config + 'database.db') then
      begin
        application.messagebox(PChar(fIniciando.Translate('Não foi possível baixar o Banco de Dados da internet. Favor, instale seu programa novamente!')), TITULO, MB_ok + mb_iconerror);
        DM.tmrSair.enabled := true;
        application.terminate;
        Exit;
      end;
    end;

    {LAZARUS: RunCommand(Application.ExeName, [], _out_) — ShellExecute removido}
    DM.tmrSair.enabled := true;
    Application.Terminate;
    Exit;
  end;

  param_versao := LowerCase(fIniciando.LANG)+'_version';

  if (Trim(param.Strings.Values[param_versao]) = '') then
  begin
    Result := false;
    Exit;
  end;

  versao_new := TStringList.Create;
  versao_new.Delimiter := '.';
  versao_new.DelimitedText := param.Strings.Values[param_versao];

  if (StrToInt(trim(versao_atu[0])) < StrToInt(trim(versao_new[0]))) or
     (
        (StrToInt(trim(versao_atu[0])) = StrToInt(trim(versao_new[0]))) and
        (StrToInt(trim(versao_atu[1])) < StrToInt(trim(versao_new[1])))
     ) then
  begin
    Result := True;
    btwsspDownload.Left := 0;
    btwsspDownload.Visible := true;
    btwsDownload.Left := 0;
    btwsDownload.Visible := true;

    fIniciando.AppCreateForm(TfNovaVersao, fNovaVersao);
    fNovaVersao.lblVAtu.Caption := versao_atu[0]+'.'+versao_atu[1];
    fNovaVersao.lblVNova.Caption := versao_new[0]+'.'+versao_new[1];
    fNovaVersao.showmodal;
    Exit;
  end;




  if (Trim(param.Strings.Values['db_version']) = '') then
  begin
    Result := false;
    Exit;
  end;

  if (DM.qrVERSAO.fieldbyname('VERSAO_BD').AsInteger < StrToInt(param.Strings.Values['db_version'])) then
  begin
    Result := false;

    if (application.messagebox(PChar(fIniciando.Translate('Uma versão mais recente do banco de dados foi encontrada. Deseja baixar agora?')), TITULO, MB_yesno + mb_iconquestion) <> 6) then
    begin
      Result := false;
      Exit;
    end
    else
    begin
      if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
      begin
        application.messagebox(PChar(fIniciando.Translate('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.')), TITULO, MB_OK + mb_iconerror);
        Result := false;
        Exit;
      end;

      lista := TStringList.Create;
      {LAZARUS: FTP tem pt_database.db/es_database.db — ftp_baixa renomeia para database.db localmente}
      lista.Add('config\' + fIniciando.LANG + '_database.db');

      fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
      fAtualiza.arquivos := lista;
      fAtualiza.ShowModal;

      if not FileExists(dir_config + 'database.db') then
      begin
        application.messagebox(PChar(fIniciando.Translate('Não foi possível baixar o Banco de Dados da internet. Favor, instale seu programa novamente!')), TITULO, MB_ok + mb_iconerror);
        Result := false;
        Exit;
      end;
    end;

    {LAZARUS: RunCommand(Application.ExeName, [], _out_) — ShellExecute removido}
    DM.tmrSair.enabled := true;
    Application.Terminate;
    Exit;
  end;


  Result := False;
end;

procedure TfmIndex.tsSorteioNMShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsSorteioNM,tsSorteioNM);
  marcaAbaAberta(tsSorteioNM);
  carrega_opc := True;

  if (loadCol.Strings.Values['SORTEIO_NOMES'] <> 'ok') then
  begin
    loadCol.Strings.Values['SORTEIO_NOMES'] := 'ok';
    loadCol.Strings.Values['SORTEIO_NOMES_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO_NOMES');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsSorteioShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsSorteio,tsSorteio);
  marcaAbaAberta(tsSorteio);
  carrega_opc := True;

  if (loadCol.Strings.Values['SORTEIO'] <> 'ok') then
  begin
    loadCol.Strings.Values['SORTEIO'] := 'ok';
    loadCol.Strings.Values['SORTEIO_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsTextoInterativoShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsTextoInterativo,tsTextoInterativo);
  marcaAbaAberta(tsTextoInterativo);
  carrega_opc := True;

  if (loadCol.Strings.Values['TEXTOI'] <> 'okf') then
  begin
    loadCol.Strings.Values['TEXTOI'] := 'okf';
    RichEdit0.Lines.Clear;
    carregaConfiguracoes('TEXTOI');
    RichEdit0.Font.Name {LAZARUS: DefaultFont->Font} := 'Tahoma';
    fcTxtI0.Text := RichEdit0.Font.Name {LAZARUS: DefaultFont->Font}; {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
    seTxtITamanho0.Text := IntToStr(RichEdit0.Font.Size {LAZARUS: DefaultFont->Font});
    RichEditEnter(RichEdit0);
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsCronometroShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsCronometro,tsCronometro);
  marcaAbaAberta(tsCronometro);
  carrega_opc := True;

  if (loadCol.Strings.Values['CRONO'] <> 'ok') then
  begin
    loadCol.Strings.Values['CRONO'] := 'ok';
    loadCol.Strings.Values['CRONO_IMG'] := '|';
    loadCol.Strings.Values['CRONO_IMG_E'] := '|';

    carregaConfiguracoes('CRONO');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsCronoCultoShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsCronoCulto,tsCronoCulto);
  marcaAbaAberta(tsCronoCulto);
  carrega_opc := True;

  if (loadCol.Strings.Values['ES'] <> 'ok') then
  begin
    loadCol.Strings.Values['ES'] := 'ok';
    loadCol.Strings.Values['ES_IMG'] := '|';
    loadCol.Strings.Values['ES_IMG_E'] := '|';

    rbgAudioES.Visible := (fIniciando.LANG <> 'ES');

    carregaConfiguracoes('ES');
  end;
  DM.tmrRelogioTimer(Sender);
  carrega_opc := False;
end;

procedure TfmIndex.txtDecrChange(Sender: TObject);
begin
  btZerarCronoClick(Sender);
end;

procedure TfmIndex.txtDecrExit(Sender: TObject);
begin
  txtDecr.text := StringReplace(txtDecr.text, ' ', '0', [rfIgnoreCase, rfReplaceAll]);

  try
    StrToTime(txtDecr.Text)
  except
    application.MessageBox('Tempo inválido!', TITULO, mb_ok + mb_iconerror);
    txtDecr.text := '00:01:00';
    txtDecr.SetFocus;
  end;

  gravaParam('Cronometro', 'Tempo Decrescente', txtDecr.Text);
end;

function TfmIndex.lerParam(Grupo, Param, Valor, Arquivo, Diretorio:string): string;
var
  ArqIni: TCustomIniFile;
  vl: string;
  dir: string;
begin
  if Arquivo = '' then
    Arquivo := 'config'+fIniciando.LANG+'.ja';

  vl := Valor;
  if (Trim(Diretorio) <> '')
    then dir := Diretorio
    else dir := dir_dados;

  try
    // Always use abreIniLiturgia for liturgia.ja to ensure UTF-8 and avoid ANSI APIs
    if Arquivo = arq_liturgia then
    begin
      {LAZARUS: cache do TMemIniFile de liturgia.ja — evita múltiplas leituras de disco
       por chamada; invalidado por invalidateLiturgiaCache após gravações}
      if not Assigned(FLiturgiaIniCache) then
        FLiturgiaIniCache := abreIniLiturgia;
      vl := FLiturgiaIniCache.ReadString(Grupo, Param, Valor);
    end
    else
    begin
      ArqIni := TIniFile.Create(dir + Arquivo);
      try
        vl := ArqIni.ReadString(Grupo, Param, Valor);
      finally
        ArqIni.Free;
      end;
    end;
  except
    on E: Exception do
    begin
      try
        gravaLog('lerParam(' + Arquivo + ',' + Grupo + ',' + Param + '): ' + E.ClassName + ' - ' + E.Message);
      except
        // Silencioso - erro ao logar não deve quebrar a app
      end;
    end;
  end;
  result := vl;
end;

function TfmIndex.getVideoID(link: string): string;
begin
  if Pos('v=', link) > 0 then
    link := Copy(link, Pos('v=', link) + 2, length(link));

  if Pos('&', link) > 0 then
    link := Copy(link, 0, Pos('&', link) - 1);

  if Pos('#', link) > 0 then
    link := Copy(link, 0, Pos('#', link) - 1);

  result := link;
end;

function TfmIndex.caminhoLiturgia: string;
begin
  Result := dir_dados + arq_liturgia;
end;

procedure TfmIndex.invalidateLiturgiaCache;
begin
  {LAZARUS: descarta o TMemIniFile em cache para que a próxima leitura releia o arquivo}
  FreeAndNil(FLiturgiaIniCache);
end;

procedure TfmIndex.garanteUtf8Liturgia;
var
  path: string;
  fs: TFileStream;
  bom: array[0..2] of Byte;
  sl: TStringList;
  {LAZARUS: enc1252 removido — Linux usa UTF-8 nativamente}
begin
  path := caminhoLiturgia;
  if not FileExists(path) then Exit;
  FillChar(bom, SizeOf(bom), 0);
  try
    fs := TFileStream.Create(path, fmOpenRead or fmShareDenyWrite);
    try
      if fs.Size >= 3 then fs.Read(bom, 3);
    finally
      fs.Free;
    end;
  except
    Exit;
  end;
  // If file already has UTF-8 BOM, assume UTF-8 and exit
  if (bom[0] = $EF) and (bom[1] = $BB) and (bom[2] = $BF) then Exit;

  sl := TStringList.Create;
  try
    // First try reading as UTF-8 (no BOM). If it succeeds, assume file is valid UTF-8.
    try
      sl.LoadFromFile(path) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
      // Successfully read as UTF-8; nothing to do.
      Exit;
    except
      // Not valid UTF-8: fall back to legacy encoding (CP1252) and convert to UTF-8
    end;

    {LAZARUS: conversão CP-1252 removida — Linux usa UTF-8 nativamente}
  finally
    sl.Free;
  end;
end;

function TfmIndex.abreIniLiturgia: TMemIniFile;
var
  path: string;
  sl: TStringList;
  {LAZARUS: enc1252 removido — Linux usa UTF-8 nativamente}
  backupPath: string;
begin
  path := caminhoLiturgia;
  try
    // Ensure file is converted to UTF-8 where possible
    try
      garanteUtf8Liturgia;
    except
      try gravaLog('abreIniLiturgia: garanteUtf8Liturgia falhou para ' + path); except end;
    end;

    try
      gravaLog('abreIniLiturgia: opening ' + path + ' (ensured UTF-8)');
    except
      // best effort
    end;

    try
      Result := TMemIniFile.Create(path) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
      Exit;
    except
      on E: EEncodingError do
      begin
        try
          gravaLog('abreIniLiturgia: EEncodingError creating TMemIniFile for ' + path + ' - ' + E.Message);
        except end;

        {LAZARUS: conversão CP-1252 removida — arquivos em UTF-8 no Linux}
        begin
          try gravaLog('abreIniLiturgia: repair (CP1252->UTF8) failed for ' + path); except end;
          // Backup corrupted file and create an empty one
          try
            backupPath := path + '.corrupt.' + FormatDateTime('yyyymmddhhnnsszzz', Now);
            RenameFile(path, backupPath);
            gravaLog('abreIniLiturgia: moved corrupted file to ' + backupPath);
          except
            try gravaLog('abreIniLiturgia: failed to backup corrupted file ' + path); except end;
          end;
          // create an empty file to continue
          try
            sl := TStringList.Create;
            try
              sl.SaveToFile(path) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
            finally
              sl.Free;
            end;
          except
            // give up and re-raise original error
            raise;
          end;
        end;

        // Try creating again after repair/backout
        try
          Result := TMemIniFile.Create(path) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
          Exit;
        except
          on E2: Exception do
          begin
            try gravaLog('abreIniLiturgia: second attempt failed for ' + path + ' - ' + E2.ClassName + ' - ' + E2.Message); except end;
            // as last resort, backup and create empty ini
            try
              backupPath := path + '.corrupt.' + FormatDateTime('yyyymmddhhnnsszzz', Now);
              if FileExists(path) then RenameFile(path, backupPath);
            except
              // ignore
            end;
            Result := TMemIniFile.Create(path) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
            Exit;
          end;
        end;
      end
      else
        raise;
    end;
  except
    on E: Exception do
    begin
      try
        gravaLog('abreIniLiturgia: erro ao abrir ' + path + ' - ' + E.ClassName + ' - ' + E.Message);
      except end;
      raise;
    end;
  end;
end;

procedure TfmIndex.gravaLog(txt:string);
const
  LIMITE_BYTES = 1048576;     // 1MB
  ALVO_BYTES   = 730 * 1024;  // ~70% do limite
var
  linha, path: string;
  tamanho, soma: Int64;
  fs: TFileStream;
  sl: TStringList;
  i, corte: Integer;
  logF: TextFile; {LAZARUS: TFile.AppendAllText — declaracao movida para var section}
begin
  linha := FormatDateTime('dd/mm/yyyy HH:MM:SS.ZZZ', now()) + '    ' + txt;

  try
    if mmLog <> nil then
      mmLog.Lines.Add(linha);
  except
    // Silencioso se mmLog falhar
  end;

  // Persistência em disco só em modo desenvolvedor
  if (pnlModDes = nil) or (not pnlModDes.Visible) then Exit;
  if dir_dados = '' then Exit;

  Inc(FLogChamadas);

  path := dir_dados + 'louvorja.log';
  try
    begin {LAZARUS: TFile.AppendAllText→TextFile append}
      AssignFile(logF, path);
      if FileExists(path) then Append(logF) else Rewrite(logF);
      try WriteLn(logF, linha); finally CloseFile(logF); end;
    end;

    // Só checa truncamento a cada 100 chamadas para não pagar custo em todo log
    if (FLogChamadas mod 100) <> 0 then Exit;

    if not FileExists(path) then Exit;
    fs := TFileStream.Create(path, fmOpenRead or fmShareDenyNone);
    try
      tamanho := fs.Size;
    finally
      fs.Free;
    end;
    if tamanho <= LIMITE_BYTES then Exit;

    sl := TStringList.Create;
    try
      sl.LoadFromFile(path) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
      soma := 0;
      corte := 0;
      for i := sl.Count - 1 downto 0 do
      begin
        Inc(soma, Length(sl[i]) + 2); // +2 = CRLF
        if soma > ALVO_BYTES then
        begin
          corte := i + 1; // qtde de linhas iniciais a remover
          Break;
        end;
      end;
      for i := 1 to corte do
        sl.Delete(0);
      sl.SaveToFile(path) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
    finally
      sl.Free;
    end;
  except
    // Silencioso por design: falha do log não pode quebrar o app nem causar recursão
  end;
end;

procedure TfmIndex.gravaParamLote(const Arquivo: string; const Itens: array of TParamItem);
var
  ArqIni: TCustomIniFile;
  i: Integer;
  arq: string;
  origPath, tempPath: string;
  origIni, tempIni: TMemIniFile;
  sections, keys: TStringList;

  var k : integer;
  var backup : string;
begin
  arq := Arquivo;
  if arq = '' then
    arq := 'config' + fIniciando.LANG + '.ja';

  try
    if arq = arq_liturgia then
    begin
      // Write atomically: copy existing INI to temp, apply changes, write temp and replace
      origPath := dir_dados + arq;
      tempPath := origPath + '.tmp';

      // Ensure liturgia.ja is in UTF-8 before attempting to read it
      try
        garanteUtf8Liturgia;
      except
        try gravaLog('gravaParamLote: garanteUtf8Liturgia failed for ' + origPath); except end;
      end;

      tempIni := TMemIniFile.Create(tempPath) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
      try
        if FileExists(origPath) then
        begin
          try
            origIni := TMemIniFile.Create(origPath) {LAZARUS: TEncoding.UTF8 removido — UTF-8 padrão no Linux};
            try
              sections := TStringList.Create;
              try
                origIni.ReadSections(sections);
                for i := 0 to sections.Count - 1 do
                begin
                  keys := TStringList.Create;
                  try
                    origIni.ReadSection(sections[i], keys);
                    for k := 0 to keys.Count - 1 do
                      tempIni.WriteString(sections[i], keys[k], origIni.ReadString(sections[i], keys[k], ''));
                  finally
                    keys.Free;
                  end;
                end;
              finally
                sections.Free;
              end;
            finally
              origIni.Free;
            end;
          except
            on E: Exception do
            begin
              // Orig file could be corrupt or unreadable; backup and continue with empty base
              try
                gravaLog('gravaParamLote: failed to read orig INI ' + origPath + ' - ' + E.ClassName + ' - ' + E.Message);
              except end;
              try
                backup := origPath + '.corrupt.' + FormatDateTime('yyyymmddhhnnsszzz', Now);
                if FileExists(origPath) then RenameFile(origPath, backup);
                gravaLog('gravaParamLote: moved corrupted orig INI to ' + backup);
              except
                try gravaLog('gravaParamLote: failed to backup corrupted orig INI ' + origPath); except end;
              end;
              // proceed without copying original contents
            end;
          end;
        end;

        for i := 0 to High(Itens) do
          tempIni.WriteString(Itens[i].Grupo, Itens[i].Param, Itens[i].Valor);

        tempIni.UpdateFile;
      finally
        tempIni.Free;
      end;

      // Replace original atomically (replace if exists)
      {LAZARUS: MoveFileEx removido — Windows API; usando DeleteFile+RenameFile}
      if FileExists(origPath) then
        SysUtils.DeleteFile(origPath);
      RenameFile(tempPath, origPath);
      // Invalida cache após gravação para próxima leitura refletir as mudanças
      invalidateLiturgiaCache;
    end
    else
    begin
      ArqIni := TIniFile.Create(dir_dados + arq);
      try
        for i := 0 to High(Itens) do
          ArqIni.WriteString(Itens[i].Grupo, Itens[i].Param, Itens[i].Valor);
        ArqIni.UpdateFile;
      finally
        ArqIni.Free;
      end;
    end;
  except
    on E: Exception do
      gravaLog('gravaParamLote(' + arq + '): ' + E.ClassName + ' - ' + E.Message);
  end;
end;

procedure TfmIndex.gravaParam(Grupo, Param, Valor, Arquivo: string);
var
  item: TParamItem;
begin
  item.Grupo := Grupo;
  item.Param := Param;
  item.Valor := Valor;
  gravaParamLote(Arquivo, [item]);
end;

procedure TfmIndex.gravaParamServer(Grupo, Param, Valor: string);
var
  ArqIni: TIniFile;
  Arquivo: string;
begin
  Arquivo := 'file.ja';

  Valor := StringReplace(Valor, #13#10, '|', [rfIgnoreCase, rfReplaceAll]);
  Valor := StringReplace(Valor, #10, '|', [rfIgnoreCase, rfReplaceAll]);
  try
    ArqIni := TIniFile.Create(dir_config + 'server/file/' + Arquivo);
    try
      ArqIni.WriteString(Grupo, Param, Valor);
    finally
      ArqIni.Free;
    end;
  except
    //
  end;
end;

procedure TfmIndex.ajustaTexto(pagina: string;areaExpandida: Boolean);
begin
  if (pagina = 'BIBLIA') then
  begin
    if not (areaExpandida) then
    begin
      lmdBibliaTxt.Top := pnlBiblia.Height;
      lmdBibliaTxt.Left := pnlBiblia.Width;
      lmdBibliaTxt.AutoSize := False;
      lmdBibliaTxt.Height := 1;
      lmdBibliaTxt.Width := pnlBiblia.Width-20;
      lmdBibliaTxt.AutoSize := True;
      lmdBibliaTxt.Top := Trunc((pnlBiblia.Height/2) - (lmdBibliaTxt.Height/2));
      lmdBibliaTxt.Left := Trunc((pnlBiblia.Width/2) - (lmdBibliaTxt.Width/2));
      lmdBibliaTxt.Refresh;

      lmdBibliaInfo.Top := pnlBiblia.Height;
      lmdBibliaInfo.Left := pnlBiblia.Width;
      lmdBibliaInfo.AutoSize := False;
      lmdBibliaInfo.Height := 1;
      lmdBibliaInfo.Width := pnlBiblia.Width-20;
      lmdBibliaInfo.AutoSize := True;
      lmdBibliaInfo.Top := lmdBibliaTxt.Top + lmdBibliaTxt.Height;
      lmdBibliaInfo.Left := Trunc((pnlBiblia.Width) - (lmdBibliaInfo.Width))-10;
      lmdBibliaInfo.Refresh;
    end
    else
    begin
      with fMonitorBiblia do
      begin
        lmdBibliaTxt.Top := pnlBiblia.Height;
        lmdBibliaTxt.Left := pnlBiblia.Width;
        lmdBibliaTxt.AutoSize := False;
        lmdBibliaTxt.Height := 1;
        lmdBibliaTxt.Width := pnlBiblia.Width-20;
        lmdBibliaTxt.AutoSize := True;
        lmdBibliaTxt.Top := Trunc((pnlBiblia.Height/2) - (lmdBibliaTxt.Height/2));
        lmdBibliaTxt.Left := Trunc((pnlBiblia.Width/2) - (lmdBibliaTxt.Width/2));
        lmdBibliaTxt.Refresh;

        lmdBibliaInfo.Top := pnlBiblia.Height;
        lmdBibliaInfo.Left := pnlBiblia.Width;
        lmdBibliaInfo.AutoSize := False;
        lmdBibliaInfo.Height := 1;
        lmdBibliaInfo.Width := pnlBiblia.Width-20;
        lmdBibliaInfo.AutoSize := True;
        lmdBibliaInfo.Top := lmdBibliaTxt.Top + lmdBibliaTxt.Height;
        lmdBibliaInfo.Left := Trunc((pnlBiblia.Width) - (lmdBibliaInfo.Width))-10;
        lmdBibliaInfo.Refresh;
      end;
    end;
  end
  else if (pagina = 'BIBLIA_BUSCA') then
  begin
    if not (areaExpandida) then
    begin
      lmdBibliaBuscaTxt.Top := pnlBibliaBusca.Height;
      lmdBibliaBuscaTxt.Left := pnlBibliaBusca.Width;
      lmdBibliaBuscaTxt.AutoSize := False;
      lmdBibliaBuscaTxt.Height := 1;
      lmdBibliaBuscaTxt.Width := pnlBibliaBusca.Width-20;
      lmdBibliaBuscaTxt.AutoSize := True;
      lmdBibliaBuscaTxt.Top := Trunc((pnlBibliaBusca.Height/2) - (lmdBibliaBuscaTxt.Height/2));
      lmdBibliaBuscaTxt.Left := Trunc((pnlBibliaBusca.Width/2) - (lmdBibliaBuscaTxt.Width/2));
      lmdBibliaBuscaTxt.Refresh;

      lmdBibliaBuscaInfo.Top := pnlBibliaBusca.Height;
      lmdBibliaBuscaInfo.Left := pnlBibliaBusca.Width;
      lmdBibliaBuscaInfo.AutoSize := False;
      lmdBibliaBuscaInfo.Height := 1;
      lmdBibliaBuscaInfo.Width := pnlBibliaBusca.Width-20;
      lmdBibliaBuscaInfo.AutoSize := True;
      lmdBibliaBuscaInfo.Top := lmdBibliaBuscaTxt.Top + lmdBibliaBuscaTxt.Height;
      lmdBibliaBuscaInfo.Left := Trunc((pnlBibliaBusca.Width) - (lmdBibliaBuscaInfo.Width))-10;
      lmdBibliaBuscaInfo.Refresh;
    end
    else
    begin
      with fMonitorBibliaBusca do
      begin
        lmdBibliaBuscaTxt.Top := pnlBibliaBusca.Height;
        lmdBibliaBuscaTxt.Left := pnlBibliaBusca.Width;
        lmdBibliaBuscaTxt.AutoSize := False;
        lmdBibliaBuscaTxt.Height := 1;
        lmdBibliaBuscaTxt.Width := pnlBibliaBusca.Width-20;
        lmdBibliaBuscaTxt.AutoSize := True;
        lmdBibliaBuscaTxt.Top := Trunc((pnlBibliaBusca.Height/2) - (lmdBibliaBuscaTxt.Height/2));
        lmdBibliaBuscaTxt.Left := Trunc((pnlBibliaBusca.Width/2) - (lmdBibliaBuscaTxt.Width/2));
        lmdBibliaBuscaTxt.Refresh;

        lmdBibliaBuscaInfo.Top := pnlBibliaBusca.Height;
        lmdBibliaBuscaInfo.Left := pnlBibliaBusca.Width;
        lmdBibliaBuscaInfo.AutoSize := False;
        lmdBibliaBuscaInfo.Height := 1;
        lmdBibliaBuscaInfo.Width := pnlBibliaBusca.Width-20;
        lmdBibliaBuscaInfo.AutoSize := True;
        lmdBibliaBuscaInfo.Top := lmdBibliaBuscaTxt.Top + lmdBibliaBuscaTxt.Height;
        lmdBibliaBuscaInfo.Left := Trunc((pnlBibliaBusca.Width) - (lmdBibliaBuscaInfo.Width))-10;
        lmdBibliaBuscaInfo.Refresh;
      end;
    end;
  end;
end;

procedure TfmIndex.apagaItemLiturgia(item: string);
var
  Panel: TPanel;
begin
  Panel := TPanel(FindComponent(item));
  Panel.Visible := false;
  apagaParam(item,'',arq_liturgia);
  lbLiturgia.Items.Delete(lbLiturgia.Items.IndexOf(item));

  salvaItensLiturgia;
end;

procedure TfmIndex.apagaParam(Grupo, Param, Arquivo: string);
var
  ArqIni: TCustomIniFile;
begin
  if Arquivo = '' then
    Arquivo := 'config'+fIniciando.LANG+'.ja';

  try
    if Arquivo = arq_liturgia then
      ArqIni := abreIniLiturgia
    else
      ArqIni := TIniFile.Create(dir_dados + Arquivo);
    try
      if (trim(Param) <> '') then
        ArqIni.DeleteKey(Grupo, Param)
      else
        ArqIni.EraseSection(Grupo);
      ArqIni.UpdateFile;
    finally
      ArqIni.Free;
    end;
  except
    on E: Exception do
      gravaLog('apagaParam(' + Arquivo + ',' + Grupo + ',' + Param + '): ' + E.ClassName + ' - ' + E.Message);
  end;
end;

procedure TfmIndex.cbAlinhamentoCapaProgramaChange(Sender: TObject);
begin
  imgImagemCapa.Stretch := (cbAlinhamentoCapaPrograma.ItemIndex = 1);
  gravaParam('Config', 'Alinhamento Imagem Fundo', inttostr(cbAlinhamentoCapaPrograma.ItemIndex));
end;

procedure TfmIndex.cbAnotacoesLiturgiaClick(Sender: TObject);
begin
  if cbAnotacoesLiturgia.Checked then
    gravaParam('Liturgia', 'ExibirAnotacoes', '1')
  else
    gravaParam('Liturgia', 'ExibirAnotacoes', '0');
  pnlAnotacoesLiturgia.Visible := cbAnotacoesLiturgia.Checked;
end;

procedure TfmIndex.cbBibliaHistoricoClick(Sender: TObject);
begin
  if cbBibliaHistorico.Checked then
    gravaParam('Biblia', 'Historico', '1')
  else
    gravaParam('Biblia', 'Historico', '0');
  pnlBibliaHistorico.Visible := cbBibliaHistorico.Checked;
  ajustaTexto('BIBLIA');
end;

procedure TfmIndex.cbBloqItensClick(Sender: TObject);
begin
  if cbBloqItens.Checked then
    gravaParam('Liturgia', 'BloquearItens', '1')
  else
    gravaParam('Liturgia', 'BloquearItens', '0');

  LiturgiaCalendarClick(nil);
  btApagaLitSel.Enabled := not cbBloqItens.Checked;
end;

procedure TfmIndex.cbColetaneasPersoChange(Sender: TObject);
begin
  if DM.cdsCOLETANEAS_PERSO.Active = false then
    Exit;

  DM.cdsCOLETANEAS_PERSO.Locate('ID', cbColetaneasPerso.KeyValue, []);
  txtColetanea2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('NOME').AsString;
  txtAbrirColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('URL').AsString;
  txtUrlInfoColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('URL_INFO').AsString;
  txtCapaColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('IMAGEM').AsString;
  txtImgInfoColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('IMAGEM_INFO').AsString;
end;

procedure TfmIndex.cbCronoElClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if cbCronoEl.Checked {LAZARUS: ItemChecked->Checked}[0] then
    gravaParam('Cronometro', 'Tempos Gravados (Extendido)', '1')
  else
    gravaParam('Cronometro', 'Tempos Gravados (Extendido)', '0');

  copiaDadosTelaExtendida;
end;

procedure TfmIndex.cbEscSBRelogioFuncClick(Sender: TObject);
begin
  if cbEscSBRelogioFunc.Checked then
    gravaParam('Escola Sabatina', 'RelogioSempreAtivo', '1')
  else
    gravaParam('Escola Sabatina', 'RelogioSempreAtivo', '0');
end;

procedure TfmIndex.cbEscSBZerarTempoClick(Sender: TObject);
begin
  if cbEscSBZerarTempo.Checked then
    gravaParam('Escola Sabatina', 'DesligarZerarTempo', '1')
  else
    gravaParam('Escola Sabatina', 'DesligarZerarTempo', '0');
end;

procedure TfmIndex.cbMarcarConcClick(Sender: TObject);
begin
  if cbMarcarConc.Checked then
    gravaParam('Liturgia', 'MarcarConcluido', '1')
  else
    gravaParam('Liturgia', 'MarcarConcluido', '0');
end;

procedure TfmIndex.cbMusicaChange(Sender: TObject);
begin
  try
    BASS_ChannelStop(BassPreviewChannel); {LAZARUS: mpMusica.Stop->BASS_ChannelStop}
  except
    //
  end;
  btOuvir.Caption := 'Ouvir';
  btOuvir.Down := False;
  btOuvir.ImageIndex := 7;
  selMusica();
end;

procedure TfmIndex.cbPosicaoFundoClick(Sender: TObject);
var
  tag: integer;
  valor: string;
begin
  if carrega_opc then
    Exit;

  tag := TComboBox {LAZARUS: TbsSkinComboBoxEx}(Sender).tag;
  valor := IntToStr(TComboBox {LAZARUS: TbsSkinComboBoxEx}(Sender).ItemIndex+1);
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Posicao Fundo', valor);
    loadCol.Strings.Values['BIBLIA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_IMG_E'] := '|';
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Posicao Fundo', valor);
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := '|';
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Posicao Fundo', valor);
    loadCol.Strings.Values['ES_IMG'] := '|';
    loadCol.Strings.Values['ES_IMG_E'] := '|';
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Posicao Fundo', valor);
    loadCol.Strings.Values['SORTEIO_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Posicao Fundo', valor);
    loadCol.Strings.Values['CRONO_IMG'] := '|';
    loadCol.Strings.Values['CRONO_IMG_E'] := '|';
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Posicao Fundo', valor);
    loadCol.Strings.Values['SORTEIO_NOMES_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Posicao Fundo', valor);
    loadCol.Strings.Values['PAINELD_IMG'] := '|';
    loadCol.Strings.Values['PAINELD_IMG_E'] := '|';
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Posicao Fundo', valor);
    loadCol.Strings.Values['RELOGIO_IMG'] := '|';
    loadCol.Strings.Values['RELOGIO_IMG_E'] := '|';
    carregaConfiguracoes('RELOGIO');
  end;

  copiaDadosTelaExtendida();
end;

procedure TfmIndex.cbRelogioAlinhamentoChange(Sender: TObject);
var
  tag: integer;
  valor: string;
begin
  if carrega_opc then
    Exit;

  tag := TComboBox {LAZARUS: TbsSkinComboBoxEx}(Sender).tag;
  valor := IntToStr(TComboBox {LAZARUS: TbsSkinComboBoxEx}(Sender).ItemIndex);
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Alinhamento', valor);
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Alinhamento', valor);
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Alinhamento', valor);
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Alinhamento', valor);
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Alinhamento', valor);
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Alinhamento', valor);
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Alinhamento', valor);
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Alinhamento', valor);
    carregaConfiguracoes('RELOGIO');
  end;

  copiaDadosTelaExtendida();
end;

procedure TfmIndex.cbRemoveItensAgendadosClick(Sender: TObject);
begin
  if cbRemoveItensAgendados.Checked then
    gravaParam('Itens Agendados', 'RemovePassados', '1')
  else
    gravaParam('Itens Agendados', 'RemovePassados', '0');
end;

function TfmIndex.cds2texto(cds: TBufDataset; campo: string): TStringList; {LAZARUS: TClientDataSet->TBufDataset}
var
  texto: TStringList;
  linha: string;
  pos: Integer;
begin
  if not cds.Active then
  begin
    cds.CreateDataSet;
    {LAZARUS: cds.LogChanges removido — TBufDataset nao tem LogChanges}
  end;

  texto := TStringList.Create;
  pos := cds.RecNo;
  cds.First;
  while not cds.Eof do
  begin
    linha := cds.FieldByName(campo).AsString;
    linha := StringReplace(linha, #13#10, '|', [rfIgnoreCase, rfReplaceAll]);
    texto.Add(linha);
    cds.Next;
  end;
  cds.RecNo := pos;
  Result := texto;
end;

procedure TfmIndex.selMusica;
begin
  if not rbgAudioES.Visible then Exit;

  if (cbMusica.ItemIndex = 0) then
    BassPreviewFile := {LAZARUS: mpMusica.FileName->BassPreviewFile} dir_config + 'abertura_escsb.mp3'
  else if (cbMusica.ItemIndex = 1) then
    BassPreviewFile := {LAZARUS: mpMusica.FileName->BassPreviewFile} dir_config + '5minutos_escsb.mp3'
  else
    BassPreviewFile := {LAZARUS: mpMusica.FileName->BassPreviewFile} dir_config + '1minuto_escsb.mp3';
  try
    BassPreviewChannel := BASS_StreamCreateFile(False, PChar(BassPreviewFile), 0, 0, 0); {LAZARUS: mpMusica.Open->BASS_StreamCreateFile}
  except
    //
  end;
end;

function TfmIndex.maiorLista(L: string): string;
var
  str: TStringList;
  m: string;
  i: integer;
begin
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(L), str);
  m := '0';
  for i := 0 to str.Count-1 do
  begin
    if StrToInt(str[i]) > StrToInt(m) then
      m := str[i];
  end;
  result := m;
end;

procedure TfmIndex.marcaAbaAberta(TabSheet: TTabSheet {LAZARUS: TbsSkinTabSheet});
var
  favIdx: integer;
begin
  pnlTitForm.Caption := TITULO;
  if (TabSheet.Tag > -1) then
  begin
    {LAZARUS: guarda bounds — Items[Tag] pode exceder se menu não foi completamente populado}
    if TabSheet.Tag < bsPopupMenuRibon.Items.Count then
      bsPopupMenuRibon.Items[TabSheet.Tag].Checked := True;

    if not DM.cdsFavoritos.Active then
    begin
      carregaFavoritos;
    end;

    carrega_opc := True;

    if (DM.cdsFavoritos.Locate('NOME_ABA', TabSheet.Name, [])) then
    begin
      favIdx := DM.cdsFavoritos.recno-1;
      {LAZARUS: TListView.ItemIndex só pode ser definido quando Items.Count > 0}
      if (favIdx >= 0) and (favIdx < ogFavoritos.Items.Count) then
        ogFavoritos.ItemIndex := favIdx;
      {LAZARUS: guarda bounds — menu favoritos pode estar vazio}
      if favIdx < bsPopupMenuFavoritos.Items.Count then
        bsPopupMenuFavoritos.Items[favIdx].Checked := True;
      botoesFavoritos('del');
    end
    else
    begin
      favIdx := DM.cdsFavoritos.RecordCount;
      {LAZARUS: TListView.ItemIndex só pode ser definido quando Items.Count > favIdx}
      if (favIdx >= 0) and (favIdx < ogFavoritos.Items.Count) then
        ogFavoritos.ItemIndex := favIdx;
      {LAZARUS: guarda bounds — menu favoritos pode estar vazio}
      if bsPopupMenuFavoritos.Items.Count > 0 then
      begin
        bsPopupMenuFavoritos.Items[0].Checked := True;
        bsPopupMenuFavoritos.Items[0].Checked := False;
      end;
      botoesFavoritos('add');
    end;

    carrega_opc := False;

    pnlTitForm.Caption := TabSheet.Caption + ' - ' + TITULO;
  end;
end;

procedure TfmIndex.meESDuracaoChange(Sender: TObject);
begin
  gravaParam('Escola Sabatina', 'Duracao', meESDuracao.Text);
end;

procedure TfmIndex.meESHoraChange(Sender: TObject);
begin
  gravaParam('Escola Sabatina', 'Hora', meESHora.Text);
end;

procedure TfmIndex.meESHoraExit(Sender: TObject);
begin
  meESHora.text := StringReplace(meESHora.text, ' ', '0', [rfIgnoreCase, rfReplaceAll]);

  try
    StrToTime(meESHora.Text)
  except
    application.MessageBox('Hora inválida!', TITULO, mb_ok + mb_iconerror);
    meESHora.Text := '00:00';
    meESHora.SetFocus;
    Exit;
  end;
end;

function TfmIndex.menorLista(L: string): string;
var
  str: TStringList;
  m: string;
  i: integer;
begin
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(L), str);
  m := '0';
  for i := 0 to str.Count-1 do
  begin
    if m = '0' then
      m := str[i];

    if (StrToInt(str[i]) > 0) and (StrToInt(str[i]) < StrToInt(m)) then
      m := str[i];
  end;
  result := m;
end;

procedure TfmIndex.tsBuscaBiblicaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfBuscaBiblica,tsBuscaBiblica);
  marcaAbaAberta(tsBuscaBiblica);
  if (loadCol.Strings.Values['BIBLIA_BUSCA_F'] <> 'okf') then
  begin
    loadCol.Strings.Values['BIBLIA_BUSCA_F'] := 'okf';

    lmdBibliaBuscaTxt.Caption := '';
    lmdBibliaBuscainfo.Caption := '';

    if (fIniciando.LANG='ES') then
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'] := lerParam('Busca Biblica', 'Versão', 'RV');
    end
    else
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'] := lerParam('Busca Biblica', 'Versão', 'ARA');
    end;

    loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] := '';

    ckLivros.Items.Clear;
    ckLivros2.Items.Clear;
    DM.qrBIBLIA_BUS_LIVROS.Close;
    DM.qrBIBLIA_BUS_LIVROS.Open;
    DM.qrBIBLIA_BUS_LIVROS.First;
    while not DM.qrBIBLIA_BUS_LIVROS.Eof do
    begin
      ckLivros.Items.Add(DM.qrBIBLIA_BUS_LIVROS.FieldByName('LIVRO').AsString);
      ckLivros2.Items.Add(DM.qrBIBLIA_BUS_LIVROS.FieldByName('LIVRO').AsString);
      ckLivros.Checked[ckLivros.Items.Count-1] := true;
      ckLivros2.Checked[ckLivros2.Items.Count-1] := true;
      DM.qrBIBLIA_BUS_LIVROS.Next;
    end;

    carregaBiblia('VER2');
    carregaBiblia('BUS');
  end;

  if (loadCol.Strings.Values['BIBLIA_BUSCA'] <> 'ok') then
  begin
    {LAZARUS: DBCtrlGridBibliaBusca.RowCount/ColCount removidos — TScrollBox nao tem RowCount/ColCount}

    loadCol.Strings.Values['BIBLIA_BUSCA'] := 'ok';
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := '|';

    carregaConfiguracoes('BIBLIA_BUSCA');
  end;
  txtBibLocaliza.SetFocus;
end;

procedure TfmIndex.txtUrlVideoOn2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  edtKeyUp(Sender,Key,Shift);
  if Key = VK_RETURN then
    btUrlVideoOn2Click(nil);
end;

procedure TfmIndex.txtUrlVideoOn3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  edtKeyUp(Sender,Key,Shift);
  if Key = VK_RETURN then
    btAddVideoOn3Click(nil);
end;

procedure TfmIndex.txtUrlVideoOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  edtKeyUp(Sender,Key,Shift);
  if Key = VK_RETURN then
    btUrlVideoOnClick(nil);
end;

procedure TfmIndex.btMusicaSlideMusicaClick(Sender: TObject);
var
  txt: string;
begin
  if (TComponent(Sender).Tag = 2)
    then txt := 'PB'
    else txt := '';

  if DM.qrBUSCA.Active = false then
    exit;

  if DM.qrBUSCA.RecordCount <= 0 then
  begin
    application.MessageBox('Música não encontrada!', TITULO, mb_ok + mb_iconerror);
    txtHino.SetFocus;
    Exit;
  end;

  if (DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') then
  begin
    if (TComponent(Sender).Tag) = 2
      then application.MessageBox('Não é possível abrir side playback de coletâneas na web!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else if (TComponent(Sender).Tag) = 3
      then application.MessageBox('Não é possível abrir slide sem música de coletâneas na web!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else abreVideoOn(DM.qrBUSCA.fieldbyname('ID').AsString, DM.qrBUSCA.fieldbyname('NOME').AsString);
  end
  else if (DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S') then
  begin
    if (TComponent(Sender).Tag) = 2
      then application.MessageBox('Não é possível abrir side playback de coletâneas personalizadas!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else if (TComponent(Sender).Tag) = 3
      then application.MessageBox('Não é possível abrir slide sem música de coletâneas personalizadas!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else
    begin
      if FileExists(DM.qrBUSCA.fieldbyname('URL').AsString) then
      begin
        abrirArquivo(DM.qrBUSCA.fieldbyname('URL').AsString);
        Exit;
      end
      else
      if DirectoryExists(DM.qrBUSCA.fieldbyname('URL').AsString) then
      begin
        fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
        fListaMusica.id_album := 0;
        fListaMusica.inicio := false;
        fListaMusica.Caption := DM.qrBUSCA.fieldbyname('NOME').AsString;
        fListaMusica.lblTitulo.Caption := DM.qrBUSCA.fieldbyname('NOME').AsString;
        fListaMusica.lblSubtitulo.Caption := '';
        fListaMusica.dir := DM.qrBUSCA.fieldbyname('URL').AsString;
        fListaMusica.DataSource := DM.dsArquivos; {LAZARUS: DBCtrlGrid.DataSource->DataSource}
        fListaMusica.pnlBotoes.Visible := False;
        fListaMusica.showmodal;
      end
      else
      begin
        application.MessageBox(PChar('Arquivo "'+DM.qrBUSCA.fieldbyname('URL').AsString+' não localizado"!'), fmIndex.titulo, mb_ok + mb_iconerror)
      end;
    end;
  end
  else
    abreLetraMusica('BD',txt,DM.qrBUSCA.FieldByName('ID').AsInteger,(TComponent(Sender).Tag) < 3);
end;

procedure TfmIndex.lit_modItem_bteditClick(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfLiturgia, fLiturgia);
  fLiturgia.Caption := 'Alterar Item';
  fLiturgia.id := TPanel(Sender).Parent.Name;
  fLiturgia.ShowModal;
end;

procedure TfmIndex.lit_modItem_checkbClick(Sender: TObject);
var
  Panel: TPanel;
begin
  Panel := TPanel(TPanel(Sender).Parent);

  if TCheckBox {LAZARUS: TbsSkinCheckBox}(Sender).Checked then
  begin
    gravaParam(Panel.Name, 'checked', FormatDateTime('dd/mm/yyyy',Now()), arq_liturgia);
    TLabel {LAZARUS: TbsSkinStdLabel}(FindComponent(Panel.Name+'_titulo')).Font.Style := [fsBold,fsStrikeOut];
    TLabel {LAZARUS: TbsSkinStdLabel}(FindComponent(Panel.Name+'_subtitulo')).Font.Style := [fsStrikeOut];
    Panel.Color := $00CED5FF;
  end
  else
  begin
    gravaParam(Panel.Name, 'checked', '', arq_liturgia);
    TLabel {LAZARUS: TbsSkinStdLabel}(FindComponent(Panel.Name+'_titulo')).Font.Style := [fsBold];
    TLabel {LAZARUS: TbsSkinStdLabel}(FindComponent(Panel.Name+'_subtitulo')).Font.Style := [];
    Panel.Color := clWhite;
  end;
end;

procedure TfmIndex.lit_modItem_textoClick(Sender: TObject);
var
  Panel: TPanel;
  item,subitem: string;
  id,tag: Integer;
  txt:string;
begin
  if Sender is TLabel {LAZARUS: TbsSkinStdLabel}
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);
  item := Panel.Name;
  if (lerParam(item, 'tipo', '', arq_liturgia) = 'categoria') then
  begin
    DM.ColorDialog.Color := Panel.Color;
    DM.ColorDialog.Execute;
    Panel.Color := DM.ColorDialog.Color;

    gravaParam(item, 'cor', ColorToString(DM.ColorDialog.Color), arq_liturgia);
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'musica') then
  begin
    if (lerParam(item, 'escolha', '0', arq_liturgia) = '1') then
    begin
      fIniciando.AppCreateForm(TfBuscaMusica, fBuscaMusica);
      fBuscaMusica.ShowModal;
      if (fBuscaMusica.id) > 0
        then id := fBuscaMusica.id
        else Exit;
    end
    else
      id := StrToInt('0'+lerParam(item, 'musica', '0', arq_liturgia));

    tag := TComponent(Sender).Tag;

    if (tag = 4) then
      abreArquivoMusica(id)
    else if (tag = 5) then
    begin
      DM.qrMUSICA.Close;
      DM.qrMUSICA.ParamByName('ID').Value := id;
      DM.qrMUSICA.Open;

      if (DM.qrMUSICA.FieldByName('URL_INSTRUMENTAL').AsString = '')
        then application.MessageBox(PChar('Esta música não possui playback!'), titulo, mb_ok + MB_ICONEXCLAMATION)
        else abreArquivoMusica(id,DM.qrMUSICA.FieldByName('ALBUM').AsString,DM.qrMUSICA.FieldByName('URL_INSTRUMENTAL').AsString);
    end
    else if (tag = 6) then
      abreLetra(id)
    else
    begin
      if Tag = 2
        then txt := 'PB'
        else txt := '';
      abreLetraMusica('BD',txt,id,(tag < 3));
    end;
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'site') then
  begin
    if (sbVideoOnAbreLiturgia.ItemIndex = 1) then
    begin
      subitem := lerParam(item, 'url', '0', arq_liturgia);
      if
       (Pos('v=', subitem) > 0)
       and (
          (Pos('.youtube.',subitem) > 0)
       or (Pos('/youtube.',subitem) > 0)
       or (Pos('.youtu.be.',subitem) > 0)
       or (Pos('/youtu.be.',subitem) > 0)
       )
        then abreVideoOn(getVideoID(subitem), lerParam(item, 'item', '0', arq_liturgia))
        else abrirArquivo(lerParam(item, 'url', '', arq_liturgia));
    end
    else abrirArquivo(lerParam(item, 'url', '', arq_liturgia));
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'arquivo') then
  begin
    if (lerParam(item, 'dir_info', 'E', arq_liturgia) = 'I')
      then subitem := ExtractFilePath(Application.ExeName)+lerParam(item, 'dir', '', arq_liturgia)
      else subitem := lerParam(item, 'dir', '', arq_liturgia);

    if FileExists(subitem)
      then abrirArquivo(subitem)
    else if DirectoryExists(subitem) then
    begin
      if (Copy(subitem,Length(subitem),1)) <> '\'
        then subitem := subitem + '\';

      abrirArquivo(openDialog('arquivo', '', '.',false,subitem));
    end
    else application.MessageBox('Arquivo ou diretório não encotrado!',TITULO,mb_ok+mb_iconerror);
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'itensagendados') then
  begin
    subitem := lerParam(item, 'id', '', arq_liturgia);

    if not DM.cdsItensAgendados.Active then
    begin
      DM.cdsItensAgendados.CreateDataSet;
      DM.cdsItensAgendados.IndexName := '';
      DM.cdsItensAgendados.IndexFieldNames := 'DATA';
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsItensAgendados.LogChanges := False;)}
    end;

    if (FileExists(dir_dados + 'itensAgendados.xml')) then
      DM.cdsItensAgendados.LoadFromFile(dir_dados + 'itensAgendados.xml');
    DM.cdsItensAgendados.Open;

    DM.cdsItensAgendados.Filtered := false;
    if not (DM.cdsItensAgendados.Locate('CATEGORIA', subitem, [])) then
    begin
      if not DM.cdsCategoriasItensAgendados.Active then
      begin
        DM.cdsCategoriasItensAgendados.CreateDataSet;
        DM.cdsCategoriasItensAgendados.IndexName := '';
        DM.cdsCategoriasItensAgendados.IndexFieldNames := 'NOME';
        {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsCategoriasItensAgendados.LogChanges := False;)}
      end;

      if (FileExists(dir_dados + 'itensAgendadosCategorias.xml')) then
        DM.cdsCategoriasItensAgendados.LoadFromFile(dir_dados + 'itensAgendadosCategorias.xml');
      DM.cdsCategoriasItensAgendados.Open;

      if not (DM.cdsCategoriasItensAgendados.Locate('ID', subitem, []))
        then application.MessageBox(PChar('Categoria '''+lerParam(item, 'item', '', arq_liturgia)+''' não encontrada. Será necessário corrigir este item!'),TITULO,mb_ok+MB_ICONERROR)
        else application.MessageBox(PChar('Não foi encontrado '''+lerParam(item, 'item', '', arq_liturgia)+''' agendado para esta data!'),TITULO,mb_ok+MB_ICONEXCLAMATION);
    end
    else if (DM.cdsItensAgendados.Locate('CATEGORIA;DATA', VarArrayOf([subitem,IncDay(now(),strtoint(loadCol.Strings.Values['LITURGIA:SEMANA']) - dayofweek(now()))]), [])) then
    begin

      if (DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').AsString = 'I')
        then subitem := ExtractFilePath(Application.ExeName)+DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString
        else subitem := DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString;

      if FileExists(subitem)
        then abrirArquivo(subitem)
      else
      begin
        application.MessageBox('Arquivo não encotrado!',TITULO,mb_ok+mb_iconerror);
        if DirectoryExists(ExtractFileDir(subitem))
          then subitem := ExtractFileDir(subitem)
        else subitem := '';

        abrirArquivo(openDialog('arquivo', '', 'ItemAgendadoLiturgia',false,subitem))
      end;

    end
    else application.MessageBox(PChar('Não foi encontrado '''+lerParam(item, 'item', '', arq_liturgia)+''' agendado para esta data!'),TITULO,mb_ok+MB_ICONEXCLAMATION);
    DM.cdsItensAgendados.Filtered := true;
  end;

  if (lerParam(item, 'tipo', '', arq_liturgia) <> 'categoria')
    and (cbMarcarConc.Checked) then
  begin
    TCheckBox {LAZARUS: TbsSkinCheckBox}(FindComponent(item+'_checkb')).Checked := True;
  end;
end;

procedure TfmIndex.btLimparBBuscaClick(Sender: TObject);
begin
  lmdBibliaBuscaTxt.Caption := '';
  lmdBibliaBuscaInfo.Caption := '';
  loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] := '';
  DBCtrlGridBibliaBusca.Refresh;
  copiaDadosTelaExtendida;
  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', '');
     fmIndex.gravaParamServer('BIBLIA', 'info', '');
  end;
end;

procedure TfmIndex.btLimparClick(Sender: TObject);
begin
  lmdBibliaTxt.Caption := '';
  lmdBibliaInfo.Caption := '';
  loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';
  loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := '0';
  DBCtrlGridBibliaVersiculo.Refresh;
  copiaDadosTelaExtendida;
  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', '');
     fmIndex.gravaParamServer('BIBLIA', 'info', '');
  end;
end;

procedure TfmIndex.Button1Click(Sender: TObject);
var
  arquivo:string;
  nome_arquivo: string;
  ordem: Integer;
  letra: TStringList;
  letra_ok: string;
  i,l,n: integer;
  uc: string;
  ZipFile: TUnZipper; {LAZARUS: TZipFile→TUnZipper}
  dir_t: string;
  str: string;
  nr,c: Integer;
begin
  letra := TStringList.Create;

  fmIndex.openDialog('geral', 'Apresentação LouvorJA (*.slja;*.lja)|*.slja;*.lja', '', true);
  for i := 0 to DM.OpenDialog.Files.Count - 1 do
  begin

    if not DM.cdsSLIDE_MUSICA2.Active then
    begin
      DM.cdsSLIDE_MUSICA2.CreateDataSet;
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsSLIDE_MUSICA2.LogChanges := False;)}
    end;
    DM.cdsSLIDE_MUSICA2.Open;
    {LAZARUS: EmptyDataSet removido — TBufDataset; usando First+Delete}
    DM.cdsSLIDE_MUSICA2.First;
    while not DM.cdsSLIDE_MUSICA2.Eof do
      DM.cdsSLIDE_MUSICA2.Delete;

    arquivo := DM.OpenDialog.Files[i];
    nome_arquivo := ExtractFileName(arquivo);


    if (arquivo <> '') then
    begin
      if (ExtractFileExt(arquivo) = '.slja') then
      begin
        ZipFile := TUnZipper.Create; {LAZARUS: TZipFile.Create zmRead}
        try
          dir_t := fmIndex.dir_temp+'~edit_'+FormatDateTime('yyyymmddHHMMSSZZZ', now());
          ZipFile.FileName := arquivo;
          ZipFile.OutputPath := dir_t;
          ZipFile.UnZipAllFiles;
          arquivo := dir_t+'/slides.lja'; {LAZARUS: backslash→slash}
        finally
          ZipFile.Free;
        end;
      end;
      copiaArquivoParaSlides(arquivo,DM.cdsSLIDE_MUSICA2,false,lbTempos);
    end
    else
      Continue;



    if (idMusica.Text = '') or (idMusica.Text = '0') then
    begin
      DM.cdsSLIDE_MUSICA2.First;
      DM.qrINSERE_MUSICA.Close;
      DM.qrINSERE_MUSICA.ParamByName('NOME').Value := DM.cdsSLIDE_MUSICA2.FieldByName('LETRA').AsString;
      DM.qrINSERE_MUSICA.ParamByName('IMAGEM').Value := ExtractFileName(DM.cdsSLIDE_MUSICA2.FieldByName('IMAGEM').AsString);
      DM.qrINSERE_MUSICA.ExecSQL;

      DM.qrSELECT_MAX_MUSICA.Close;
      DM.qrSELECT_MAX_MUSICA.Open;
      idMusica.Text := DM.qrSELECT_MAX_MUSICA.FieldByName('MAX_ID').AsString;
    end;

    if (idMusica.Text = '') or (idMusica.Text = '0') then
    begin
      application.MessageBox('Não foi possível inserir!', TITULO, mb_ok + mb_iconerror);
      Exit;
    end;

    DM.cdsSLIDE_MUSICA2.First;

    DM.qrSELECT_LETRA_MUSICA.Close;
    DM.qrSELECT_LETRA_MUSICA.ParamByName('MUSICA').Value := idMusica.Text;
    DM.qrSELECT_LETRA_MUSICA.Open;
    DM.qrSELECT_LETRA_MUSICA.First;

    ordem := 0;
    while not DM.cdsSLIDE_MUSICA2.Eof do
    begin
      letra.Clear;
      letra_ok := '';
      uc := '';
      letra.Text := DM.cdsSLIDE_MUSICA2.FieldByName('LETRA').AsString;
      letra.Text := trim(letra.Text);
      letra.Text := AnsiUpperCase(Copy(letra.Text,1,1))+Copy(letra.Text,2,Length(letra.Text));
      letra.Text := StringReplace(letra.Text, '|', #13#10, [rfIgnoreCase, rfReplaceAll]);
      for l := 0 to letra.Count-1 do
      begin
        letra[l] := Trim(letra[l]);
        uc := Copy(letra[l],Length(letra[l]),1);
        if (uc = '.') or (uc = ',') or (uc = ';') then
          letra[l] := Copy(letra[l],1,Length(letra[l])-1);
        letra[l] := Trim(letra[l]);

        if Trim(letra[l]) <> '' then
        begin
          if Trim(letra_ok) <> '' then
            letra_ok := letra_ok+#13#10;
          letra_ok := letra_ok+letra[l];
        end;
      end;

      if DM.cdsSLIDE_MUSICA2.RecNo > 1 then
      begin
        if DM.qrSELECT_LETRA_MUSICA.Eof then
        begin
          ordem := ordem+1;
          DM.qrINSERE_LETRA_MUSICA.Close;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('MUSICA').Value := idMusica.Text;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('LETRA').Value := letra_ok;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('TEMPO').Value := DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').AsString;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('ORDEM').Value := ordem;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('IMAGEM').Value := ExtractFileName(DM.cdsSLIDE_MUSICA2.FieldByName('IMAGEM').AsString);
          DM.qrINSERE_LETRA_MUSICA.ExecSQL;
        end
        else
        begin
          DM.qrALTERA_LETRA_MUSICA.Close;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('MUSICA').Value := idMusica.Text;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('LETRA').Value := letra_ok;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('TEMPO').Value := DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').AsString;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('ID').Value := DM.qrSELECT_LETRA_MUSICA.FieldByName('ID').AsInteger;
          DM.qrALTERA_LETRA_MUSICA.ExecSQL;
          DM.qrSELECT_LETRA_MUSICA.Next;
          ordem := DM.qrSELECT_LETRA_MUSICA.FieldByName('ORDEM').AsInteger;
        end;
      end;
      DM.cdsSLIDE_MUSICA2.Next;
    end;

    if ((idAlbum.Text <> '') and (idAlbum.Text <> '0')) then
    begin
      if (Trim(idFaixa.Text) = '') then idFaixa.Text := '0';
      if (idFaixa.Text = '0') then
      begin
        for n := 1 to Length(nome_arquivo) do
        begin
          str := Copy(nome_arquivo,n,1);
          val(str, nr, c);
          if c = 0 then
          begin
            idFaixa.Text := idFaixa.Text + str;
          end
          else Break;
        end;
      end;

      DM.qrINSERE_MUSICA_ALBUM.Close;
      DM.qrINSERE_MUSICA_ALBUM.ParamByName('ID_ALBUM').Value := idAlbum.Text;
      DM.qrINSERE_MUSICA_ALBUM.ParamByName('ID_MUSICA').Value := idMusica.Text;
      DM.qrINSERE_MUSICA_ALBUM.ParamByName('FAIXA').Value := idFaixa.Text;
      DM.qrINSERE_MUSICA_ALBUM.ExecSQL;
    end;

    idMusica.Text := '0';
    idFaixa.Text := '0';
  end;
  idMusica.SetFocus;
  application.MessageBox(PChar('Arquivos importados com sucesso!'), TITULO, mb_ok + mb_iconinformation);
end;

procedure TfmIndex.Button2Click(Sender: TObject);
var
  lista: TStringList;
  Flags: Cardinal;
begin
  lista := TStringList.Create;
  lista.Add('_teste_ftp.txt');

  if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), fmIndex.TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
  fAtualiza.cancela := false;
  fAtualiza.arquivos := lista;
  fAtualiza.ShowModal;
end;

procedure TfmIndex.getClipboard();
var
  f: THandle;
  buffer: Array [0..MAX_PATH] of Char;
  i, numFiles: Integer;
begin
  {LAZARUS: CF_HDROP/DragQueryFile/GetAsHandle removidos — Windows drag-drop nao disponivel no Linux}
  cboard.Items.Clear;
  if Clipboard.HasFormat(CF_TEXT) then
    cboard.Items.Add(Clipboard.AsText);
end;

procedure TfmIndex.Button5Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := true;
    ckLivros2.Checked[i] := true;
  end;
end;

procedure TfmIndex.Button6Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := false;
    ckLivros2.Checked[i] := false;
  end;
end;

procedure TfmIndex.Button7Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := (i <= 38);
    ckLivros2.Checked[i] := (i <= 38);
  end;
end;

procedure TfmIndex.Button8Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := (i > 38);
    ckLivros2.Checked[i] := (i > 38);
  end;
end;

procedure TfmIndex.Button9Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := not ckLivros.Checked[i];
    ckLivros2.Checked[i] := ckLivros.Checked[i];
  end;
end;

procedure TfmIndex.Link(Sender: TObject);
begin
  try
    abrirArquivo(TLabel(Sender).Caption);
  except
  end;
end;

procedure TfmIndex.lista_coletaneas_web(p: string; id: string);
var
  Jpg: TJPEGImage;
  bmp: TBitmap;
  i: integer;
  dir: string;
  Base64String: string;
begin
  if (p = 'canais') then
  begin
    DM.qrONL_CANAIS.Close;
    DM.qrONL_CANAIS.Open;
    {LAZARUS: bgOnlCanais.Items.Clear — TToolBar stub}
    {LAZARUS: bgOnlCanais.ItemIndex — TToolBar sem ItemIndex}
    lbbgOnlCanais.Items.Clear; {LAZARUS: restaurado}
    pnlOnlPlaylists.Visible := False;
    pnlOnlVideos.Visible := False;
    DM.ico_on_canais.Clear;
    dir := dir_temp + 'imagens_onl\canais\';
    while not DM.qrONL_CANAIS.eof do
    begin
      {LAZARUS: bgOnlCanais.Items.Add.Caption — TToolBar nao tem Items.Add API}
      lbbgOnlCanais.Items.Add(DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString);
      i := lbbgOnlCanais.Items.Count - 1; {LAZARUS: bgOnlCanais.Items.Count->lbbgOnlCanais}

      try
        Jpg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        if FileExists(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg') then
          Jpg.LoadFromFile(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg')
        else
        begin
          Base64String := DM.qrONL_CANAIS.FieldByName('IMAGEM_64').AsString;
          SaveBase64ImageToFile(
            ExtractBase64Data(Base64String),
            dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg'
          );

          if FileExists(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg') then
            Jpg.LoadFromFile(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg');
        end;
        bmp.Assign(Jpg);
      except
        Jpg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        bmp.Assign(Jpg);
      end;
      bmp.Height := 88;
      bmp.Width := 88;
      DM.ico_on_canais.Add(bmp, nil);

      {LAZARUS: bgOnlCanais.Items[i].ImageIndex — TToolBar nao tem Items[i] API}

      DM.qrONL_CANAIS.Next;
    end;
  end
  else if (p = 'playlists') then
  begin
    DM.qrONL_PLAYLISTS.Close;
    DM.qrONL_PLAYLISTS.ParamByName('CANAL_ID').Value := id;
    DM.qrONL_PLAYLISTS.Open;
    {LAZARUS: bgOnlPlaylists.Items.Clear — TToolBar stub}
    {LAZARUS: bgOnlPlaylists.ItemIndex — TToolBar sem ItemIndex}
    lbbgOnlPlaylists.Items.Clear; {LAZARUS: restaurado}
    pnlOnlVideos.Visible := False;
    DM.ico_on_playlists.Clear;
    dir := dir_temp + 'imagens_onl\playlists\';
    while not DM.qrONL_PLAYLISTS.eof do
    begin
      {LAZARUS: bgOnlPlaylists.Items.Add.Caption — TToolBar nao tem Items.Add API}
      lbbgOnlPlaylists.Items.Add(DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString);
      i := lbbgOnlPlaylists.Items.Count - 1; {LAZARUS: bgOnlPlaylists.Items.Count->lbbgOnlPlaylists}

      try
        Jpg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        if FileExists(dir + DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString + '.jpg') then
          Jpg.LoadFromFile(dir + DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString + '.jpg')
        else
        begin
          Base64String := DM.qrONL_PLAYLISTS.FieldByName('IMAGEM_64').AsString;
          SaveBase64ImageToFile(
            ExtractBase64Data(Base64String),
            dir + DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString + '.jpg'
          );

          if FileExists(dir + DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString + '.jpg') then
            Jpg.LoadFromFile(dir + DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString + '.jpg');
        end;
        bmp.Assign(Jpg);
      except
        Jpg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        bmp.Assign(Jpg);
      end;
      bmp.Height := 90;
      bmp.Width := 120;
      DM.ico_on_playlists.Add(bmp, nil);

      {LAZARUS: bgOnlPlaylists.Items[i].ImageIndex — TToolBar nao tem Items[i] API}

      DM.qrONL_PLAYLISTS.Next;
    end;
  end
  else if (p = 'videos') then
  begin
    DM.qrONL_VIDEOS.Close;
    DM.qrONL_VIDEOS.ParamByName('PLAYLIST_ID').Value := id;
    DM.qrONL_VIDEOS.Open;
    bgOnlVideos.ScrollBy(0, 0);
    {LAZARUS: bgOnlVideos.Items.Clear — TToolBar stub}
    {LAZARUS: bgOnlVideos.ItemIndex — TToolBar sem ItemIndex}
    lbbgOnlVideos.Items.Clear; {LAZARUS: restaurado}
    DM.ico_on_videos.Clear;
    dir := dir_temp + 'imagens_onl\videos\';

    gaOnlVideos.Visible := True;
    gaOnlVideos.Position := 0;
    gaOnlVideos.Max := DM.qrONL_VIDEOS.RecordCount;

    while not DM.qrONL_VIDEOS.eof do
    begin
      gaOnlVideos.Position := DM.qrONL_VIDEOS.RecNo;
      Application.ProcessMessages;

      {LAZARUS: bgOnlVideos.Items.Add.Caption — TToolBar nao tem Items.Add API}
      lbbgOnlVideos.Items.Add(DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString);
      i := lbbgOnlVideos.Items.Count - 1; {LAZARUS: bgOnlVideos.Items.Count->lbbgOnlVideos}

      try
        Jpg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        if FileExists(dir + DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString + '.jpg') then
          Jpg.LoadFromFile(dir + DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString + '.jpg')
        else
        begin
          Base64String := DM.qrONL_VIDEOS.FieldByName('IMAGEM_64').AsString;
          SaveBase64ImageToFile(
            ExtractBase64Data(Base64String),
            dir + DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString + '.jpg'
          );

          if FileExists(dir + DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString + '.jpg') then
            Jpg.LoadFromFile(dir + DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString + '.jpg');
        end;
        bmp.Assign(Jpg);
      except
        Jpg := TJPEGImage.Create;
        bmp := TBitmap.Create;
        bmp.Assign(Jpg);
      end;
      bmp.Height := 90;
      bmp.Width := 120;
      DM.ico_on_videos.Add(bmp, nil);

      {LAZARUS: bgOnlVideos.Items[i].ImageIndex — TToolBar nao tem Items[i] API}

      DM.qrONL_VIDEOS.Next;
    end;
    bgOnlVideos.ScrollBy(0, 0);

    gaOnlVideos.Visible := False;
  end;
  imgYoutubeCapa.Visible := not pnlOnlVideos.Visible;
end;

function TfmIndex.lista_monitores(): TMonitorInfoArray; {LAZARUS: TArray<TMonitorInfo>->TMonitorInfoArray}
var
  qtd_monitores, i, j: integer;
  MonitorsArray: TMonitorInfoArray; {LAZARUS: TArray<TMonitorInfo>->TMonitorInfoArray}
  temp: TMonitorInfo;
begin
  qtd_monitores := Screen.MonitorCount;
  SetLength(MonitorsArray, qtd_monitores);

  for i := 0 to qtd_monitores-1 do
  begin
    MonitorsArray[i].Left := Screen.Monitors[i].Left;
    MonitorsArray[i].Top := Screen.Monitors[i].Top;
    MonitorsArray[i].Width := Screen.Monitors[i].Width;
    MonitorsArray[i].Height := Screen.Monitors[i].Height;
  end;

  {LAZARUS: TArray.Sort<TMonitorInfo> removido — Delphi generics; insertion sort}
  for i := 1 to qtd_monitores - 1 do
  begin
    temp := MonitorsArray[i];
    j := i - 1;
    while (j >= 0) and ((MonitorsArray[j].Top > temp.Top) or
          ((MonitorsArray[j].Top = temp.Top) and (MonitorsArray[j].Left > temp.Left))) do
    begin
      MonitorsArray[j + 1] := MonitorsArray[j];
      Dec(j);
    end;
    MonitorsArray[j + 1] := temp;
  end;

  result := MonitorsArray;
end;

procedure TfmIndex.tsPainelDShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsPainelD,tsPainelD);
  marcaAbaAberta(tsPainelD);
  carrega_opc := True;

  if (loadCol.Strings.Values['PAINELD'] <> 'ok') then
  begin
    loadCol.Strings.Values['PAINELD'] := 'ok';
    loadCol.Strings.Values['PAINELD_IMG'] := '|';
    loadCol.Strings.Values['PAINELD_IMG_E'] := '|';

    lmdTxtPainelD.Caption := '';
    carregaConfiguracoes('PAINELD');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsPersonalizadasShow(Sender: TObject);
var
  i: Integer;
begin
  PaginaMenuAtiva(bsColetPerso,tsPersonalizadas);
  marcaAbaAberta(tsPersonalizadas);
  if (loadCol.Strings.Values['PERSO'] <> 'ok') then
  begin
    loadCol.Strings.Values['PERSO'] := 'ok';

    if not DM.cdsCOLETANEAS_PERSO.Active then
    begin
      DM.cdsCOLETANEAS_PERSO.CreateDataSet;
      DM.cdsCOLETANEAS_PERSO.IndexName := '';
      DM.cdsCOLETANEAS_PERSO.IndexFieldNames := 'NOME';
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsCOLETANEAS_PERSO.LogChanges := False;)}
    end;

    if (FileExists(dir_dados + 'coletaneasUsuario.xml')) then
      DM.cdsCOLETANEAS_PERSO.LoadFromFile(dir_dados + 'coletaneasUsuario.xml');
    DM.cdsCOLETANEAS_PERSO.Open;

    for i := sbColPERSO.ComponentCount - 1 downto 0 do
      sbColPERSO.Components[i].Free;

    if trim(txtBuscaColetPeso.Text) <> '' then
    begin
      DM.cdsCOLETANEAS_PERSO.Filtered := true;
      DM.cdsCOLETANEAS_PERSO.Filter := 'UPPER(NOME) LIKE UPPER(' + (QuotedStr('%'+txtBuscaColetPeso.Text+'%')) + ')';
      stColetPerso_0.Text {LAZARUS: TStatusPanel.Caption→.Text} := 'Buscando nome: ''' + txtBuscaColetPeso.Text + '''';
    end
    else
    begin
      DM.cdsCOLETANEAS_PERSO.Filtered := false;
      stColetPerso_0.Text {LAZARUS: TStatusPanel.Caption→.Text} := '';
    end;

    stColetPerso_1.Text {LAZARUS: TStatusPanel.Caption→.Text} := qtItens(DM.cdsCOLETANEAS_PERSO,'álbum encontrado','álbuns encontrados','Nenhum álbum encontrado');

    corCampoBusca(DM.cdsCOLETANEAS_PERSO,txtBuscaColetPeso,nil);
    fExibeColetaneasPerso(sbColPERSO);
  end;
end;

procedure TfmIndex.tsRelogioShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsRelogio,tsRelogio);
  marcaAbaAberta(tsRelogio);
  carrega_opc := True;

  if (loadCol.Strings.Values['RELOGIO'] <> 'ok') then
  begin
    loadCol.Strings.Values['RELOGIO'] := 'ok';
    loadCol.Strings.Values['RELOGIO_IMG'] := '|';
    loadCol.Strings.Values['RELOGIO_IMG_E'] := '|';

    carregaConfiguracoes('RELOGIO');
  end;
  DM.tmrRelogioTimer(Sender);
  DM.tmrRelogio.Enabled := True;

  carrega_opc := False;
end;

procedure TfmIndex.fExibeColetaneasPerso(ScrollBox: TScrollBox {LAZARUS: TbsSkinScrollBox});
var
  Button: TSpeedButton {LAZARUS: TbsSkinButtonEx};
  gLeft, gTop, gWidth, gHeight: Integer;
  mLeft: integer;
  dirIMG: string;
  id: string;
  formWidth: Integer;
  bitmap: TBitmap;
  idimg: integer;
const
  Tipo = 'PERSO';
begin
  formWidth := ScrollBox.Width;

  ScrollBox.VertScrollBar.Position := 0; {LAZARUS: VScroll->VertScrollBar.Position}
  gLeft := 0;
  gTop := 10;
  gWidth := 165;
  gHeight := 190;

  bitmap := nil;

  while ((gLeft + gWidth + 10 + gWidth + 20) < formWidth) do
    gLeft := gLeft + gWidth + 10;
  mLeft := trunc((formWidth - (gLeft + gWidth + 10)) / 2);
  gLeft := mLeft;

  DM.cdsCOLETANEAS_PERSO.First;
  while not DM.cdsCOLETANEAS_PERSO.Eof do
  begin
    id := DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value;

    Button := TSpeedButton {LAZARUS: TbsSkinButtonEx}(FindComponent('gbPerso_' + id));
    Button.Free;
    if Assigned(Button) then
      continue;

    try
      Button := TSpeedButton {LAZARUS: TbsSkinButtonEx}.Create(ScrollBox);
      Button.Visible := False;

      with Button do
      begin
        Parent := ScrollBox;
        Name := 'gbPerso_' + id;
        Caption := '';
//        Tag := DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value;

        {LAZARUS: TbsSkinButtonEx.Layout removido}
        {LAZARUS: TbsSkinButtonEx.SkinData removido}
        {LAZARUS: TbsSkinButtonEx.ImageList removido}
        OnClick := sbClickPerso;
        PopupMenu := ppColetaneasPerso;

        dirIMG := DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value;
        if (trim(dirIMG) <> '') and (DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value = 'I') then
          dirIMG := ExtractFilePath(Application.ExeName) + dirIMG;
        try
          if (Trim(dirIMG) = '') then
            ImageIndex := 0
          else if (fileexists(dirIMG)) then
          begin
            bitmap := TBitmap.Create;
            bitmap.LoadFromFile(dirIMG);
            bitmap.TransparentColor := clFuchsia;
            bitmap.Transparent := false;
            idimg := DM.imCapas.Add(bitmap, bitmap);
            ImageIndex := idimg;
            bitmap.Free;
          end
          else
          begin
            Caption := 'Imagem de capa não localizada!';
            ImageIndex := 0;
          end;
        except
          Caption := 'Tamanho ou formato de imagem inválido!';
          ImageIndex := 0;
          bitmap.Free;
        end;

        Caption := {LAZARUS: TbsSkinButtonEx.Title->Caption} ' ' + DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').AsString + ' ';

        if ((not FileExists(DM.cdsCOLETANEAS_PERSO.FieldByName('URL').AsString)) and
           (not DirectoryExists(DM.cdsCOLETANEAS_PERSO.FieldByName('URL').AsString))) then
        begin
          Caption := 'Coletânea não localizada! Clique para corrigir.';
        end;

        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    except
      with Button do
      begin
        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    end;
    Button.Visible := True;

    if ((gLeft + gWidth + 10 + gWidth + 20) >= formWidth) then
    begin
      gLeft := mLeft;
      gTop := gTop + gHeight + 10;
    end
    else
      gLeft := gLeft + gWidth + 10;

    DM.cdsCOLETANEAS_PERSO.Next;
  end;
  ScrollBox.VertScrollBar.Position := 0; {LAZARUS: VScroll->VertScrollBar.Position}
  ScrollBox.VertScrollBar.Visible := True; {LAZARUS: VScrollBar->VertScrollBar}
  ScrollBox.VertScrollBar.Position := 0; {LAZARUS: VScrollBar->VertScrollBar}
end;

function TfmIndex.FileSize(const FileName: string): Int64;
var
  SR: TSearchRec;
begin
  {LAZARUS: TWin32FileAttributeData/GetFileAttributesEx removidos — Windows API; usando FindFirst}
  if FindFirst(FileName, faAnyFile, SR) = 0 then
  begin
    Result := SR.Size;
    FindClose(SR);
  end
  else
    Result := -1;
end;

procedure TfmIndex.focoAplicacao(acao: Boolean);
begin
  if btwsMinimize.Enabled <> acao then btwsMinimize.Enabled := acao;
  if btwsMaximized.Enabled <> acao then btwsMaximized.Enabled := acao;
  if btwsClose.Enabled <> acao then btwsClose.Enabled := acao;
  if btwsDownload.Enabled <> acao then btwsDownload.Enabled := acao;

  if acao = true then
  begin
    if layoutValue.Strings.Values['cor_texto'] <> '' then
      pnlTitForm.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto']);
  end
  else
  begin
    if layoutValue.Strings.Values['cor_texto_dis'] <> '' then
      pnlTitForm.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_dis']);
  end;
end;

procedure TfmIndex.sbClickPerso(Sender: TObject);
var
  mComponente: string;
  URL: string;
  id: string;
begin
  mComponente := TSpeedButton(Sender).Name;

  id := Copy(mComponente, Pos('_', mComponente) + 1, Length(mComponente));

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  URL := DM.cdsCOLETANEAS_PERSO.FieldByName('URL').AsString;

  if FileExists(URL) then
  begin
    abrirArquivo(URL);
    Exit;
  end
  else
  if DirectoryExists(URL) then
  begin
    fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
    fListaMusica.id_album := 0;
    fListaMusica.inicio := false;
    fListaMusica.Caption := TSpeedButton {LAZARUS: TbsSkinButtonEx}(Sender).Caption; {LAZARUS: TbsSkinButtonEx.Title->Caption}
    fListaMusica.lblTitulo.Caption := TSpeedButton {LAZARUS: TbsSkinButtonEx}(Sender).Caption; {LAZARUS: TbsSkinButtonEx.Title->Caption}
    fListaMusica.lblSubtitulo.Caption := '';
    fListaMusica.dir := URL;
    fListaMusica.DataSource := DM.dsArquivos; {LAZARUS: DBCtrlGrid.DataSource->DataSource (2nd)}
    fListaMusica.pnlBotoes.Visible := False;
    {LAZARUS: TbsSkinButtonEx.ImageList.GetBitmap removido — TSpeedButton nao tem ImageList}
    fListaMusica.showmodal;
  end
  else
  begin
    pnlAltColPerso.Visible := False;
    btAltColPersoClick(Sender);
    cbColetaneasPerso.KeyValue := id;
    cbColetaneasPersoChange(Sender);
    cbColetaneasPerso.Enabled := False;
    exit;
  end;
end;

procedure TfmIndex.sButton10Click(Sender: TObject);
begin
  abrirArquivo(dir_dados + 'config.ja');
end;

procedure TfmIndex.sbVideoOnAbreLiturgiaChange(Sender: TObject);
begin
  gravaParam('Videos Online', 'Player Liturgia', IntToStr(sbVideoOnAbreLiturgia.ItemIndex));
end;

procedure TfmIndex.sbVideoOnAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Videos Online', 'Monitor', sbVideoOnAreaExtendida.Items[sbVideoOnAreaExtendida.ItemIndex]);
end;

function TfmIndex.SegundosToTime(Segundos: Cardinal): String;
var
  Seg, Min, Hora: Cardinal;
  retorno: string;
begin
  Hora := Segundos div 3600;
  Seg := Segundos mod 3600;
  Min := Seg div 60;
  Seg := Seg mod 60;

  retorno := '';
  if (Hora > 0) then retorno := retorno+FormatFloat(',00', Hora) + ':';
  retorno := retorno + FormatFloat('00', Min) + ':' + FormatFloat('00', Seg);

  Result := retorno;
end;

procedure TfmIndex.btOuvirClick(Sender: TObject);
begin
  if not rbgAudioES.Visible then Exit;

  selMusica();
  if btOuvir.Caption = 'Ouvir' then
  begin
    try
      DM.tmrMediaPlayer.Enabled := true;
      BASS_ChannelPlay(BassPreviewChannel, True); {LAZARUS: mpMusica.Play->BASS_ChannelPlay}
    except
      DM.tmrMediaPlayer.Enabled := false;
      btOuvir.Caption := 'Ouvir';
      btOuvir.Down := False;
      btOuvir.ImageIndex := 7;
      abrirArquivo(BassPreviewFile,true) {LAZARUS: mpMusica.FileName->BassPreviewFile};
      Exit;
    end;
    btOuvir.Caption := 'Parar';
    btOuvir.Down := True;
    btOuvir.ImageIndex := 9;
  end
  else
  begin
    DM.tmrMediaPlayer.Enabled := false;
    try
      BASS_ChannelStop(BassPreviewChannel); {LAZARUS: mpMusica.Stop->BASS_ChannelStop}
    except
      //
    end;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;
  end;
end;

procedure TfmIndex.btLigarClick(Sender: TObject);
var
  fmt: TFormatSettings;
begin
  if btLigar.Caption = 'Ligar' then
  begin
    try
      BASS_ChannelStop(BassPreviewChannel); {LAZARUS: mpMusica.Stop->BASS_ChannelStop}
    except
      //
    end;

    fmt.ShortDateFormat:='dd/mm/yyyy';
    fmt.DateSeparator  :='/';
    fmt.LongTimeFormat :='hh:nn:ss';
    fmt.TimeSeparator  :=':';

    if opcCronoCTempo.ItemIndex = 0 then
    begin
      try
        StrToTime(meESHora.Text)
      except
        application.MessageBox('Hora inválida!', TITULO, mb_ok + mb_iconerror);
        btOuvir.Down := False;
        meESHora.SetFocus;
        Exit;
      end;
      tEscSBCrono := StrToDateTime(FormatDateTime('dd/mm/yyyy',Now())+' '+meESHora.Text + ':00',fmt);
    end
    else
    begin
      tEscSBCrono := StrToDateTime(FormatDateTime('dd/mm/yyyy hh:nn:ss',Now()),fmt);
      tEscSBCrono := IncSecond(IncMinute(tEscSBCrono,StrToInt(meESDuracao.Text)),1);
    end;

    if (tEscSBCrono < now())
      then tEscSBCrono := tEscSBCrono+1;

    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    DM.tmrRelogioTimer(Sender);
    btLigar.Caption := 'Desligar';
    btLigar.Down := True;
    btLigar.ImageIndex := 21;

    if (cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[0]) then
    begin
      cbMusica.ItemIndex := 0;
      selMusica();
      btOuvirClick(Sender);
    end;
  end
  else
  begin
    DM.tmrRelogioTimer(Sender);
    btLigar.Caption := 'Ligar';
    btLigar.Down := False;
    btLigar.ImageIndex := 20;
    gEscSbR.Max := 1;
    gEscSbR.Position := 1;

    try
      BASS_ChannelStop(BassPreviewChannel); {LAZARUS: mpMusica.Stop->BASS_ChannelStop}
    except
      //
    end;
    DM.tmrMediaPlayer.Enabled := false;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    lmdEscSbR.Font.Color := csEscsbCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};
    if (fMonitorCronometroCulto <> nil) then
    begin
      fMonitorCronometroCulto.lmdEscSbR.Font.Color := lmdEscSbR.Font.Color;
    end;
  end;

  bsAddT1.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddT5.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddT10.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddTm1.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddTm5.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddTm10.Enabled := not(btLigar.Caption = 'Ligar');
end;

procedure TfmIndex.pbPlayerMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  newPosition : integer;
begin
  DM.tmrPlayer.Enabled := false;
  newPosition := Round(x * pbPlayer.Max / pbPlayer.ClientWidth); {LAZARUS: MaxValue->Max}
  {LAZARUS: MediaPlayer1.Position->BASS_ChannelSetPosition}
  BASS_ChannelSetPosition(PlayerStream, BASS_ChannelSeconds2Bytes(PlayerStream, newPosition / 1000.0), BASS_POS_BYTE);
  DM.tmrPlayer.Enabled := True;
  if btplPlay.Down then BASS_ChannelPlay(PlayerStream, False); {LAZARUS: MediaPlayer1.Play->BASS}
end;

procedure TfmIndex.player(url: string;video: Boolean);
var
  monitor,i: integer;
begin
  if (fPlayer <> nil) then
    fPlayer.Close;

  if (video) then
  begin
      monitor := strtoint(lerParam('Player', 'Monitor', '2'));
    if (Screen.MonitorCount < monitor) then
      monitor := 0
    else
      monitor := monitor - 1;

    fIniciando.AppCreateForm(TfPlayer, fPlayer);

    if ckPlayerTelaCheia.Checked then
      fPlayer.BorderStyle := bsNone
    else
      fPlayer.BorderStyle := bsSizeable;
    fPlayer.AlphaBlend := True;
    fPlayer.AlphaBlendValue := 0;
    fPlayer.Show;

    fPlayer.Left := monitorInfo(monitor).Left;
    fPlayer.Top := monitorInfo(monitor).Top;
    fPlayer.Width := monitorInfo(monitor).Width;
    fPlayer.Height := monitorInfo(monitor).Height;

    if ckFadeForm.Checked then
    begin
      for i := 0 to 255 do
      begin
        fPlayer.AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else fPlayer.AlphaBlendValue := 255;
    fPlayer.Caption := ExtractFileName(url);
  end;

  try
    pbPlayer.Position := 0;
    lblPlayer.Caption := 'Reproduzindo: '+ExtractFileName(url);
    pnlPlayer.Visible := True;
    {LAZARUS: MediaPlayer1.Display removido — BASS nao renderiza video}
    PlayerStream := BASS_StreamCreateFile(False, PChar(url), 0, 0, 0); {LAZARUS: MediaPlayer1.FileName+Open->BASS_StreamCreateFile}
    {LAZARUS: MediaPlayer1.DisplayRect removido — BASS nao renderiza video}
    BASS_ChannelPlay(PlayerStream, False); {LAZARUS: MediaPlayer1.Play->BASS}
    btplPlay.Down := True;
    btplPause.Down := False;
    pbPlayer.Max := Round(BASS_ChannelBytes2Seconds(PlayerStream, BASS_ChannelGetLength(PlayerStream, BASS_POS_BYTE)) * 1000); {LAZARUS: MediaPlayer1.Length->BASS}
    DM.tmrPlayer.Enabled := True;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('Ocorreu um erro ao executar arquivo: '+E.Message+#13#10+'Pressione Ok para abrir o arquivo!'),TITULO,mb_ok+mb_iconerror);
      abrirArquivo(url,true);
      btplFecharClick(nil);
    end;
  end;
end;

procedure TfmIndex.pnlAddColPersoClose(Sender: TObject);
begin
  btAddColPerso.Down := False;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
end;

procedure TfmIndex.pnlAltColPersoClose(Sender: TObject);
begin
  btAltColPerso.Down := False;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
end;

procedure TfmIndex.pnlDoxologiaMusicasClose(Sender: TObject);
begin
  {LAZARUS: bgDoxologiaCate.ItemIndex — TToolBar nao tem ItemIndex}
end;

procedure TfmIndex.pnlFormatClose(Sender: TObject);
var
  tag: integer;
begin
  tag := TPanel {LAZARUS: TbsSkinExPanel}(Sender).tag;
  if (tag = 1) then
  begin
    pnlFormatBiblia.Visible := False;
    btFormatBiblia.Down := pnlFormatBiblia.Visible;
    ajustaTexto('BIBLIA');
  end
  else if (tag = 2) then
  begin
    pnlFormatBibliaB.Visible := False;
    btFormatBibliaB.Down := pnlFormatBibliaB.Visible;
    ajustaTexto('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    pnlFormatEscSB.Visible := False;
    btFormatEscSB.Down := pnlFormatEscSB.Visible;
    lmdEscSb.Top := 0;
    lmdEscSb.Left := 0;
    lmdEscSb.Width := pnlEscSB.Width;
    lmdEscSb.Height := round(pnlEscSB.Height / 2);
    lmdEscSbR.Top := round(pnlEscSB.Height / 2);
    lmdEscSbR.Left := 0;
    lmdEscSbR.Width := pnlEscSB.Width;
    lmdEscSbR.Height := round(pnlEscSB.Height / 2);
  end
  else if (tag = 4) then
  begin
    pnlFormatSorteio.Visible := False;
    btFormatSorteio.Down := pnlFormatSorteio.Visible;
  end
  else if (tag = 5) then
  begin
    pnlFormatCrono.Visible := False;
    btFormatCrono.Down := pnlFormatCrono.Visible;
  end
  else if (tag = 6) then
  begin
    pnlFormatSorteioNM.Visible := False;
    btFormatSorteioNM.Down := pnlFormatSorteioNM.Visible;
  end
  else if (tag = 7) then
  begin
    pnlFormatPainelD.Visible := False;
    btFormatPainelD.Down := pnlFormatPainelD.Visible;
  end
  else if (tag = 9) then
  begin
    pnlFormatRelogio.Visible := False;
    btFormatRelogio.Down := pnlFormatRelogio.Visible;
  end;
end;

procedure TfmIndex.pnLivrosClose(Sender: TObject);
begin
  ajustaTexto('BIBLIA_BUSCA');
end;

procedure TfmIndex.pnlOnlPlaylistsClose(Sender: TObject);
begin
  {LAZARUS: bgOnlCanais.ItemIndex — TToolBar sem ItemIndex}
  pnlOnlVideos.Visible := False;
  imgYoutubeCapa.Visible := not pnlOnlVideos.Visible;
end;

procedure TfmIndex.pnlOnlVideosClose(Sender: TObject);
begin
  {LAZARUS: bgOnlPlaylists.ItemIndex — TToolBar sem ItemIndex}
  imgYoutubeCapa.Visible := True;
end;

procedure TfmIndex.posicaoFundoClick(Sender: TObject);
begin
  gravaParam('Musicas', 'Imagem Fundo Posicao', IntToStr(fmIndex.posicaoFundo.ItemIndex+1))
end;

procedure TfmIndex.ppVideosOnPersoPopup(Sender: TObject);
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

procedure TfmIndex.btImpSorteioNMClick(Sender: TObject);
var
  i: Integer;
  arq: string;
begin
  arq := openDialog('texto', '', '');
  paramtemp.Lines.Clear;

  if Trim(arq) <> '' then
  begin
    paramtemp.Lines := arquivoCodificado(arq);

    for i := 0 to paramtemp.Lines.Count - 1 do
    begin
      try
        opSort_Nm.Text := paramtemp.Lines[i];
        btAddSorteioNMClick(nil);
      except
      end;
    end;
  end;
end;



procedure TfmIndex.btIniciarCronoClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Enabled) then Exit;
  pnlCrono.DoubleBuffered := True;
  if btIniciarCrono.Caption = 'Iniciar' then
  begin
    if txtDecr.Enabled = true then
      txtDecrExit(Sender);
    tCrono := tCronoT;
    tCronoOld := Now;
    DM.tmrCrono.Enabled := True;
    btIniciarCrono.Caption := 'Pausar';
    btIniciarCrono.ImageIndex := 28;
    btIniciarCrono.Down := True;
  end
  else
  begin
    DM.tmrCrono.Enabled := False;
    btIniciarCrono.Caption := 'Iniciar';
    btIniciarCrono.ImageIndex := 20;
    btIniciarCrono.Down := False;
  end;
end;

procedure TfmIndex.btZerarCronoClick(Sender: TObject);
var
  hora: string;
begin
//  pnlCrono.DoubleBuffered := False;
  if (Sender <> nil) and (not TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Enabled) then Exit;
  DM.tmrCrono.Enabled := false;
  btIniciarCrono.Caption := 'Iniciar';
  btIniciarCrono.ImageIndex := 20;
  btIniciarCrono.Down := False;
  gCrono.Max := 1;
  gCrono.Position := 1;

  tCronoT := 0;
  if rbDirecao.ItemIndex = 0 then
  begin
    tCronoT := 0;
    {LAZARUS: guard — cbFormatoTempoCrono.ItemIndex pode ser -1 se tab nunca foi aberta}
    if cbFormatoTempoCrono.ItemIndex >= 0 then
      lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], StrToTime('00:00:00'))
    else
      lmdCrono.Caption := '00:00:00.000';
  end
  else
  begin
    hora := StringReplace(txtDecr.text, ' ', '0', [rfIgnoreCase, rfReplaceAll]);
    btIniciarCrono.Enabled := true;
    try
      tCronoT := strtotime(hora);
    except
      btIniciarCrono.Enabled := false;
    end;

    if btZerarCrono.Tag = 0 then
    begin
      try
        lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], StrToTime(hora));
      except
      end;
    end;
    btZerarCrono.Tag := 0;
  end;
  if fMonitorCronometro <> nil then
  begin
    fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
    fMonitorCronometro.gCrono.Max := gCrono.Max;
    fMonitorCronometro.gCrono.Position := gCrono.Position;
    fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;
  end;
end;

procedure TfmIndex.buscaMusicas;
var
  valor: string;
  i: Integer;
  tabela: string;
  letra: string;
  opc_colet: string;
begin
  if carrega_opc then exit;
  if loadCol.Strings.Values['BUSCA:CARREGADO'] <> 'S' then Exit;
  if loadCol.Strings.Values['BUSCA:STATUS'] = 'I' then Exit;

  loadCol.Strings.Values['BUSCA:STATUS'] := 'I';

  pnlreBusca.Visible := False;
  bsSkinScrollBar8.Visible := true;
  valor := trim(txtBusca.Text);

  if (ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[0] = False) and (ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[1] = False) and (ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[2] = False)
    then ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[0] := True;

  if (ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[0] = False) and (ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[1] = False) and (ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[2] = False)
    then ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[0] := True;

  opc_colet := ',';
  if (ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[0] = True) then opc_colet := opc_colet + 'B,';
  if (ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[1] = True) then opc_colet := opc_colet + 'W,';
  if (ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[2] = True) then opc_colet := opc_colet + 'P,';

  if (trim(valor) = '')
    then pnlStatusBuscaMusicas0.Text {LAZARUS: TStatusPanel.caption->Text} := ''
    else pnlStatusBuscaMusicas0.Text {LAZARUS: TStatusPanel.caption->Text} := 'Buscando nome: ''' + valor + '''';


  DM.qrBUSCA.Close;
  DM.qrBUSCA.ParamByName('TIPO').AsString := opc_colet;
  DM.qrBUSCA.ParamByName('VALOR').AsString := termo_busca(valor);

  if (ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[0]) then
    DM.qrBUSCA.ParamByName('OPC_NOME').AsString := 'S'
  else
    DM.qrBUSCA.ParamByName('OPC_NOME').AsString := 'N';

  if (ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[1]) then
    DM.qrBUSCA.ParamByName('OPC_LETRA').AsString := 'S'
  else
    DM.qrBUSCA.ParamByName('OPC_LETRA').AsString := 'N';

  if (ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[2]) then
    DM.qrBUSCA.ParamByName('OPC_ALBUM').AsString := 'S'
  else
    DM.qrBUSCA.ParamByName('OPC_ALBUM').AsString := 'N';

  if tabLetras.Tabs[tabLetras.TabIndex] <> 'Todas'  then
    DM.qrBUSCA.ParamByName('INICIAL').AsString := tabLetras.Tabs[tabLetras.TabIndex]
  else
    DM.qrBUSCA.ParamByName('INICIAL').AsString := '';

  DM.qrBUSCA.Open;

  pnlStatusBuscaMusicas1.Text {LAZARUS: TStatusPanel.Caption→.Text} := qtItens(DM.qrBUSCA,'música encontrada','músicas encontradas','Nenhuma música encontrada');
  loadCol.Strings.Values['BUSCA:STATUS'] := '';



  if (DM.qrBUSCA.RecordCount = 1) then
  begin
    if (0 {LAZARUS: ckgColetaneas.ItemIndex — TCheckGroup nao tem ItemIndex} = 0) or ((0 {LAZARUS: ckgColetaneas.ItemIndex — TCheckGroup nao tem ItemIndex} = 2) and (DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString <> 'S') and (DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString <> 'S')) then
    begin
      reBusca.Lines.Clear;
      DM.qrLETRA.Close;
      DM.qrLETRA.ParamByName('MUSICA').Value := DM.qrBUSCA.fieldbyname('ID').AsInteger;
      DM.qrLETRA.Open;
      while not DM.qrLETRA.Eof do
      begin
        letra := '';
        if (DM.qrLETRA.fieldbyname('LETRA_AUX').AsString <> '') then
          letra := letra+'['+DM.qrLETRA.fieldbyname('LETRA_AUX').AsString+'] ';

        letra := letra+DM.qrLETRA.fieldbyname('LETRA').AsString;
        letra := StringReplace(letra, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]);
        reBusca.Lines.Add(letra);

        DM.qrLETRA.Next;
      end;

      pnlreBusca.Height := DBGrid2.Height - pnlStatusBuscaMusicas.Height - 22;
      pnlreBusca.Top := 0;
      formataTexto(reBusca);
      pnlreBusca.Visible := true;
    end;
    bsSkinScrollBar8.Visible := False;
    dbGrid2.Columns[2].Width := dbGrid2.Width - dbGrid2.Columns[0].Width - dbGrid2.Columns[1].Width - dbGrid2.Columns[3].Width;
  end
  else
  begin
    pnlreBusca.Visible := False;
  end;
//  bsErroMusica.Visible := pnlreBusca.Visible;

  corCampoBusca(DM.qrBUSCA, txtBusca, DBGrid2);
  pnlStatusBuscaMusicas1.Text {LAZARUS: TStatusPanel.Caption→.Text} := qtItens(DM.qrBUSCA,'música encontrada','músicas encontradas','Nenhuma música encontrada');;
  dbGrid2.Columns[2].Width := dbGrid2.Width - dbGrid2.Columns[0].Width - dbGrid2.Columns[1].Width - dbGrid2.Columns[3].Width;
  loadCol.Strings.Values['BUSCA:STATUS'] := '';

  DBGrid2CellClick(nil);
end;

procedure TfmIndex.btplFecharClick(Sender: TObject);
begin
  try
    BASS_ChannelStop(PlayerStream); {LAZARUS: MediaPlayer1.Stop->BASS}
  except
    //
  end;
  BASS_StreamFree(PlayerStream); {LAZARUS: MediaPlayer1.Close->BASS_StreamFree}
  PlayerStream := 0; {LAZARUS: MediaPlayer1.FileName:=''->PlayerStream reset}
  pnlPlayer.Visible := False;
  lblPlayer.Caption := '';
  DM.tmrPlayer.Enabled := False;
  pbPlayer.Position := 0;

  if (fPlayer <> nil) and (fPlayer.Visible) then
    fPlayer.Close;
end;

procedure TfmIndex.btplPauseClick(Sender: TObject);
begin
  if btplPause.Down <> True then
  begin
    btplPause.Down := True;
    Exit;
  end;

  BASS_ChannelPause(PlayerStream); {LAZARUS: MediaPlayer1.Pause->BASS}
  btplPlay.Down := false;
end;

procedure TfmIndex.btplPlayClick(Sender: TObject);
begin
  if btplPlay.Down <> True then
  begin
    btplPlay.Down := True;
    Exit;
  end;

  BASS_ChannelPlay(PlayerStream, False); {LAZARUS: MediaPlayer1.Play->BASS}
  btplPause.Down := false;
end;

procedure TfmIndex.botoesFavoritos(acao: string);
begin
  btAddFav.Enabled := (acao = 'add');
  miAddFav.Enabled := (acao = 'add');

  btDelFav.Enabled := (acao = 'del');
  miDelFav.Enabled := (acao = 'del');
end;

procedure TfmIndex.bsAddTClick(Sender: TObject);
var
  t: integer;
begin
  if (Sender <> nil) and (not TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Enabled) then Exit;

  t := TComponent(Sender).Tag;
  try
    BASS_ChannelStop(BassPreviewChannel); {LAZARUS: mpMusica.Stop->BASS_ChannelStop}
  except
    //
  end;
  tEscSBCrono := IncMinute(tEscSBCrono,t);
  DM.tmrRelogioTimer(Sender);
end;

procedure TfmIndex.bsAppMenu1ChangePage(Sender: TObject);
begin
  bsAppMenu1Items1Click(Sender);
end;

procedure TfmIndex.bsAppMenu1Click(Sender: TObject);
begin
  bsAppMenu1Items1Click(Sender);
end;

procedure TfmIndex.bsAppMenu1Items10Click(Sender: TObject);
begin
  DM.tmrSair.Enabled := True;
end;

procedure TfmIndex.bsAppMenu1Items1Click(Sender: TObject);
begin
  fmIndex.gpSobre.Align := alClient;
  fmIndex.ScrollBox1.Align := alClient;
  fmIndex.ScrollBox5.Align := alClient;
  carrega_monitores();
end;

procedure TfmIndex.bsAppMenu1Items3Click(Sender: TObject);
begin
//  fIniciando.AppCreateForm(TfTransmitir, fTransmitir);
  fTransmitir.Show;
end;

procedure TfmIndex.bsAppMenu1Items6Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    OpenURL(url) {LAZARUS: ShellExecute→OpenURL};
//  fIniciando.AppCreateForm(TfEnviaMensagem, fEnviaMensagem);
//  fEnviaMensagem.edAssunto.Text := '';
//  fEnviaMensagem.param := 'FEEDBACK';
//  fEnviaMensagem.mmMensagem.Text := '';
//  fEnviaMensagem.ShowModal;
end;

procedure TfmIndex.bsAppMenu1Items7Click(Sender: TObject);
var
  Flags: Cardinal;
begin
  if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), fmIndex.TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  {LAZARUS: DM.progressDialog.Caption := 'Coletânea JA'; — progressDialog removido}
  {LAZARUS: DM.progressDialog.LabelCaption := 'Procurando atualizações... aguarde...'; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Value := 0; — progressDialog removido}
  {LAZARUS: DM.progressDialog.MaxValue := 2; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Execute; — progressDialog removido}
  application.ProcessMessages;
  Sleep(1000);

  {LAZARUS: DM.progressDialog.Value := 1; — progressDialog removido}
  application.ProcessMessages;

  gravaParam('Config', 'UltimaConexao', '-');
  carregaParams;
  if verVersao() = false then
  begin
    Sleep(1000);
    application.messagebox(PChar('Não foram encontradas novas versões do programa!'), fmIndex.TITULO, MB_OK + mb_iconinformation);
    application.ProcessMessages;
  end;
  {LAZARUS: DM.progressDialog.MaxValue := 1; — progressDialog removido}
  {LAZARUS: DM.progressDialog.Value := DM.progressDialog.MaxValue — progressDialog removido}
  {LAZARUS: DM.progressDialog.Close; — progressDialog removido}


end;

procedure TfmIndex.bsknbtn1Click(Sender: TObject);
begin
  OpenURL('https://louvorja.com.br/doacao/') {LAZARUS: ShellExecute→OpenURL};
end;

procedure TfmIndex.bsPngImageView11Click(Sender: TObject);
begin
  if (DM.cdsItensAgendados.FieldByName('ID').AsString = '') then
  begin
    MonthCalendar1DblClick(MonthCalendar1);
    Exit;
  end;

  fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
  fItensAgendados.id := DM.cdsItensAgendados.FieldByName('ID').AsString;
  fItensAgendados.tipo := 'ITEM';
  fItensAgendados.ShowModal;
  loadCol.Strings.Values['LITURGIA'] := '';
end;

procedure TfmIndex.bsPngImageView13Click(Sender: TObject);
begin
  if (DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString = '') then
  begin
    btAddCategoriaAgendadosClick(Sender);
    Exit;
  end;

  fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
  fItensAgendados.id := DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString;
  fItensAgendados.tipo := 'CATEGORIA';
  fItensAgendados.ShowModal;
  loadCol.Strings.Values['LITURGIA'] := '';
end;

procedure TfmIndex.bsPopupMenuFavoritosPopup(Sender: TObject);
begin
  if not DM.cdsFavoritos.Active then
    fmIndex.carregaFavoritos;
end;

procedure TfmIndex.RibbonPCButtons0Click(Sender: TObject);
begin
  if (fBuscaMusica <> nil) and (fBuscaMusica.Visible) and (fBuscaMusica.Active)
    then exit;

  fIniciando.AppCreateForm(TfBuscaMusica, fBuscaMusica);
  fBuscaMusica.ShowModal;
  if (fBuscaMusica.id) > 0
    then abreLetraMusica('BD','',fBuscaMusica.id,true);
end;

procedure TfmIndex.RibbonPCButtons3Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    OpenURL(url) {LAZARUS: ShellExecute→OpenURL};
end;

procedure TfmIndex.RibbonPCButtons4Click(Sender: TObject);
begin
  {LAZARUS: RibbonPC.AppMenu.ItemIndex/ShowAppMenu removidos — TPageControl nao tem AppMenu}
end;

procedure TfmIndex.RibbonPCButtons5Click(Sender: TObject);
begin
  if (fHelp <> nil) and (fHelp.Visible) then
  begin
    fHelp.Close;
    fmIndex.Refresh;
  end;

  fIniciando.AppCreateForm(TfHelp, fHelp);
  if (Screen.ActiveForm.Name <> 'fmIndex') then
    fHelp.tabPage := Screen.ActiveForm.Name
  else if PageControl1.Visible then
    fHelp.tabPage := PageControl1.ActivePage.Name
  else
    fHelp.tabPage := '';
  fHelp.ShowModal;
end;

procedure TfmIndex.RibbonPCChangePage(Sender: TObject);
begin
  if (RibbonPC.ActivePage.Tag = 0) and (pnlfmSubTituloRib.Tag = 1) then
    pnlfmSubTituloRib.Visible := True
  else
    pnlfmSubTituloRib.Visible := False;

  if RibbonPC.ActivePage = bsFavoritos then
  begin
    if (loadCol.Strings.Values['RIBP_FAVORITOS'] <> 'okf') then
    begin
      loadCol.Strings.Values['RIBP_FAVORITOS'] := 'okf';
      carregaFavoritos();
    end;
  end;
end;

procedure TfmIndex.bsRibbonGroup19DialogButtonClick(Sender: TObject);
begin
  pnLivros.Visible := not pnLivros.Visible;
  ajustaTexto('BIBLIA_BUSCA');
end;

procedure TfmIndex.bsSkinButton10Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := False;
    lbSorteioNMItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton11Click(Sender: TObject);
var
  i: integer;
  item: string;
  linha: integer;
begin
  for i := lbSorteioNM.Items.Count - 1 downto 0 do
  begin
    lbSorteioNM.ItemIndex := i;
    if (lbSorteioNM.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} = True) then
    begin
      item := lbSorteioNM.Items[lbSorteioNM.ItemIndex] {LAZARUS: TCheckListBox — Items[] is string};
      lbSorteioNM.Items.Delete(i);
      vlSorteadosNM.FindRow(item, linha);
      if linha >= 0 then
        vlSorteadosNM.DeleteRow(linha);
    end;
  end;

  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    item := lbSorteioNM.Items[lbSorteioNM.ItemIndex] {LAZARUS: TCheckListBox — Items[] is string};
    vlSorteioNM.Strings.Values[item] := IntToStr(lbSorteioNM.ItemIndex);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  end;

  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton12Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := not lbSorteioNM.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]};
    lbSorteioNMItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton13Click(Sender: TObject);
begin
  lbCrono.Items.Clear;
  loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] := '1';
  if fMonitorCronometro <> nil then
  begin
    fMonitorCronometro.lbCrono.Items := lbCrono.Items;
  end;
end;

procedure TfmIndex.bsSkinButton15Click(Sender: TObject);
begin
  abrirArquivo(dir_config + 'BD.mdb');
end;

procedure TfmIndex.bsSkinButton1Click(Sender: TObject);
var
  id: string;
begin
  txtAbrirColetExit(Sender);
  id := cbColetaneasPerso.KeyValue;

  if cbColetaneasPerso.KeyValue <= 0 then
  begin
    application.messagebox('Escolha uma coletânea para aterar!', TITULO, MB_OK + mb_iconexclamation);
    cbColetaneasPerso.SetFocus;
    {LAZARUS: cbColetaneasPerso.DropDown — TComboBox nao tem metodo DropDown}
    exit;
  end;

  if (trim(txtColetanea2.Text) = '') then
  begin
    application.messagebox('Digite o nome da coletânea!', TITULO, MB_OK + mb_iconexclamation);
    txtColetanea2.SetFocus;
    exit;
  end;

  DM.cdsCOLETANEAS_PERSO.Filtered := false;
  DM.cdsCOLETANEAS_PERSO.Filter := 'UPPER(NOME) = UPPER(' + (QuotedStr(txtColetanea2.Text)) + ') AND ID <> ' + id;
  DM.cdsCOLETANEAS_PERSO.Filtered := True;
  if (DM.cdsCOLETANEAS_PERSO.RecordCount > 0) then
  begin
    application.messagebox('Já existe uma coletânea com este nome!', TITULO, MB_OK + mb_iconexclamation);
    txtColetanea2.SetFocus;
    DM.cdsCOLETANEAS_PERSO.Filtered := false;
    exit;
  end
  else
    DM.cdsCOLETANEAS_PERSO.Filtered := false;

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  DM.cdsCOLETANEAS_PERSO.Edit;
  DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').Value := txtColetanea2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL_INFO').Value := txtUrlInfoColet2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL').Value := txtAbrirColet2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value := txtImgInfoColet2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value := txtCapaColet2.text;
  DM.cdsCOLETANEAS_PERSO.Post;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  txtColetanea2.text := '';
  txtUrlInfoColet2.text := '';
  txtAbrirColet2.text := '';
  txtImgInfoColet2.text := '';
  txtCapaColet2.text := '';
  cbColetaneasPersoChange(Sender);

  importColetaneasPerso();
end;

procedure TfmIndex.bsSkinButton20Click(Sender: TObject);
begin
  if DM.cdsBIBLIA_HISTORICO.RecordCount <= 0 then Exit;

  if (DM.cdsBIBLIA_HISTORICO.Locate('VERSAO;LIVRO;CAPITULO;VERSICULO', VarArrayOf([loadCol.Strings.Values['BIBLIA_P_VERSAO'],loadCol.Strings.Values['BIBLIA_P_LIVRO'],loadCol.Strings.Values['BIBLIA_P_CAPITULO'],loadCol.Strings.Values['BIBLIA_P_VERSICULO']]), [])) then
    DM.cdsBIBLIA_HISTORICO.Delete;
end;

procedure TfmIndex.bsSkinButton21Click(Sender: TObject);
var
  Item: TListItem;
  existe: Boolean;
  a_sim: Integer;
//  a_nao: Integer;
  tag: integer;
  tabela,campo,campo_a,campo_id: string;
  tamanho: Longint;
  url: string;
begin
  gProgresso.Position {LAZARUS: TProgressBar.Value->Position} := 0;
  lvArquivos.Items.Clear;
  a_sim := 0;
//  a_nao := 0;
  tag := TButton {LAZARUS: TbsSkinButton}(Sender).Tag;

  DM.qrARQUIVOS_SISTEMA.Close;
  DM.qrARQUIVOS_SISTEMA.Open;
  DM.qrARQUIVOS_SISTEMA.First;
  gProgresso.Max {LAZARUS: TProgressBar.MaxValue->Max} := DM.qrARQUIVOS_SISTEMA.RecordCount;

  while not DM.qrARQUIVOS_SISTEMA.eof do
  begin
    url := DM.qrARQUIVOS_SISTEMA.FieldByName('URL').AsString;
    url := StringReplace(url, '\', PathDelim, [rfReplaceAll]); {LAZARUS: normaliza separador Windows→OS p/ acesso ao FS local}
    if (fIniciando.paramexec.Strings.Values['dir_config'] <> '') then
      url := StringReplace(url,'config'+PathDelim,fIniciando.paramexec.Strings.Values['dir_config']+PathDelim,[rfIgnoreCase, rfReplaceAll]);
    existe := (FileExists(ExtractFilePath(application.ExeName)+'/'+url));

    if not existe then
    begin
      Item := lvArquivos.Items.Add;
      Item.Checked := not existe;
      Item.Caption := DM.qrARQUIVOS_SISTEMA.FieldByName('ARQUIVO').AsString;
      Item.SubItems.Add(url);
//      a_nao := a_nao + 1;
      Item.SubItems.Add('0');
      Item.SubItems.Add('Não encontrado');
    end
    else
    begin
      tamanho := FileSize(url);

      if   ((tag = 1) and (DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger <= 0))
        or ((tag = 2) and (DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger < tamanho))
        or ((tag = 3) and (DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger > tamanho))
        or (tag < 1) then
      begin
        tabela := '';
        campo := '';
        campo_a := '';

        if DM.qrARQUIVOS_SISTEMA.FieldByName('TABELA').AsString <> '' then
        begin
          tabela := DM.qrARQUIVOS_SISTEMA.FieldByName('TABELA').AsString;
          campo_a := DM.qrARQUIVOS_SISTEMA.FieldByName('CAMPO_ARQ').AsString;
          campo := DM.qrARQUIVOS_SISTEMA.FieldByName('CAMPO_ARQ_TAM').AsString;
          campo_id := DM.qrARQUIVOS_SISTEMA.FieldByName('CHAVE').AsString;
        end;

        if (tabela <> '') then
        begin

          DM.qrGRAVA_TAMANHO_ARQUIVO.Close;
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Clear;
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Add('UPDATE '+tabela+' SET');
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Add(campo+' = '+inttostr(tamanho));
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Add('WHERE '+campo_a+' = "'+campo_id+'"');
          DM.qrGRAVA_TAMANHO_ARQUIVO.ExecSQL;

          Item := lvArquivos.Items.Add;
          Item.Checked := not existe;
          Item.Caption := DM.qrARQUIVOS_SISTEMA.FieldByName('ARQUIVO').AsString;
          Item.SubItems.Add(url);
//          a_nao := a_nao + 1;
          Item.SubItems.Add(IntToStr(tamanho)+'/'+inttostr(DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger));
          Item.SubItems.Add('Atualizado');

          a_sim := a_sim + 1;
        end;
      end;
    end;

    gProgresso.Position {LAZARUS: TProgressBar.Value->Position} := DM.qrARQUIVOS_SISTEMA.RecNo;
    Application.ProcessMessages;
    DM.qrARQUIVOS_SISTEMA.Next;
  end;

  application.MessageBox(PChar('Arquivos atualizados: '+inttostr(a_sim)), fmIndex.titulo, mb_ok + MB_ICONINFORMATION);

end;

procedure TfmIndex.bsSkinButton24Click(Sender: TObject);
begin
  {LAZARUS: bgOnlCanais.ItemIndex — TToolBar sem ItemIndex; usando ItemIndex 0}
  if lbbgOnlCanais.Items.Count > 0 then
    atualiza_coletaneas_web('playlists', lbbgOnlCanais.Items[0]);
end;

procedure TfmIndex.bsSkinButton25Click(Sender: TObject);
begin
  atualiza_coletaneas_web('canais');
end;

procedure TfmIndex.bsSkinButton26Click(Sender: TObject);
begin
  {LAZARUS: bgOnlPlaylists.ItemIndex — TToolBar sem ItemIndex; usando ItemIndex 0}
  if lbbgOnlPlaylists.Items.Count > 0 then
    atualiza_coletaneas_web('videos', lbbgOnlPlaylists.Items[0]);
end;

procedure TfmIndex.bsSkinButton2Click(Sender: TObject);
begin
  if (application.MessageBox(PChar('Deseja restaurar a formatação do texto?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  apagaParam('Musicas', 'Cor Titulo');
  apagaParam('Musicas', 'Cor Texto');
  apagaParam('Musicas', 'Cor Texto Repetido');
  apagaParam('Musicas', 'Cor Texto Aux');
  apagaParam('Musicas', 'FundoTransparente');
  apagaParam('Musicas', 'Tamanho Titulo');
  apagaParam('Musicas', 'Tamanho Texto');
  apagaParam('Musicas', 'Tamanho Texto Aux');

  corTituloMusica.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(fmIndex.lerParam('Musicas', 'Cor Titulo', '$000b4ef'));
  corTextoMusica.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(fmIndex.lerParam('Musicas', 'Cor Texto', '$0FFFFFF'));
  corTextoRepetido.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(fmIndex.lerParam('Musicas', 'Cor Texto Repetido', '$000b4ef'));
  corTextoAuxMusica.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor} := StringToColor(fmIndex.lerParam('Musicas', 'Cor Texto Aux', '$000b4ef'));
  ckMusicaFundoTransparente.Checked := (fmIndex.lerParam('Musicas', 'FundoTransparente', '0') = '1');
  seTamanhoTitulo.Text := fmIndex.lerParam('Musicas', 'Tamanho Titulo', '18');
  seTamanhoTexto.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto', '14');
  seTamanhoTextoAux.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto Aux', '10');

end;

procedure TfmIndex.btAddColetPersoClick(Sender: TObject);
var
  id: string;
begin
  txtAbrirColetExit(Sender);
  if (trim(txtColetanea.Text) = '') then
  begin
    application.messagebox('Digite o nome da coletânea!', fmIndex.TITULO, MB_OK + mb_iconexclamation);
    txtColetanea.SetFocus;
    exit;
  end;

  if (DM.cdsCOLETANEAS_PERSO.Locate('NOME', txtColetanea.text, [])) then
  begin
    application.messagebox('Já existe uma coletânea com este nome!', fmIndex.TITULO, MB_OK + mb_iconexclamation);
    txtColetanea.SetFocus;
    exit;
  end;

  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsCOLETANEAS_PERSO.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível salvar. Clique em salvar novamente!', fmIndex.TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsCOLETANEAS_PERSO.Append;
  DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value := id;
  DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').Value := txtColetanea.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL_INFO').Value := txtUrlInfoColet.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL').Value := txtAbrirColet.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value := txtImgInfoColet.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value := txtCapaColet.text;
  DM.cdsCOLETANEAS_PERSO.Post;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  txtColetanea.text := '';
  txtUrlInfoColet.text := '';
  txtAbrirColet.text := '';
  txtImgInfoColet.text := '';
  txtCapaColet.text := '';

  importColetaneasPerso();
end;

procedure TfmIndex.bsSkinButton34Click(Sender: TObject);
begin
  abrirArquivo(dir_dados + 'liturgia.ja');
end;

procedure TfmIndex.bsSkinButton36Click(Sender: TObject);
begin
  {LAZARUS: RibbonPC.AppMenu.Visible removido — TPageControl nao tem AppMenu}
  fIniciando.AppCreateForm(TfArquivosExcesso,fArquivosExcesso);
  fArquivosExcesso.showmodal;
end;

procedure TfmIndex.bsSkinButton38Click(Sender: TObject);
begin
  {LAZARUS: RibbonPC.AppMenu.Visible removido — TPageControl nao tem AppMenu}
  fIniciando.AppCreateForm(TfArquivosFalta,fArquivosFalta);
  fArquivosFalta.showmodal;
end;

procedure TfmIndex.bsSkinButton3Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := True;
    lbSorteioItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton43Click(Sender: TObject);
var
  item: TStringList;
  i,id: integer;
  str: string;
begin
  item := TStringList.Create;
  lbHlpTemp.lines.Clear;
  lbHlpArquivos.Items.Clear;
  lbHlpImagens.Items.Clear;
  lbHlpFalta.Items.Clear;

  lblStatusHlp.Caption := 'Inicando Verificação...';
  Application.ProcessMessages;
  //Sleep(500);

  lblStatusHlp.Caption := 'Apagando tabela de arquivos Help...';
  Application.ProcessMessages;
  DM.qrARQUIVOS_HELP_DELETE.ExecSQL;
  //Sleep(500);

  lblStatusHlp.Caption := 'Buscando Arquivos de Ajuda...';
  Application.ProcessMessages;
  if not FileExists(dir_config+'help/menu.hja' {LAZARUS: '\' → '/' separador Linux}) then
  begin
    lbHlpFalta.Items.Add('menu.hja');
    lblStatusHlp.Caption := 'Arquivo de Menu não encontrado. Finalizado!';
    Exit;
  end;

  lbHlpTemp.lines.LoadFromFile(dir_config+'help/menu.hja' {LAZARUS: '\' → '/' separador Linux});
  lbHlpArquivos.Items.Add('menu.hja');
  for i := 0 to lbHlpTemp.lines.Count-1 do
  begin
    item.Clear;
    ExtractStrings(['|'], [], PChar(lbHlpTemp.lines[i]+'|_|_|_'), item);

    if item[1] = '_' then Continue;

    if not FileExists(dir_config+'help/'+item[1]) then {LAZARUS: '\' → '/' separador Linux}
    begin
      if lbHlpFalta.Items.IndexOf(item[1]) < 0
        then lbHlpFalta.Items.Add(item[1]);
    end
    else
    begin
      if lbHlpArquivos.Items.IndexOf(item[1]) < 0
        then lbHlpArquivos.Items.Add(item[1]);
    end;
  end;
  //Sleep(500);

  lblStatusHlp.Caption := 'Buscando Imagens...';
  Application.ProcessMessages;
  for i := 0 to lbHlpArquivos.Items.Count-1 do
  begin
    lblStatusHlp.Caption := 'Buscando Imagens... Arquivo '+inttostr(i+1)+' de '+inttostr(lbHlpArquivos.Items.Count)+' ('+lbHlpArquivos.Items[i]+')';
    Application.ProcessMessages;

    lbHlpTemp.Lines.Clear;
    lbHlpTemp.Lines.LoadFromFile(dir_config+'help/'+lbHlpArquivos.Items[i]); {LAZARUS: '\' → '/' separador Linux}
    lbHlpTemp.Text := StringReplace(lbHlpTemp.Text, #13#10, '', [rfIgnoreCase, rfReplaceAll]);
    lbHlpTemp.Text := StringReplace(lbHlpTemp.Text, ' ', '', [rfIgnoreCase, rfReplaceAll]);
    lbHlpTemp.Text := StringReplace(lbHlpTemp.Text, '[DIR_HLP]', '', [rfIgnoreCase, rfReplaceAll]);
    while (pos('<imgsrc',lbHlpTemp.Text) > 0) do
    begin
      lbHlpTemp.Text := Copy(lbHlpTemp.Text,pos('<imgsrc',lbHlpTemp.Text)+9,length(lbHlpTemp.Text));
      str := Copy(lbHlpTemp.Text,0,pos('''',lbHlpTemp.Text)-1);
      lbHlpTemp.Text := Copy(lbHlpTemp.Text,pos('''',lbHlpTemp.Text)+1,length(lbHlpTemp.Text));

      if not FileExists(dir_config+'help/imgs/'+str) then {LAZARUS: '\' → '/' separador Linux}
      begin
        if lbHlpFalta.Items.IndexOf(str) < 0
          then lbHlpFalta.Items.Add(str);
      end
      else
      begin
        if lbHlpImagens.Items.IndexOf(str) < 0
          then lbHlpImagens.Items.Add(str);
      end;
    end;
  end;
  //Sleep(500);


  lblStatusHlp.Caption := 'Gravando no Banco de Dados...';
  Application.ProcessMessages;
  id := 0;
  for i := 0 to lbHlpArquivos.Items.Count-1 do
  begin
    id := id + 1;
    lblStatusHlp.Caption := 'Gravando no Banco de Dados... Registro '+inttostr(id)+' de '+inttostr(lbHlpArquivos.Items.Count+lbHlpImagens.Items.Count)+' ('+lbHlpArquivos.Items[i]+')';
    Application.ProcessMessages;

    DM.qrARQUIVOS_HELP.Close;
    DM.qrARQUIVOS_HELP.ParamByName('ID').Value := id;
    DM.qrARQUIVOS_HELP.ParamByName('ARQUIVO').Value := ExtractFileName(lbHlpArquivos.Items[i]);
    DM.qrARQUIVOS_HELP.ParamByName('URL').Value := 'config\help\'+lbHlpArquivos.Items[i];
    DM.qrARQUIVOS_HELP.ExecSQL;
  end;
  for i := 0 to lbHlpImagens.Items.Count-1 do
  begin
    id := id + 1;
    lblStatusHlp.Caption := 'Gravando no Banco de Dados... Registro '+inttostr(id)+' de '+inttostr(lbHlpArquivos.Items.Count+lbHlpImagens.Items.Count)+' ('+lbHlpImagens.Items[i]+')';
    Application.ProcessMessages;

    DM.qrARQUIVOS_HELP.Close;
    DM.qrARQUIVOS_HELP.ParamByName('ID').Value := id;
    DM.qrARQUIVOS_HELP.ParamByName('ARQUIVO').Value := ExtractFileName(lbHlpImagens.Items[i]);
    DM.qrARQUIVOS_HELP.ParamByName('URL').Value := 'config\help\imgs\'+lbHlpImagens.Items[i];
    DM.qrARQUIVOS_HELP.ExecSQL;
  end;

  lblStatusHlp.Caption := 'Finalizado!';
  Application.ProcessMessages;
end;

procedure TfmIndex.bsSkinButton44Click(Sender: TObject);
var
  bass_musica: HSAMPLE = 0;
  bass_channel: HCHANNEL;
  mus: Boolean;
  musica: string;
  tempo: QWORD;
  ntempo: string;
  query: string;
  erro: boolean;
begin
  mus := false;
  erro := False;

  Memo1.Lines.clear();
  Memo1.Lines.Add('****INICIANDO****');

  DM.qrMUSICA_ATUALIZAR.Close;
  DM.qrMUSICA_ATUALIZAR.Open;


  while not DM.qrMUSICA_ATUALIZAR.eof do
  begin
    erro := False;
    Memo1.Lines.Add(DM.qrMUSICA_ATUALIZAR.FieldByName('ID').AsString+' - '+DM.qrMUSICA_ATUALIZAR.FieldByName('NOME').AsString);

    DM.qrSLIDE_MUSICA.Close;
    DM.qrSLIDE_MUSICA.ParamByName('MUSICA_ID').Value := DM.qrMUSICA_ATUALIZAR.FieldByName('ID').AsInteger;
    DM.qrSLIDE_MUSICA.Open;
    DM.qrSLIDE_MUSICA.First;

    Memo1.Lines.Add(' >> Verifica PLAYBACK!');
    while not DM.qrSLIDE_MUSICA.eof do
    begin
      if (DM.qrSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA') then
      begin
        musica := DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString;
        if (musica <> '') then
        begin
          musica := diretorio(ExtractFilePath(Application.ExeName)+'\config\musicas\'+musica);
          Memo1.Lines.Add(musica);
          if (mus) then
          begin
            BASS_MusicFree(bass_musica);
            BASS_Free();
          end;

          try
            BASS_Init(-1, 44100, 0, nil, nil) {LAZARUS: Handle→nil (Linux BASS_Init)};
          except
            //
          end;
          bass_musica := BASS_SampleLoad(FALSE, PChar(musica), 0, 0, 3, BASS_SAMPLE_OVER_POS or BASS_UNICODE);
          bass_channel := BASS_SampleGetChannel(bass_musica, False);
          if not BASS_ChannelPlay(bass_channel, False) then
          begin
            Memo1.Lines.Add(' >> Erro ao carregar audio!');
            musica := '';
            erro := True;
          end;
          mus := True;
        end;
      end
      else
      begin

        if (musica <> '') then
        begin
          tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO_PB').AsInteger;
          if (tempo <= 0) then
            tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO').AsInteger;

          ntempo := floattostr(BASS_ChannelBytes2Seconds(bass_channel,tempo));
          Memo1.Lines.Add('TEMPO: '+inttostr(tempo)+' >> '+ntempo);

          Try
            query := 'UPDATE MUSICAS_LETRA SET TEMPO_PB_s='+ntempo+' WHERE ID='+DM.qrSLIDE_MUSICA.FieldByName('LETRA_ID').AsString;
            DM.qrBD.Close;
            DM.qrBD.SQL.Clear;
            DM.qrBD.SQL.Text := query;
            DM.qrBD.ExecSQL;
          Except
            on E: Exception do
            begin
              Memo1.Lines.Add('ERRO SQL: '+E.Message);
              musica := '';
              erro := True;
            end;
          end;
        end;

      end;

      Application.ProcessMessages;
      DM.qrSLIDE_MUSICA.Next;
    end;

    Memo1.Lines.Add(' >> Verifica VOCAL!');
    DM.qrSLIDE_MUSICA.First;
    while not DM.qrSLIDE_MUSICA.eof do
    begin
      if (DM.qrSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA') then
      begin
        musica := DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString;
        if (musica <> '') then
        begin
          musica := diretorio(ExtractFilePath(Application.ExeName)+'\config\musicas\'+musica);
          Memo1.Lines.Add(musica);
          if (mus) then
          begin
            BASS_MusicFree(bass_musica);
            BASS_Free();
          end;

          try
            BASS_Init(-1, 44100, 0, nil, nil) {LAZARUS: Handle→nil (Linux BASS_Init)};
          except
            //
          end;
          bass_musica := BASS_SampleLoad(FALSE, PChar(musica), 0, 0, 3, BASS_SAMPLE_OVER_POS or BASS_UNICODE);
          bass_channel := BASS_SampleGetChannel(bass_musica, False);
          if not BASS_ChannelPlay(bass_channel, False) then
          begin
            Memo1.Lines.Add(' >> Erro ao carregar audio!');
            musica := '';
            erro := True;
          end;
          mus := True;
        end;
      end
      else
      begin

        if (musica <> '') then
        begin
          tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO').AsInteger;
          ntempo := floattostr(BASS_ChannelBytes2Seconds(bass_channel,tempo));
          Memo1.Lines.Add('TEMPO: '+inttostr(tempo)+' >> '+ntempo);

          Try
            query := 'UPDATE MUSICAS_LETRA SET TEMPO_S='+ntempo+' WHERE ID='+DM.qrSLIDE_MUSICA.FieldByName('LETRA_ID').AsString;
            DM.qrBD.Close;
            DM.qrBD.SQL.Clear;
            DM.qrBD.SQL.Text := query;
            DM.qrBD.ExecSQL;
          Except
            on E: Exception do
            begin
              Memo1.Lines.Add('ERRO SQL: '+E.Message);
              musica := '';
              erro := True;
            end;
          end;
        end;

      end;

      Application.ProcessMessages;
      DM.qrSLIDE_MUSICA.Next;
    end;
    DM.qrSLIDE_MUSICA.Close;

    if (musica <> '') and (erro <> True) then
    begin
      Memo1.Lines.Add(' >> Salva no Banco de Dados!');
      query := 'UPDATE MUSICAS SET `_AJUSTADO`=1  WHERE ID='+DM.qrMUSICA_ATUALIZAR.FieldByName('ID').AsString;
      DM.qrBD.Close;
      DM.qrBD.SQL.Clear;
      DM.qrBD.SQL.Text := query;
      DM.qrBD.ExecSQL;
    end;

    Application.ProcessMessages;
    DM.qrMUSICA_ATUALIZAR.Next;
  end;
  DM.qrMUSICA_ATUALIZAR.Close;

  Memo1.Lines.Add('****FIM****');
end;

procedure TfmIndex.bsSkinButton45Click(Sender: TObject);
begin
  atualizaIgnoreAlbum;
  sTabSheet13Show(Sender);
end;

procedure TfmIndex.bsSkinButton46Click(Sender: TObject);
var
  ids: string;
begin
  ids := lerParam('Config','IgnorarAlbuns','');
  ids := StringReplace(','+ids+',', ',629,', ',', [rfIgnoreCase, rfReplaceAll]);
  ids := StringReplace(ids,',,', ',', [rfIgnoreCase, rfReplaceAll]);
  if (copy(ids,1,1) = ',') then
    ids := copy(ids,2,length(ids));
  if (copy(ids,length(ids),1) = ',') then
    ids := copy(ids,1,length(ids)-1);

  gravaParam('Config','IgnorarAlbuns',ids);

  atualizaIgnoreAlbum;

  DM.qrALBUM_ATIV.Close;
  DM.qrALBUM_ATIV.Open;
  DM.qrALBUM_INATIV.Close;
  DM.qrALBUM_INATIV.Open;

  tsHinarioNShow(Sender);
end;

procedure TfmIndex.bsSkinButton47Click(Sender: TObject);
begin
  if (application.MessageBox(PChar('Deseja restaurar a formatação do texto na tela de retorno?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  apagaParam('Musicas', 'Tamanho Texto Retorno');

  seTamanhoTextoRetorno.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto Retorno', '17');
end;

procedure TfmIndex.bsSkinButton4Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := False;
    lbSorteioItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton5Click(Sender: TObject);
var
  i: integer;
  item: string;
  linha: integer;
begin
  for i := lbSorteio.Items.Count - 1 downto 0 do
  begin
    lbSorteio.ItemIndex := i;
    if (lbSorteio.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} = True) then
    begin
      item := lbSorteio.Items[lbSorteio.ItemIndex] {LAZARUS: TCheckListBox — Items[] is string};
      lbSorteio.Items.Delete(i);
      vlSorteados.FindRow(item, linha);
      if linha >= 0 then
        vlSorteados.DeleteRow(linha);
    end;
  end;

  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    item := lbSorteio.Items[lbSorteio.ItemIndex] {LAZARUS: TCheckListBox — Items[] is string};
    vlSorteio.Strings.Values[item] := IntToStr(lbSorteio.ItemIndex);
  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  end;

  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton6Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := not lbSorteio.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]};
    lbSorteioItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton7Click(Sender: TObject);
begin
  lbSorteadoNM.Items.Clear;
  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteadoNM.Items := lbSorteadoNM.Items;
  end;
end;

procedure TfmIndex.bsSkinButton8Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := True;
    lbSorteioNMItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton9Click(Sender: TObject);
begin
  lbSorteado.Items.Clear;
  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteado.Items := lbSorteado.Items;
  end;
end;

procedure TfmIndex.opcCronoCTempoClick(Sender: TObject);
begin
  meESHora.Enabled := (opcCronoCTempo.ItemIndex = 0);
  meESDuracao.Enabled := (opcCronoCTempo.ItemIndex = 1);
  if carrega_opc then exit;

  if (meESHora.Enabled) then meESHora.SetFocus;
  if (meESDuracao.Enabled) then meESDuracao.SetFocus;

  gravaParam('Escola Sabatina', 'TempoFim', inttostr(opcCronoCTempo.ItemIndex));
end;

procedure TfmIndex.busBibliaCapituloChange(Sender: TObject);
begin
  DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',(busBibliaCapitulo.ItemIndex+1),[]);
end;

procedure TfmIndex.busBibliaCapituloExit(Sender: TObject);
begin
  busBibliaCapitulo.Text := busBibliaCapitulo.Items[busBibliaCapitulo.ItemIndex];
  DBCtrlGridBibliaCapituloClick(Sender);
end;

procedure TfmIndex.busBibliaLivroChange(Sender: TObject);
begin
  DM.qrBIBLIA_LIVROS.Locate('ID',(busBibliaLivro.ItemIndex+1),[]);
end;

procedure TfmIndex.busBibliaLivroExit(Sender: TObject);
begin
  busBibliaLivro.Text := busBibliaLivro.Items[busBibliaLivro.ItemIndex];
  DBCtrlGridBibliaLivroClick(Sender);
end;

procedure TfmIndex.gridAlbAtDblClick(Sender: TObject);
var
  ids: string;
  DataSet : TDataSet;
  DBGrid: TDBGrid {LAZARUS: TbsSkinDBGrid};
  Query: TZQuery {LAZARUS: TFDQuery};
  i: integer;
begin
  DBGrid := gridAlbAt;
  DataSet := DBGrid.DataSource.DataSet;
  Query := DM.qrALBUM_ATIV;

  if not Query.Active then Exit;
  if Query.RecNo <= 0 then Exit;
  if DBGrid.SelectedRows.Count <= 0
    then DBGrid.SelectedRows.CurrentRowSelected := True;

  ids := lerParam('Config','IgnorarAlbuns','');
  try
   DataSet.DisableControls;
   for i := 0 to DBGrid.SelectedRows.Count-1 do
   begin
//     DataSet.GotoBookmark(Pointer(DBGrid.SelectedRows.Items[i]));
     if ids <> '' then ids := ids+',';
     ids := ids+Query.FieldByName('ID').AsString;
   end;
  finally
    DataSet.EnableControls;
  end;


  gravaParam('Config','IgnorarAlbuns',ids);
  atualizaIgnoreAlbum;
  Query.Close;
  Query.Open;

  DM.qrALBUM_INATIV.Close;
  DM.qrALBUM_INATIV.Open;
  FormResize(Sender);
end;

procedure TfmIndex.gridAlbInatDblClick(Sender: TObject);
var
  ids: string;
  DataSet : TDataSet;
  DBGrid: TDBGrid {LAZARUS: TbsSkinDBGrid};
  Query: TZQuery {LAZARUS: TFDQuery};
  i: integer;
begin
  DBGrid := gridAlbInat;
  DataSet := DBGrid.DataSource.DataSet;
  Query := DM.qrALBUM_INATIV;

  if not Query.Active then Exit;
  if Query.RecNo <= 0 then Exit;
  if DBGrid.SelectedRows.Count <= 0
    then DBGrid.SelectedRows.CurrentRowSelected := True;

  ids := lerParam('Config','IgnorarAlbuns','');
  try
   DataSet.DisableControls;
   for i := 0 to DBGrid.SelectedRows.Count-1 do
   begin
//     DataSet.GotoBookmark(Pointer(DBGrid.SelectedRows.Items[i]));
      ids := StringReplace(','+ids+',', ','+Query.FieldByName('ID').AsString+',', ',', [rfIgnoreCase, rfReplaceAll]);
      if Copy(ids,1,1)=',' then
        ids := copy(ids,2,length(ids));
      if Copy(ids,length(ids),1)=',' then
        ids := copy(ids,1,length(ids)-1);
   end;
  finally
    DataSet.EnableControls;
  end;

  gravaParam('Config','IgnorarAlbuns',ids);
  atualizaIgnoreAlbum;
  Query.Close;
  Query.Open;
  DM.qrALBUM_ATIV.Close;
  DM.qrALBUM_ATIV.Open;
  FormResize(Sender);
end;

procedure TfmIndex.busBibliaVersiculoChange(Sender: TObject);
begin
  carregaBiblia('VSC');
end;

procedure TfmIndex.busBibliaVersiculoKeyPress(Sender: TObject; var Key: Char);
var
  desc_passagem:string;
begin
  if Key = #13 then
  begin
    Key := #0;

    if DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.Eof
      then Exit;

//    DBCtrlGridBibliaVersiculoClick(Sender);
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := geraIntervaloNum(GetStrNumber2(trim(busBibliaVersiculo.Text)));

    if (loadCol.Strings.Values['BIBLIA_VERSICULO'] = '0') or (trim(loadCol.Strings.Values['BIBLIA_VERSICULO']) = '') then
    begin
      DBCtrlGridBibliaVersiculoClick(Sender);
      exit;
    end;

    loadCol.Strings.Values['BIBLIA_P_VERSAO'] := loadCol.Strings.Values['BIBLIA_VERSAO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO'] := loadCol.Strings.Values['BIBLIA_LIVRO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_P_CAPITULO'] := loadCol.Strings.Values['BIBLIA_CAPITULO'];
    loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := loadCol.Strings.Values['BIBLIA_VERSICULO'];

    lmdBibliaTxt.Caption := '';
    DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.First;
    while not DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.Eof do
    begin
      if lmdBibliaTxt.Caption <> ''
        then lmdBibliaTxt.Caption := lmdBibliaTxt.Caption+#13#10;

      lmdBibliaTxt.Caption := lmdBibliaTxt.Caption+DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.FieldByName('PASSAGEM').AsString;
      DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.Next;
    end;
    lmdBibliaTxt.Caption := '"'+removeTagsHTML(lmdBibliaTxt.Caption)+'"';

    lmdBibliaInfo.Caption := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']+' '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+formataIntervaloNum(loadCol.Strings.Values['BIBLIA_P_VERSICULO'])+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
    ajustaTexto('BIBLIA');
    copiaDadosTelaExtendida;

    if (fTransmitir.btServidor.ImageIndex <> 8) then
    begin
       fmIndex.gravaParamServer('BIBLIA', 'texto', lmdBibliaTxt.Caption);
       fmIndex.gravaParamServer('BIBLIA', 'info', lmdBibliaInfo.Caption);
    end;

    gravaParam('Biblia', 'Versão',loadCol.Strings.Values['BIBLIA_P_VERSAO']);
    gravaParam('Biblia', 'Livro',loadCol.Strings.Values['BIBLIA_P_LIVRO']);
    gravaParam('Biblia', 'Livro Sigla',loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']);
    gravaParam('Biblia', 'Livro Nome',loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']);
    gravaParam('Biblia', 'Capitulo',loadCol.Strings.Values['BIBLIA_P_CAPITULO']);
    gravaParam('Biblia', 'Versiculo',loadCol.Strings.Values['BIBLIA_P_VERSICULO']);

    desc_passagem := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']+'. '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+formataIntervaloNum(loadCol.Strings.Values['BIBLIA_P_VERSICULO'])+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
    if (DM.cdsBIBLIA_HISTORICO.Locate('DESC_PASSAGEM', desc_passagem, [])) then
    begin
      DM.cdsBIBLIA_HISTORICO.Edit;
    end
    else
    begin
      DM.cdsBIBLIA_HISTORICO.Append;
      DM.cdsBIBLIA_HISTORICO.FieldByName('ID').Value := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
      DM.cdsBIBLIA_HISTORICO.FieldByName('DATAHORA').Value := Now;
    end;
    DM.cdsBIBLIA_HISTORICO.FieldByName('VERSAO').Value := loadCol.Strings.Values['BIBLIA_P_VERSAO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('LIVRO').Value := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('CAPITULO').Value := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('VERSICULO').Value := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('PASSAGEM').Value := DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.FieldByName('PASSAGEM_ORI').AsString;
    DM.cdsBIBLIA_HISTORICO.FieldByName('DESC_PASSAGEM').Value := desc_passagem;
    DM.cdsBIBLIA_HISTORICO.Post;


    DBCtrlGridBibliaVersiculo.Refresh;
    DBCtrlGridBibliaVersiculoPaintPanel(DBCtrlGridBibliaVersiculo,0,nil,Rect(1, 1, DBCtrlGridBibliaVersiculo.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGridBibliaVersiculo.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2));
  end;
end;

procedure TfmIndex.pnlAnotacoesLiturgiaClose(Sender: TObject);
begin
  cbAnotacoesLiturgia.Checked := False;
end;

procedure TfmIndex.pnlBibliaHistoricoClose(Sender: TObject);
begin
  cbBibliaHistorico.Checked := false;
  cbBibliaHistoricoClick(Sender);
end;

procedure TfmIndex.itensAgendadosClick(Sender: TObject);
var
  arquivo: string;
  info: string;
begin
  if (DM.cdsItensAgendados.FieldByName('ID').AsString = '') then
  begin
    MonthCalendar1DblClick(MonthCalendar1);
    Exit;
  end;

  arquivo := DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString;
  info := DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').AsString;

  if info = 'I' then
    arquivo := diretorio(ExtractFilePath(Application.ExeName)+'\')+arquivo;


  if (arquivo <> '') then
  begin
    if (FileExists(arquivo)) then
      abrirArquivo(arquivo)
    else
      application.MessageBox(PChar('Arquivo '''+arquivo+''' não encontrado!'),TITULO,mb_ok+mb_iconerror);
  end;
end;

procedure TfmIndex.categoriasItensAgendadosClick(Sender: TObject);
begin
  if (DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString = '') then
  begin
    btAddCategoriaAgendadosClick(Sender);
    Exit;
  end;

  txtCategoria.Text := DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString;
  DM.cdsItensAgendados.Filtered := true;
  DM.cdsItensAgendados.Filter := 'CATEGORIA = '''+txtCategoria.Text+'''';
  pnlItensAgendados.Visible := True;
  {LAZARUS: dbctrlItensAgendados.RowCount/ColCount removidos — TScrollBox nao tem RowCount/ColCount}

  refreshCalendar();
end;

procedure TfmIndex.move_MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Panel: TPanel;
  w: integer;
begin
  if Sender is TImage {LAZARUS: TbsPngImageView}
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);

  move_panel := TPanel.Create(Self);
//  move_panel.Color := Panel.Color;

  move_x := x;
  move_y := y;
  move := True;

  Panel.BringToFront;
  w := Panel.Width;
  Panel.Align := alNone;
  Panel.Width := w;
  Panel.Color := $0085F8FE;
  panel.DoubleBuffered := True;
  sbLiturgia.DoubleBuffered := True;
end;

procedure TfmIndex.move_MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Panel: TPanel;
begin
  if Sender is TImage {LAZARUS: TbsPngImageView}
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);

  if move then
  begin
    Panel.Left := Panel.Left + (x - move_x);
    Panel.Top := Panel.Top + (y - move_y);
  end;
end;

procedure TfmIndex.move_MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Panel: TPanel;
  i: integer;
  itens: TStringList;
begin
  if Sender is TImage {LAZARUS: TbsPngImageView}
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);

  move := False;
  Panel.Align := alTop;
  Panel.Color := move_panel.Color;

  move_panel.Free;
  panel.DoubleBuffered := False;
  sbLiturgia.DoubleBuffered := False;

  itens := TStringList.Create;
  for i := 0 to pred(sbLiturgia.ControlCount) do
  begin
    if sbLiturgia.Controls[i].Visible
      then itens.Add(FormatFloat('000000000',(sbLiturgia.ClientHeight {LAZARUS: VScrollBar.RealClientHeight->ClientHeight}*100)+sbLiturgia.Controls[i].Top)+'|'+sbLiturgia.Controls[i].Name);
  end;
  itens.Sort;
  lbLiturgiaPos.Items.Clear;
  lbLiturgiaPos.Items := itens;
  lbLiturgia.Items.Clear;
  for i := 0 to itens.Count-1 do
    lbLiturgia.Items.Add(Copy(itens[i], Pos('|',itens[i])+1, Length(itens[i])));

  salvaItensLiturgia;
end;

procedure TfmIndex.ckVideoOnJanelaClick(Sender: TObject);
begin
  if ckVideoOnJanela.Checked then
    gravaParam('Videos Online', 'MonitorTelaCheia', '1')
  else
    gravaParam('Videos Online', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.imgCapaProgramaEnter(Sender: TObject);
begin
  imgCapaPrograma.Text := verificaURL(imgCapaPrograma.Text, txtImgCapaProgramaInfo, true);
end;

procedure TfmIndex.imgCapaProgramaExit(Sender: TObject);
begin
  if trim(imgCapaPrograma.Text) <> '' then
  begin
    try
      imgImagemCapa.Picture.LoadFromFile(imgCapaPrograma.Text);
      imgCapaPrograma.Text := verificaURL(imgCapaPrograma.Text, txtImgCapaProgramaInfo);
    except
      application.messagebox(PChar('Arquivo de imagem ''' + imgCapaPrograma.Text + ''' inválido!'), TITULO, MB_OK + mb_iconerror);
      imgImagemCapa.Picture := imgImagemCapaModel.Picture;
      imgCapaPrograma.Text := '';
      txtImgCapaProgramaInfo.Text := '';
    end;
  end
  else
  begin
    imgImagemCapa.Picture := imgImagemCapaModel.Picture;
    txtImgCapaProgramaInfo.Text := '';
  end;
  gravaParam('Config', 'Imagem Fundo', imgCapaPrograma.Text);
  gravaParam('Config', 'Imagem Fundo Info', txtImgCapaProgramaInfo.Text);
end;

procedure TfmIndex.imgFundoMusicaEnter(Sender: TObject);
begin
  imgFundoMusica.Text := verificaURL(imgFundoMusica.Text, txtImgFundoMusicaInfo, true);
end;

procedure TfmIndex.imgFundoMusicaExit(Sender: TObject);
begin
  if trim(imgFundoMusica.Text) <> '' then
  begin
    imgFundoMusica.Text := verificaURL(imgFundoMusica.Text, txtImgFundoMusicaInfo);
  end
  else
  begin
    imgImagemCapa.Picture := imgImagemCapaModel.Picture;
    txtImgCapaProgramaInfo.Text := '';
  end;
  gravaParam('Musicas', 'Imagem Fundo', imgFundoMusica.Text);
  gravaParam('Musicas', 'Imagem Fundo Info', txtImgFundoMusicaInfo.Text);
end;

procedure TfmIndex.cbColorFTxtIChangeColor(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TColorButton {LAZARUS: TbsSkinColorButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Color := TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor};
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.cbColorRTxtIChangeColor(Sender: TObject);
var
  tag: Integer;
  RichEdit:TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TColorButton {LAZARUS: TbsSkinColorButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  RE_SetSelBgColor(RichEdit, TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor});
end;

procedure TfmIndex.cbColorTxtIChangeColor(Sender: TObject);
var
  tag: Integer;
  RichEdit:TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TColorButton {LAZARUS: TbsSkinColorButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  {LAZARUS: RichEdit.SelAttributes.Color — TRichMemo usa SetRangeColor}
  RichEdit.SetRangeColor(RichEdit.SelStart, RichEdit.SelLength, TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor});
end;

procedure TfmIndex.cbFormatoChange(Sender: TObject);
var
  nome,param,subparam: string;
begin
  nome := TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Name;
  if nome = 'cbFormatoHora' then
  begin
    param := 'Relogio';
    subparam := 'FormatoHora';
  end
  else if nome = 'cbFormatoHoraES' then
  begin
    param := 'Escola Sabatina';
    subparam := 'FormatoHora';
  end
  else if nome = 'cbFormatoTempoES' then
  begin
    param := 'Escola Sabatina';
    subparam := 'FormatoTempo';
  end
  else if nome = 'cbFormatoTempoCrono' then
  begin
    param := 'Cronometro';
    subparam := 'FormatoTempo';
  end;


  gravaParam(param, subparam, TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Items[TComboBox {LAZARUS: TbsSkinComboBox}(Sender).ItemIndex])
end;

procedure TfmIndex.cbLayoutChange(Sender: TObject);
begin
  gravaParam('Config', 'Layout', IntToStr(cbLayout.ItemIndex));
  {LAZARUS: DM.bsSkinData1.SkinIndex/SkinList removidos — BusinessSkinForm removido}

  if (layoutValue.Strings.Values['cor'] <> '')
    then pnlfmBarraTituloForm.Color := StringToColor(layoutValue.Strings.Values['cor']);

  if (layoutValue.Strings.Values['cor_escura'] <> '')
    then pnlfmTituloRib.Color := StringToColor(layoutValue.Strings.Values['cor_escura']);

  if (layoutValue.Strings.Values['cor_texto'] <> '')
    then pnlTitForm.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto']);

  if (layoutValue.Strings.Values['cor_texto_marc'] <> '')
    then pnlfmSubTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_marc']);

  if (layoutValue.Strings.Values['cor_texto_tit_ribbon'] <> '')
    then lblfmTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_tit_ribbon']);

  pnlTitForm.Color := pnlfmBarraTituloForm.Color;
  pnlfmSubTituloRib.Color := pnlfmTituloRib.Color;

  btwsMinimize.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btMinimize']);
  if (fmIndex.WindowState = wsMaximized)
    then btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btRestore'])
    else btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btMaximized']);
  btwsClose.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btClose']);
  btwsDownload.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btDownload']);
end;

procedure TfmIndex.rbDirecaoClick(Sender: TObject);
begin
  txtDecr.Enabled := (rbDirecao.ItemIndex = 1);
  if txtDecr.Enabled then
    txtDecr.Setfocus;

  btZerarCronoClick(Sender);
  gravaParam('Cronometro', 'Direcao', IntToStr(rbDirecao.ItemIndex));
end;

function TfmIndex.RecursiveDelete(FullPath: String;nivel: integer): Boolean;
Var
  sr : TSearchRec;
  iRetorno : Integer;
begin
  Result := False;
  FullPath := IncludeTrailingPathDelimiter(FullPath);
  if not(DirectoryExists(FullPath)) then
    Exit;

  iRetorno := FindFirst(FullPath + '*.*', faAnyFile, sr);
  while iRetorno = 0 do
  begin
    if (sr.Name <> '.') and (sr.Name <> '..') then
      if sr.Attr = faDirectory then
        RecursiveDelete(FullPath + sr.Name,nivel+1)
      else
      begin
        {LAZARUS: GetFileAttributes/SetFileAttributes removidos — Windows API}
        SysUtils.DeleteFile(FullPath + sr.Name);
      end;
      iRetorno := FindNext(sr);
  end;
  FindClose(sr);
  if (nivel > 0) then
    Result := RemoveDir(FullPath)
end;

procedure TfmIndex.refreshCalendar;
//var
//  data: TDate;
begin
//  data := EncodeDate(StrToInt(Copy(MonthCalendar1.Date,1,4)), StrToInt(Copy(MonthCalendar1.Date,6,2)), StrToInt(Copy(MonthCalendar1.Date,9,2))); {LAZARUS: TCalendar.Date returns 'YYYY-MM-DD'}
//  MonthCalendar1.Visible := False;
//  MonthCalendar1.Date := IncMonth(data,12);
//  MonthCalendar1.Date := data;
//  MonthCalendar1.Visible := True;
end;

procedure TfmIndex.opSort_NmKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btAddSorteioNMClick(nil);
end;

procedure TfmIndex.lbSorteioNMItemCheckClick(Sender: TObject);
var
  item: string;
  linha: integer;
begin
  item := lbSorteioNM.Items[lbSorteioNM.ItemIndex] {LAZARUS: TCheckListBox — Items[] is string};
  if lbSorteioNM.Checked[lbSorteioNM.ItemIndex] {LAZARUS: TCheckListBox.Items[ItemIndex].Checked->Checked[ItemIndex]} = true then
  begin
    vlSorteadosNM.Strings.Values[item] := IntToStr(lbSorteioNM.ItemIndex);
    vlSorteioNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteioNM.DeleteRow(linha);
  end
  else
  begin
    vlSorteioNM.Strings.Values[item] := IntToStr(lbSorteioNM.ItemIndex);
    vlSorteadosNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteadosNM.DeleteRow(linha);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  end;

  SorteioContador;
end;

procedure TfmIndex.ckMonitorJanelaClick(Sender: TObject);
begin
  if ckMonitorJanela.Checked then
    gravaParam('Config', 'MonitorTelaCheia', '1')
  else
    gravaParam('Config', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.ckSlideFormatPersoExtClick(Sender: TObject);
begin
  if ckSlideFormatPersoExt.Checked then
    gravaParam('Musicas', 'ExternoPersonalizado', '1')
  else
    gravaParam('Musicas', 'ExternoPersonalizado', '0');
end;

procedure TfmIndex.ckSlideImgFormatPersoClick(Sender: TObject);
begin
  bsFormatSlideImgPerso.Visible := False;
  if ckSlideImgFormatPerso.Checked
    then bsFormatSlImgPerso.Height := 48
    else bsFormatSlImgPerso.Height := 24;
  bsFormatSlideImgPerso.Visible := ckSlideImgFormatPerso.Checked;
  if ckSlideImgFormatPerso.Checked then
    gravaParam('Musicas', 'FundoPersonalizado', '1')
  else
    gravaParam('Musicas', 'FundoPersonalizado', '0');
end;

procedure TfmIndex.ckSlideTxtFormatPersoClick(Sender: TObject);
begin
  bsFormatSlidePerso.Visible := False;
  if ckSlideTxtFormatPerso.Checked
    then bsFormatSlPerso.Height := 72
    else bsFormatSlPerso.Height := 24;
  bsFormatSlidePerso.Visible := ckSlideTxtFormatPerso.Checked;
  if ckSlideTxtFormatPerso.Checked then
    gravaParam('Musicas', 'TextoPersonalizado', '1')
  else
    gravaParam('Musicas', 'TextoPersonalizado', '0');
end;

procedure TfmIndex.ckMusicaFundoTransparenteClick(Sender: TObject);
begin
  if ckMusicaFundoTransparente.Checked then
    gravaParam('Musicas', 'FundoTransparente', '1')
  else
    gravaParam('Musicas', 'FundoTransparente', '0');
end;

procedure TfmIndex.ckMusicaJanelaClick(Sender: TObject);
begin
  if ckMusicaJanela.Checked then
    gravaParam('Musicas', 'MonitorTelaCheia', '1')
  else
    gravaParam('Musicas', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.ckMusicaOperadorClick(Sender: TObject);
begin
  if ckMusicaOperador.Checked then
    gravaParam('Musicas', 'ModoOperador', '1')
  else
    gravaParam('Musicas', 'ModoOperador', '0');
end;

procedure TfmIndex.ckMusicaRetornoClick(Sender: TObject);
begin
  bsFormatSlideRetorno.Visible := False;
  if ckMusicaRetorno.Checked
    then bsFormatSlRetorno.Height := 48
    else bsFormatSlRetorno.Height := 24;
  bsFormatSlideRetorno.Visible := ckMusicaRetorno.Checked;
  if ckMusicaRetorno.Checked then
    gravaParam('Musicas', 'ModoRetorno', '1')
  else
    gravaParam('Musicas', 'ModoRetorno', '0');
end;

procedure TfmIndex.ckMusicaTituloSlideClick(Sender: TObject);
begin
  if ckMusicaTituloSlide.Checked then
    gravaParam('Musicas', 'TituloSlide', '1')
  else
    gravaParam('Musicas', 'TituloSlide', '0');
end;

procedure TfmIndex.ckMusicaTopoClick(Sender: TObject);
begin
  if ckMusicaTopo.Checked then
    gravaParam('Musicas', 'Topo', '1')
  else
    gravaParam('Musicas', 'Topo', '0');
end;

procedure TfmIndex.ckPlayerAudioClick(Sender: TObject);
begin
  if ckPlayerAudio.Checked then
    gravaParam('Player', 'Audio', '1')
  else
    gravaParam('Player', 'Audio', '0');
end;

procedure TfmIndex.ckPlayerTelaCheiaClick(Sender: TObject);
begin
  if ckPlayerTelaCheia.Checked then
    gravaParam('Player', 'MonitorTelaCheia', '1')
  else
    gravaParam('Player', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.ckPlayerVideoClick(Sender: TObject);
begin
  if ckPlayerVideo.Checked then
    gravaParam('Player', 'Video', '1')
  else
    gravaParam('Player', 'Video', '0');
end;

procedure TfmIndex.ckSorteioExpClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if ckSorteioExp.Checked {LAZARUS: ItemChecked->Checked}[0] then
    gravaParam('Sorteio', 'Numeros Sorteio (Extendido)', '1')
  else
    gravaParam('Sorteio', 'Numeros Sorteio (Extendido)', '0');

  if ckSorteioExp.Checked {LAZARUS: ItemChecked->Checked}[1] then
    gravaParam('Sorteio', 'Numeros Sorteados (Extendido)', '1')
  else
    gravaParam('Sorteio', 'Numeros Sorteados (Extendido)', '0');

  copiaDadosTelaExtendida;
end;

procedure TfmIndex.ckSorteioExpNMClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if ckSorteioExpNM.Checked {LAZARUS: ItemChecked->Checked}[0] then
    gravaParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '1')
  else
    gravaParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '0');

  if ckSorteioExpNM.Checked {LAZARUS: ItemChecked->Checked}[1] then
    gravaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '1')
  else
    gravaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '0');

  copiaDadosTelaExtendida;
end;

procedure TfmIndex.ckMesmaJanelaClick(Sender: TObject);
begin
  if ckMesmaJanela.Checked then
    gravaParam('Config', 'ckMesmaJanela', '1')
  else
    gravaParam('Config', 'ckMesmaJanela', '0');
end;

procedure TfmIndex.bsSkinSpeedButton10Click(Sender: TObject);
begin
  abrePagina(tsBuscaBiblica);
end;

procedure TfmIndex.bsSkinSpeedButton12Click(Sender: TObject);
begin
  if DM.qrHINOS.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;
  abreLetra(DM.qrHINOS.FieldByName('ID').AsInteger, txtHino.Text);
end;

procedure TfmIndex.bsSkinSpeedButton12NClick(Sender: TObject);
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;
  abreLetra(DM.qrHINOSN.FieldByName('ID').AsInteger, txtHino.Text);
end;

procedure TfmIndex.bsSkinSpeedButton13Click(Sender: TObject);
begin
  if DM.qrHINOS.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrHINOS.fieldbyname('ID').AsInteger,DM.qrHINOS.fieldbyname('ALBUM').AsString,DM.qrHINOS.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrHINOS.fieldbyname('ID').AsInteger,DM.qrHINOS.fieldbyname('ALBUM').AsString,DM.qrHINOS.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.bsSkinSpeedButton13NClick(Sender: TObject);
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.bsSkinSpeedButton14Click(Sender: TObject);
begin
  abrePagina(tsBuscaMusica);
//  0 {LAZARUS: ckgColetaneas.ItemIndex — TCheckGroup nao tem ItemIndex} := 0;
end;

procedure TfmIndex.bsSkinSpeedButton16Click(Sender: TObject);
begin
  abrePagina(tsDoxologia);
end;

procedure TfmIndex.btBibVersAntClick(Sender: TObject);
begin
  if (trim(busBibliaVersiculo.Text) <> '') then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';
    busBibliaVersiculo.Text := '';
    busBibliaVersiculoChange(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_LIVRO'] <> loadCol.Strings.Values['BIBLIA_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_LIVRO'] := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaLivroClick(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_CAPITULO'] <> loadCol.Strings.Values['BIBLIA_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaCapituloClick(Sender);
  end;

  if (loadCol.Strings.Values['BIBLIA_P_VERSICULO'] = '0')
    then loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := '1';

  DM.qrBIBLIA_VERSICULOS.Locate('VERSICULO',menorLista(loadCol.Strings.Values['BIBLIA_P_VERSICULO']),[]);
  DM.qrBIBLIA_VERSICULOS.Prior;
  if (DM.qrBIBLIA_VERSICULOS.Bof) then
  begin
    DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_P_CAPITULO'],[]);
    DM.qrBIBLIA_CAPITULOS.Prior;
    if (DM.qrBIBLIA_CAPITULOS.Bof) then
    begin
      DM.qrBIBLIA_LIVROS.Locate('ID',loadCol.Strings.Values['BIBLIA_P_LIVRO'],[]);
      DM.qrBIBLIA_LIVROS.Prior;
      if (DM.qrBIBLIA_LIVROS.Bof) then
      begin
        DM.qrBIBLIA_LIVROS.Last;
      end;
      DBCtrlGridBibliaLivroClick(Sender);
      DM.qrBIBLIA_CAPITULOS.Last;
    end;
    DBCtrlGridBibliaCapituloClick(Sender);
    DM.qrBIBLIA_VERSICULOS.Last;
  end;
  DBCtrlGridBibliaVersiculoClick(Sender);
end;

procedure TfmIndex.btBibVersSegClick(Sender: TObject);
begin
  if (trim(busBibliaVersiculo.Text) <> '') then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';
    busBibliaVersiculo.Text := '';
    busBibliaVersiculoChange(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_LIVRO'] <> loadCol.Strings.Values['BIBLIA_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_LIVRO'] := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaLivroClick(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_CAPITULO'] <> loadCol.Strings.Values['BIBLIA_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaCapituloClick(Sender);
  end;

  if (loadCol.Strings.Values['BIBLIA_P_VERSICULO'] = '0')
    then loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := '1';

  DM.qrBIBLIA_VERSICULOS.Locate('VERSICULO',maiorLista(loadCol.Strings.Values['BIBLIA_P_VERSICULO']),[]);
  DM.qrBIBLIA_VERSICULOS.Next;
  if (DM.qrBIBLIA_VERSICULOS.Eof) then
  begin
    DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_P_CAPITULO'],[]);
    DM.qrBIBLIA_CAPITULOS.Next;
    if (DM.qrBIBLIA_CAPITULOS.Eof) then
    begin
      DM.qrBIBLIA_LIVROS.Locate('ID',loadCol.Strings.Values['BIBLIA_P_LIVRO'],[]);
      DM.qrBIBLIA_LIVROS.Next;
      if (DM.qrBIBLIA_LIVROS.Eof) then
      begin
        DM.qrBIBLIA_LIVROS.First;
      end;
      DBCtrlGridBibliaLivroClick(Sender);
      DM.qrBIBLIA_CAPITULOS.First;
    end;
    DBCtrlGridBibliaCapituloClick(Sender);
    DM.qrBIBLIA_VERSICULOS.First;
  end;
  DBCtrlGridBibliaVersiculoClick(Sender);
end;

procedure TfmIndex.bsSkinSpeedButton1Click(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfEditorSlides, fEditorSlides);
  fEditorSlides.Show;
end;

procedure TfmIndex.bsSkinSpeedButton20Click(Sender: TObject);
begin
  abrePagina(tsPersonalizadas);
end;

procedure TfmIndex.bsSkinSpeedButton23Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    OpenURL(url) {LAZARUS: ShellExecute→OpenURL};
(*
  fIniciando.AppCreateForm(TfEnviaMensagem, fEnviaMensagem);
  fEnviaMensagem.edAssunto.Text := 'Erro no Hino "' + DM.qrHINOS.FieldByName('NOME_COM').AsString + '"';
  fEnviaMensagem.param := 'MUSICA.ID=' + DM.qrHINOS.FieldByName('ID').AsString;
  fEnviaMensagem.mmMensagem.Lines.Add('Especifique o erro:');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Erro nos tempos dos slides');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Erro de ortografia');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Imagem inapropriada');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Outro: [especifique]');
  fEnviaMensagem.mmMensagem.Lines.Add('');
  fEnviaMensagem.mmMensagem.Lines.Add('[Informe aqui mais detalhes]');
  fEnviaMensagem.ShowModal;    *)
end;

procedure TfmIndex.bsSkinSpeedButton24Click(Sender: TObject);
var
  i, j: Integer;
  id: string;
  url: string;
  nome: string;
  arquivos: TStringList;
begin
  arquivos := TStringList.Create;
  ExtractStrings(['|'], [], PChar(openDialog('arquivo', '', '',true)), arquivos);

  for i := 0 to arquivos.Count - 1 do
  begin
    id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
    while (DM.cdsCOLETANEAS_PERSO.Locate('ID', id, [])) do
    begin
      id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
      Sleep(100);
    end;

    j := 0;
    nome := ChangeFileExt(ExtractFileName(arquivos[i]), '');
    while (DM.cdsCOLETANEAS_PERSO.Locate('NOME', nome, [])) do
    begin
      j := j + 1;
      nome := ChangeFileExt(ExtractFileName(arquivos[i]), '') + inttostr(j);
    end;

    txtUrlInfoColetV.Text := '';
    url := verificaURL(arquivos[i], txtUrlInfoColetV);

    DM.cdsCOLETANEAS_PERSO.Append;
    DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value := id;
    DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').Value := nome;
    DM.cdsCOLETANEAS_PERSO.FieldByName('URL_INFO').Value := txtUrlInfoColetV.Text;
    DM.cdsCOLETANEAS_PERSO.FieldByName('URL').Value := url;
    DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value := '';
    DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value := '';
    DM.cdsCOLETANEAS_PERSO.Post;
  end;

  if arquivos.Count > 0 then
  begin
    loadCol.Strings.Values['PERSO'] := '';
    tsPersonalizadasShow(Sender);
  end;
end;

procedure TfmIndex.bsSkinSpeedButton25Click(Sender: TObject);
begin
  abrePagina(tsCronoCulto);
end;

procedure TfmIndex.bsSkinSpeedButton26Click(Sender: TObject);
begin
  abrePagina(tsLiturgia);
end;

procedure TfmIndex.bsSkinSpeedButton27Click(Sender: TObject);
begin
  abrePagina(tsPainelD);
end;

procedure TfmIndex.bsSkinSpeedButton28Click(Sender: TObject);
begin
  abrePagina(tsSorteioNM);
end;

procedure TfmIndex.bsSkinSpeedButton29Click(Sender: TObject);
begin
  abrePagina(tsCronometro);
end;

procedure TfmIndex.bsSkinSpeedButton2Click(Sender: TObject);
begin
  abrePagina(tsMusicasInfantis);
end;

procedure TfmIndex.btAddColPersoClick(Sender: TObject);
begin
  pnlAddColPerso.Visible := not pnlAddColPerso.Visible;
  btAddColPerso.Down := pnlAddColPerso.Visible;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
  if pnlAddColPerso.Visible then
  begin
    txtColetanea.text := '';
    txtUrlInfoColet.text := '';
    txtAbrirColet.text := '';
    txtImgInfoColet.text := '';
    txtCapaColet.text := '';
    txtAbrirColet.SetFocus;
  end;
end;

procedure TfmIndex.btAltColPersoClick(Sender: TObject);
begin
  pnlAltColPerso.Visible := not pnlAltColPerso.Visible;
  btAltColPerso.Down := pnlAltColPerso.Visible;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
  if pnlAltColPerso.Visible then
  begin
    cbColetaneasPerso.KeyValue := -1;
    cbColetaneasPerso.Enabled := True;
    txtColetanea2.text := '';
    txtUrlInfoColet2.text := '';
    txtAbrirColet2.text := '';
    txtImgInfoColet2.text := '';
    txtCapaColet2.text := '';
    txtAbrirColet2.SetFocus;
  end;
end;

procedure TfmIndex.btAbreHinosClick(Sender: TObject);
begin
  abrePagina(tsHinario);
end;

procedure TfmIndex.btAbreHinosNClick(Sender: TObject);
begin
  abrePagina(tsHinarioN);
end;

procedure TfmIndex.btAbreSaveVideoOn(campo: TEdit {LAZARUS: TbsSkinEdit});
begin
  if (campo.Text = '') then
  begin
    application.MessageBox(PChar('Digite a URL ou ID do vídeo do Youtube!'), titulo, mb_ok + MB_ICONEXCLAMATION);
    campo.SetFocus;
    exit;
  end;

  btColetaneasOnlinePersoClick(nil);
  txtNomeVideoOn3.Text := '';
  txtUrlVideoOn3.Text := campo.Text;
  campo.Text := '';
  txtNomeVideoOn3.SetFocus;
end;

procedure TfmIndex.bsSkinSpeedButton30Click(Sender: TObject);
begin
  abrePagina(tsSorteio);
end;

procedure TfmIndex.bsSkinSpeedButton31Click(Sender: TObject);
begin
  abrePagina(tsTextoInterativo);
end;

procedure TfmIndex.bsSkinSpeedButton37Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    OpenURL(url) {LAZARUS: ShellExecute→OpenURL};
end;

procedure TfmIndex.btErroClick(Sender: TObject);
var
url:string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    OpenURL(url) {LAZARUS: ShellExecute→OpenURL};
(*  fIniciando.AppCreateForm(TfEnviaMensagem, fEnviaMensagem);
  fEnviaMensagem.edAssunto.Text := 'Sugestão de Música para a Categoria "' + lblDoxologiaCate.Caption + '"';
  fEnviaMensagem.param := 'DOXOLOGIA=' + lblDoxologiaCate.Caption;
  fEnviaMensagem.mmMensagem.Lines.Add('Música a ser sugerida para esta categoria: [Especifique]');
  fEnviaMensagem.ShowModal;    *)
end;

procedure TfmIndex.btExecSQLClick(Sender: TObject);
begin
  DM.qrBD.Close;
  DM.qrBD.SQL.Clear;
  DM.qrBD.SQL.Text := mmBD.Text;
  DM.qrBD.Open;

  AjustaLarguraCamposDBGrid(bsSkinDBGrid2);
end;

procedure TfmIndex.btExecVideoOn(campo: TEdit {LAZARUS: TbsSkinEdit}; limpa: Boolean);
var
  videoID: string;
begin
  videoID := trim(campo.Text);

  if (videoID = '') then
  begin
    application.MessageBox(PChar('Digite a URL ou ID do vídeo do Youtube!'), titulo, mb_ok + MB_ICONEXCLAMATION);
    campo.SetFocus;
    exit;
  end;

  videoID := getVideoID(videoID);

  if (limpa = True) then
    campo.Text := '';
  abreVideoOn(videoID, 'Vídeo do Youtube');
end;

procedure TfmIndex.btExibeTxtPainelDClick(Sender: TObject);
begin
  pnlTxtPainelD.DoubleBuffered := True;
  lmdTxtPainelD.Caption := mmPainelD.Text;
  copiaDadosTelaExtendida;
  pnlTxtPainelD.DoubleBuffered := False;
end;

procedure TfmIndex.bsSkinSpeedButton38Click(Sender: TObject);
var
  arq: string;
begin
  arq := openDialog('arquivo', 'Formato Rich Text (*.rtf)|*.rtf|Arquivos de Texto (*.txt)|*.txt|Todos os Arquivos (*.*)|*.*');
  if arq <> '' then
  begin
    RichEdit0.Lines.Clear;
    RichEdit0.Lines.LoadFromFile(arq);
  end;
end;

procedure TfmIndex.bsSkinSpeedButton39Click(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.CutToClipboard;
end;

procedure TfmIndex.bsSkinSpeedButton3NClick(Sender: TObject);
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.btSortearNMClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Enabled) then Exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if (Trim(opSort_NM.Text) <> '') then
    btAddSorteioNMClick(Sender);

  if vlSorteioNM.Strings.Count <= 0 then
  begin
    lmdSorteioNM.Caption := '----';
    if fMonitorSorteioNomes <> nil then
      fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
    application.messagebox('Não há nomes disponíveis para serem sorteados!', TITULO, mb_ok + mb_iconexclamation);
    opSort_NM.SetFocus;
    exit;
  end;

  vSorteioAnimFimNM := IncMilliSecond(Now,trunc(seSorteioTempoNM.Value*1000));
  gSorteioNM.Max {LAZARUS: TProgressBar.MaxValue->Max} := trunc(vSorteioAnimFimNM * 10000000000);
  gSorteioNM.Min {LAZARUS: TProgressBar.MinValue->Min} := trunc(now * 10000000000);

  pnlSorteioNM.DoubleBuffered := True;
  DM.tmrSortearNM.Enabled := true;
end;

procedure TfmIndex.btFormatClick(Sender: TObject);
var
  tag: integer;
  pwd: string;
begin
  if TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Down then
  begin
    pwd := lerParam('Senha', 'Formatacao', '');

    if Trim(pwd) <> '' then
    begin
      application.MessageBox('O administrador do sistema bloqueou o acesso à este recurso! Para continuar, será necessário colocar a senha de acesso!', titulo, mb_ok + MB_ICONINFORMATION);

      {LAZARUS: DM.pwd (TbsSkinPasswordDialog) substituido por InputQuery}
      if not InputQuery(titulo, 'Digite a senha de acesso:', pwd) or (pwd = '') then
      begin
        TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Down := False;
        exit;
      end;

      if (pwd <> lerParam('Senha', 'Formatacao', ''))
        then pwd := lerParam('Senha', 'Formatacao', '');
    end;
  end
  else pwd := '';


  if Trim(pwd) <> '' then
  begin
    application.MessageBox('Senha incorreta!', titulo, mb_ok + mb_iconerror);
    TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Down := False;
    exit;
  end;

  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).tag;
  if (tag = 1) then
  begin
    pnlFormatBiblia.Visible := btFormatBiblia.Down;
      ajustaTexto('BIBLIA');
  end
  else if (tag = 2) then
  begin
    pnlFormatBibliaB.Visible := btFormatBibliaB.Down;
    ajustaTexto('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    pnlFormatEscSB.Visible := btFormatEscSB.Down;
    lmdEscSb.Top := 0;
    lmdEscSb.Left := 0;
    lmdEscSb.Width := pnlEscSB.Width;
    lmdEscSb.Height := round(pnlEscSB.Height / 2);
    lmdEscSbR.Top := round(pnlEscSB.Height / 2);
    lmdEscSbR.Left := 0;
    lmdEscSbR.Width := pnlEscSB.Width;
    lmdEscSbR.Height := round(pnlEscSB.Height / 2);
  end
  else if (tag = 4) then
    pnlFormatSorteio.Visible := btFormatSorteio.Down
  else if (tag = 5) then
    pnlFormatCrono.Visible := btFormatCrono.Down
  else if (tag = 6) then
    pnlFormatSorteioNM.Visible := btFormatSorteioNM.Down
  else if (tag = 7) then
    pnlFormatPainelD.Visible := btFormatPainelD.Down
  else if (tag = 9) then
    pnlFormatRelogio.Visible := btFormatRelogio.Down;
end;

procedure TfmIndex.btLimpaSorteioClick(Sender: TObject);
var
  i: integer;
begin
  if application.messagebox(PChar('Deseja realmente reiniciar o sorteio?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteio.Caption := '0000';
  lbSorteado.items.Clear;
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := False;
    lbSorteioItemCheckClick(Sender);
  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteado.items.Clear;
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
  end;
end;

procedure TfmIndex.btLimpaSorteioReiniciaClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Enabled) then Exit;
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteio.Caption := '0000';
  if fMonitorSorteio <> nil then
    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
end;

procedure TfmIndex.btLimpaSorteioReiniciaNMClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Enabled) then Exit;
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteioNM.Caption := '----';
  if fMonitorSorteioNomes <> nil then
    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
end;

procedure TfmIndex.btLitClipBoardClick(Sender: TObject);
var
  i: Integer;
begin
  if (application.MessageBox('Colar itens da área de transferência?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;

  for i := 0 to cboard.Items.Count-1 do
  begin
    fIniciando.AppCreateForm(TfLiturgia, fLiturgia);
    fLiturgia.Caption := 'Adicionar Item';
    fLiturgia.id := '';
    fLiturgia.Show;
    if (FileExists(cboard.Items[i])) or (DirectoryExists(cboard.Items[i])) then
    begin
      fLiturgia.cbItens.ItemIndex := fLiturgia.cbItens.Items.IndexOf('Arquivo/Diretório');
      fLiturgia.txtItem.Text := ChangeFileExt(ExtractFileName(cboard.Items[i]),'');
      fLiturgia.edtDiretorio.Text := cboard.Items[i];
      fLiturgia.btAddClick(Sender);
    end
    else
    begin
      fLiturgia.cbItens.ItemIndex := fLiturgia.cbItens.Items.IndexOf('Anotação');
      fLiturgia.txtItem.Text := cboard.Items[i];
      fLiturgia.edtAnotacao.Text := cboard.Items[i];
      fLiturgia.btAddClick(Sender);
    end;
  end;
end;

procedure TfmIndex.btBibBusVersAntClick(Sender: TObject);
begin
  if not DM.qrBIBLIA_BUSCA.Active then exit;
  if DM.qrBIBLIA_BUSCA.RecordCount <= 0 then exit;

  if (loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] = '')
    then DM.qrBIBLIA_BUSCA.First
  else
  begin
    DM.qrBIBLIA_BUSCA.Locate('DESC_PASSAGEM2',loadCol.Strings.Values['BIBLIA_BUSCA_INFO'],[]);
    DM.qrBIBLIA_BUSCA.Prior;
  end;

  if (DM.qrBIBLIA_BUSCA.Bof) then DM.qrBIBLIA_BUSCA.Last;

  DBCtrlGridBibliaBuscaClick(Sender);
end;

procedure TfmIndex.btBibBusVersSegClick(Sender: TObject);
begin
  if not DM.qrBIBLIA_BUSCA.Active then exit;
  if DM.qrBIBLIA_BUSCA.RecordCount <= 0 then exit;

  if (loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] = '')
    then DM.qrBIBLIA_BUSCA.First
  else
  begin
    DM.qrBIBLIA_BUSCA.Locate('DESC_PASSAGEM2',loadCol.Strings.Values['BIBLIA_BUSCA_INFO'],[]);
    DM.qrBIBLIA_BUSCA.Next;
  end;

  if (DM.qrBIBLIA_BUSCA.Eof) then DM.qrBIBLIA_BUSCA.First;

  DBCtrlGridBibliaBuscaClick(Sender);
end;

procedure TfmIndex.btBibLocalizaClick(Sender: TObject);
begin
  carregaBiblia('BUS');
end;

procedure TfmIndex.btLimpaSorteioLimpaClick(Sender: TObject);
var
  i, linha: integer;
  item: string;
begin
  if application.messagebox(PChar('Deseja realmente zerar o sorteio?' + #13 + 'Todos os números serão apagados!'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  for i := lbSorteio.Items.Count - 1 downto 0 do
  begin
    lbSorteio.ItemIndex := i;
    item := lbSorteio.Items[lbSorteio.ItemIndex] {LAZARUS: TCheckListBox — Items[] is string};
    lbSorteio.Items.Delete(i);
    vlSorteio.FindRow(item, linha);
    if linha >= 0 then
      vlSorteio.DeleteRow(linha);
    vlSorteados.FindRow(item, linha);
    if linha >= 0 then
      vlSorteados.DeleteRow(linha);
  end;

  lbSorteado.Items.Clear;
  lmdSorteio.Caption := '0000';
  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteado.items.Clear;
    fMonitorSorteio.lbSorteio.items.Clear;
    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
  end;
  SorteioContador();
end;

procedure TfmIndex.btLimpaSorteioLimpaNMClick(Sender: TObject);
var
  i, linha: integer;
  item: string;
begin
  if application.messagebox(PChar('Deseja realmente zerar o sorteio?' + #13 + 'Todos os nomes serão apagados!'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  for i := lbSorteioNM.Items.Count - 1 downto 0 do
  begin
    lbSorteioNM.ItemIndex := i;
    item := lbSorteioNM.Items[lbSorteioNM.ItemIndex] {LAZARUS: TCheckListBox — Items[] is string};
    lbSorteioNM.Items.Delete(i);
    vlSorteioNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteioNM.DeleteRow(linha);
    vlSorteadosNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteadosNM.DeleteRow(linha);
  end;

  lbSorteadoNM.Items.Clear;
  lmdSorteioNM.Caption := '----';
  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteadoNM.items.Clear;
    fMonitorSorteioNomes.lbSorteioNM.items.Clear;
    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
  end;
  SorteioContador();
end;

procedure TfmIndex.btLimpaSorteioNMClick(Sender: TObject);
var
  i: integer;
begin
  if application.messagebox(PChar('Deseja realmente reiniciar o sorteio?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteioNM.Caption := '----';
  lbSorteadoNM.items.Clear;
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Checked[i] {LAZARUS: TCheckListBox.Items[i].Checked->Checked[i]} := False;
    lbSorteioNMItemCheckClick(Sender);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteadoNM.items.Clear;
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
  end;
end;

procedure TfmIndex.btAddSorteioClick(Sender: TObject);
var
  i, ini, fin, linha: integer;
  {LAZARUS: Item: TListItem removido — TCheckListBox.Items.Add retorna Integer}
  Numero: string;
begin
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if trim(opSort_Ini.text) = '' then
  begin
    if (trim(opSort_Fin.text) = '') then
    begin
      if (Sender <> nil) then
        application.MessageBox('Coloque o número para ser adicionado!', TITULO, mb_ok + mb_iconexclamation);
      opSort_Ini.SetFocus;
      Exit;
    end;
    opSort_Ini.text := opSort_Fin.text;
    opSort_Fin.text := '';
  end;

  if trim(opSort_Fin.text) = '' then
    opSort_Fin.text := opSort_Ini.text;

  ini := strtoint(opSort_Ini.text);
  fin := strtoint(opSort_Fin.text);

  if ini > fin then
  begin
    fin := strtoint(opSort_Ini.text);
    ini := strtoint(opSort_Fin.text);
  end;

  for i := ini to fin do
  begin

    Numero := formatfloat('0000', i);
    if Trim(vlSorteio.Strings.Values[Numero]) <> '' then
    begin
      lbSorteio.Checked[StrToInt(vlSorteio.Strings.Values[Numero])] := False; {LAZARUS: TCheckListBox}
    end
    else if Trim(vlSorteados.Strings.Values[Numero]) <> '' then
    begin
      lbSorteio.Checked[StrToInt(vlSorteados.Strings.Values[Numero])] := False; {LAZARUS: TCheckListBox}
      vlSorteio.Strings.Values[Numero] := vlSorteados.Strings.Values[Numero];
      vlSorteados.FindRow(Numero, linha);
      vlSorteados.DeleteRow(linha);
    end
    else
    begin
      {LAZARUS: TCheckListBox.Items.Add(s) retorna Integer, nao TListItem}
      lbSorteio.Items.Add(Numero);
      vlSorteio.Strings.Values[Numero] := IntToStr(lbSorteio.Items.Count - 1);
    end;

  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  end;

  opSort_Ini.text := '';
  opSort_Fin.text := '';
  SorteioContador();
  opSort_Ini.SetFocus;
end;

procedure TfmIndex.btAddSorteioNMClick(Sender: TObject);
var
  linha: integer;
  {LAZARUS: Item: TListItem removido — TCheckListBox.Items.Add retorna Integer}
  nome: string;
begin
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if trim(opSort_Nm.text) = '' then
  begin
    if (Sender <> nil) then
      application.MessageBox('Digite o nome para ser adicionado!', TITULO, mb_ok + mb_iconexclamation);
    opSort_Nm.SetFocus;
    Exit;
  end;

  nome := Copy(opSort_Nm.Text, 0, opSort_Nm.MaxLength);
  if Trim(vlSorteioNM.Strings.Values[nome]) <> '' then
  begin
    lbSorteioNM.Checked[StrToInt(vlSorteioNM.Strings.Values[nome])] := False; {LAZARUS: TCheckListBox}
  end
  else if Trim(vlSorteadosNM.Strings.Values[nome]) <> '' then
  begin
    lbSorteioNM.Checked[StrToInt(vlSorteadosNM.Strings.Values[nome])] := False; {LAZARUS: TCheckListBox}
    vlSorteioNM.Strings.Values[nome] := vlSorteadosNM.Strings.Values[nome];
    vlSorteadosNM.FindRow(nome, linha);
    vlSorteadosNM.DeleteRow(linha);
  end
  else
  begin
    {LAZARUS: TCheckListBox.Items.Add(s) retorna Integer, nao TListItem}
    lbSorteioNM.Items.Add(nome);
    vlSorteioNM.Strings.Values[nome] := IntToStr(lbSorteioNM.Items.Count - 1);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  end;

  opSort_NM.text := '';
  SorteioContador();
  opSort_NM.SetFocus;
end;

procedure TfmIndex.btfsBoldClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  if (fsBold in RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes}) then
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} - [fsBold]
  else
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} + [fsBold];
end;

procedure TfmIndex.btfsItalicClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  if (fsItalic in RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes}) then
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} - [fsItalic]
  else
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} + [fsItalic];
end;

procedure TfmIndex.btfsStrikeOutClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  if (fsStrikeOut in RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes}) then
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} - [fsStrikeOut]
  else
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} + [fsStrikeOut];
end;

procedure TfmIndex.btfsUnderlineClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  if (fsUnderline in RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes}) then
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} - [fsUnderline]
  else
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} + [fsUnderline];
end;

procedure TfmIndex.bsSkinSpeedButton41Click(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.CopyToClipboard;
end;

procedure TfmIndex.bsSkinSpeedButton42Click(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.PasteFromClipboard;
end;

procedure TfmIndex.bsSkinSpeedButton43Click(Sender: TObject);
var
  arq: string;
begin
  arq := saveDialog('texto', 'Formato Rich Text (*.rtf)|*.rtf');
  if arq <> '' then RichEdit0.Lines.SaveToFile(arq);
end;

procedure TfmIndex.bsSkinSpeedButton44Click(Sender: TObject);
var
  SelStart, SelLength: integer;
  tag: Integer;
  RichEdit:TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));

  paramtemp.Lines.Clear;
  SelStart := RichEdit.SelStart;
  SelLength := RichEdit.SelLength;
  paramtemp.Text := RichEdit.SelText;
  RichEdit.ClearSelection;
  RichEdit.SelText := paramtemp.Text;
  RichEdit.SelStart := SelStart;
  RichEdit.SelLength := SelLength;
  RichEdit.Font.Name := {LAZARUS: SelAttributes.Name stub} RichEdit.Font.Name {LAZARUS: DefaultFont->Font};
  RichEdit.Font.Size := {LAZARUS: SelAttributes.Size stub} RichEdit.Font.Size {LAZARUS: DefaultFont->Font};
  RichEdit.Font.Color := {LAZARUS: SelAttributes.Color stub} RichEdit.Font.Color {LAZARUS: DefaultFont->Font};
  RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := RichEdit.Font.Style {LAZARUS: DefaultFont->Font};
  RE_SetSelBgColor(RichEdit, clWhite);
end;

procedure TfmIndex.bsSkinSpeedButton45Click(Sender: TObject);
var
  tag: Integer;
  RichEdit:TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  if application.messagebox(PChar('Deseja realmente apagar o texto?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  tag := TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Lines.Clear;
end;

procedure TfmIndex.bsSkinSpeedButton46Click(Sender: TObject);
begin
  Application.MessageBox('Para excluir uma coletânea, clique com o botão direito sobre ela, e em seguida, opção "Excluir".', TITULO, mb_ok + mb_iconinformation);
end;

procedure TfmIndex.bttaLeftJustifyClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  {LAZARUS: RichEdit.Paragraph.Alignment — TRichMemo usa SetParaAlignment; stub}
end;

procedure TfmIndex.bttaRightJustifyClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  {LAZARUS: RichEdit.Paragraph.Alignment — TRichMemo usa SetParaAlignment; stub}
end;

procedure TfmIndex.bttaCenterClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  {LAZARUS: RichEdit.Paragraph.Alignment — TRichMemo usa SetParaAlignment; stub}
end;

procedure TfmIndex.bsSkinSpeedButton4Click(Sender: TObject);
begin
  abrePagina(tsDiversas);
end;

procedure TfmIndex.bsSkinSpeedButton50Click(Sender: TObject);
begin
  abrePagina(tsRelogio);
end;

procedure TfmIndex.bsSkinSpeedButton53Click(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TCheckBox {LAZARUS: TbsSkinCheckBox};
begin
  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TCheckBox {LAZARUS: TbsSkinCheckBox}(FindComponent(item+'_checkb'));
    if Assigned(checkbox)
      then checkbox.Checked := True;
  end;
end;

procedure TfmIndex.bsSkinSpeedButton54Click(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TCheckBox {LAZARUS: TbsSkinCheckBox};
begin
  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TCheckBox {LAZARUS: TbsSkinCheckBox}(FindComponent(item+'_checkb'));
    if Assigned(checkbox)
      then checkbox.Checked := False;
  end;
end;

procedure TfmIndex.bsSkinSpeedButton55Click(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TCheckBox {LAZARUS: TbsSkinCheckBox};
begin
  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TCheckBox {LAZARUS: TbsSkinCheckBox}(FindComponent(item+'_checkb'));
    if Assigned(checkbox)
      then checkbox.Checked := not checkbox.Checked;
  end;
end;

{LAZARUS: port upstream 1570e57 — copia os itens selecionados da liturgia para
 outros dias da semana, com opção de sobrescrever o conteúdo do dia destino}
procedure TfmIndex.btCopiaLitSelClick(Sender: TObject);
var
  i: Integer;
  item: string;
  checkbox: TCheckBox {LAZARUS: TbsSkinCheckBox};
  dlg: TfCopiaLiturgiaDia;
  diaOrigem: Integer;
  diasDestino: TArray<Integer>;
begin
  FLitClipboard.Clear;
  for i := 0 to lbLiturgia.Items.Count - 1 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TCheckBox(FindComponent(item + '_checkb'));
    if Assigned(checkbox) and checkbox.Checked then
      FLitClipboard.Add(item);
  end;

  if FLitClipboard.Count = 0 then
  begin
    Application.MessageBox('Selecione ao menos um item para copiar!', TITULO, MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  diaOrigem := StrToIntDef(loadCol.Strings.Values['LITURGIA:SEMANA'], DayOfWeek(Now));
  FLitClipboardSemana := diaOrigem;

  dlg := TfCopiaLiturgiaDia.CreateDialog(Self, diaOrigem);
  try
    if dlg.ShowModal <> mrOk then Exit;
    diasDestino := dlg.GetDiasSelecionados;

    if Length(diasDestino) = 0 then
    begin
      Application.MessageBox('Selecione ao menos um dia de destino!', TITULO, MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    copiaItensLiturgiaParaDias(diasDestino, dlg.GetSobrescrever);

    Application.MessageBox(
      PChar('Itens copiados com sucesso para ' + IntToStr(Length(diasDestino)) + ' dia(s)!'),
      TITULO, MB_OK + MB_ICONINFORMATION);

  finally
    dlg.Free;
  end;
end;

{LAZARUS: lógica de cópia extraída de btCopiaLitSelClick — copia os itens em
 FLitClipboard para os dias informados; reutilizável em teste headless}
procedure TfmIndex.copiaItensLiturgiaParaDias(const diasDestino: array of Integer; sobrescrever: Boolean);
var
  i, k, dia: Integer;
  item, novoId, semanaStr: string;
  itensExistentes, existingIds, keys: TStringList;
  iniRead: TMemIniFile;
  params: array of TParamItem;

  procedure AddParam(const grupo, param, valor: string);
  begin
    SetLength(params, Length(params) + 1);
    params[High(params)].Grupo := grupo;
    params[High(params)].Param := param;
    params[High(params)].Valor := valor;
  end;
begin
    for dia in diasDestino do
    begin
      semanaStr := IntToStr(dia);
      itensExistentes := TStringList.Create;
      try
        if sobrescrever then
        begin
          existingIds := TStringList.Create;
          try
            existingIds.Delimiter := ';';
            existingIds.DelimitedText := lerParam('Geral', semanaStr, '', arq_liturgia);
            for k := 0 to existingIds.Count - 1 do
              if Trim(existingIds[k]) <> '' then
                apagaParam(existingIds[k], '', arq_liturgia);
          finally
            existingIds.Free;
          end;
        end
        else
        begin
          itensExistentes.Delimiter := ';';
          itensExistentes.DelimitedText := lerParam('Geral', semanaStr, '', arq_liturgia);
          for k := itensExistentes.Count - 1 downto 0 do
            if Trim(itensExistentes[k]) = '' then
              itensExistentes.Delete(k);
        end;

        for i := 0 to FLitClipboard.Count - 1 do
        begin
          item := FLitClipboard[i];
          novoId := 'item_' + FormatDateTime('yyyymmddhhnnsszzz', Now)
                    + '_d' + semanaStr + '_i' + IntToStr(i);
          SetLength(params, 0);

          keys := TStringList.Create;
          try
            iniRead := abreIniLiturgia;
            try
              iniRead.ReadSection(item, keys);
              for k := 0 to keys.Count - 1 do
                if keys[k] <> 'checked' then
                  AddParam(novoId, keys[k], iniRead.ReadString(item, keys[k], ''));
            finally
              iniRead.Free;
            end;
          finally
            keys.Free;
          end;

          if Length(params) > 0 then
            gravaParamLote(arq_liturgia, params);
          itensExistentes.Add(novoId);
        end;

        gravaParam('Geral', semanaStr,
          {LAZARUS: #13#10 → LineEnding — no Linux Text usa #10; só o 1º item persistia}
          StringReplace(itensExistentes.Text, LineEnding, ';', [rfIgnoreCase, rfReplaceAll]),
          arq_liturgia);
        gravaParam('Geral', 'AlteraOrdem-' + semanaStr,
          FormatDateTime('dd/mm/yyyy hh:mm:ss', Now), arq_liturgia);
      finally
        itensExistentes.Free;
      end;
    end;
end;

procedure TfmIndex.btApagaLitSelClick(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TCheckBox {LAZARUS: TbsSkinCheckBox};
begin
  if application.messagebox(PChar('Deseja realmente apagar todos os itens marcados?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    Exit;

  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TCheckBox {LAZARUS: TbsSkinCheckBox}(FindComponent(item+'_checkb'));
    if Assigned(checkbox) then
    begin
      if checkbox.Checked
        then apagaItemLiturgia(item);
    end;
  end;
end;

procedure TfmIndex.bsSkinSpeedButton58Click(Sender: TObject);
begin
  abrePagina(tsColetaneasOnline);
end;

procedure TfmIndex.bsSkinSpeedButton59Click(Sender: TObject);
begin
  abrePagina(tsBuscaMusica);
//  0 {LAZARUS: ckgColetaneas.ItemIndex — TCheckGroup nao tem ItemIndex} := 1;
end;

procedure TfmIndex.bsSkinSpeedButton5Click(Sender: TObject);
begin
  abrePagina(tsItensAgendados);
end;

procedure TfmIndex.btUrlVideoOnClick(Sender: TObject);
begin
  btExecVideoOn(txtUrlVideoOn);
end;

procedure TfmIndex.bsSkinSpeedButton60Click(Sender: TObject);
begin
  if (application.MessageBox(PChar('A atualização de todos os vídeos pode demorar um pouco!' + #13 + #10 + 'Deseja continuar?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;
  atualiza_coletaneas_web('tudo');
end;

procedure TfmIndex.bsSkinSpeedButton61Click(Sender: TObject);
begin
  btAbreSaveVideoOn(txtUrlVideoOn);
end;

procedure TfmIndex.bsSkinSpeedButton62Click(Sender: TObject);
begin
  if (fVideoOn <> nil) and (fVideoOn.Visible) then
    fVideoOn.Close
  else
    application.MessageBox(PChar('Não há nenhum vídeo aberto para ser encerrado!'), titulo, mb_ok + mb_iconinformation);
end;

procedure TfmIndex.btMusicaLetraClick(Sender: TObject);
begin
  if DM.qrBUSCA.RecordCount <= 0 then
  begin
    application.MessageBox('Música não encontrada!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;
  if DM.qrBUSCA.FieldByName('TIPO_WEB').AsString = 'S' then
  begin
    application.MessageBox('Não há letras cadastradas para músicas da web!', TITULO, mb_ok + MB_ICONEXCLAMATION);
    exit;
  end;
  abreLetra(DM.qrBUSCA.FieldByName('ID').AsInteger, txtBusca.Text);
end;

procedure TfmIndex.btOrdFavClick(Sender: TObject);
begin
  if DM.cdsFavoritos.RecordCount <= 0 then
  begin
    application.messagebox(PChar('Não há nenhuma página nos favoritos para alterar a ordem!'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  if DM.cdsFavoritos.RecordCount = 1 then
  begin
    application.messagebox(PChar('É necessário pelo menos, duas páginas nos favoritos para alterar a ordem!'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  fIniciando.AppCreateForm(TfFavoritos, fFavoritos);
  fFavoritos.ShowModal;

  if PageControl1.Visible = false then exit;

  if (DM.cdsFavoritos.Locate('NOME_ABA', PageControl1.ActivePage.Name, [])) then
  begin
    botoesFavoritos('del');
  end
  else
  begin
    botoesFavoritos('add');
  end;
end;

procedure TfmIndex.btAddFavClick(Sender: TObject);
var
  id,nome,nome_aba: string;
  imagem,ordem: Integer;
begin
  if not DM.cdsFavoritos.Active then
    carregaFavoritos;


  if PageControl1.Visible = false then
  begin
    application.messagebox(PChar('Não há nenhuma página aberta para adicionar aos favoritos!'+#13#10+'Clique neste botão após abrir uma página.'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  nome := PageControl1.ActivePage.Caption;
  nome_aba := PageControl1.ActivePage.Name;
  imagem := PageControl1.ActivePage.ImageIndex;

  if (DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, [])) then
  begin
    application.messagebox(PChar('A página '''+nome+''' já está nos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONEXCLAMATION);
    DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, []);
    DM.cdsFavoritos.Edit;
    DM.cdsFavoritos.FieldByName('NOME').Value := nome;
    DM.cdsFavoritos.FieldByName('IMAGEM').Value := imagem;
    DM.cdsFavoritos.Post;
    exit;
  end;

  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsFavoritos.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível adicionar. Clique novamente!', TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsFavoritos.Last;
  if DM.cdsFavoritos.RecordCount <= 0 then
    ordem := 1
  else
    ordem := DM.cdsFavoritos.FieldByName('ORDEM').AsInteger + 1;

  DM.cdsFavoritos.Append;
  DM.cdsFavoritos.FieldByName('ID').Value := id;
  DM.cdsFavoritos.FieldByName('ORDEM').Value := ordem;
  DM.cdsFavoritos.FieldByName('NOME').Value := nome;
  DM.cdsFavoritos.FieldByName('NOME_ABA').Value := nome_aba;
  DM.cdsFavoritos.FieldByName('IMAGEM').Value := imagem;
  DM.cdsFavoritos.Post;

  carregaFavoritos();
  botoesFavoritos('del');
  application.messagebox(PChar('Página '''+nome+''' adicionada com sucesso aos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
end;

procedure TfmIndex.btDelFavClick(Sender: TObject);
var
  nome,nome_aba: string;
begin
  if PageControl1.Visible = false then
  begin
    application.messagebox(PChar('Não há nenhuma página aberta para remover dos favoritos!'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  nome := PageControl1.ActivePage.Caption;
  nome_aba := PageControl1.ActivePage.Name;

  if not (DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, [])) then
  begin
    application.messagebox(PChar('A página '''+nome+''' não está nos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, []);
  DM.cdsFavoritos.Delete;

  carregaFavoritos();
  botoesFavoritos('add');
  application.messagebox(PChar('Página '''+nome+''' removida com sucesso dos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
end;

procedure TfmIndex.btwsCloseClick(Sender: TObject);
begin
//  close;
  Application.Terminate;
  DM.tmrSair.Enabled := true;
end;

procedure TfmIndex.btwsDownloadClick(Sender: TObject);
begin
  verVersao();
end;

procedure TfmIndex.btwsMaximizedClick(Sender: TObject);
begin
  if (fmIndex.WindowState = wsMaximized) then
  begin
    fmIndex.WindowState := wsNormal;
    btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btMaximized']);
    fmIndex.BorderStyle := bsSizeable;
    {LAZARUS: SetWindowLong/GetWindowLong removidos — Windows API}
  end
  else
  begin
    fmIndex.WindowState := wsMaximized;
    btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btRestore']);
    fmIndex.BorderStyle := bsNone;
  end;

end;

procedure TfmIndex.btwsMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfmIndex.btwsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  btwsformBotoes.HotImages := DM.ico_janela_clk;
end;

procedure TfmIndex.btwsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  btwsformBotoes.HotImages := DM.ico_janela_hot;
end;

procedure TfmIndex.btColetaneasOnlinePersoClick(Sender: TObject);
begin
  abrePagina(tsColetaneasOnlinePerso);
end;

procedure TfmIndex.btUrlVideoOn2Click(Sender: TObject);
begin
  btExecVideoOn(txtUrlVideoOn2);
end;

procedure TfmIndex.bsSkinSpeedButton66Click(Sender: TObject);
begin
  btAbreSaveVideoOn(txtUrlVideoOn2);
end;

procedure TfmIndex.btMusicaAudioMusicaClick(Sender: TObject);
begin
  if DM.qrBUSCA.RecordCount <= 0 then
  begin
    application.MessageBox('Música não encontrada!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if DM.qrBUSCA.FieldByName('TIPO_WEB').AsString = 'S' then
  begin
    application.MessageBox('Não é possível abrir arquivo da músicas de músicas na web!', TITULO, mb_ok + MB_ICONEXCLAMATION);
    exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrBUSCA.fieldbyname('ID').AsInteger,DM.qrBUSCA.fieldbyname('ALBUM').AsString,DM.qrBUSCA.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrBUSCA.fieldbyname('ID').AsInteger,DM.qrBUSCA.fieldbyname('ALBUM').AsString,DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.btAddVideoOn3Click(Sender: TObject);
var
  videoID: string;
  nomeVIDEO: string;
  id: string;
  url: string;
begin
  nomeVIDEO := trim(txtNomeVideoOn3.Text);
  videoID := trim(txtUrlVideoOn3.Text);

  if (videoID = '') then
  begin
    application.MessageBox(PChar('Digite a URL ou ID do vídeo do Youtube!'), titulo, mb_ok + MB_ICONEXCLAMATION);
    txtUrlVideoOn3.SetFocus;
    exit;
  end;

  videoID := getVideoID(videoID);

  url := 'https://www.youtube.com/watch?v=' + videoID;

  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsVideosOnPerso.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível adicionar vídeo. Tente novamente!', TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsVideosOnPerso.Append;
  DM.cdsVideosOnPerso.FieldByName('ID').Value := id;
  DM.cdsVideosOnPerso.FieldByName('NOME').Value := nomeVIDEO;
  DM.cdsVideosOnPerso.FieldByName('URL').Value := url;
  DM.cdsVideosOnPerso.FieldByName('VIDEOID').Value := videoID;
  DM.cdsVideosOnPerso.Post;

  txtNomeVideoOn3.Text := '';
  txtUrlVideoOn3.Text := '';
  stVideosOnPerso_1.Text {LAZARUS: TStatusPanel.Caption→.Text} := qtItens(DM.cdsVideosOnPerso,'vídeo encontrado','vídeos encontrados','Nenhum vídeo encontrado');

  btVidOnlPExcluir.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPCopiarLink.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPAbrirNaveg.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPExec.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
end;

procedure TfmIndex.bsSkinSpeedButton68Click(Sender: TObject);
begin
  btExecVideoOn(txtUrlVideoOn3, false);
end;

procedure TfmIndex.bsSkinSpeedButton6Click(Sender: TObject);
begin
  abreLetraMusicaAlbum(712,DM.qrHINOS.FieldByName('ID').AsInteger);
end;

procedure TfmIndex.bsSkinSpeedButton6NClick(Sender: TObject);
begin
  abreLetraMusicaAlbum(629,DM.qrHINOSN.FieldByName('ID').AsInteger);
end;

procedure TfmIndex.bsSkinSpeedButton7Click(Sender: TObject);
var
  arq: string;
begin
    arq := openDialog('pasta');
    if arq <> '' then
    begin
      arq := ExcludeTrailingPathDelimiter(arq);
      txtAbrirColet.Text := arq;
      txtAbrirColetExit(txtAbrirColet);
      btAddColetPersoClick(btAddColetPerso);
    end;
end;

procedure TfmIndex.btPersoClipBoardClick(Sender: TObject);
var
  i: Integer;
begin
  if pnlAddColPerso.Visible then exit;
  if pnlAltColPerso.Visible then exit;
  if txtBuscaColetPeso.Focused then Exit;

  if (application.MessageBox('Colar itens da área de transferência?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;

  for i := 0 to cboard.Items.Count-1 do
  begin
    if (FileExists(cboard.Items[i])) or (DirectoryExists(cboard.Items[i])) then
    begin
      txtCapaColet.Text := '';
      txtColetanea.Text := '';
      txtAbrirColet.Text := cboard.Items[i];
      txtAbrirColetExit(Sender);

      if (DM.cdsCOLETANEAS_PERSO.Locate('NOME', txtColetanea.text, [])) then
        Continue;
      btAddColetPersoClick(Sender);
    end;
  end;
end;

procedure TfmIndex.btAddCategoriaAgendadosClick(Sender: TObject);
var
  id: string;
begin
  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsCategoriasItensAgendados.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível criar categoria. Tente novamente!', TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsCategoriasItensAgendados.Append;
  DM.cdsCategoriasItensAgendados.FieldByName('ID').Value := id;
  DM.cdsCategoriasItensAgendados.FieldByName('NOME').Value := 'Categoria '+inttostr(DM.cdsCategoriasItensAgendados.RecordCount+1);
  DM.cdsCategoriasItensAgendados.Post;
  categoriasItensAgendadosClick(Sender);

  fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
  fItensAgendados.id := id;
  fItensAgendados.tipo := 'CATEGORIA';
  fItensAgendados.ShowModal;
end;

procedure TfmIndex.btAddItemLiturgiaClick(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfLiturgia, fLiturgia);
  fLiturgia.Caption := 'Adicionar Item';
  fLiturgia.id := '';
  fLiturgia.ShowModal;
end;

{LAZARUS: port upstream b09c49b — arquivos arrastados p/ a aba Liturgia abrem o
 modal de adição com tipo "Arquivo" pré-selecionado; múltiplos arquivos em sequência}
procedure TfmIndex.FormDropFiles(Sender: TObject; const FileNames: array of String);
var
  i: Integer;
begin
  if not ((PageControl1.Visible) and (PageControl1.ActivePage = tsLiturgia)) then
    Exit;

  for i := 0 to High(FileNames) do
  begin
    fIniciando.AppCreateForm(TfLiturgia, fLiturgia);
    fLiturgia.Caption := 'Adicionar Item';
    fLiturgia.id := '';
    fLiturgia.arquivoInicial := FileNames[i];
    fLiturgia.ShowModal;
  end;
end;

procedure TfmIndex.bsSkinSpeedButton8Click(Sender: TObject);
begin
  if (application.MessageBox('Deseja realmente remover os itens anteriores a data de hoje?', titulo, mb_yesno + mb_iconquestion) <> 6)
    then Exit;

  removeItensAgendadosPassados;
end;

procedure TfmIndex.btHinoSlideMusicaClick(Sender: TObject);
var
  txt: string;
begin
  if DM.qrHINOS.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    txtHino.SetFocus;
    Exit;
  end;
  if (TComponent(Sender).Tag = 2)
    then txt := 'PB'
    else txt := '';

  fmIndex.abreLetraMusica('BD',txt,DM.qrHINOS.FieldByName('ID').AsInteger,(TComponent(Sender).Tag < 3));
end;

procedure TfmIndex.btHinoSlideMusicaNClick(Sender: TObject);
var
  txt: string;
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    txtHinoN.SetFocus;
    Exit;
  end;
  if (TComponent(Sender).Tag = 2)
    then txt := 'PB'
    else txt := '';

  fmIndex.abreLetraMusica('BD',txt,DM.qrHINOSN.FieldByName('ID').AsInteger,(TComponent(Sender).Tag < 3));
end;

procedure TfmIndex.btAbreColJAClick(Sender: TObject);
begin
  abrePagina(tsJA);
end;

procedure TfmIndex.bsSkinSpeedButton9Click(Sender: TObject);
begin
  abrePagina(tsBiblia);
end;

procedure TfmIndex.seTamanhoTextoAuxChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Texto Aux', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
end;

procedure TfmIndex.seTamanhoTextoChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Texto', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
end;

procedure TfmIndex.seTamanhoTextoRetornoChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Texto Retorno', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
end;

procedure TfmIndex.seTamanhoTituloChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Titulo', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
end;

procedure TfmIndex.bsSkinTabSheet5Show(Sender: TObject);
begin
  AjustaLarguraCamposDBGrid(bsSkinDBGrid1);
end;

procedure TfmIndex.bsSkinTabSheet6Show(Sender: TObject);
begin
  loadCol.Strings.Values['COLETANEAS_PERSO_ONL'] := '';
  abrePagina(tsColetaneasOnlinePerso);
  AjustaLarguraCamposDBGrid(bsSkinDBGrid3);
end;

procedure TfmIndex.bsSkinTabSheet7Show(Sender: TObject);
begin
  carregaFavoritos();
  AjustaLarguraCamposDBGrid(bsSkinDBGrid4);
end;

procedure TfmIndex.btAnotTempoClick(Sender: TObject);
var
  i: integer;
  {LAZARUS: Item: TListItem removido — TCheckListBox.Items.Add retorna Integer}
  tempo: string;
begin
  if (loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] = '') then
    loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] := '1';

  i := StrToInt(loadCol.Strings.Values['CRONO:ID_TEMPO_GR']);
  loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] := IntToStr(i + 1);

  tempo := lmdCrono.Caption;

  {LAZARUS: TCheckListBox.Items.Add(s) retorna Integer, nao TListItem}
  lbCrono.Items.Add(formatfloat('00', i) + ' - ' + tempo);
  lbCrono.ItemIndex := lbCrono.Items.Count - 1;
  if (fMonitorCronometro <> nil) then
  begin
    fMonitorCronometro.lbCrono.Items := lbCrono.Items;
    fMonitorCronometro.lbCrono.ItemIndex := lbCrono.ItemIndex;
  end;
end;

procedure TfmIndex.btSortearClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Enabled) then Exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if (Trim(opSort_Ini.Text) <> '') or (Trim(opSort_Fin.Text) <> '') then
    btAddSorteioClick(Sender);

  if vlSorteio.Strings.Count <= 0 then
  begin
    lmdSorteio.Caption := '0000';
    if fMonitorSorteio <> nil then
      fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
    application.messagebox('Não há números disponíveis para serem sorteados!', TITULO, mb_ok + mb_iconexclamation);
    opSort_Ini.SetFocus;
    exit;
  end;

  vSorteioAnimFim := IncMilliSecond(Now,trunc(seSorteioTempo.Value*1000));
  gSorteio.Max := trunc(vSorteioAnimFim * 10000000000);
  gSorteio.Min := trunc(now * 10000000000);

  pnlSorteio.DoubleBuffered := True;
  DM.tmrSortear.Enabled := true;
end;

procedure TfmIndex.desenvolvedor(ativo: boolean);
var
  _pwd: string;
begin
  if (ativo = true) then
  begin
    _pwd := '';
    {LAZARUS: DM.PasswordDialog substituido por InputQuery}
    if not InputQuery(titulo, 'Digite a senha de acesso:', _pwd) then
      Exit;
    if (_pwd <> senha_bd) then
    begin
      if (_pwd <> '') then
        Application.MessageBox('Senha incorreta!',TITULO,mb_ok+mb_iconerror);
      Exit;
    end;
  end;

  bsAppMenu1.Pages[0].TabVisible {LAZARUS: TPageControl.Items->Pages} := ativo;
  pnlModDes.Visible := ativo;
  txtIDMusica.Visible := ativo;
  gpLiturgiaDes.Visible := ativo;

  if (fEditorSlides <> nil) then
  begin
    fEditorSlides.param.Visible := ativo;
    fEditorSlides.dbGrid.Visible := ativo;
    fEditorSlides.lbTempos.Visible := ativo;
  end;
  if (fMusica <> nil) then
  begin
    fMusica.pnlAdm.Visible := ativo;
    fMusica.pnGrid.Visible := ativo;
  end;
end;

function TfmIndex.diretorio(dir:string): string;
begin
  dir := StringReplace(dir,'\\','\',[rfIgnoreCase, rfReplaceAll]);
  result := dir;
end;

function TfmIndex.DownloadArquivo(const Origem, Destino: string): Boolean;
var
  Http: TFPHTTPClient;
begin
  {LAZARUS: WinInet/InternetOpen removidos — usando TFPHTTPClient}
  Result := False;
  Http := TFPHTTPClient.Create(nil);
  try
    try
      Http.AllowRedirect := True;
      Http.Get(Origem, Destino);
      Result := True;
    except
      Result := False;
    end;
  finally
    Http.Free;
  end;
end;

procedure TfmIndex.edtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = 84) and (Shift = [ssCtrl]) or
      (Key = 65) and (Shift = [ssCtrl])) then
  begin
    TEdit {LAZARUS: TbsSkinEdit}(Sender).SelectAll;
  end;
end;

procedure TfmIndex.escSBTempo;
var
  agora: TDateTime;
  crono: TTime;
  MyHora, MyMinuto, MySegundo, MyMiliSegundo: Word;
  Segundos: integer;
begin
  agora := now();
  crono := tEscSBCrono - agora;

  if (tEscSBCrono < agora) and (not cbEscSBZerarTempo.Checked)
    then lmdEscSbR.Caption := '-'+formatdatetime(cbFormatoTempoES.Items[cbFormatoTempoES.ItemIndex], crono)
    else lmdEscSbR.Caption := formatdatetime(cbFormatoTempoES.Items[cbFormatoTempoES.ItemIndex], crono);

  if (tEscSBCrono < agora) and (lmdEscSbR.Font.Color <> csEscsbCor3.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor})
    then lmdEscSbR.Font.Color := csEscsbCor3.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor}
  else if (tEscSBCrono >= agora) and (lmdEscSbR.Font.Color <> csEscsbCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor})
    then lmdEscSbR.Font.Color := csEscsbCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

  DecodeTime(crono, MyHora, MyMinuto, MySegundo, MyMiliSegundo);
  Segundos := MyMiliSegundo + (MySegundo * 1000) + (MyMinuto * 60000) + (MyHora * 3600000);
  if (Segundos > gEscSbR.Max) then
    gEscSbR.Max := Segundos;
  gEscSbR.Position := Segundos;

  if (rbgAudioES.Visible) and (tEscSBCrono > agora) and (formatdatetime('hh:mm:ss', crono) = '00:05:10') and (cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[1]) then
  begin
    try
      BASS_ChannelStop(BassPreviewChannel); {LAZARUS: mpMusica.Stop->BASS_ChannelStop}
    except
      //
    end;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    cbMusica.ItemIndex := 1;
    selMusica();
    btOuvirClick(btOuvir);
  end;
  if (rbgAudioES.Visible) and (tEscSBCrono > agora) and (formatdatetime('hh:mm:ss', crono) = '00:01:10') and (cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[2]) then
  begin
    try
      BASS_ChannelStop(BassPreviewChannel); {LAZARUS: mpMusica.Stop->BASS_ChannelStop}
    except
      //
    end;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    cbMusica.ItemIndex := 2;
    selMusica();
    btOuvirClick(btOuvir);
  end;
  if (tEscSBCrono <= now()) and (cbEscSBZerarTempo.Checked) then
  begin
    btLigar.Caption := 'Ligar';
    btLigar.Down := False;
    btLigar.ImageIndex := 20;
    gEscSbR.Max := 1;
    gEscSbR.Position := 1;
    lmdEscSbR.Font.Color := csEscsbCor2.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor};

    bsAddT1.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddT5.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddT10.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddTm1.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddTm5.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddTm10.Enabled := not(btLigar.Caption = 'Ligar');
  end;

  if (fMonitorCronometroCulto <> nil) then
  begin
    fMonitorCronometroCulto.gEscSbR.Max := gEscSbR.Max;
    fMonitorCronometroCulto.gEscSbR.Position := gEscSbR.Position;
    fMonitorCronometroCulto.lmdEscSbR.Caption := lmdEscSbR.Caption;
    fMonitorCronometroCulto.lmdEscSbR.Font.Color := lmdEscSbR.Font.Color;
  end;
end;

procedure TfmIndex.dblBibVersao2Click(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'] := DM.qrBIBLIA_VERSAO_2.FieldByName('SIGLA').AsString;
  gravaParam('Busca Biblica', 'Versão', loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO']);
end;

procedure TfmIndex.dblBibVersaoClick(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_VERSAO'] := dblBibVersao.KeyValue;
  if (loadCol.Strings.Values['BIBLIA_P_LIVRO'] <> loadCol.Strings.Values['BIBLIA_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_LIVRO'] := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
  end;
  if (loadCol.Strings.Values['BIBLIA_P_CAPITULO'] <> loadCol.Strings.Values['BIBLIA_P_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
  end;
  carregaBiblia('VSC');
  DBCtrlGridBibliaVersiculoClick(DBCtrlGridBibliaVersiculo);
end;

procedure TfmIndex.Localizar(ValorBusca: string; RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit}; recolore: boolean);
begin
  {LAZARUS: FindText/SelAttributes nao disponivel em TRichMemo — busca em RichEdit nao implementada}
end;

function TfmIndex.formataIntervaloNum(S: string): string;
var
  str: TStringList;
  arr: array of integer;
  i,ant: Integer;
  u: string;
begin
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(S), str);
  str.Sorted := True;
  str.Duplicates := dupIgnore;
  setlength(arr,str.Count);
  u := '';
  for i := 0 to str.Count-1 do
  begin
    if (u <> str[i]) then
    begin
      arr[i] := StrToInt(str[i]);
      u := str[i];
    end;
  end;

  aSort(arr);
  S := '';
  ant := 0;
  for i := 0 to Length(arr)-1 do
  begin
    if (arr[i] > 0) then
    begin
      if (ant = 0) then
      begin
        S := S+IntToStr(arr[i]);
      end
      else if (arr[i]-ant = 1) and (Length(arr)-1 > i) and (arr[i+1]-arr[i] = 1) then
      begin
        S := S+'-';
      end
      else
      begin
        S := S+','+IntToStr(arr[i]);
      end;
      S := StringReplace(S, '-,', '-', [rfIgnoreCase, rfReplaceAll]);
      S := StringReplace(S, '--', '-', [rfIgnoreCase, rfReplaceAll]);
      ant := arr[i];
    end;
  end;
  S := StringReplace(S, '-,', '-', [rfIgnoreCase, rfReplaceAll]);
  S := StringReplace(S, '--', '-', [rfIgnoreCase, rfReplaceAll]);
  Result := S;
end;

procedure TfmIndex.formataTexto(RichEdit: TRichMemo {LAZARUS: TbsSkinRichEdit});
var
  iPosINI, iPosTAM: integer;
  txt_pre, txt, txt_pos: string;
  i: integer;
begin
  RichEdit.SelStart := 0;
  RichEdit.SelLength := Length(RichEdit.text);
  RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := [];

  paramtemp.lines.Clear;

  while Pos('[', RichEdit.text) > 0 do
  begin
    iPosINI := Pos('[', RichEdit.text);
    iPosTAM := Pos(']', Copy(RichEdit.text, iPosINI, Length(RichEdit.text)));

    txt_pre := Copy(RichEdit.Text, 1, iPosINI - 1);
    txt := Copy(RichEdit.Text, iPosINI + 1, iPosTAM - 2);
    txt_pos := Copy(RichEdit.Text, iPosINI + iPosTAM, Length(RichEdit.Text));

    RichEdit.text := txt_pre + txt + txt_pos;
    if iPosTAM > 0 then
    begin
      paramtemp.Lines.Add(IntToStr(Length(StringReplace(txt_pre, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]))) + ',' + IntToStr(Length(StringReplace(txt, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]))));

    end;
  end;

  for i := 0 to paramtemp.Lines.Count - 1 do
  begin
    iPosINI := StrToInt(Copy(paramtemp.Lines[i], 1, Pos(',', paramtemp.Lines[i]) - 1));
    iPosTAM := StrToInt(Copy(paramtemp.Lines[i], Pos(',', paramtemp.Lines[i]) + 1, Length(paramtemp.Lines[i])));
    RichEdit.SelStart := iPosINI;
    RichEdit.SelLength := iPosTAM;
    RichEdit.Font.Style {LAZARUS: SelAttributes.Style stub — TRichMemo usa GetTextAttributes} := [fsBold];
//    Application.Processmessages;
  end;

  RichEdit.SelStart := 0;
  RichEdit.SelLength := 0;
end;

procedure TfmIndex.FormResize(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to loadCol.RowCount - 1 do
    if loadCol.Cells[1, i] = 'ok' then
      loadCol.Cells[1, i] := '';

  if PageControl1.Visible = true then
  begin
    try
      PageControl1.Pages[PageControl1.ActivePageIndex].OnShow(Sender);
    except
      //
    end;
  end;
end;

function TfmIndex.geraIntervaloNum(S: string): string;
var
  str: TStringList;
  str2: TStringList;
  mi,ma: integer;
  i,j: Integer;
begin
  S := StringReplace(S, ';', ',', [rfIgnoreCase, rfReplaceAll]);
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(S), str);
  S := '';
  for i := 0 to str.Count-1 do
  begin
    str2 := TStringList.Create;
    ExtractStrings(['-'], [], PChar(str[i]), str2);
    mi := 9999;
    ma := 0;
    for j := 0 to str2.Count-1 do
    begin
      if (StrToInt(str2[j]) > ma)
        then ma := StrToInt(str2[j]);

      if (StrToInt(str2[j]) < mi)
        then mi := StrToInt(str2[j]);
    end;

    for j := mi to ma do
    begin
      if S <> '' then
        S := S + ',';
      S := S + IntToStr(j);
    end;
  end;
  result := S;
end;

procedure TfmIndex.tsBibliaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfBiblia,tsBiblia);
  marcaAbaAberta(tsBiblia);
  if (loadCol.Strings.Values['BIBLIA_F'] <> 'okf') then
  begin
    lmdBibliaTxt.Caption := '';
    lmdBibliainfo.Caption := '';

    DM.qrBUSCA_VERSAO.Close;
    DM.qrBUSCA_VERSAO.ParamByName('SIGLA').AsString := lerParam('Biblia', 'Versão', '.');
    DM.qrBUSCA_VERSAO.Open;
    if (DM.qrBUSCA_VERSAO.RecordCount <= 0) then
    begin
      fmIndex.apagaParam('Biblia');
      DM.qrBUSCA_VERSAO_1.Close;
      DM.qrBUSCA_VERSAO_1.Open;
      while not DM.qrBUSCA_VERSAO_1.Eof do
      begin
        loadCol.Strings.Values['BIBLIA_VERSAO'] := DM.qrBUSCA_VERSAO_1.FieldByName('VERSAO').AsString;
        loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := DM.qrBUSCA_VERSAO_1.FieldByName('SIGLA').AsString+'.';
        loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := DM.qrBUSCA_VERSAO_1.FieldByName('LIVRO').AsString;
        DM.qrBUSCA_VERSAO_1.next;
      end;
    end
    else
    begin
      loadCol.Strings.Values['BIBLIA_VERSAO'] := lerParam('Biblia', 'Versão', '');
      loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := lerParam('Biblia', 'Livro Sigla', '');
      loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := lerParam('Biblia', 'Livro Nome', '');
    end;
    loadCol.Strings.Values['BIBLIA_F'] := 'okf';
    loadCol.Strings.Values['BIBLIA_LIVRO'] := lerParam('Biblia', 'Livro', '1');
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := lerParam('Biblia', 'Capitulo', '1');
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';

    loadCol.Strings.Values['BIBLIA_P_VERSAO'] := loadCol.Strings.Values['BIBLIA_VERSAO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO'] := loadCol.Strings.Values['BIBLIA_LIVRO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_P_CAPITULO'] := loadCol.Strings.Values['BIBLIA_CAPITULO'];
    loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := loadCol.Strings.Values['BIBLIA_VERSICULO'];

    busBibliaLivro.Items.Clear;
    DM.qrBIBLIA_BUS_LIVROS.Close;
    DM.qrBIBLIA_BUS_LIVROS.Open;
    DM.qrBIBLIA_BUS_LIVROS.First;
    while not DM.qrBIBLIA_BUS_LIVROS.Eof do
    begin
      busBibliaLivro.Items.Add(DM.qrBIBLIA_BUS_LIVROS.FieldByName('LIVRO').AsString);
      DM.qrBIBLIA_BUS_LIVROS.Next;
    end;

    carregaBiblia('VER');
    carregaBiblia('LIV');
    carregaBiblia('CAP');
    carregaBiblia('VSC');

    if not DM.cdsBIBLIA_HISTORICO.Active then
    begin
      DM.cdsBIBLIA_HISTORICO.CreateDataSet;
      {LAZARUS: IndexName → IndexFieldNames — TBufDataset não suporta índices nomeados criados em runtime;
       ORDER_DATAHORA era TClientDataSet.IndexDefs; substituído por IndexFieldNames no campo DATAHORA}
      DM.cdsBIBLIA_HISTORICO.IndexFieldNames := 'DATAHORA';
      {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsBIBLIA_HISTORICO.LogChanges := False;)}
    end;

  end;

  if (loadCol.Strings.Values['BIBLIA'] <> 'ok') then
  begin
    loadCol.Strings.Values['BIBLIA'] := 'ok';

    {LAZARUS: DBCtrlGridBibliaLivro/Capitulo.RowCount/ColCount removidos — TScrollBox nao tem RowCount/ColCount}

    {LAZARUS: DBCtrlGridBibliaVersiculo.RowCount/ColCount removidos — TScrollBox nao tem RowCount/ColCount}

    {LAZARUS: DBCtrlGridBibliaHistorico.RowCount/ColCount removidos — TScrollBox nao tem RowCount/ColCount}

    loadCol.Strings.Values['BIBLIA'] := 'ok';
    loadCol.Strings.Values['BIBLIA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_IMG_E'] := '|';

    carregaConfiguracoes('BIBLIA');
  end;

  {LAZARUS: corrige layout dos painéis da aba Bíblia — bsSkinExPanel7/8/5/bsSkinPanel4
   todos tinham Align=alClient, sobrepondo-se; ajustaBibliaLayout usa posicionamento explícito.
   ProcessMessages garante que o GTK2 processe o layout antes de ler ClientWidth/ClientHeight.}
  if not Assigned(GridPanel74.OnResize) then
    GridPanel74.OnResize := GridPanel74Resize;
  Application.ProcessMessages;
  ajustaBibliaLayout;

end;

procedure TfmIndex.miOpcExportar1Click(Sender: TObject);
begin
  botao_trmenu.OnClick(Sender);
end;

function TfmIndex.ExtractBase64Data(const Base64String: string): string;
const
  Base64Prefix = 'base64,';
var
  PrefixPos: Integer;
begin
  // Encontra a posição do prefixo 'base64,'
  PrefixPos := Pos(Base64Prefix, Base64String);
  if PrefixPos > 0 then
    // Retorna a parte da string após o prefixo 'base64,'
    Result := Copy(Base64String, PrefixPos + Length(Base64Prefix), MaxInt)
  else
    // Se não houver prefixo, retorna a string original
    Result := Base64String;
end;

function TfmIndex.ExtraiTexto(const Str, Str1, Str2: string): string;
var
  Inicio, Fim: string;
begin
  Inicio := Copy(Str, Pos(Str1, Str) + Length(Str1), Length(Str));

  // Pega o Texto Restante, iniciando ao final da variavel Str1;
  Fim := Copy(Inicio, 0, Pos(Str2, Inicio) - 1);

  // Copia o Texto da posição inicial '0' até o Final, que é determinado pela posição inicial da variavel str2 menos '1' para corrigir;
  Result := Fim;
end;

procedure TfmIndex.carregaParams;
var
  LinkPag: string;
  txt: string;
  Flags: Cardinal;
  vers: string;
  {ip: TIdIPWatch;} {LAZARUS: TIdIPWatch removido}
  lParams: TStringList;
  versao_atu: TStringList;
begin
  if (paramexec.Strings.Values['internet'] <> '0') then
  begin
    if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
    begin
      if FileExists(dir_dados + 'configweb.ja') then
        Param.Strings.LoadFromFile(dir_dados + 'configweb.ja');
      Param.Strings.Values['internet_conexao'] := '0';
      Param.Strings.Values['download_params'] := '0';
    end
    else
    begin
      Buffer := 0;

      if (lerParam('Config', 'UltimaConexao', '') <> formatdatetime('yyyy-mm-dd', Now())) then
      begin
        gravaParam('Config', 'UltimaConexao', formatdatetime('yyyy-mm-dd', Now()));

        {LAZARUS: DM.progressDialog.MaxValue := StrToInt(lerParam('Config', 'Param Buffer', '100000')); — progressDialog removido}
        DM.FHttp.ConnectTimeout := 5000; {LAZARUS: timeout 5s para não travar inicialização}
        DM.FHttp.IOTimeout := 5000;
        DM.FHttp.AddHeader('Api-Token', api_token); {LAZARUS: IdHTTP1.Request.CustomHeaders → FHttp.AddHeader}

        try
          LinkPag := DM.FHttp.Get( {LAZARUS: IdHTTP1.Get→FHttp.Get} url_params);
          //txt := ExtraiTexto(LinkPag, '<params>', '</params>');
          txt := LinkPag;
          txt := IfThen(trim(txt) = '', '=', txt);
          Param.Strings.Text := txt;
          Param.Strings.SaveToFile(dir_dados + 'configweb.ja');
          Param.Strings.Values['internet_conexao'] := '1';
          Param.Strings.Values['download_params'] := '1';
          Param.Strings.Values['tentativas'] := '1';
        except
          Sleep(2000);
          try
            LinkPag := DM.FHttp.Get( {LAZARUS: IdHTTP1.Get→FHttp.Get} url_params);
            //txt := ExtraiTexto(LinkPag, '<params>', '</params>');
            txt := LinkPag;
            txt := IfThen(trim(txt) = '', '=', txt);
            Param.Strings.Text := txt;
            Param.Strings.SaveToFile(dir_dados + 'configweb.ja');
            Param.Strings.Values['internet_conexao'] := '1';
            Param.Strings.Values['download_params'] := '1';
            Param.Strings.Values['tentativas'] := '2';
          except
            on E: Exception do
            begin
              txt := DecodeStringBase64( {LAZARUS: IdDecoderMIME.DecodeString→DecodeStringBase64} lerParam('Config', 'Params', '='));
              txt := IfThen(trim(txt) = '', '=', txt);
              Param.Strings.Text := txt;
              Param.Strings.Values['internet_conexao'] := '1';
              Param.Strings.Values['download_params'] := '0';
              erro_log.Lines.Add(E.Message);
              erro_log.Lines.Add(url_params);
              gravaParam('Config', 'UltimaConexao', 'ERR');
            end;
          end;
        end;

        if Buffer > 0 then
          gravaParam('Config', 'Param Buffer', IntToStr(Buffer));
        Buffer := 0;

        if (Trim(Param.Strings.Values['formulario']) <> '') then
        begin
          DM.qrVERSAO.Close;
          DM.qrVERSAO.Open;

          versao_atu := TStringList.Create;
          versao_atu.Delimiter := '.';
          versao_atu.DelimitedText := VersaoExe + '.' + DM.qrVERSAO.fieldbyname('VERSAO_BD').AsString;

          vers := versao_atu[0]+'.'+versao_atu[1]+'.'+versao_atu[4]+'.'+versao_atu[5];
          if (vers <> lerParam('Config', 'EnviaAcesso', '')) then
          begin
            {LAZARUS: DM.progressDialog.Value := 0; — progressDialog removido}
            {LAZARUS: DM.progressDialog.MaxValue := StrToInt(lerParam('Config', 'Form Buffer', '200')); — progressDialog removido}

            try
              {ip := TIdIPWatch.Create(nil);} {LAZARUS: TIdIPWatch removido}
              lParams := TStringList.Create;
              lParams.Add('tipo=acesso');
              lParams.Add('versao=' + vers);
              lParams.Add('versao_exe=' + VersaoExe);
              lParams.Add('datahora=' + formatdatetime('yyyy-mm-dd hh:nn:ss', Now()));
              lParams.Add('ip=' + '' {LAZARUS: TIdIPWatch.LocalIP removido});
              lParams.Add('dir=' + Application.ExeName);
              lParams.Add('parametros=' + Application.ExeName {LAZARUS: GetCommandLine → Application.ExeName});
              paramtemp.Lines.Clear;
              paramtemp.Text := GetComputerNameFunc;
              lParams.Add('nome=' + trim(paramtemp.Lines[0]));
              paramtemp.Text := DM.FHttp.FormPost( {LAZARUS: idHttp1.Post→FHttp.FormPost} Param.Strings.Values['formulario'], lParams);
            except
            end;
            gravaParam('Config', 'EnviaAcesso', vers);

            if Buffer > 0 then
              gravaParam('Config', 'Form Buffer', IntToStr(Buffer));
            Buffer := 0;
          end;
        end;
      end
      else
      begin
        if FileExists(dir_dados + 'configweb.ja') then
          Param.Strings.LoadFromFile(dir_dados + 'configweb.ja');

        Param.Strings.Values['internet_conexao'] := '0';
        Param.Strings.Values['download_params'] := '0';
      end;
    end;
  end
  else
  begin
    if FileExists(dir_dados + 'configweb.ja') then
      Param.Strings.LoadFromFile(dir_dados + 'configweb.ja');

    Param.Strings.Values['internet_conexao'] := '-1';
    Param.Strings.Values['download_params'] := '0';
  end;
end;

procedure TfmIndex.carrega_monitores;
var
  i: Integer;
  MonitorsArray: TMonitorInfoArray; {LAZARUS: TArray<TMonitorInfo>->TMonitorInfoArray}
begin
  MonitorsArray := lista_monitores();
  {LAZARUS: ctrlMonitores.ColCount removido — TScrollBox nao tem ColCount}

  if not DM.cdsMonitores.Active then
  begin
    DM.cdsMonitores.CreateDataSet;
    {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsMonitores.LogChanges := False;)}
  end;
  DM.cdsMonitores.Open;
  {LAZARUS: EmptyDataSet removido — TBufDataset; usando First+Delete}
  DM.cdsMonitores.First;
  while not DM.cdsMonitores.Eof do
    DM.cdsMonitores.Delete;

  for i := 0 to length(MonitorsArray)-1 do
  begin
    DM.cdsMonitores.Append;
    DM.cdsMonitores.FieldByName('ID').Value := i;
    DM.cdsMonitores.FieldByName('NUM').Value := i+1;
    DM.cdsMonitores.FieldByName('WIDTH').Value := MonitorsArray[i].Width;
    DM.cdsMonitores.FieldByName('HEIGHT').Value := MonitorsArray[i].Height;
    DM.cdsMonitores.FieldByName('TOP').Value := MonitorsArray[i].Top;
    DM.cdsMonitores.FieldByName('LEFT').Value := MonitorsArray[i].Left;
    DM.cdsMonitores.FieldByName('X').Value := 'x';
    DM.cdsMonitores.Post;
  end;
end;

procedure TfmIndex.Excluir1Click(Sender: TObject);
var
  id, mComponente: string;
begin
  mComponente := TPopupMenu {LAZARUS: TbsSkinPopupMenu}(TMenuItem(Sender).GetParentMenu).PopupComponent.Name;
  id := Copy(mComponente, Pos('_', mComponente) + 1, Length(mComponente));

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  if (application.messagebox(PChar('Deseja realmente remover a coletânea ''' + DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').AsString + ''' do Menu?' + #13#10 + #13#10 + 'Nota: Isto não irá excluir os arquivos desta coletânea, somente o link que aponta para ela.'), fmIndex.TITULO, MB_YESNO + mb_iconquestion)) <> 6 then
    exit;

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  DM.cdsCOLETANEAS_PERSO.Delete;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  importColetaneasPerso();
end;

procedure TfmIndex.Excluir3Click(Sender: TObject);
var
  id: string;
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  if application.messagebox(PChar('Deseja realmente excluir este link?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    Exit;

  id := DM.cdsVideosOnPerso.FieldByName('ID').AsString;

  DM.cdsVideosOnPerso.Locate('ID', id, []);
  DM.cdsVideosOnPerso.Delete;
  stVideosOnPerso_1.Text {LAZARUS: TStatusPanel.Caption→.Text} := qtItens(DM.cdsVideosOnPerso,'vídeo encontrado','vídeos encontrados','Nenhum vídeo encontrado');

  btVidOnlPExcluir.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPCopiarLink.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPAbrirNaveg.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPExec.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
end;

procedure TfmIndex.ExcluirTodas1Click(Sender: TObject);
begin
  if application.messagebox(PChar('Deseja realmente excluir todas coletâneas personalizadas?' + #13#10 + #13#10 + 'Nota: Isto não irá excluir os arquivos destas coletâneas, somente os links que apontam para elas.'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    Exit;

  if FileExists(dir_dados + 'coletaneasUsuario.xml') then
    DeleteFile(dir_dados + 'coletaneasUsuario.xml');

  {LAZARUS: EmptyDataSet removido; usando First+Delete}
  DM.cdsCOLETANEAS_PERSO.First;
  while not DM.cdsCOLETANEAS_PERSO.Eof do
    DM.cdsCOLETANEAS_PERSO.Delete;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  importColetaneasPerso();
end;

function TfmIndex.GetComputerNameFunc: string;
begin
  {LAZARUS: GetComputerName removido — Windows API; usando GetEnvironmentVariable(HOSTNAME)}
  Result := GetEnvironmentVariable('HOSTNAME');
  if Result = '' then
    Result := 'localhost';
end;

function TfmIndex.GetEnvVarValue(const VarName: string): string;
begin
  {LAZARUS: GetEnvironmentVariable Windows API -> SysUtils.GetEnvironmentVariable}
  Result := SysUtils.GetEnvironmentVariable(VarName);
end;

{LAZARUS: port upstream 32c09b8 — GetAdaptersInfo (iphlpapi, Windows-only) →
 `ip -4 -o addr show up` via RunCommand. Retorna pares nome=ip das interfaces
 IPv4 ativas, excluindo loopback. Lista vazia em qualquer falha — o chamador
 trata caindo no GetIP.}
function TfmIndex.enumerarInterfacesRede: TStringList;
var
  saida, linha, nome, ip: string;
  linhas: TStringList;
  i, p: Integer;
begin
  Result := TStringList.Create;
  try
    if not RunCommand('ip', ['-4', '-o', 'addr', 'show', 'up'], saida) then
      Exit;
    linhas := TStringList.Create;
    try
      linhas.Text := saida;
      for i := 0 to linhas.Count - 1 do
      begin
        linha := linhas[i];
        {formato: "3: wlp0s20f3    inet 192.168.15.19/24 brd ..."}
        nome := ExtractWord(2, linha, [' ', #9]);
        ip := ExtractWord(4, linha, [' ', #9]);
        p := Pos('/', ip);
        if p > 0 then
          ip := Copy(ip, 1, p - 1);
        if (nome = '') or (nome = 'lo') or (ip = '') or (Pos('127.', ip) = 1) then
          Continue;
        Result.Add(nome + '=' + ip);
      end;
    finally
      linhas.Free;
    end;
  except
    {sem o comando `ip` ou erro de parse — lista vazia, chamador usa GetIP}
  end;
end;

function TfmIndex.GetIP: string;
var
  ifaces: TStringList;
begin
  {LAZARUS: port 32c09b8 — antes stub '127.0.0.1' (TIdStack/GStack removidos).
   Retorna o IP da primeira interface não-loopback ativa.}
  Result := '127.0.0.1';
  ifaces := enumerarInterfacesRede;
  try
    if ifaces.Count > 0 then
      Result := ifaces.ValueFromIndex[0];
  finally
    ifaces.Free;
  end;
end;

function TfmIndex.GetStrNumber(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

function TfmIndex.GetStrNumber2(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9',',',';','-']) then
    {$ELSE}
    if vText^ in ['0'..'9',',',';','-'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

procedure TfmIndex.BitmapFileToPNG(const Source, Dest: string);
var
  Bitmap: TBitmap;
  PNG: TPortableNetworkGraphic; {LAZARUS: TPNGImage→TPortableNetworkGraphic}
begin
  Bitmap := TBitmap.Create;
  PNG := TPortableNetworkGraphic.Create; {LAZARUS: TPNGImage→TPortableNetworkGraphic}
  {In case something goes wrong, free booth Bitmap and PNG}
  try
    Bitmap.LoadFromFile(Source);
    PNG.Assign(Bitmap);    //Convert data into png
    PNG.SaveToFile(Dest);
  finally
    Bitmap.Free;
    PNG.Free;
  end
end;

procedure TfmIndex.LiturgiaCalendarClick(Sender: TObject);
var
  dia_semana: integer;
  i: integer;
begin
  if Sender <> nil then
    RichEdit1Exit(Sender);

  if Sender = nil then
    dia_semana := dayofweek(now())
  else
    dia_semana := TComponent(Sender).Tag;
  loadCol.Strings.Values['LITURGIA:SEMANA'] := inttostr(dia_semana);
  for i := 1 to 7 do
    TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('lcal_' + inttostr(i)) as TSpeedButton {LAZARUS: TbsSkinSpeedButton}).Down := (TSpeedButton {LAZARUS: TbsSkinSpeedButton}(FindComponent('lcal_' + inttostr(i)) as TSpeedButton {LAZARUS: TbsSkinSpeedButton}).Tag = dia_semana);

  RichEdit1.Lines.Clear;
  if FileExists(dir_dados+'AnotacoesLiturgia_'+IntToStr(dia_semana)+'.rtf') then
    RichEdit1.Lines.LoadFromFile(dir_dados+'AnotacoesLiturgia_'+IntToStr(dia_semana)+'.rtf');
  RichEdit1.Font.Name {LAZARUS: DefaultFont->Font} := 'Tahoma';
  fcTxtI1.Text := RichEdit1.Font.Name {LAZARUS: DefaultFont->Font}; {LAZARUS: TbsSkinFontComboBox.Text (LAZARUS: TbsSkinFontComboBox.FontName->TComboBox.Text)->TComboBox.Text}
  seTxtITamanho1.Text := IntToStr(RichEdit1.Font.Size {LAZARUS: DefaultFont->Font});
  RichEditEnter(RichEdit1);

  carregaLiturgia(dia_semana);
end;

procedure TfmIndex.spServerClick(Sender: TObject);
var
  idx: Integer;
begin
  {LAZARUS: TStatusBar.OnClick — verificar qual painel foi clicado (spServer = Panels[1])}
  idx := bsSkinStatusBar1.GetPanelIndexAt(bsSkinStatusBar1.ScreenToClient(Mouse.CursorPos).X, 5);
  if (idx = 1) and (trim(spServer.Text {LAZARUS: TStatusPanel.Caption→.Text}) <> '') then
    OpenURL(spServer.Text {LAZARUS: TStatusPanel.Caption→.Text}); {LAZARUS: ShellExecute→OpenURL}
end;

procedure TfmIndex.sTabSheet12Show(Sender: TObject);
begin
  loadCol.Strings.Values['PERSO'] := '';
  abrePagina(tsPersonalizadas);
  AjustaLarguraCamposDBGrid(DBGrid3);
end;

procedure TfmIndex.sTabSheet13Show(Sender: TObject);
begin
  mmConfigJA.Lines.LoadFromFile(dir_dados + 'config.ja');
end;

procedure TfmIndex.sTabSheet14Show(Sender: TObject);
begin
  mmLiturgia.Lines.LoadFromFile(dir_dados + 'liturgia.ja');
end;

procedure TfmIndex.sTabSheet15Show(Sender: TObject);
var
  i: integer;
  item: TListItem;
begin
  lvMonitores.Items.Clear;
  for i := 0 to Screen.MonitorCount - 1 do
  begin
    item := lvMonitores.Items.Add;
    item.Caption := 'Monitor ' + inttostr(i + 1);

    item := lvMonitores.Items.Add;
    item.Caption := 'Índice';
    item.SubItems.Add(inttostr(i));

    item := lvMonitores.Items.Add;
    item.Caption := 'Dimensões';
    item.SubItems.Add(inttostr(monitorInfo(i).Width) + ' x ' + inttostr(monitorInfo(i).Height));

    item := lvMonitores.Items.Add;
    item.Caption := 'Posição';
    item.SubItems.Add(inttostr(monitorInfo(i).Top) + ' (Vertical) x ' + inttostr(monitorInfo(i).Left) + ' (Horizontal)');

    item := lvMonitores.Items.Add;
    item.Caption := '';
  end;
end;

procedure TfmIndex.sTabSheet16Show(Sender: TObject);
begin
  mmParam.Text := Application.ExeName {LAZARUS: GetCommandLine → Application.ExeName};
end;

procedure TfmIndex.sTabSheet18Show(Sender: TObject);
begin
  DM.ADO.GetTableNames('', slbTabelas.Items); {LAZARUS: TZConnection.GetTableNames(Pattern,List)}
end;

function TfmIndex.verificaURL(url: string; input: TCustomEdit {LAZARUS: TbsSkinEdit→TCustomEdit}; reverso: Boolean = False): string;
var
  dirCol: string;
  dirArqPart: string;
begin
  dirCol := ExtractFilePath(Application.ExeName);
  if reverso = true then
  begin
    if input.Text = 'I' then
      url := dirCol + url;
  end
  else
  begin
    dirArqPart := AnsiMidStr(PChar(url), 1, StrLen(PChar(dirCol)));

    if (dirCol = dirArqPart) then
    begin
      url := AnsiMidStr(PChar(url), StrLen(PChar(dirCol)) + 1, StrLen(PChar(url)));
      if trim(url) = '' then
      begin
        url := dirCol;
        input.Text := 'E';
      end
      else
        input.Text := 'I';
    end
    else if (FileExists(dirCol + dirArqPart)) then {LAZARUS: removido '\' redundante — dirCol já termina em separador}
      input.Text := 'I'
    else
      input.Text := 'E';
  end;

  if (Copy(url,1,1) = '\') then
    url := copy(url,2,Length(url));

  Result := url;
end;

function TfmIndex.verificaURL(url: string; input: TFileNameEdit {LAZARUS: TbsSkinFileEdit overload}; reverso: Boolean = False): string;
var
  proxy: TEdit;
begin
  {LAZARUS: TFileNameEdit nao herda de TCustomEdit — overload com proxy TEdit}
  proxy := TEdit.Create(nil);
  try
    proxy.Text := input.Text;
    Result := verificaURL(url, TCustomEdit(proxy), reverso);
    input.Text := proxy.Text;
  finally
    proxy.Free;
  end;
end;

procedure TfmIndex.sListView1DblClick(Sender: TObject);
var
  item: Integer;
  URL: string;
begin
  item := TListView {LAZARUS: TbsSkinListView}(Sender).ItemIndex;
  if (item < 0) then
    Exit;

  URL := TListView {LAZARUS: TbsSkinListView}(Sender).Items[item].SubItems[1];
  if (trim(URL) = '') then
    Exit;

  abrirArquivo(URL);
end;

procedure TfmIndex.lbSorteioItemCheckClick(Sender: TObject);
var
  item: string;
  linha: integer;
begin
  item := lbSorteio.Items[lbSorteio.ItemIndex]; {LAZARUS: TCheckListBox — Items[] is string}
  if lbSorteio.Checked[lbSorteio.ItemIndex] = true then {LAZARUS: .Items[].Checked→.Checked[]}
  begin
    vlSorteados.Strings.Values[item] := IntToStr(lbSorteio.ItemIndex);
    vlSorteio.FindRow(item, linha);
    if linha >= 0 then
      vlSorteio.DeleteRow(linha);
  end
  else
  begin
    vlSorteio.Strings.Values[item] := IntToStr(lbSorteio.ItemIndex);
    vlSorteados.FindRow(item, linha);
    if linha >= 0 then
      vlSorteados.DeleteRow(linha);
  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  end;

  SorteioContador;
end;

procedure TfmIndex.processaArquivo(arq: string);
var
  ext: string;
  audio: Boolean;
  ZipFile: TUnZipper; {LAZARUS: TZipFile→TUnZipper}
  dir_t: string;
begin
  ext := (ExtractFileExt(arq));
  if (ext = '.slja') then
  begin
    ZipFile := TUnZipper.Create; {LAZARUS: TZipFile zmRead}
    try
      dir_t := dir_temp+'~read_'+FormatDateTime('yyyymmddHHMMSSZZZ', now());
      ZipFile.FileName := arq;
      ZipFile.OutputPath := dir_t;
      ZipFile.UnZipAllFiles;
      arq := dir_t+'/slides.lja';
    finally
      ZipFile.Free;
    end;
    audio := (lerParam('Geral', 'audio', '1', ExtractFileName(arq), ExtractFilePath(arq)) = '1');
    abreLetraMusica('EXT',arq,-1,audio);
  end
  else
  if (ext = '.lja') then
  begin
    audio := (lerParam('Geral', 'audio', '1', ExtractFileName(arq), ExtractFilePath(arq)) = '1');
    abreLetraMusica('EXT',arq,-1,audio);
  end
  else
  begin
    Application.MessageBox(PChar('Arquivo "'+arq+'" inválido!'),TITULO,mb_ok+mb_iconerror);
    DM.tmrSair.Enabled := True;
  end;
//  showmessage(ext);
end;

procedure TfmIndex.RichEdit1Exit(Sender: TObject);
begin
  RichEdit1.Lines.SaveToFile(dir_dados+'AnotacoesLiturgia_'+loadCol.Strings.Values['LITURGIA:SEMANA']+'.rtf');
end;

procedure TfmIndex.mmBDKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F9) or (Key = VK_F5)
    then btExecSQLClick(Sender);
  edtKeyUp(Sender,Key,Shift);
end;

procedure TfmIndex.mmPainelDKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    btExibeTxtPainelDClick(Sender);
    mmPainelD.SelectAll;
    Key := #0;
  end
  else if (Key = #10) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    Key := #13;
  end;
end;

procedure TfmIndex.mmPopMonitorClick(Sender: TObject);
var
  tag: integer;
  item_config: string;
begin
  tag := TMenuItem(Sender).Tag;

//  if (botao_trmenu.ImageList.Name = 'ico_40x40')
//    then botao_trmenu.ImageIndex := 10
//    else botao_trmenu.ImageIndex := 53;
  botao_trmenu.Tag := tag;

  item_config := monitor_tp_config(botao_trmenu);
  gravaParam(item_config, 'Monitor', IntToStr(tag+1));

  monitor_bt_label(botao_trmenu);

//  botao_trmenu.OnClick(botao_trmenu);
end;

procedure TfmIndex.mnAbreFavoritoClick(Sender: TObject);
begin
  ogFavoritos.ItemIndex := TMenuItem(Sender).Tag;
end;

procedure TfmIndex.mnFechaAbaClick(Sender: TObject);
var
  t: integer;
begin
  t := PageControl1.Pages[PageControl1.ActivePageIndex].Tag;
  PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible := False;
  bsPopupMenuRibon.Items.Delete(t);
  confereAbasAbertas();
end;

procedure TfmIndex.mnFechaTodasAbasClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if (PageControl1.Pages[i].TabVisible = true) then
    begin
      PageControl1.Pages[i].TabVisible := False;
      bsPopupMenuRibon.Items.Delete(0);
    end;
  end;
  confereAbasAbertas();
  PaginaMenuAtiva(tsColetaneas);
end;

procedure TfmIndex.mnSelecionaAbaClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if (PageControl1.Pages[i].TabVisible = True) and (PageControl1.Pages[i].Tag = TMenuItem(Sender).Tag) then
    begin
      PageControl1.ActivePageIndex := i;
      Break;
    end;
  end;
end;

procedure TfmIndex.Modificar1Click(Sender: TObject);
var
  id, mComponente: string;
begin
  mComponente := TPopupMenu {LAZARUS: TbsSkinPopupMenu}(TMenuItem(Sender).GetParentMenu).PopupComponent.Name;
  id := Copy(mComponente, Pos('_', mComponente) + 1, Length(mComponente));

  pnlAltColPerso.Visible := False;
  btAltColPersoClick(Sender);
  cbColetaneasPerso.KeyValue := id;
  cbColetaneasPersoChange(Sender);
  cbColetaneasPerso.Enabled := False;
  txtAbrirColet2Enter(Sender);
end;

procedure TfmIndex.slbTabelasListBoxClick(Sender: TObject);
begin
  mmBD.Lines.Clear;
  mmBD.Lines.Add('SELECT * FROM '+slbTabelas.Items[slbTabelas.ItemIndex]);
  btExecSQLClick(Sender);
end;

procedure TfmIndex.sbMusicaAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Monitor', sbMusicaAreaExtendida.Items[sbMusicaAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.sbMusicaOperadorAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'MonitorOperador', sbMusicaOperadorAreaExtendida.Items[sbMusicaOperadorAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.sbMusicaRetornoAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'MonitorRetorno', sbMusicaRetornoAreaExtendida.Items[sbMusicaRetornoAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.sbPlayerAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Player', 'Monitor', sbPlayerAreaExtendida.Items[sbPlayerAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.expandirArea(Sender: TObject);
var
  abre: Boolean;
  monitor: Integer;
  i: integer;
  item_config: string;
  botao: string;
begin
  if Sender = nil then
    abre := False
  else
  begin
    if (TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}(Sender).ImageIndex <> 11) and
       (TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}(Sender).ImageIndex <> 54) then
      abre := True
    else
      abre := False;
  end;

  botao := TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}(Sender).Name;


  if abre = True then
  begin
    item_config := monitor_tp_config(TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}(Sender));
    monitor := strtoint(lerParam(item_config, 'Monitor', '2'));
    if (Screen.MonitorCount < monitor) then
    begin
      if (Application.MessageBox(PChar('Não foi possível localizar monitor '+inttostr(monitor)+'. Deseja abrir no monitor principal?'), TITULO, mb_yesno + mb_iconquestion) <> 6) then
        Exit;

      monitor := 0;
    end
    else
      monitor := monitor - 1;

    if (botao = 'btExp_MenuMusicas') then
    begin
      if fMonitorMenuMusicas <> nil then
        fMonitorMenuMusicas.Close;
      fIniciando.AppCreateForm(TfMonitorMenuMusicas, fMonitorMenuMusicas);
      fMonitorMenuMusicas.AlphaBlend := True;
      fMonitorMenuMusicas.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorMenuMusicas.BorderStyle := bsNone
      else
        fMonitorMenuMusicas.BorderStyle := bsSizeable;

      fMonitorMenuMusicas.show;
      fMonitorMenuMusicas.Left := monitorInfo(monitor).Left;
      fMonitorMenuMusicas.Top := monitorInfo(monitor).Top;
      fMonitorMenuMusicas.Width := monitorInfo(monitor).Width;
      fMonitorMenuMusicas.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorMenuMusicas.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorMenuMusicas.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_Biblia') then
    begin
      loadCol.Strings.Values['BIBLIA_IMG_E'] := '|';

      if fMonitorBiblia <> nil then
        fMonitorBiblia.Close;
      fIniciando.AppCreateForm(TfMonitorBiblia, fMonitorBiblia);
      fMonitorBiblia.AlphaBlend := True;
      fMonitorBiblia.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorBiblia.BorderStyle := bsNone
      else
        fMonitorBiblia.BorderStyle := bsSizeable;

      fMonitorBiblia.show;
      fMonitorBiblia.Left := monitorInfo(monitor).Left;
      fMonitorBiblia.Top := monitorInfo(monitor).Top;
      fMonitorBiblia.Width := monitorInfo(monitor).Width;
      fMonitorBiblia.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorBiblia.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorBiblia.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_BibliaBusca') then
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := '|';

      if fMonitorBibliaBusca <> nil then
        fMonitorBibliaBusca.Close;
      fIniciando.AppCreateForm(TfMonitorBibliaBusca, fMonitorBibliaBusca);
      fMonitorBibliaBusca.AlphaBlend := True;
      fMonitorBibliaBusca.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorBibliaBusca.BorderStyle := bsNone
      else
        fMonitorBibliaBusca.BorderStyle := bsSizeable;

      fMonitorBibliaBusca.show;
      fMonitorBibliaBusca.Left := monitorInfo(monitor).Left;
      fMonitorBibliaBusca.Top := monitorInfo(monitor).Top;
      fMonitorBibliaBusca.Width := monitorInfo(monitor).Width;
      fMonitorBibliaBusca.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorBibliaBusca.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorBibliaBusca.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_EscolaSabatina') then
    begin
      loadCol.Strings.Values['ES_IMG_E'] := '|';

      if fMonitorCronometroCulto <> nil then
        fMonitorCronometroCulto.Close;
      fIniciando.AppCreateForm(TfMonitorCronometroCulto, fMonitorCronometroCulto);
      fMonitorCronometroCulto.AlphaBlend := True;
      fMonitorCronometroCulto.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorCronometroCulto.BorderStyle := bsNone
      else
        fMonitorCronometroCulto.BorderStyle := bsSizeable;

      fMonitorCronometroCulto.show;
      fMonitorCronometroCulto.Left := monitorInfo(monitor).Left;
      fMonitorCronometroCulto.Top := monitorInfo(monitor).Top;
      fMonitorCronometroCulto.Width := monitorInfo(monitor).Width;
      fMonitorCronometroCulto.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorCronometroCulto.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorCronometroCulto.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_Sorteio') then
    begin
      loadCol.Strings.Values['SORTEIO_IMG_E'] := '|';

      if fMonitorSorteio <> nil then
        fMonitorSorteio.Close;
      fIniciando.AppCreateForm(TfMonitorSorteio, fMonitorSorteio);
      fMonitorSorteio.AlphaBlend := True;
      fMonitorSorteio.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorSorteio.BorderStyle := bsNone
      else
        fMonitorSorteio.BorderStyle := bsSizeable;

      fMonitorSorteio.show;
      fMonitorSorteio.Left := monitorInfo(monitor).Left;
      fMonitorSorteio.Top := monitorInfo(monitor).Top;
      fMonitorSorteio.Width := monitorInfo(monitor).Width;
      fMonitorSorteio.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorSorteio.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorSorteio.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_SorteioNM') then
    begin
      loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := '|';

      if fMonitorSorteioNomes <> nil then
        fMonitorSorteioNomes.Close;
      fIniciando.AppCreateForm(TfMonitorSorteioNomes, fMonitorSorteioNomes);
      fMonitorSorteioNomes.AlphaBlend := True;
      fMonitorSorteioNomes.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorSorteioNomes.BorderStyle := bsNone
      else
        fMonitorSorteioNomes.BorderStyle := bsSizeable;

      fMonitorSorteioNomes.show;
      fMonitorSorteioNomes.Left := monitorInfo(monitor).Left;
      fMonitorSorteioNomes.Top := monitorInfo(monitor).Top;
      fMonitorSorteioNomes.Width := monitorInfo(monitor).Width;
      fMonitorSorteioNomes.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorSorteioNomes.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorSorteioNomes.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_Cronometro') then
    begin
      loadCol.Strings.Values['CRONO_IMG_E'] := '|';

      if fMonitorCronometro <> nil then
        fMonitorCronometro.Close;
      fIniciando.AppCreateForm(TfMonitorCronometro, fMonitorCronometro);
      fMonitorCronometro.AlphaBlend := True;
      fMonitorCronometro.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorCronometro.BorderStyle := bsNone
      else
        fMonitorCronometro.BorderStyle := bsSizeable;

      fMonitorCronometro.show;
      fMonitorCronometro.Left := monitorInfo(monitor).Left;
      fMonitorCronometro.Top := monitorInfo(monitor).Top;
      fMonitorCronometro.Width := monitorInfo(monitor).Width;
      fMonitorCronometro.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorCronometro.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorCronometro.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_PainelD') then
    begin
      loadCol.Strings.Values['PAINELD_IMG_E'] := '|';

      if fMonitorPainelDinamico <> nil then
        fMonitorPainelDinamico.Close;
      fIniciando.AppCreateForm(TfMonitorPainelDinamico, fMonitorPainelDinamico);
      fMonitorPainelDinamico.AlphaBlend := True;
      fMonitorPainelDinamico.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorPainelDinamico.BorderStyle := bsNone
      else
        fMonitorPainelDinamico.BorderStyle := bsSizeable;

      fMonitorPainelDinamico.show;
      fMonitorPainelDinamico.Left := monitorInfo(monitor).Left;
      fMonitorPainelDinamico.Top := monitorInfo(monitor).Top;
      fMonitorPainelDinamico.Width := monitorInfo(monitor).Width;
      fMonitorPainelDinamico.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorPainelDinamico.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorPainelDinamico.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_TextoInterativo') then
    begin
      if fMonitorTextoInterativo <> nil then
        fMonitorTextoInterativo.Close;
      fIniciando.AppCreateForm(TfMonitorTextoInterativo, fMonitorTextoInterativo);
      fMonitorTextoInterativo.AlphaBlend := True;
      fMonitorTextoInterativo.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorTextoInterativo.BorderStyle := bsNone
      else
        fMonitorTextoInterativo.BorderStyle := bsSizeable;

      fMonitorTextoInterativo.show;
      fMonitorTextoInterativo.Left := monitorInfo(monitor).Left;
      fMonitorTextoInterativo.Top := monitorInfo(monitor).Top;
      fMonitorTextoInterativo.Width := monitorInfo(monitor).Width;
      fMonitorTextoInterativo.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorTextoInterativo.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorTextoInterativo.AlphaBlendValue := 255;
    end
    else if (botao = 'btExp_Relogio') then
    begin
      loadCol.Strings.Values['RELOGIO_IMG_E'] := '|';

      if fMonitorRelogio <> nil then
        fMonitorRelogio.Close;
      fIniciando.AppCreateForm(TfMonitorRelogio, fMonitorRelogio);
      fMonitorRelogio.AlphaBlend := True;
      fMonitorRelogio.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorRelogio.BorderStyle := bsNone
      else
        fMonitorRelogio.BorderStyle := bsSizeable;

      fMonitorRelogio.show;
      fMonitorRelogio.Left := monitorInfo(monitor).Left;
      fMonitorRelogio.Top := monitorInfo(monitor).Top;
      fMonitorRelogio.Width := monitorInfo(monitor).Width;
      fMonitorRelogio.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorRelogio.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorRelogio.AlphaBlendValue := 255;
    end;

  end
  else if Sender <> nil then
  begin
    if (botao = 'btExp_MenuMusicas') then
    begin
      if fMonitorMenuMusicas <> nil then
        fMonitorMenuMusicas.Close;
    end
    else
    if (botao = 'btExp_Biblia') then
    begin
      if fMonitorBiblia <> nil then
        fMonitorBiblia.Close;
    end
    else
    if (botao = 'btExp_BibliaBusca') then
    begin
      if fMonitorBibliaBusca <> nil then
        fMonitorBibliaBusca.Close;
    end
    else
    if (botao = 'btExp_EscolaSabatina') then
    begin
      if fMonitorCronometroCulto <> nil then
        fMonitorCronometroCulto.Close;
    end
    else
    if (botao = 'btExp_Sorteio') then
    begin
      if fMonitorSorteio <> nil then
        fMonitorSorteio.Close;
    end
    else
    if (botao = 'btExp_SorteioNM') then
    begin
      if fMonitorSorteioNomes <> nil then
        fMonitorSorteioNomes.Close;
    end
    else
    if (botao = 'btExp_Cronometro') then
    begin
      if fMonitorCronometro <> nil then
        fMonitorCronometro.Close;
    end
    else if (botao = 'btExp_PainelD') then
    begin
      if fMonitorPainelDinamico <> nil then
        fMonitorPainelDinamico.Close;
    end
    else if (botao = 'btExp_TextoInterativo') then
    begin
      if fMonitorTextoInterativo <> nil then
        fMonitorTextoInterativo.Close;
    end
    else if (botao = 'btExp_Relogio') then
    begin
      if fMonitorRelogio <> nil then
        fMonitorRelogio.Close;
    end;

    {LAZARUS: TSpeedButton.ImageList nao existe — removido}
    TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}(Sender).ImageIndex := 10;

  end;


end;

procedure TfmIndex.ExportarMusica(id: integer;audio:boolean;nome:string;param:string);
var
  url: string;
begin
  url := saveDialog('arquivo', 'Apresentação LouvorJA (*.slja)|*.slja','','','',trim(nome)+'.slja');
  if url <> '' then
    exportarMusicaParaArquivo(id, audio, url, param);
end;

procedure TfmIndex.exportarMusicaParaArquivo(id: integer;audio:boolean;url:string;param:string);
var
  arquivo : TMemIniFile;
  slide: string;
  tempo: string;
  ZipFile: TZipper; {LAZARUS: TZipFile zmWrite→TZipper}
  arq: string;
  arq_e: string;
  arq_d: string; {LAZARUS: path de disco normalizado (\ do DB → /)}
  imgList: TStringList;
begin
    ZipFile := TZipper.Create; {LAZARUS: TZipper}
    imgList := TStringList.Create;

    try
      imgList.Clear;

      try
        ZipFile.FileName := url; {LAZARUS: Open zmWrite→FileName}

        arq := dir_temp+'~save_'+ExtractFileName(url)+'_'+FormatDateTime('yyyymmddHHMMSSZZZ', now())+'.temp';
        arquivo := Tmeminifile.Create(arq);
        arquivo.Clear;

        try

          DM.qrSLIDE_MUSICA.Close;
          DM.qrSLIDE_MUSICA.ParamByName('MUSICA_ID').Value := id;
          DM.qrSLIDE_MUSICA.Open;

          arquivo.writeString('Geral', 'slides', IntToStr(DM.qrSLIDE_MUSICA.RecordCount));
          if (audio = true)
            then arquivo.writeString('Geral', 'audio', '1')
            else arquivo.writeString('Geral', 'audio', '0');
          if (param = 'PB') then
          begin
            if Trim(DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString) <> '' then
            begin
              {LAZARUS: normaliza \ do DB → / no acesso ao FS; entrada ZIP com / (zip spec, compatível Windows)}
              arq_d := StringReplace(dir_config+'musicas/'+DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString,'\','/',[rfReplaceAll]);
              arq_e := 'audio/'+ExtractFileName(arq_d);
              ZipFile.Entries.AddFileEntry(arq_d,arq_e); {LAZARUS: Add→AddFileEntry}
              arquivo.writeString('Geral', 'url_musica', arq_e);
            end
            else
            begin
              Application.MessageBox('Esta música não possui playback!',TITULO,mb_ok+MB_ICONEXCLAMATION);
              Exit;
            end;
          end
          else
          begin
            if Trim(DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString) <> '' then
            begin
              {LAZARUS: normaliza \ do DB → / no acesso ao FS; entrada ZIP com / (zip spec, compatível Windows)}
              arq_d := StringReplace(dir_config+'musicas/'+DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString,'\','/',[rfReplaceAll]);
              arq_e := 'audio/'+ExtractFileName(arq_d);
              ZipFile.Entries.AddFileEntry(arq_d,arq_e); {LAZARUS: Add→AddFileEntry}
              arquivo.writeString('Geral', 'url_musica', arq_e);
            end;
          end;

          while not DM.qrSLIDE_MUSICA.eof do
          begin
            slide := 'Slide:'+inttostr(DM.qrSLIDE_MUSICA.RecNo);
            arquivo.writeString(slide, 'tipo', DM.qrSLIDE_MUSICA.FieldByName('TIPO').AsString);
            if Trim(DM.qrSLIDE_MUSICA.FieldByName('LETRA').AsString) <> ''
              then arquivo.writeString(slide, 'letra', StringReplace(StringReplace(DM.qrSLIDE_MUSICA.FieldByName('LETRA').AsString,#13#10,'|',[rfReplaceAll]),#10,'|',[rfReplaceAll]));

            if DM.qrSLIDE_MUSICA.FieldByName('FUNDO_LETRA').AsInteger = 1
              then arquivo.writeString(slide, 'fundo_letra', '1')
              else arquivo.writeString(slide, 'fundo_letra', '0');

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString) <> '')
              then arquivo.writeString(slide, 'tamanho_letra', DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString);

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA').AsString) <> '')
              then arquivo.writeString(slide, 'cor_letra', ColorToHtml(StringToColor(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA').AsString)));

            if Trim(DM.qrSLIDE_MUSICA.FieldByName('LETRA_AUX').AsString) <> ''
              then arquivo.writeString(slide, 'letra_aux', StringReplace(StringReplace(DM.qrSLIDE_MUSICA.FieldByName('LETRA_AUX').AsString,#13#10,'|',[rfReplaceAll]),#10,'|',[rfReplaceAll]));

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString) <> '')
              then arquivo.writeString(slide, 'tamanho_letra_aux', DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').AsString);

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString) <> '')
              then arquivo.writeString(slide, 'cor_letra_aux', ColorToHtml(StringToColor(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString)));

            if Trim(DM.qrSLIDE_MUSICA.FieldByName('IMAGEM').AsString) <> '' then
            begin
              {LAZARUS: normaliza \ do DB → / no acesso ao FS; entrada ZIP com / (zip spec, compatível Windows)}
              arq_d := StringReplace(dir_config+'imagens/'+DM.qrSLIDE_MUSICA.FieldByName('IMAGEM').AsString,'\','/',[rfReplaceAll]);
              arq_e := 'imagens/'+ExtractFileName(arq_d);
              if imgList.IndexOf(arq_e) < 0 then
              begin
                imgList.Add(arq_e);
                ZipFile.Entries.AddFileEntry(arq_d,arq_e); {LAZARUS: Add→AddFileEntry}
              end;
              arquivo.writeString(slide, 'imagem', arq_e);
            end;

            if (param = 'PB')
              then tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO_PB').AsString
              else tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO').AsString;
    //        tempo := SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,pos)))
            arquivo.writeString(slide, 'tempo', tempo);

            DM.qrSLIDE_MUSICA.Next;
          end;
          DM.qrSLIDE_MUSICA.Close;
          arquivo.UpdateFile;
        finally
          arquivo.Free;
        end;

        ZipFile.Entries.AddFileEntry(arq,'slides.lja'); {LAZARUS: Add→Entries.AddFileEntry}
        ZipFile.ZipAllFiles; {LAZARUS: zipper write}
        DeleteFile(arq);
      finally
        ZipFile.Free;
      end;

    finally
      imgList.Free;
    end;

    Application.MessageBox('Slides exportados com sucesso!', TITULO, mb_ok + mb_iconinformation);
end;

procedure TfmIndex.ExportarMusicaClick(Sender: TObject);
var
  nome:string;
  id,tag: Integer;
  musica:string;
  param: string;
begin
  nome := TComponent(Sender).Name;
  tag := TComponent(Sender).Tag;
  id := 0;
  param := '';

  if (nome = 'miOpcExportar1') or (nome = 'miOpcExportar2') or (nome = 'miOpcExportar3')
    then nome := botao_trmenu.Name;

  if (nome = 'btExportarHino') then
  begin
    id := DBGrid1.DataSource.DataSet.FieldByName('ID').AsInteger;
    musica := DBGrid1.DataSource.DataSet.FieldByName('NOME').AsString;
  end
  else if (nome = 'btExportarHinoN') then
  begin
    id := DBGrid1N.DataSource.DataSet.FieldByName('ID').AsInteger;
    musica := DBGrid1N.DataSource.DataSet.FieldByName('NOME').AsString;
  end
  else if (nome = 'btExportarMusica') then
  begin
    if DBGrid2.DataSource.DataSet.FieldByName('TIPO_WEB').AsString = 'S' then
    begin
      application.MessageBox('Não é possível exportar slides de músicas da web!', TITULO, mb_ok + MB_ICONEXCLAMATION);
      exit;
    end;
    id := DBGrid2.DataSource.DataSet.FieldByName('ID').AsInteger;
    musica := DBGrid2.DataSource.DataSet.FieldByName('NOME').AsString;
  end;

  if tag = 2 then
  begin
    musica := musica + ' - PB';
    param := 'PB';
  end;

  ExportarMusica(id,(tag <= 2),musica,param);
end;

procedure TfmIndex.confereAbasAbertas;
var
  i, t: Integer;
begin
  mnFechaAba.Enabled := False;
  mnFechaTodasAbas.Enabled := False;

  t := 0;
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if PageControl1.Pages[i].TabVisible = true then
    begin
      mnFechaAba.Enabled := True;
      mnFechaTodasAbas.Enabled := True;
      PageControl1.Pages[i].Tag := t;
      {LAZARUS: guarda bounds — menu pode ter menos itens que abas abertas}
      if t < bsPopupMenuRibon.Items.Count then
        bsPopupMenuRibon.Items[t].Tag := t;
      t := t + 1;
    end;
  end;

  if mnFechaAba.Enabled = False then
  begin
    pnlTitForm.Caption := TITULO;
    PageControl1.Visible := false;
    botoesFavoritos('-');
    PaginaMenuAtiva(nil);
    {LAZARUS: guarda bounds}
    if bsPopupMenuFavoritos.Items.Count > 0 then
    begin
      bsPopupMenuFavoritos.Items[0].Checked := True;
      bsPopupMenuFavoritos.Items[0].Checked := False;
    end;
  end;
end;

procedure TfmIndex.copiaArquivoParaSlides(url: string; cds: TBufDataset; fechaerro: boolean; ListBox: TListBox; editor: Boolean); {LAZARUS: TClientDataSet->TBufDataset}
var
  i,slides: integer;
  slide,letra,letra_aux,tempo: string;
  uCor,uLetra: string;
begin

  uCor := '';
  uLetra := '';

  try
    slides := StrToInt('0'+fmIndex.lerParam('Geral', 'slides', '0',ExtractFileName(url), ExtractFilePath(url)));
    if (slides <= 0) then
    begin
      Application.MessageBox('Ocorreu um erro ao executar este arquivo!', fmIndex.titulo, mb_ok + mb_iconerror);
      if fechaerro then
      begin
        DM.tmrSair.Enabled := true;
        close;
      end;
      Exit;
    end;
  except
    Application.MessageBox('Ocorreu um erro ao executar este arquivo!', fmIndex.titulo, mb_ok + mb_iconerror);
    if fechaerro then
    begin
      DM.tmrSair.Enabled := true;
      close;
    end;
    Exit;
  end;

  for i := 1 to slides do
  begin
    slide := 'Slide:'+inttostr(i);
    letra := fmIndex.lerParam(slide, 'letra', '',ExtractFileName(url), ExtractFilePath(url));
    letra := StringReplace(letra,'|', #13#10, [rfIgnoreCase, rfReplaceAll]);
    letra_aux := fmIndex.lerParam(slide, 'letra_aux', '',ExtractFileName(url), ExtractFilePath(url));
    letra_aux := StringReplace(letra_aux,'|', #13#10, [rfIgnoreCase, rfReplaceAll]);
    tempo := fmIndex.lerParam(slide, 'tempo', '0',ExtractFileName(url), ExtractFilePath(url));

    if ListBox <> nil then
      ListBox.Items.Add(tempo);
    cds.Append;
    cds.FieldByName('LOCAL').Value := 'EXT';
    cds.FieldByName('TIPO').Value := fmIndex.lerParam(slide, 'tipo', 'LETRA',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('MUSICA_ID').Value := '-1';
    cds.FieldByName('LETRA_ID').Value := '-1';
    if not (FileExists(ExtractFilePath(url)+fmIndex.lerParam('Geral', 'url_musica', '',ExtractFileName(url), ExtractFilePath(url)))) then
      cds.FieldByName('URL_MUSICA').Value := fmIndex.lerParam('Geral', 'url_musica', '',ExtractFileName(url), ExtractFilePath(url))
    else
      cds.FieldByName('URL_MUSICA').Value := ExtractFilePath(url)+fmIndex.lerParam('Geral', 'url_musica', '',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('LETRA').Value := letra;
    cds.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(letra);
    cds.FieldByName('ORDEM').Value := i;
    if not (FileExists(ExtractFilePath(url)+fmIndex.lerParam(slide, 'imagem', '',ExtractFileName(url), ExtractFilePath(url)))) then
      cds.FieldByName('IMAGEM').Value := fmIndex.lerParam(slide, 'imagem', '',ExtractFileName(url), ExtractFilePath(url))
    else
      cds.FieldByName('IMAGEM').Value := ExtractFilePath(url)+fmIndex.lerParam(slide, 'imagem', '',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('IMAGEM_POSICAO').Value := '0'+fmIndex.lerParam(slide, 'imagem_posicao', '5',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('TEMPO').Value := tempo;
    cds.FieldByName('FUNDO_LETRA').Value := (fmIndex.lerParam(slide, 'fundo_letra', '1',ExtractFileName(url), ExtractFilePath(url)) = '1');
    if (i > 1) then
    begin
      cds.FieldByName('TAMANHO_LETRA').Value := '0'+fmIndex.lerParam(slide, 'tamanho_letra', '14',ExtractFileName(url), ExtractFilePath(url));
      cds.FieldByName('COR_LETRA').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_letra', '#FFFFFF',ExtractFileName(url), ExtractFilePath(url)));
    end
    else
    begin
      cds.FieldByName('TAMANHO_LETRA').Value := '0'+fmIndex.lerParam(slide, 'tamanho_letra', '18',ExtractFileName(url), ExtractFilePath(url));
      cds.FieldByName('COR_LETRA').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_letra', '#efb400',ExtractFileName(url), ExtractFilePath(url)));
    end;
    cds.FieldByName('LETRA_AUX').Value := letra_aux;
    cds.FieldByName('TAMANHO_LETRA_AUX').Value := '0'+fmIndex.lerParam(slide, 'tamanho_letra_aux', '10',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('COR_LETRA_AUX').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_letra_aux', '#efb400',ExtractFileName(url), ExtractFilePath(url)));
    cds.FieldByName('COR_FUNDO').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_fundo', '#000000',ExtractFileName(url), ExtractFilePath(url)));

    if (fmIndex.ckSlideTxtFormatPerso.Checked and fmIndex.ckSlideFormatPersoExt.Checked and not editor) then
    begin
      DM.cdsSLIDE_MUSICA.FieldByName('FUNDO_LETRA').Value := not fmIndex.ckMusicaFundoTransparente.Checked;

      if i = 1 then
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').Value := fmIndex.seTamanhoTitulo.Text;
        DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTituloMusica.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
      end
      else
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').Value := fmIndex.seTamanhoTexto.Text;
        if (uLetra <> '') and (Trim(uLetra) = Trim(AnsiUpperCase(letra))) then
        begin
          if uCor = '' then
          begin
            DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTextoRepetido.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
            uCor := 'S';
          end
          else
          begin
            DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTextoMusica.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
            uCor := '';
          end;
        end
        else
        begin
          DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTextoMusica.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
          uCor := '';
        end;
        uLetra := AnsiUpperCase(letra);
      end;
      DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').Value := fmIndex.seTamanhoTextoAux.Text;
      DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').Value := ColorToString(fmIndex.corTextoRepetido.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
    end;

    if (fmIndex.ckSlideImgFormatPerso.Checked and fmIndex.ckSlideFormatPersoExt.Checked and not editor) then
    begin
      if (fmIndex.ckFundoTransparente.Checked) then
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('COR_FUNDO').Value := fMusica.Color;
        DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').Value := '';
        DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM_POSICAO').Value := fmIndex.posicaoFundo.ItemIndex+1;
      end
      else
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('COR_FUNDO').Value := ColorToString(fmIndex.corFundoMusica.ButtonColor {LAZARUS: TColorButton.ColorValue->ButtonColor});
        DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').Value := fmIndex.imgFundoMusica.Text;
        DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM_POSICAO').Value := fmIndex.posicaoFundo.ItemIndex+1;
      end;
    end;

    cds.Post;
  end;
end;

procedure TfmIndex.copiaDadosTelaExtendida;
var
  Stream: TStringStream;
begin
  if (fMonitorMenuMusicas <> nil) and (fListaMusica <> nil) then
  begin
    fMonitorMenuMusicas.lblTitulo.Caption := fListaMusica.lblTitulo.Caption;
    fMonitorMenuMusicas.lblSubtitulo.Caption := fListaMusica.lblSubtitulo.Caption;
    fMonitorMenuMusicas.imgCapa.Picture := fListaMusica.imgCapa.Picture;
    {LAZARUS: DBCtrlGrid (TScrollBox) nao tem RowCount — ignorado}
    //fMonitorMenuMusicas.DBCtrlGrid.RowCount := Trunc(fMonitorMenuMusicas.DBCtrlGrid.ClientHeight / 80);
  end;


  if (fMonitorBiblia <> nil) then
  begin
    fMonitorBiblia.lmdBibliaTxt.Font := lmdBibliaTxt.Font;
    fMonitorBiblia.lmdBibliaInfo.Font := lmdBibliaInfo.Font;
    fMonitorBiblia.lmdBibliaTxt.Font.Height := Trunc((fMonitorBiblia.pnlBiblia.Height/100)*strtoint(lerParam('Biblia', 'Tamanho', '7')));
    fMonitorBiblia.lmdBibliaInfo.Font.Height := Trunc((fMonitorBiblia.pnlBiblia.Height/100)*strtoint(lerParam('Biblia', 'Tamanho Passagem', '7')));
    fMonitorBiblia.pnlBiblia.Color := pnlBiblia.Color;

    fMonitorBiblia.lmdBibliaTxt.Caption := lmdBibliaTxt.Caption;
    fMonitorBiblia.lmdBibliaInfo.Caption := lmdBibliaInfo.Caption;

    fMonitorBiblia.pnlBiblia.DoubleBuffered := pnlBiblia.DoubleBuffered;
    ajustaTexto('BIBLIA',true);

    if (loadCol.Strings.Values['BIBLIA_IMG_E'] <> lerParam('Biblia', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['BIBLIA_IMG_E'] := lerParam('Biblia', 'Imagem Fundo', '');
      fMonitorBiblia.imgBiblia.Picture := imgBiblia.Picture;

      fMonitorBiblia.imgBiblia.Refresh;
      fMonitorBiblia.imgBiblia.Repaint;
      fMonitorBiblia.pnlBiblia.Refresh;
      fMonitorBiblia.pnlBiblia.Invalidate;
      fMonitorBiblia.pnlBiblia.Repaint;
      ajustaImagem(fMonitorBiblia.imgBiblia,fMonitorBiblia.pnlBiblia,cbBibliaPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorBibliaBusca <> nil) then
  begin
    fMonitorBibliaBusca.lmdBibliaBuscaTxt.Font := lmdBibliaBuscaTxt.Font;
    fMonitorBibliaBusca.lmdBibliaBuscaInfo.Font := lmdBibliaBuscaInfo.Font;
    fMonitorBibliaBusca.lmdBibliaBuscaTxt.Font.Height := Trunc((fMonitorBibliaBusca.pnlBibliaBusca.Height/100)*strtoint(lerParam('Busca Biblica', 'Tamanho', '7')));
    fMonitorBibliaBusca.lmdBibliaBuscaInfo.Font.Height := Trunc((fMonitorBibliaBusca.pnlBibliaBusca.Height/100)*strtoint(lerParam('Busca Biblica', 'Tamanho Passagem', '7')));
    fMonitorBibliaBusca.pnlBibliaBusca.Color := pnlBibliaBusca.Color;

    fMonitorBibliaBusca.lmdBibliaBuscaTxt.Caption := lmdBibliaBuscaTxt.Caption;
    fMonitorBibliaBusca.lmdBibliaBuscaInfo.Caption := lmdBibliaBuscaInfo.Caption;

    fMonitorBibliaBusca.pnlBibliaBusca.DoubleBuffered := pnlBibliaBusca.DoubleBuffered;
    ajustaTexto('BIBLIA_BUSCA',true);

    if (loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] <> lerParam('Busca Biblica', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := lerParam('Busca Biblica', 'Imagem Fundo', '');
      fMonitorBibliaBusca.imgBibliaBusca.Picture := imgBibliaBusca.Picture;

      fMonitorBibliaBusca.imgBibliaBusca.Refresh;
      fMonitorBibliaBusca.imgBibliaBusca.Repaint;
      fMonitorBibliaBusca.pnlBibliaBusca.Refresh;
      fMonitorBibliaBusca.pnlBibliaBusca.Invalidate;
      fMonitorBibliaBusca.pnlBibliaBusca.Repaint;
      ajustaImagem(fMonitorBibliaBusca.imgBibliaBusca,fMonitorBibliaBusca.pnlBibliaBusca,cbBibliabPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorCronometroCulto <> nil) then
  begin
    fMonitorCronometroCulto.lmdEscSb.Font := lmdEscSb.Font;
    fMonitorCronometroCulto.lmdEscSbR.Font := lmdEscSbR.Font;
    fMonitorCronometroCulto.lmdEscSb.Font.Height := Trunc((fMonitorCronometroCulto.pnlEscSB.Height/100)*strtoint(lerParam('Escola Sabatina', 'Tamanho', '30')));
    fMonitorCronometroCulto.lmdEscSbR.Font.Height := Trunc((fMonitorCronometroCulto.pnlEscSB.Height/100)*strtoint(lerParam('Escola Sabatina', 'Tamanho 2', '20')));
    fMonitorCronometroCulto.pnlEscSB.Color := pnlEscSB.Color;

    fMonitorCronometroCulto.lmdEscSb.Caption := lmdEscSb.Caption;
    fMonitorCronometroCulto.lmdEscSbR.Caption := lmdEscSbR.Caption;
    fMonitorCronometroCulto.gEscSbR.Max := gEscSbR.Max;
    fMonitorCronometroCulto.gEscSbR.Position := gEscSbR.Position;

    fMonitorCronometroCulto.pnlEscSB.DoubleBuffered := pnlEscSB.DoubleBuffered;

    if (loadCol.Strings.Values['ES_IMG_E'] <> lerParam('Escola Sabatina', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['ES_IMG_E'] := lerParam('Escola Sabatina', 'Imagem Fundo', '');
      fMonitorCronometroCulto.imgEscSB.Picture := imgEscSB.Picture;

      fMonitorCronometroCulto.imgEscSB.Refresh;
      fMonitorCronometroCulto.imgEscSB.Repaint;
      fMonitorCronometroCulto.pnlEscSB.Refresh;
      fMonitorCronometroCulto.pnlEscSB.Invalidate;
      fMonitorCronometroCulto.pnlEscSB.Repaint;
      ajustaImagem(fMonitorCronometroCulto.imgEscSB,fMonitorCronometroCulto.pnlEscSB,cbEscSBPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorSorteio <> nil) then
  begin
    fMonitorSorteio.lmdSorteio.Font := lmdSorteio.Font;
    fMonitorSorteio.lmdSorteio.Font.Height := Trunc((fMonitorSorteio.pnlSorteio.Height/100)*strtoint(lerParam('Sorteio', 'Tamanho', '35')));
    fMonitorSorteio.pnlSorteio.Color := pnlSorteio.Color;
    fMonitorSorteio.pnlSorteioE.Visible := ckSorteioExp.Checked {LAZARUS: ItemChecked->Checked}[0];
    fMonitorSorteio.pnlSorteioD.Visible := ckSorteioExp.Checked {LAZARUS: ItemChecked->Checked}[1];

    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
    fMonitorSorteio.lmdSorteio.Align := lmdSorteio.Align;
    if fMonitorSorteio.lmdSorteio.Align = alClient
      then fMonitorSorteio.lmdSorteio.Height := fMonitorSorteio.pnlSorteio.Height
      else fMonitorSorteio.lmdSorteio.Height := Trunc(fMonitorSorteio.pnlSorteio.Height/2);

    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    try
      fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
    except
    end;
    fMonitorSorteio.lbSorteado.Items := lbSorteado.Items;
    try
      fMonitorSorteio.lbSorteado.ItemIndex := lbSorteado.ItemIndex;
    except
    end;
    fMonitorSorteio.gSorteio.Max := gSorteio.Max;
    fMonitorSorteio.gSorteio.Position := gSorteio.Position;

    fMonitorSorteio.pnlSorteio.DoubleBuffered := pnlSorteio.DoubleBuffered;

    if (loadCol.Strings.Values['SORTEIO_IMG_E'] <> lerParam('Sorteio', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['SORTEIO_IMG_E'] := lerParam('Sorteio', 'Imagem Fundo', '');
      fMonitorSorteio.imgSorteio.Picture := imgSorteio.Picture;
      fMonitorSorteio.imgSorteio.Refresh;
      fMonitorSorteio.imgSorteio.Repaint;
      fMonitorSorteio.pnlSorteio.Refresh;
      fMonitorSorteio.pnlSorteio.Invalidate;
      fMonitorSorteio.pnlSorteio.Repaint;
      ajustaImagem(fMonitorSorteio.imgSorteio,fMonitorSorteio.pnlSorteio,cbSorteioPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorSorteioNomes <> nil) then
  begin
    fMonitorSorteioNomes.lmdSorteioNM.Font := lmdSorteioNM.Font;
    fMonitorSorteioNomes.lmdSorteioNM.Font.Height := Trunc((fMonitorSorteioNomes.pnlSorteioNM.Height/100)*strtoint(lerParam('Sorteio Nomes', 'Tamanho', '15')));
    fMonitorSorteioNomes.pnlSorteioNM.Color := pnlSorteioNM.Color;
    fMonitorSorteioNomes.pnlSorteioNME.Visible := ckSorteioExpNM.Checked {LAZARUS: ItemChecked->Checked}[0];
    fMonitorSorteioNomes.pnlSorteioNMD.Visible := ckSorteioExpNM.Checked {LAZARUS: ItemChecked->Checked}[1];

    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
    fMonitorSorteioNomes.lmdSorteioNM.Align := lmdSorteioNM.Align;
    if fMonitorSorteioNomes.lmdSorteioNM.Align = alClient
      then fMonitorSorteioNomes.lmdSorteioNM.Height := fMonitorSorteioNomes.pnlSorteioNM.Height
      else fMonitorSorteioNomes.lmdSorteioNM.Height := Trunc(fMonitorSorteioNomes.pnlSorteioNM.Height/2);

    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    try
      fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
    except
    end;
    fMonitorSorteioNomes.lbSorteadoNM.Items := lbSorteadoNM.Items;
    try
      fMonitorSorteioNomes.lbSorteadoNM.ItemIndex := lbSorteadoNM.ItemIndex;
    except
    end;
    fMonitorSorteioNomes.gSorteioNM.Max {LAZARUS: TProgressBar.MaxValue->Max} := gSorteioNM.Max {LAZARUS: TProgressBar.MaxValue->Max};
    fMonitorSorteioNomes.gSorteioNM.Position := gSorteioNM.Position;

    fMonitorSorteioNomes.pnlSorteioNM.DoubleBuffered := pnlSorteioNM.DoubleBuffered;

    if (loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] <> lerParam('Sorteio Nomes', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := lerParam('Sorteio Nomes', 'Imagem Fundo', '');
      fMonitorSorteioNomes.imgSorteioNM.Picture := imgSorteioNM.Picture;

      fMonitorSorteioNomes.imgSorteioNM.Refresh;
      fMonitorSorteioNomes.imgSorteioNM.Repaint;
      fMonitorSorteioNomes.pnlSorteioNM.Refresh;
      fMonitorSorteioNomes.pnlSorteioNM.Invalidate;
      fMonitorSorteioNomes.pnlSorteioNM.Repaint;
      ajustaImagem(fMonitorSorteioNomes.imgSorteioNM,fMonitorSorteioNomes.pnlSorteioNM,cbSorteioNMPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorCronometro <> nil) then
  begin
    fMonitorCronometro.lmdCrono.Font := lmdCrono.Font;
    fMonitorCronometro.lmdCrono.Font.Height := Trunc((fMonitorCronometro.pnlCrono.Height/100)*strtoint(lerParam('Cronometro', 'Tamanho', '22')));
    fMonitorCronometro.pnlCrono.Color := pnlCrono.Color;
    fMonitorCronometro.pnlTempoGravado.Visible := cbCronoEl.Checked {LAZARUS: ItemChecked->Checked}[0];

    fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
    fMonitorCronometro.lmdCrono.Align := lmdCrono.Align;
    if fMonitorCronometro.lmdCrono.Align = alClient
      then fMonitorCronometro.lmdCrono.Height := fMonitorCronometro.pnlCrono.Height
      else fMonitorCronometro.lmdCrono.Height := Trunc(fMonitorCronometro.pnlCrono.Height/2);

    fMonitorCronometro.lbCrono.Items := lbCrono.Items;
    fMonitorCronometro.gCrono.Max := gCrono.Max;
    fMonitorCronometro.gCrono.Position := gCrono.Position;

    fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;

    if (loadCol.Strings.Values['CRONO_IMG_E'] <> lerParam('Cronometro', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['CRONO_IMG_E'] := lerParam('Cronometro', 'Imagem Fundo', '');
      fMonitorCronometro.imgCrono.Picture := imgCrono.Picture;

      fMonitorCronometro.imgCrono.Refresh;
      fMonitorCronometro.imgCrono.Repaint;
      fMonitorCronometro.pnlCrono.Refresh;
      fMonitorCronometro.pnlCrono.Invalidate;
      fMonitorCronometro.pnlCrono.Repaint;
      ajustaImagem(fMonitorCronometro.imgCrono,fMonitorCronometro.pnlCrono,cbCronoPosicaoFundo.ItemIndex+1);
    end;
  end;

  if (fMonitorPainelDinamico <> nil) then
  begin
    fMonitorPainelDinamico.lmdTxtPainelD.Font := lmdTxtPainelD.Font;
    fMonitorPainelDinamico.lmdTxtPainelD.Font.Height := Trunc((fMonitorPainelDinamico.pnlTxtPainelD.Height/100)*strtoint(lerParam('Painel Dinamico', 'Tamanho', '15')));
    fMonitorPainelDinamico.pnlTxtPainelD.Color := pnlTxtPainelD.Color;

    fMonitorPainelDinamico.lmdTxtPainelD.Caption := lmdTxtPainelD.Caption;
    fMonitorPainelDinamico.lmdTxtPainelD.Align := lmdTxtPainelD.Align;
    if fMonitorPainelDinamico.lmdTxtPainelD.Align = alClient
      then fMonitorPainelDinamico.lmdTxtPainelD.Height := fMonitorPainelDinamico.pnlTxtPainelD.Height
      else fMonitorPainelDinamico.lmdTxtPainelD.Height := Trunc(fMonitorPainelDinamico.pnlTxtPainelD.Height/2);

    fMonitorPainelDinamico.pnlTxtPainelD.DoubleBuffered := pnlTxtPainelD.DoubleBuffered;

    if (loadCol.Strings.Values['PAINELD_IMG_E'] <> lerParam('Painel Dinamico', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['PAINELD_IMG_E'] := lerParam('Painel Dinamico', 'Imagem Fundo', '');
      fMonitorPainelDinamico.imgTxtPainelD.Picture := imgTxtPainelD.Picture;

      fMonitorPainelDinamico.imgTxtPainelD.Refresh;
      fMonitorPainelDinamico.imgTxtPainelD.Repaint;
      fMonitorPainelDinamico.pnlTxtPainelD.Refresh;
      fMonitorPainelDinamico.pnlTxtPainelD.Invalidate;
      fMonitorPainelDinamico.pnlTxtPainelD.Repaint;
      ajustaImagem(fMonitorPainelDinamico.imgTxtPainelD,fMonitorPainelDinamico.pnlTxtPainelD,cbTxtPainelDPosicaoFundo.ItemIndex+1);
    end;
  end;

  if (fMonitorRelogio <> nil) then
  begin
    fMonitorRelogio.lmdRelogio.Font := lmdRelogio.Font;
    fMonitorRelogio.lmdRelogio.Font.Height := Trunc((fMonitorRelogio.pnlRelogio.Height/100)*strtoint(lerParam('Relogio', 'Tamanho', '30')));
    fMonitorRelogio.pnlRelogio.Color := pnlRelogio.Color;

    fMonitorRelogio.lmdRelogio.Caption := lmdRelogio.Caption;
    fMonitorRelogio.lmdRelogio.Align := lmdRelogio.Align;
    if fMonitorRelogio.lmdRelogio.Align = alClient
      then fMonitorRelogio.lmdRelogio.Height := fMonitorRelogio.pnlRelogio.Height
      else fMonitorRelogio.lmdRelogio.Height := Trunc(fMonitorRelogio.pnlRelogio.Height/2);


    fMonitorRelogio.pnlRelogio.DoubleBuffered := pnlRelogio.DoubleBuffered;

    if (loadCol.Strings.Values['RELOGIO_IMG_E'] <> lerParam('Relogio', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['RELOGIO_IMG_E'] := lerParam('Relogio', 'Imagem Fundo', '');
      fMonitorRelogio.imgRelogio.Picture := imgRelogio.Picture;

      fMonitorRelogio.imgRelogio.Refresh;
      fMonitorRelogio.imgRelogio.Repaint;
      fMonitorRelogio.pnlRelogio.Refresh;
      fMonitorRelogio.pnlRelogio.Invalidate;
      fMonitorRelogio.pnlRelogio.Repaint;
      ajustaImagem(fMonitorRelogio.imgRelogio,fMonitorRelogio.pnlRelogio,cbRelogioPosicaoFundo.ItemIndex+1);
    end;
  end;

  if (fMonitorTextoInterativo <> nil) then
  begin
    Stream := TStringStream.Create('');
    try
     RichEdit0.Lines.SaveToStream(Stream);

      Stream.Seek(0, soFromBeginning);
     fMonitorTextoInterativo.RichEdit0.Lines.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
    fMonitorTextoInterativo.RichEdit0.Color := RichEdit0.Color;
  end;
end;

procedure TfmIndex.CopiarLink1Click(Sender: TObject);
var
  txt: string;
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  txt := DM.cdsVideosOnPerso.FieldByName('URL').AsString;

  Clipboard.AsText := txt;
  application.messagebox(PChar('Link ''' + txt + ''' copiado para a Área de Transferência!'), TITULO, mb_ok + MB_ICONINFORMATION)
end;

procedure TfmIndex.copiaSlidesParaArquivo(url: string; cds: TBufDataset); {LAZARUS: TClientDataSet→TBufDataset}
var
  arquivo : TMemIniFile;
  slide: string;
  tempo: string;
  pos: integer;
  ZipFile: TZipper; {LAZARUS: TZipFile zmWrite→TZipper}
  arq: string;
  arq_e: string;
  arq_d: string; {LAZARUS: path de disco normalizado (\ do DB → /)}
  imgList: TStringList;

  bass_musica: HSAMPLE;
  bass_channel: HCHANNEL;
begin
//url := url+'.zip';
  ZipFile := TZipper.Create; {LAZARUS: TZipper}
  imgList := TStringList.Create;

  try
    imgList.Clear;

    try
      ZipFile.FileName := url; {LAZARUS: Open zmWrite→FileName}

      arq := dir_temp+'~save_'+ExtractFileName(url)+'_'+FormatDateTime('yyyymmddHHMMSSZZZ', now())+'.temp';
      arquivo := Tmeminifile.Create(arq);
      arquivo.Clear;

      pos := 1;
      if cds.RecNo > 0
        then pos := cds.RecNo;
      try
        cds.First;

        arquivo.writeString('Geral', 'slides', IntToStr(cds.RecordCount));
        arquivo.writeString('Geral', 'versao', lblVersao.Caption);

        if Trim(cds.FieldByName('URL_MUSICA').AsString) <> '' then
        begin
          {LAZARUS: normaliza \ → / no acesso ao FS; entrada ZIP com / (zip spec, compatível Windows)}
          arq_d := StringReplace(cds.FieldByName('URL_MUSICA').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
          arq_d := StringReplace(arq_d,'\','/',[rfReplaceAll]);
          arq_e := 'audio/'+ExtractFileName(arq_d);
          ZipFile.Entries.AddFileEntry(arq_d,arq_e); {LAZARUS: Add→AddFileEntry}
          arquivo.writeString('Geral', 'url_musica', arq_e);
          arquivo.writeString('Geral', 'audio', '1');

          try
            BASS_Init(-1, 44100, 0, nil, nil) {LAZARUS: Handle→nil (Linux BASS_Init)};
          except
            //
          end;
          try
            bass_musica := BASS_SampleLoad(FALSE, PChar(arq_d), 0, 0, 3, BASS_SAMPLE_OVER_POS or BASS_UNICODE); {LAZARUS: path normalizado}
            bass_channel := BASS_SampleGetChannel(bass_musica, False);
            if not BASS_ChannelPlay(bass_channel, False) then
            begin
              arquivo.writeString('Geral', 'bass', 'error');
            end;
          except
            //
          end;
        end
        else
          arquivo.writeString('Geral', 'audio', '0');

        while not cds.eof do
        begin
          slide := 'Slide:'+inttostr(cds.RecNo);
          if cds.RecNo = 1 then
            arquivo.writeString(slide, 'tipo', 'CAPA')
          else
            arquivo.writeString(slide, 'tipo', 'LETRA');

          if Trim(cds.FieldByName('LETRA').AsString) <> ''
            then arquivo.writeString(slide, 'letra', StringReplace(cds.FieldByName('LETRA').AsString,#13#10,'|',[rfIgnoreCase, rfReplaceAll]));

          if cds.FieldByName('FUNDO_LETRA').AsBoolean = True
            then arquivo.writeString(slide, 'fundo_letra', '1')
            else arquivo.writeString(slide, 'fundo_letra', '0');

          if (Trim(cds.FieldByName('TAMANHO_LETRA').AsString) <> '0') and (Trim(cds.FieldByName('TAMANHO_LETRA').AsString) <> '')
            then arquivo.writeString(slide, 'tamanho_letra', cds.FieldByName('TAMANHO_LETRA').AsString);

          if (Trim(cds.FieldByName('COR_LETRA').AsString) <> '0') and (Trim(cds.FieldByName('COR_LETRA').AsString) <> '')
            then arquivo.writeString(slide, 'cor_letra', ColorToHtml(StringToColor(cds.FieldByName('COR_LETRA').AsString)));

          if (Trim(cds.FieldByName('COR_FUNDO').AsString) <> '0') and (Trim(cds.FieldByName('COR_FUNDO').AsString) <> '')
            then arquivo.writeString(slide, 'cor_fundo', ColorToHtml(StringToColor(cds.FieldByName('COR_FUNDO').AsString)));

          if Trim(cds.FieldByName('LETRA_AUX').AsString) <> ''
            then arquivo.writeString(slide, 'letra_aux', StringReplace(cds.FieldByName('LETRA_AUX').AsString,#13#10,'|',[rfIgnoreCase, rfReplaceAll]));

          if (Trim(cds.FieldByName('TAMANHO_LETRA_AUX').AsString) <> '0') and (Trim(cds.FieldByName('TAMANHO_LETRA').AsString) <> '')
            then arquivo.writeString(slide, 'tamanho_letra_aux', cds.FieldByName('TAMANHO_LETRA_AUX').AsString);

          if (Trim(cds.FieldByName('COR_LETRA_AUX').AsString) <> '0') and (Trim(cds.FieldByName('COR_LETRA_AUX').AsString) <> '')
            then arquivo.writeString(slide, 'cor_letra_aux', ColorToHtml(StringToColor(cds.FieldByName('COR_LETRA_AUX').AsString)));

          if Trim(cds.FieldByName('IMAGEM').AsString) <> '' then
          begin
            {LAZARUS: normaliza \ → / no acesso ao FS; entrada ZIP com / (zip spec, compatível Windows)}
            arq_d := StringReplace(cds.FieldByName('IMAGEM').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
            arq_d := StringReplace(arq_d,'\','/',[rfReplaceAll]);
            arq_e := 'imagens/'+ExtractFileName(arq_d);
            if imgList.IndexOf(arq_e) < 0 then
            begin
              imgList.Add(arq_e);
              ZipFile.Entries.AddFileEntry(arq_d,arq_e); {LAZARUS: Add→AddFileEntry}
            end;
            arquivo.writeString(slide, 'imagem', arq_e);
          end;

          if Trim(cds.FieldByName('IMAGEM_POSICAO').AsString) <> ''
            then arquivo.writeString(slide, 'imagem_posicao', cds.FieldByName('IMAGEM_POSICAO').AsString);

          tempo := cds.FieldByName('TEMPO').AsString;
          arquivo.writeString(slide, 'tempo', tempo);

          if Trim(cds.FieldByName('URL_MUSICA').AsString) <> '' then
          begin
            try
              arquivo.writeString(slide, 'tempo_hms', SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,strtoint(tempo)))));
            except
              //
            end;
          end;

          if cds.RecordCount = cds.RecNo then Break;

          cds.Next;
        end;
        arquivo.UpdateFile;
      finally
        arquivo.Free;
      end;

      try
        BASS_MusicFree(bass_musica);
        BASS_Free();
      except
        //
      end;

      ZipFile.Entries.AddFileEntry(arq,'slides.lja'); {LAZARUS: Add→AddFileEntry}
      ZipFile.ZipAllFiles; {LAZARUS: zipper write}
      DeleteFile(arq);
    finally
      ZipFile.Free;
    end;

  finally
    imgList.Free;
  end;

  if (cds.Active) and (cds.RecordCount > 0) then
    cds.RecNo := pos;
end;

procedure TfmIndex.copiaTextoParaSlides(texto: string;
  cds: TBufDataset); {LAZARUS: TClientDataSet->TBufDataset}
var
  linhas: TStringList;
  i,qt_lin,pos: Integer;
  letra: string;
begin
  linhas := TStringList.Create;
  linhas.Text := texto;

  if (linhas.Count <= 0)
    then linhas.Add('');

  if (Trim(linhas[linhas.Count-1]) <> '')
    then linhas.Add('');

  if not cds.Active then
  begin
    cds.CreateDataSet;
    {LAZARUS: TBufDataset nao tem LogChanges — ignorado}
    //cds.LogChanges := False;
  end;

  pos := 1;
  qt_lin := cds.RecordCount;
  if qt_lin > 0 then pos := cds.RecNo;
  for i := 0 to linhas.Count-1 do
  begin
    letra := linhas[i];
    letra := StringReplace(letra,'|', #13#10, [rfIgnoreCase, rfReplaceAll]);

    if (qt_lin >= i+1) then
    begin
      cds.Locate('ORDEM', i+1, []);
      cds.Edit;
      cds.FieldByName('LETRA').Value := letra;
      cds.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(letra);
      cds.Post;
    end
    else
    begin
      cds.Append;
      cds.FieldByName('LOCAL').Value := 'INT';
      if (i = 0)
        then cds.FieldByName('TIPO').Value := 'CAPA'
        else cds.FieldByName('TIPO').Value := 'LETRA';
      cds.FieldByName('MUSICA_ID').Value := '-1';
      cds.FieldByName('LETRA_ID').Value := '-1';
      cds.FieldByName('URL_MUSICA').Value := '';
      cds.FieldByName('LETRA').Value := letra;
      cds.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(letra);
      cds.FieldByName('ORDEM').Value := i+1;
      cds.FieldByName('IMAGEM').Value := '';
      cds.FieldByName('IMAGEM_POSICAO').Value := '5';
      cds.FieldByName('TEMPO').Value := '0';
      cds.FieldByName('FUNDO_LETRA').Value := '1';
      cds.FieldByName('TAMANHO_LETRA').Value := '0';
      cds.FieldByName('COR_LETRA').Value := '';
      cds.FieldByName('LETRA_AUX').Value := '';
      cds.FieldByName('TAMANHO_LETRA_AUX').Value := '0';
      cds.FieldByName('COR_LETRA_AUX').Value := '';
      cds.Post;
    end;
  end;
  i := i+1;
  while i <= qt_lin do
  begin
    cds.Locate('ORDEM', i, []);
    cds.Delete;
    i := i+1;
  end;
  cds.RecNo := pos;
//  cds.Refresh;

end;

function TfmIndex.CopyComponent(Component, AParent: TComponent;
  NewComponentName: String): TComponent;
var
  Stream: TMemoryStream;
  S: String;
begin
  Result := TComponentClass(Component.ClassType).Create(Component.Owner);
  S := Component.Name;
  Component.Name := NewComponentName;
  Stream := TMemoryStream.Create;
  try
    Stream.WriteComponent(Component);
    Component.Name := S;
    Stream.Seek(0, soFromBeginning);
    Stream.ReadComponent(Result);
  finally
    Stream.Free;
  end;
  TWinControl(AParent).InsertControl(TControl(Result));
end;

function TfmIndex.monitorInfo(index: integer): TMonitorInfo;
var
  MonitorsArray: TMonitorInfoArray; {LAZARUS: TArray<TMonitorInfo>->TMonitorInfoArray}
begin
  MonitorsArray := lista_monitores();
  result := MonitorsArray[index];
end;

procedure TfmIndex.monitores(padrao: integer);
var
  qtd_monitores: integer;
  i: Integer;
  item: TMenuItem;
  lista: TStringList;
begin
  qtd_monitores := Screen.MonitorCount;

//Randomize;
//qtd_monitores := 3 + Random(10);

  bsPopupExpand.Items.Clear;
  sbMusicaAreaExtendida.Items.Clear;
  sbMusicaRetornoAreaExtendida.Items.Clear;
  sbVideoOnAreaExtendida.Items.Clear;
  sbPlayerAreaExtendida.Items.Clear;

  lista := TStringList.Create;
  lista.Clear;

  for i := 0 to qtd_monitores-1 do
  begin
    item := TMenuItem.Create(bsPopupExpand);
    item.Caption := 'Monitor '+IntToStr(i+1)+' ('+IntToStr(monitorInfo(i).Width)+'x'+IntToStr(monitorInfo(i).Height)+')';
    item.OnClick := mmPopMonitorClick;
    item.Tag := i;
    item.Checked := (padrao = i);
    item.RadioItem := True;

    bsPopupExpand.Items.Add(item);
    lista.Add(IntToStr(i+1));
  end;

  item := TMenuItem.Create(bsPopupExpand);
  item.Caption := '-';
  item.Tag := -1;
  bsPopupExpand.Items.Add(item);

  item := TMenuItem.Create(bsPopupExpand);
  item.Caption := 'Identificar Monitores';
  item.OnClick := identifica_monitores;
  item.Tag := -1;
  bsPopupExpand.Items.Add(item);

  sbMusicaAreaExtendida.Items := lista;
  sbMusicaRetornoAreaExtendida.Items := lista;
  sbMusicaOperadorAreaExtendida.Items := lista;
  sbVideoOnAreaExtendida.Items := lista;
  sbPlayerAreaExtendida.Items := lista;

  sbMusicaAreaExtendida.ItemIndex := StrToInt(lerParam('Musicas', 'Monitor', '2')) - 1;
  sbMusicaRetornoAreaExtendida.ItemIndex := StrToInt(lerParam('Musicas', 'MonitorRetorno', '3')) - 1;
  sbMusicaOperadorAreaExtendida.ItemIndex := StrToInt(lerParam('Musicas', 'MonitorOperador', '1')) - 1;
  sbVideoOnAreaExtendida.ItemIndex := StrToInt(lerParam('Videos Online', 'Monitor', '2')) - 1;
  sbPlayerAreaExtendida.ItemIndex := StrToInt(lerParam('Player', 'Monitor', '2')) - 1;
end;

procedure TfmIndex.monitor_bt_label(botao: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton});
var
  monitor: Integer;
  item_config: string;
begin
  item_config := monitor_tp_config(botao);
  monitor := StrToInt(lerParam(item_config, 'Monitor', '2'));
  if botao.Name = 'btExp_MenuMusicas'
    then botao.Caption := 'Projetar Menu (Monitor '+inttostr(monitor)+')'
    else botao.Caption := 'Monitor '+inttostr(monitor);
  botao.Tag := monitor-1;
end;

function TfmIndex.monitor_tp_config(botao: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}): string;
var
  tp: string;
begin
  tp := '';
       if botao.Name = 'btExp_Biblia' then tp := 'Biblia'
  else if botao.Name = 'btExp_BibliaBusca' then tp := 'Busca Biblica'
  else if botao.Name = 'btExp_EscolaSabatina' then tp := 'Escola Sabatina'
  else if botao.Name = 'btExp_Sorteio' then tp := 'Sorteio'
  else if botao.Name = 'btExp_SorteioNM' then tp := 'Sorteio Nomes'
  else if botao.Name = 'btExp_Cronometro' then tp := 'Cronometro'
  else if botao.Name = 'btExp_PainelD' then tp := 'Painel Dinamico'
  else if botao.Name = 'btExp_TextoInterativo' then tp := 'Texto Interativo'
  else if botao.Name = 'btExp_Relogio' then tp := 'Relogio'
  else if botao.Name = 'btExp_MenuMusicas' then tp := 'Lista Musicas';

  Result := tp;
end;

procedure TfmIndex.MonthCalendar1DblClick(Sender: TObject);
var
  data: TDate;
  id: string;
//  title: string;
  info: TEdit {LAZARUS: TbsSkinEdit};
  arq,dir: string;
begin
  data := EncodeDate(StrToInt(Copy(MonthCalendar1.Date,1,4)), StrToInt(Copy(MonthCalendar1.Date,6,2)), StrToInt(Copy(MonthCalendar1.Date,9,2))); {LAZARUS: TCalendar.Date returns 'YYYY-MM-DD'}
  if (DM.cdsItensAgendados.Locate('CATEGORIA;DATA', VarArrayOf([txtCategoria.Text,data]), [])) then
  begin
    fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
    fItensAgendados.id := DM.cdsItensAgendados.FieldByName('ID').AsString;
    fItensAgendados.tipo := 'ITEM';
    fItensAgendados.ShowModal;
    loadCol.Strings.Values['LITURGIA'] := '';
    Exit;
  end;

  arq := openDialog('arquivo', '', 'ItensAgendados', False, '', 'Escolher arquivo para o dia '+formatdatetime('dd/mm/yyyy',data));
  if (arq <> '') then
  begin
    info := TEdit {LAZARUS: TbsSkinEdit}.Create(nil);
    dir := verificaURL(arq, info, false);

    id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
    DM.cdsItensAgendados.Append;
    DM.cdsItensAgendados.FieldByName('ID').Value := id;
    DM.cdsItensAgendados.FieldByName('CATEGORIA').Value := txtCategoria.Text;
    DM.cdsItensAgendados.FieldByName('DATA').Value := data;
    DM.cdsItensAgendados.FieldByName('NOME').Value := ChangeFileExt(ExtractFileName(arq),'');
    DM.cdsItensAgendados.FieldByName('ARQUIVO').Value := dir;
    DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').Value := info.Text;
    DM.cdsItensAgendados.Post;
    refreshCalendar;
  end;
  loadCol.Strings.Values['LITURGIA'] := '';
end;

procedure TfmIndex.MonthCalendar1GetMonthInfo(Sender: TObject; Month: Cardinal;
  var MonthBoldInfo: Cardinal);
var
  dia: Integer;
  dias: array of cardinal;
begin
  SetLength(dias, 0);

  DM.cdsItensAgendadosClone.Filtered := True;
  DM.cdsItensAgendadosClone.Filter := 'CATEGORIA = '''+txtCategoria.Text+''' AND MONTH(DATA) = '+inttostr(Month)+' AND YEAR(DATA) = '+IntToStr(StrToIntDef(Copy(MonthCalendar1.Date,1,4), YearOf(Now)) {LAZARUS: TCalendar.Date returns 'YYYY-MM-DD'});
//  DM.cdsItensAgendadosClone.Filter := 'CATEGORIA = '''+txtCategoria.Text+''' AND MONTH(DATA) = '+inttostr(Month)+' AND YEAR(DATA) = '+IntToStr(YearOf(now()));
  if DM.cdsItensAgendadosClone.RecordCount > 0 then
  begin
    DM.cdsItensAgendadosClone.First;
    while not DM.cdsItensAgendadosClone.Eof do
    begin
      dia := StrToInt(FormatDateTime('dd',DM.cdsItensAgendadosClone.FieldByName('DATA').AsDateTime));

      SetLength(dias, Length(dias)+1);
      dias[High(dias)] := dia;

      DM.cdsItensAgendadosClone.Next;
    end;

    {LAZARUS: TCalendar.BoldDays nao existe no LCL — ignorado}
    //MonthCalendar1.BoldDays(dias, MonthBoldInfo);
  end;
end;

procedure TfmIndex.MouseWheel(Direction: string; Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  Pt: TPoint;
  Rct: TRect;
  i: integer;
  Delta: Integer;
  ScrollBox: TScrollBox {LAZARUS: TbsSkinScrollBox};
  DBCtrlGrid: TScrollBox {LAZARUS: TDBCtrlGrid sem equiv LCL};
begin
  GetCursorPos(Pt);

  with Screen.ActiveForm do
  begin
//    if not Active then
//      Exit;

    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i].ClassType = TScrollBox {LAZARUS: TbsSkinScrollBox} then
      begin
        ScrollBox := TScrollBox {LAZARUS: TbsSkinScrollBox}(Components[i]);
        GetWindowRect(ScrollBox.Handle, Rct);
        if (PtInRect(Rct, Pt)) and (ScrollBox.Parent.Visible) then
        begin
          if Direction = 'Up' then
            {LAZARUS: ScrollBox.VScrollBar.Position removido}
        end;
      end
      {LAZARUS: TDBCtrlGrid (TScrollBox) nao tem DataSource — bloco comentado}
      (*else if Components[i].ClassType = TScrollBox then
      begin
        DBCtrlGrid := TScrollBox(Components[i]);
        GetWindowRect(DBCtrlGrid.Handle, Rct);
        if (PtInRect(Rct, Pt)) and (DBCtrlGrid.Parent.Visible) then
        begin
          SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0,@Delta, 0);
          if not(PtInRect(DBCtrlGrid.ClientRect, DBCtrlGrid.ScreenToClient(MousePos)))
            then Exit;
          DBCtrlGrid.DataSource.DataSet.moveby(Delta);
        end;
      end*);
           (*
      else
      if fmIndex.Components[i].ClassType = TPageControl {LAZARUS: TbsRibbon} then
      begin
        Ribbon := TPageControl {LAZARUS: TbsRibbon}(fmIndex.Components[i]);
        GetWindowRect(Ribbon.Handle,Rct);
        if (PtInRect(Rct, Pt)) and (Ribbon.Visible) then
        begin
          if Direction = 'Up' then
          begin
            if Ribbon.TabIndex <= 0 then Exit;
            Ribbon.TabIndex := Ribbon.TabIndex - 1
          end
          else
          begin
            Ribbon.TabIndex := Ribbon.TabIndex + 1;
          end;
          ShowMessage(inttostr(Ribbon.TabIndex));
        end;
      end*);
    end;
  end;
end;

{LAZARUS: WMGetMinmaxInfo removido — Windows message handler nao disponivel no LCL}
(*
procedure TfmIndex.WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo);
var R: TRect; P_TL: TPoint;
begin
  inherited;
  SystemParametersInfo(SPI_GETWORKAREA, SizeOf(R), @R, 0);
  P_TL := R.TopLeft;
  Msg.MinMaxInfo^.ptMaxPosition := P_TL;
  OffsetRect(R, -R.Left, -R.Top);
  Msg.MinMaxInfo^.ptMaxSize := R.BottomRight;
end;
*)

{LAZARUS: WMNCHitTest removido — Windows message handler nao disponivel no LCL}
(*
procedure TfmIndex.WMNCHitTest(var Msg: TWMNCHitTest);
var ScreenPt: TPoint;
begin
  ScreenPt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
  if (ScreenPt.x < 5) then Msg.Result := HTLEFT
  else if (ScreenPt.y < 5) then Msg.Result := HTTOP
  else if (ScreenPt.x >= Width - 5) then Msg.Result := HTRIGHT
  else if (ScreenPt.y >= Height - 5) then Msg.Result := HTBOTTOM
  else if (ScreenPt.x < 5) and (ScreenPt.y < 5) then Msg.Result := HTTOPLEFT
  else if (ScreenPt.x < 5) and (ScreenPt.y >= Height - 5) then Msg.Result := HTBOTTOMLEFT
  else if (ScreenPt.x >= Width - 5) and (ScreenPt.y < 5) then Msg.Result := HTTOPRIGHT
  else if (ScreenPt.x >= Width - 5) and (ScreenPt.y >= Height - 5) then Msg.Result := HTBOTTOMRIGHT
end;
*)

procedure TfmIndex.btOpcResetClick(Sender: TObject);
var
  tag: integer;
  pwd: string;
begin
  pwd := lerParam('Senha', 'Formatacao', '');

  if Trim(pwd) <> '' then
  begin
    application.MessageBox('O administrador do sistema bloqueou o acesso à este recurso! Para continuar, será necessário colocar a senha de acesso!', titulo, mb_ok + MB_ICONINFORMATION);

    {LAZARUS: DM.pwd (TbsSkinPasswordDialog) substituido por InputQuery}
    if not InputQuery(titulo, 'Digite a senha de acesso:', pwd) or (pwd = '') then
    begin
      TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Down := False;
      exit;
    end;

    if (pwd = lerParam('Senha', 'Formatacao', ''))
      then pwd := '';
  end;

  if Trim(pwd) <> '' then
  begin
    application.MessageBox('Senha incorreta!', titulo, mb_ok + mb_iconerror);
    TSpeedButton {LAZARUS: TbsSkinSpeedButton}(Sender).Down := False;
    exit;
  end;

  if (application.MessageBox(PChar('Deseja restaurar as configurações?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  tag := TComponent(Sender).tag;
  if (tag = 1) then
  begin
    apagaParam('Biblia', 'Historico');
    apagaParam('Biblia', 'Fonte');
    apagaParam('Biblia', 'Tamanho');
    apagaParam('Biblia', 'Tamanho Passagem');
    apagaParam('Biblia', 'Cor');
    apagaParam('Biblia', 'Cor Passagem');
    apagaParam('Biblia', 'Cor Fundo');
    apagaParam('Biblia', 'Imagem Fundo');
    apagaParam('Biblia', 'Imagem Fundo - UrlInfo');
    apagaParam('Biblia', 'Posicao Fundo');
    carregaConfiguracoes('BIBLIA');

  end
  else if (tag = 2) then
  begin
    apagaParam('Busca Biblica', 'Fonte');
    apagaParam('Busca Biblica', 'Tamanho');
    apagaParam('Busca Biblica', 'Tamanho Passagem');
    apagaParam('Busca Biblica', 'Cor');
    apagaParam('Busca Biblica', 'Cor Passagem');
    apagaParam('Busca Biblica', 'Cor Fundo');
    apagaParam('Busca Biblica', 'Imagem Fundo');
    apagaParam('Busca Biblica', 'Imagem Fundo - UrlInfo');
    apagaParam('Busca Biblica', 'Posicao Fundo');
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    apagaParam('Escola Sabatina', 'Fonte');
    apagaParam('Escola Sabatina', 'Tamanho');
    apagaParam('Escola Sabatina', 'Cor');
    apagaParam('Escola Sabatina', 'Tamanho 2');
    apagaParam('Escola Sabatina', 'Cor 2');
    apagaParam('Escola Sabatina', 'Cor Fundo');
    apagaParam('Escola Sabatina', 'Imagem Fundo');
    apagaParam('Escola Sabatina', 'Imagem Fundo - UrlInfo');
    apagaParam('Escola Sabatina', 'Posicao Fundo');
    apagaParam('Escola Sabatina', 'FormatoHora');
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    apagaParam('Sorteio', 'Fonte');
    apagaParam('Sorteio', 'Tamanho');
    apagaParam('Sorteio', 'Cor');
    apagaParam('Sorteio', 'Cor Fundo');
    apagaParam('Sorteio', 'Numeros Disponiveis (Extendido)');
    apagaParam('Sorteio', 'Numeros Sorteados (Extendido)');
    apagaParam('Sorteio', 'Imagem Fundo');
    apagaParam('Sorteio', 'Imagem Fundo - UrlInfo');
    apagaParam('Sorteio', 'Posicao Fundo');
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    apagaParam('Cronometro', 'Fonte');
    apagaParam('Cronometro', 'Tamanho');
    apagaParam('Cronometro', 'Cor');
    apagaParam('Cronometro', 'Cor Fundo');
    apagaParam('Cronometro', 'Tempos Gravados (Extendido)');
    apagaParam('Cronometro', 'Tempo Decrescente');
    apagaParam('Cronometro', 'Direcao');
    apagaParam('Cronometro', 'Imagem Fundo');
    apagaParam('Cronometro', 'Imagem Fundo - UrlInfo');
    apagaParam('Cronometro', 'Posicao Fundo');
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    apagaParam('Sorteio Nomes', 'Fonte');
    apagaParam('Sorteio Nomes', 'Tamanho');
    apagaParam('Sorteio Nomes', 'Cor');
    apagaParam('Sorteio Nomes', 'Cor Fundo');
    apagaParam('Sorteio Nomes', 'Numeros Disponiveis (Extendido)');
    apagaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)');
    apagaParam('Sorteio Nomes', 'Imagem Fundo');
    apagaParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo');
    apagaParam('Sorteio Nomes', 'Posicao Fundo');
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    apagaParam('Painel Dinamico', 'Fonte');
    apagaParam('Painel Dinamico', 'Tamanho');
    apagaParam('Painel Dinamico', 'Cor');
    apagaParam('Painel Dinamico', 'Cor Fundo');
    apagaParam('Painel Dinamico', 'Imagem Fundo');
    apagaParam('Painel Dinamico', 'Imagem Fundo - UrlInfo');
    apagaParam('Painel Dinamico', 'Posicao Fundo');
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    apagaParam('Relogio', 'Fonte');
    apagaParam('Relogio', 'Tamanho');
    apagaParam('Relogio', 'Cor');
    apagaParam('Relogio', 'Cor Fundo');
    apagaParam('Relogio', 'Imagem Fundo');
    apagaParam('Relogio', 'Imagem Fundo - UrlInfo');
    apagaParam('Relogio', 'Posicao Fundo');
    apagaParam('Relogio', 'FormatoHora');
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.csOpcCorChange(Sender: TObject);
var
  tag: integer;
begin
  if carrega_opc then
    Exit;

  tag := TColorButton {LAZARUS: TbsSkinColorButton}(Sender).tag;
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 12) then
  begin
    gravaParam('Biblia', 'Cor Passagem', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 19) then
  begin
    gravaParam('Biblia', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 22) then
  begin
    gravaParam('Busca Biblica', 'Cor Passagem', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 29) then
  begin
    gravaParam('Busca Biblica', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('ES');
  end
  else if (tag = 32) then
  begin
    gravaParam('Escola Sabatina', 'Cor 2', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('ES');
  end
  else if (tag = 33) then
  begin
    gravaParam('Escola Sabatina', 'Cor 3', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('ES');
  end
  else if (tag = 39) then
  begin
    gravaParam('Escola Sabatina', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 49) then
  begin
    gravaParam('Sorteio', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 59) then
  begin
    gravaParam('Cronometro', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 69) then
  begin
    gravaParam('Sorteio Nomes', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 79) then
  begin
    gravaParam('Painel Dinamico', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Cor', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('RELOGIO');
  end
  else if (tag = 99) then
  begin
    gravaParam('Relogio', 'Cor Fundo', ColorToString(TColorButton {LAZARUS: TbsSkinColorButton}(Sender).ButtonColor {LAZARUS: ColorValue->ButtonColor}));
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaBuscaClick(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] := DM.qrBIBLIA_BUSCA.FieldByName('DESC_PASSAGEM2').AsString;
  lmdBibliaBuscaTxt.Caption := DM.qrBIBLIA_BUSCA.FieldByName('PASSAGEM').AsString;
  lmdBibliaBuscaInfo.Caption := DM.qrBIBLIA_BUSCA.FieldByName('DESC_PASSAGEM2').AsString;

  ajustaTexto('BIBLIA_BUSCA');
  copiaDadosTelaExtendida;

  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', lmdBibliaBuscaTxt.Caption);
     fmIndex.gravaParamServer('BIBLIA', 'info', lmdBibliaBuscaInfo.Caption);
  end;

  DBCtrlGridBibliaBusca.Refresh;
  DBCtrlGridBibliaBuscaPaintPanel(DBCtrlGridBibliaBusca,0, nil, Rect(1, 1, DBCtrlGridBibliaBusca.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGridBibliaBusca.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2));
end;

procedure TfmIndex.DBCtrlGridBibliaBuscaPaintPanel(
  DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox}; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGrid.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2);

    if (loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] = DM.qrBIBLIA_BUSCA {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('DESC_PASSAGEM2').AsString) then
    begin
      txtBibliaBusca.Font.Color := $002E2E2E;
      txtBibliaBusca.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      txtBibliaBuscaPassagem.Font.Color := $002E2E2E;
      txtBibliaBuscaPassagem.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtBibliaBusca.Font.Color := clWhite;
      txtBibliaBusca.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      txtBibliaBuscaPassagem.Font.Color := clWhite;
      txtBibliaBuscaPassagem.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $00282828;
    end;

    DBCtrlGridBibliaBusca_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.ajustaBibliaLayout;
{LAZARUS: os painéis da aba Bíblia (bsSkinExPanel7/8/5 + bsSkinPanel4) originalmente usavam
 o sistema de tile/grid do bsSkinPanel. No LCL todos ficaram com Align=alClient e se sobrepõem.
 Esta procedure reposiciona manualmente para replicar o layout original:
   coluna esquerda: Livros (booksW px, altura total)
   topo direito: Capítulos (metade da largura restante) | Versículos (outra metade)
   base direita: Preview pnlBiblia (largura total restante)}
var
  totalW, totalH, booksW, chapW, rowH: Integer;
begin
  if GridPanel74 = nil then Exit;

  {LAZARUS: desalinhar sempre para evitar sobreposição no LCL mesmo quando ClientWidth=0.
   Os painéis têm Align=alClient no LFM; se saímos antes de setar alNone eles se sobrepõem.
   Quando ClientWidth=0 o LCL pode ter redimensionado os painéis para 0x0 — restaurar bounds
   do LFM como fallback para que fiquem visíveis até GridPanel74Resize refinar o layout.}
  bsSkinExPanel7.Align := alNone;
  bsSkinExPanel8.Align := alNone;
  bsSkinExPanel5.Align := alNone;
  bsSkinPanel4.Align   := alNone;

  if (GridPanel74.ClientWidth = 0) or (GridPanel74.ClientHeight = 0) then
  begin
    bsSkinExPanel7.SetBounds(3,   0,   296, 434);
    bsSkinExPanel8.SetBounds(305, 0,   294, 217);
    bsSkinExPanel5.SetBounds(605, 0,   294, 217);
    bsSkinPanel4.SetBounds(302,   217, 600, 217);
    Exit;
  end;

  totalW := GridPanel74.ClientWidth;
  totalH := GridPanel74.ClientHeight;
  booksW := 302;   {largura da coluna de livros}
  rowH   := totalH div 2;  {altura das linhas superior e inferior}
  chapW  := (totalW - booksW) div 2;  {largura de cada coluna no topo: capítulos|versículos}

  bsSkinExPanel7.Align := alNone;
  bsSkinExPanel7.SetBounds(0, 0, booksW, totalH);

  bsSkinExPanel8.Align := alNone;
  bsSkinExPanel8.SetBounds(booksW, 0, chapW, rowH);

  bsSkinExPanel5.Align := alNone;
  bsSkinExPanel5.SetBounds(booksW + chapW, 0, totalW - booksW - chapW, rowH);

  bsSkinPanel4.Align := alNone;
  bsSkinPanel4.SetBounds(booksW, rowH, totalW - booksW, totalH - rowH);
end;

procedure TfmIndex.GridPanel74Resize(Sender: TObject);
begin
  ajustaBibliaLayout;
end;

procedure TfmIndex.DBCtrlGridBibliaCapituloClick(Sender: TObject);
begin
  if (loadCol.Strings.Values['BIBLIA_LIVRO'] = loadCol.Strings.Values['BIBLIA_P_LIVRO']) and
     (DM.qrBIBLIA_CAPITULOS {LAZARUS: DBCtrlGridBibliaCapitulo.DataSource.DataSet}.FieldByName('CAPITULO').AsString = loadCol.Strings.Values['BIBLIA_P_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
  end
  else if (loadCol.Strings.Values['BIBLIA_CAPITULO'] <> DM.qrBIBLIA_CAPITULOS {LAZARUS: DBCtrlGridBibliaCapitulo.DataSource.DataSet}.FieldByName('CAPITULO').AsString) then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '1';
  end;

  loadCol.Strings.Values['BIBLIA_CAPITULO'] := DM.qrBIBLIA_CAPITULOS {LAZARUS: DBCtrlGridBibliaCapitulo.DataSource.DataSet}.FieldByName('CAPITULO').AsString;
  if (loadCol.Strings.Values['BIBLIA_CAPITULO'] <> '') then
    busBibliaCapitulo.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_CAPITULO'])-1;
  DBCtrlGridBibliaCapitulo.Refresh;
  DBCtrlGridBibliaCapituloPaintPanel(DBCtrlGridBibliaCapitulo,StrToInt('0'+loadCol.Strings.Values['BIBLIA_CAPITULO']),nil,Rect(1, 1, DBCtrlGridBibliaCapitulo.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGridBibliaCapitulo.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2));

  carregaBiblia('VSC');
end;

procedure TfmIndex.DBCtrlGridBibliaCapituloPaintPanel(
  DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox}; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGrid.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2);

    if (StrToInt('0'+loadCol.Strings.Values['BIBLIA_CAPITULO']) = DM.qrBIBLIA_CAPITULOS {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('CAPITULO').AsInteger) then
    begin
      txtdbBibliaCapitulo.Font.Color := $002E2E2E;
      txtdbBibliaCapitulo.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtdbBibliaCapitulo.Font.Color := clWhite;
      txtdbBibliaCapitulo.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $00000070;
    end;

    DBCtrlGridBibliaCapitulo_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaHistoricoClick(Sender: TObject);
var
  key : Char;
  BIBLIA_VERSAO,BIBLIA_LIVRO,BIBLIA_CAPITULO,BIBLIA_VERSICULO: string;
begin
  BIBLIA_VERSAO := DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGridBibliaHistorico.DataSource.DataSet}.FieldByName('VERSAO').AsString;
  BIBLIA_LIVRO := DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGridBibliaHistorico.DataSource.DataSet}.FieldByName('LIVRO').AsString;
  BIBLIA_CAPITULO := DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGridBibliaHistorico.DataSource.DataSet}.FieldByName('CAPITULO').AsString;
  BIBLIA_VERSICULO := DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGridBibliaHistorico.DataSource.DataSet}.FieldByName('VERSICULO').AsString;

  if trim(BIBLIA_VERSAO) = '' then Exit;


  dblBibVersao.KeyValue := BIBLIA_VERSAO;
  loadCol.Strings.Values['BIBLIA_VERSAO'] := dblBibVersao.KeyValue;

  DM.qrBIBLIA_LIVROS.Locate('ID',BIBLIA_LIVRO,[]);
  DBCtrlGridBibliaLivroClick(Sender);

  DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',BIBLIA_CAPITULO,[]);
  DBCtrlGridBibliaCapituloClick(Sender);

  busBibliaVersiculo.Text := BIBLIA_VERSICULO;
  key := Char(13);
  busBibliaVersiculoKeyPress(Sender,key);
  busBibliaVersiculo.Text := '';

  DBCtrlGridBibliaHistorico.Refresh;
  DBCtrlGridBibliaHistoricoPaintPanel(DBCtrlGridBibliaHistorico,0,nil,Rect(1, 1, DBCtrlGridBibliaHistorico.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGridBibliaHistorico.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2));
end;

procedure TfmIndex.DBCtrlGridBibliaHistoricoPaintPanel(
  DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox}; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGrid.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2);

    if (loadCol.Strings.Values['BIBLIA_P_VERSICULO'] = DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('VERSICULO').AsString) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_CAPITULO']) = DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('CAPITULO').AsInteger) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_LIVRO']) = DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('LIVRO').AsInteger) and
       (loadCol.Strings.Values['BIBLIA_P_VERSAO'] = DM.cdsBIBLIA_HISTORICO {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('VERSAO').AsString) then
    begin
      txtBibliaHistorico.Font.Color := $002E2E2E;
      txtBibliaHistorico.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      txtBibliaHistoricoPassagem.Font.Color := $002E2E2E;
      txtBibliaHistoricoPassagem.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtBibliaHistorico.Font.Color := clWhite;
      txtBibliaHistorico.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      txtBibliaHistoricoPassagem.Font.Color := clWhite;
      txtBibliaHistoricoPassagem.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $002E2E2E;
    end;

    DBCtrlGridBibliaHistorico_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaLivroClick(Sender: TObject);
begin
  if (DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGridBibliaLivro.DataSource.DataSet}.FieldByName('ID').AsString = loadCol.Strings.Values['BIBLIA_P_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
  end
  else if (loadCol.Strings.Values['BIBLIA_LIVRO'] <> DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGridBibliaLivro.DataSource.DataSet}.FieldByName('ID').AsString) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := '1';
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '1';
  end;

  loadCol.Strings.Values['BIBLIA_LIVRO'] := DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGridBibliaLivro.DataSource.DataSet}.FieldByName('ID').AsString;
  loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGridBibliaLivro.DataSource.DataSet}.FieldByName('SIGLA').AsString;
  loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGridBibliaLivro.DataSource.DataSet}.FieldByName('LIVRO').AsString;
  busBibliaLivro.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_LIVRO'])-1;
  DBCtrlGridBibliaLivro.Refresh;
  DBCtrlGridBibliaLivroPaintPanel(DBCtrlGridBibliaLivro,StrToInt('0'+loadCol.Strings.Values['BIBLIA_LIVRO']),nil,Rect(1, 1,DBCtrlGridBibliaLivro.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGridBibliaLivro.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2));

  carregaBiblia('CAP');
  DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_CAPITULO'],[]);
  DBCtrlGridBibliaCapituloClick(Sender);
end;

procedure TfmIndex.DBCtrlGridBibliaLivroPaintPanel(
  DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox}; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGrid.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2);

    txtdbBibliaLivroNm.Visible := (DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('SIGLA_N').AsString <> '');
    if (StrToInt('0'+loadCol.Strings.Values['BIBLIA_LIVRO']) = DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('ID').AsInteger) then
    begin
      txtdbBibliaLivroSg.Font.Color := $002E2E2E;
      txtdbBibliaLivroSg.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      txtdbBibliaLivro.Font.Color := $002E2E2E;
      txtdbBibliaLivro.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      txtdbBibliaLivroNm.Font.Color := $002E2E2E;
      txtdbBibliaLivroNm.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      DBCtrlGrid.Canvas.Brush.Color := StringToColor(DM.qrBIBLIA_LIVROS {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('COR').AsString);

      txtdbBibliaLivroSg.Font.Color := clWhite;
      txtdbBibliaLivroSg.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      txtdbBibliaLivro.Font.Color := clWhite;
      txtdbBibliaLivro.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      txtdbBibliaLivroNm.Font.Color := clWhite;
      txtdbBibliaLivroNm.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
    end;

    DBCtrlGridBibliaLivro_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaVersiculoClick(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_VERSICULO'] := DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.FieldByName('VERSICULO').AsString;

  loadCol.Strings.Values['BIBLIA_P_VERSAO'] := loadCol.Strings.Values['BIBLIA_VERSAO'];
  loadCol.Strings.Values['BIBLIA_P_LIVRO'] := loadCol.Strings.Values['BIBLIA_LIVRO'];
  loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'];
  loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_LIVRO_NOME'];
  loadCol.Strings.Values['BIBLIA_P_CAPITULO'] := loadCol.Strings.Values['BIBLIA_CAPITULO'];
  loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := loadCol.Strings.Values['BIBLIA_VERSICULO'];

  lmdBibliaTxt.Caption := '"'+removeTagsHTML(DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.FieldByName('PASSAGEM_ORI').AsString)+'"';
  lmdBibliaInfo.Caption := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']+' '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+loadCol.Strings.Values['BIBLIA_P_VERSICULO']+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', lmdBibliaTxt.Caption);
     fmIndex.gravaParamServer('BIBLIA', 'info', lmdBibliaInfo.Caption);
  end;
  ajustaTexto('BIBLIA');
  copiaDadosTelaExtendida;

  gravaParam('Biblia', 'Versão',loadCol.Strings.Values['BIBLIA_P_VERSAO']);
  gravaParam('Biblia', 'Livro',loadCol.Strings.Values['BIBLIA_P_LIVRO']);
  gravaParam('Biblia', 'Livro Sigla',loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']);
  gravaParam('Biblia', 'Livro Nome',loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']);
  gravaParam('Biblia', 'Capitulo',loadCol.Strings.Values['BIBLIA_P_CAPITULO']);
  gravaParam('Biblia', 'Versiculo',loadCol.Strings.Values['BIBLIA_P_VERSICULO']);

  if (DM.cdsBIBLIA_HISTORICO.Locate('VERSAO;LIVRO;CAPITULO;VERSICULO', VarArrayOf([loadCol.Strings.Values['BIBLIA_P_VERSAO'],loadCol.Strings.Values['BIBLIA_P_LIVRO'],loadCol.Strings.Values['BIBLIA_P_CAPITULO'],loadCol.Strings.Values['BIBLIA_P_VERSICULO']]), [])) then
  begin
    DM.cdsBIBLIA_HISTORICO.Edit;
  end
  else
  begin
    DM.cdsBIBLIA_HISTORICO.Append;
    DM.cdsBIBLIA_HISTORICO.FieldByName('ID').Value := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
    DM.cdsBIBLIA_HISTORICO.FieldByName('DATAHORA').Value := Now;
  end;
  DM.cdsBIBLIA_HISTORICO.FieldByName('VERSAO').Value := loadCol.Strings.Values['BIBLIA_P_VERSAO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('LIVRO').Value := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('CAPITULO').Value := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('VERSICULO').Value := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('PASSAGEM').Value := DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGridBibliaVersiculo.DataSource.DataSet}.FieldByName('PASSAGEM_ORI').AsString;
  DM.cdsBIBLIA_HISTORICO.FieldByName('DESC_PASSAGEM').Value := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']+'. '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+loadCol.Strings.Values['BIBLIA_P_VERSICULO']+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
  DM.cdsBIBLIA_HISTORICO.Post;


  DBCtrlGridBibliaVersiculo.Refresh;
  DBCtrlGridBibliaVersiculoPaintPanel(DBCtrlGridBibliaVersiculo,StrToInt('0'+loadCol.Strings.Values['BIBLIA_VERSICULO']),nil,Rect(1, 1, DBCtrlGridBibliaVersiculo.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGridBibliaVersiculo.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2));
end;

procedure TfmIndex.DBCtrlGridBibliaVersiculoPaintPanel(
  DBCtrlGrid: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid — sem equivalente LCL, usar TScrollBox}; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.ClientWidth {LAZARUS: PanelWidth->ClientWidth}-2, DBCtrlGrid.ClientHeight {LAZARUS: PanelHeight->ClientHeight}-2);

    if (Pos(','+DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('VERSICULO').AsString+',',','+loadCol.Strings.Values['BIBLIA_P_VERSICULO']+',') > 0) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_CAPITULO']) = DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('CAPITULO').AsInteger) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_LIVRO']) = DM.qrBIBLIA_VERSICULOS {LAZARUS: DBCtrlGrid.DataSource.DataSet}.FieldByName('LIVRO').AsInteger) then
    begin
      txtdbBibliaVersiculo.Font.Color := $002E2E2E;
      txtdbBibliaVersiculo.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      txtdbBibliaVersiculoTxt.Font.Color := $002E2E2E;
      txtdbBibliaVersiculoTxt.Font.Color {LAZARUS: DefaultFont->Font} := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtdbBibliaVersiculo.Font.Color := clWhite;
      txtdbBibliaVersiculo.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      txtdbBibliaVersiculoTxt.Font.Color := clWhite;
      txtdbBibliaVersiculoTxt.Font.Color {LAZARUS: DefaultFont->Font} := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $00282828;
    end;

    DBCtrlGridBibliaVersiculo_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.dbctrlMusicasClick(Sender: TObject);
var
  tag: integer;
  QUERY: TZQuery {LAZARUS: TFDQuery};
  txt: string;
begin
  tag := TComponent(Sender).tag;

  if (tag < 10) then
  begin
    QUERY := DM.qrMUSICAS;
  end
  else if (tag < 20) then
  begin
    tag := tag-10;
    QUERY := DM.qrMUSICAS_INFANTIS;
  end
  else
    QUERY := nil;

  if (QUERY.FieldByName('ID').AsString = '') then Exit;

  if (tag = 4) then
    abreArquivoMusica(QUERY.FieldByName('ID').AsInteger,QUERY.FieldByName('ALBUM').AsString,QUERY.FieldByName('URL').AsString)
  else if (tag = 5) then
  begin
    if (QUERY.FieldByName('URL_INSTRUMENTAL').AsString = '') then
    begin
//      application.MessageBox(PChar('Esta música não possui playback. Será aberto o áudio cantado!'), titulo, mb_ok + MB_ICONEXCLAMATION);
      application.MessageBox(PChar('Esta música não possui playback!'), titulo, mb_ok + MB_ICONEXCLAMATION);
//      abreArquivoMusica(QUERY.FieldByName('ID').AsInteger,QUERY.FieldByName('ALBUM').AsString,QUERY.FieldByName('URL').AsString)
    end
    else abreArquivoMusica(QUERY.FieldByName('ID').AsInteger,QUERY.FieldByName('ALBUM').AsString,QUERY.FieldByName('URL_INSTRUMENTAL').AsString);
  end
  else if (tag = 6) then
    abreLetra(QUERY.FieldByName('ID').AsInteger)
  else
  begin
    if (Tag = 2)
      then txt := 'PB'
      else txt := '';
    abreLetraMusica('BD',txt,QUERY.FieldByName('ID').AsInteger,(tag < 3));
  end;
end;

procedure TfmIndex.fcOpcFonteChange(Sender: TObject);
var
  tag: integer;
begin
  if carrega_opc then
    Exit;

  tag := TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).tag;
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Fonte', TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text});
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.fcTxtIChange(Sender: TObject);
var
  tag: Integer;
  RichEdit:TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Font.Name := {LAZARUS: SelAttributes.Name stub} TComboBox {LAZARUS: TbsSkinFontComboBox}(Sender).Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text};
end;

procedure TfmIndex.seOpcTamanhoChange(Sender: TObject);
var
  tag: integer;
begin
 if carrega_opc then
    Exit;

  TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text := Trim(TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
  if Trim(TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text) = '' then
    Exit;
  //if StrToInt(TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text) < 10 then
  //  Exit;

  tag := TComboBox {LAZARUS: TbsSkinComboBox}(Sender).tag;
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Tamanho', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 12) then
  begin
    gravaParam('Biblia', 'Tamanho Passagem', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Tamanho', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 22) then
  begin
    gravaParam('Busca Biblica', 'Tamanho Passagem', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Tamanho', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('ES');
  end
  else if (tag = 32) then
  begin
    gravaParam('Escola Sabatina', 'Tamanho 2', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Tamanho', FloatToStr(TSpinEdit {LAZARUS: TbsSkinSpinEdit}(Sender).Value));
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Tamanho', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Tamanho', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Tamanho', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Tamanho', TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.seSorteioTempoChange(Sender: TObject);
begin
  gravaParam('Sorteio', 'TempoAnimacao', FloatToStr(seSorteioTempo.Value));
end;

procedure TfmIndex.seSorteioTempoNMChange(Sender: TObject);
begin
  gravaParam('Sorteio Nomes', 'TempoAnimacao', FloatToStr(seSorteioTempoNM.Value));
end;

procedure TfmIndex.seTxtITamanhoChange(Sender: TObject);
var
  tag: Integer;
  RichEdit:TRichMemo {LAZARUS: TbsSkinRichEdit};
begin
  tag := TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Tag;
  RichEdit := TRichMemo {LAZARUS: TbsSkinRichEdit}(FindComponent('RichEdit'+inttostr(tag)));

  TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text := Trim(TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
  if Trim(TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text) = '' then
    Exit;

  RichEdit.Font.Size := {LAZARUS: SelAttributes.Size stub} StrToInt(TComboBox {LAZARUS: TbsSkinComboBox}(Sender).Text);
end;

procedure TfmIndex.ShowTrackMenu(Sender: TObject);
var
  tag: integer;
begin
  botao_trmenu := TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}(Sender);
  tag := botao_trmenu.tag;
  monitores(tag);
end;

function TfmIndex.ColorToHtml(DColor: TColor): string;
var
  tmpRGB: TColorRef;
begin
  tmpRGB := ColorToRGB(DColor);
  Result := Format('#%.2x%.2x%.2x', [GetRValue(tmpRGB), GetGValue(tmpRGB), GetBValue(tmpRGB)]);
end;

procedure TfmIndex.cgEscSBAudioClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[0] then
    gravaParam('Escola Sabatina', 'Abertura', '1')
  else
    gravaParam('Escola Sabatina', 'Abertura', '0');

  if cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[1] then
    gravaParam('Escola Sabatina', '5 min.', '1')
  else
    gravaParam('Escola Sabatina', '5 min.', '0');

  if cgEscSBAudio.Checked {LAZARUS: ItemChecked->Checked}[2] then
    gravaParam('Escola Sabatina', '1 min.', '1')
  else
    gravaParam('Escola Sabatina', '1 min.', '0');

end;

procedure TfmIndex.ckFadeFormClick(Sender: TObject);
begin
  if ckFadeForm.Checked then
    gravaParam('Config', 'FadeForm', '1')
  else
    gravaParam('Config', 'FadeForm', '0');
end;

procedure TfmIndex.ckFundoTransparenteClick(Sender: TObject);
begin
  if ckFundoTransparente.Checked then
    gravaParam('Musicas', 'FundoTelaTransparente', '1')
  else
    gravaParam('Musicas', 'FundoTelaTransparente', '0');
  bsFormatSlideImgPerso2.Visible := (not ckFundoTransparente.Checked);
end;

procedure TfmIndex.ckgColetaneasClick(Sender: TObject);
begin
  if carrega_opc then exit;
  txtBuscaChange(Sender);

  if ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[0] then
    gravaParam('Busca', 'Baixadas', '1')
  else
    gravaParam('Busca', 'Baixadas', '0');

  if ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[1] then
    gravaParam('Busca', 'Web', '1')
  else
    gravaParam('Busca', 'Web', '0');

  if ckgColetaneas.Checked {LAZARUS: ItemChecked->Checked}[2] then
    gravaParam('Busca', 'Personalizadas', '1')
  else
    gravaParam('Busca', 'Personalizadas', '0');
end;

procedure TfmIndex.ckgFiltrosClick(Sender: TObject);
begin
  if carrega_opc then exit;
  txtBuscaChange(Sender);

  if ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[0] then
    gravaParam('Busca', 'Filtro 1', '1')
  else
    gravaParam('Busca', 'Filtro 1', '0');

  if ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[1] then
    gravaParam('Busca', 'Filtro 2', '1')
  else
    gravaParam('Busca', 'Filtro 2', '0');

  if ckgFiltros.Checked {LAZARUS: ItemChecked->Checked}[2] then
    gravaParam('Busca', 'Filtro 3', '1')
  else
    gravaParam('Busca', 'Filtro 3', '0');

end;

procedure TfmIndex.ckLivros2ClickCheck(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ckLivros2.Items.Count - 1 do
    ckLivros.Checked[i] := ckLivros2.checked[i];
end;

procedure TfmIndex.ckLivrosClickCheck(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
    ckLivros2.Checked[i] := ckLivros.checked[i];
end;

procedure TfmIndex.btOpcFileNameEditEnter(Sender: TObject);
var
  btOpcFileNameEditInfo: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
begin
  if carrega_opc then
    Exit;

  btOpcFileNameEditInfo := TFileNameEdit {LAZARUS: TbsSkinFileEdit}(FindComponent(TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Name + 'Info'));
  TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text := verificaURL(TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text, btOpcFileNameEditInfo, true);
end;

procedure TfmIndex.btOpcFileNameEditExit(Sender: TObject);
var
  tag: integer;
  btOpcFileNameEditInfo: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
begin
  if carrega_opc then
    Exit;

  btOpcFileNameEditInfo := TFileNameEdit {LAZARUS: TbsSkinFileEdit}(FindComponent(TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Name + 'Info'));
  TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text := StringReplace(TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text, '|', '', [rfIgnoreCase, rfReplaceAll]);
  TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text := verificaURL(TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text, btOpcFileNameEditInfo, false);

  tag := TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).tag;
  if (tag = 1) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Biblia', 'Imagem Fundo');
      apagaParam('Biblia', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Biblia', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Biblia', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Busca Biblica', 'Imagem Fundo');
      apagaParam('Busca Biblica', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Busca Biblica', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Busca Biblica', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Escola Sabatina', 'Imagem Fundo');
      apagaParam('Escola Sabatina', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Escola Sabatina', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Escola Sabatina', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Sorteio', 'Imagem Fundo');
      apagaParam('Sorteio', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Sorteio', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Sorteio', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Cronometro', 'Imagem Fundo');
      apagaParam('Cronometro', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Cronometro', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Cronometro', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Sorteio Nomes', 'Imagem Fundo');
      apagaParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Sorteio Nomes', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Painel Dinamico', 'Imagem Fundo');
      apagaParam('Painel Dinamico', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Painel Dinamico', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Painel Dinamico', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    if (TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text = '') then
    begin
      apagaParam('Relogio', 'Imagem Fundo');
      apagaParam('Relogio', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Relogio', 'Imagem Fundo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text);
      gravaParam('Relogio', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('RELOGIO');
  end;

  copiaDadosTelaExtendida();
end;

procedure TfmIndex.txtCapaColet2Enter(Sender: TObject);
begin
  txtCapaColet2.Text := verificaURL(txtCapaColet2.Text, txtImgInfoColet2, true);
end;

procedure TfmIndex.txtCapaColet2Exit(Sender: TObject);
begin
  txtCapaColet2.Text := verificaURL(txtCapaColet2.Text, txtImgInfoColet2);
end;

procedure TfmIndex.txtCapaColetEnter(Sender: TObject);
begin
  txtCapaColet.Text := verificaURL(txtCapaColet.Text, txtImgInfoColet, true);
end;

procedure TfmIndex.txtCapaColetExit(Sender: TObject);
begin
  txtCapaColet.Text := verificaURL(txtCapaColet.Text, txtImgInfoColet);
end;

function TfmIndex.HtmlToColor(Color: string): String;
begin
  Color := StringReplace(Color,'#', '', [rfIgnoreCase, rfReplaceAll]);
  if (Color <> '')
    then Result := '$0' + Copy(Color, 5, 2) + Copy(Color, 3, 2) + Copy(Color, 1, 2)
    else Result := '';
end;

procedure TfmIndex.identifica_monitores(Sender: TObject);
var
  form: TfIdentificaMonitores;
  qtd_monitores: integer;
  i: Integer;
begin
  carrega_monitores();
  monitores();
  qtd_monitores := Screen.MonitorCount;

  for i := 0 to qtd_monitores-1 do
  begin
    if i > Screen.MonitorCount-1
      then Continue;

    form := TfIdentificaMonitores.Create(Self);
    form.Show;
    form.Top := monitorInfo(i).Top;
    form.Left := monitorInfo(i).Left;
    form.rotulo.Caption := IntToStr(i+1);
    form.detalhes.Caption := IntToStr(monitorInfo(i).Width) + ' x ' + IntToStr(monitorInfo(i).Height);
    form.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmIndex.ImpExpClick(Sender: TObject);
var
  tag: integer;
  arquivo,descricao: string;
  arquivos: array[0..6] of string;
  arq: string;
begin
  tag := TComponent(Sender).Tag;
  arquivos[0] := 'config'+fIniciando.LANG+'.ja';
  arquivos[1] := 'coletaneasUsuario.xml';
  arquivos[2] := 'videosOnUsuario.xml';
  arquivos[3] := 'liturgia.ja';
  arquivos[4] := 'favoritos.xml';
  arquivos[5] := 'itensAgendadosCategorias.xml';
  arquivos[6] := 'itensAgendados.xml';

  arquivo := '';
  descricao := '';
  case tag of
    101, 102: begin arquivo := arquivos[0];descricao := 'Arquivo de Configuração'; end;
    111, 112: begin arquivo := arquivos[1];descricao := 'Arquivo de Coletâneas Personalizadas'; end;
    121, 122: begin arquivo := arquivos[2];descricao := 'Arquivo de Vídeos Online Personalizados'; end;
    131, 132: begin arquivo := arquivos[3];descricao := 'Arquivo de Liturgia'; end;
    141, 142: begin arquivo := arquivos[4];descricao := 'Arquivo de Favoritos'; end;
    151, 152: begin arquivo := arquivos[5];descricao := 'Arquivo de Categorias de Itens Agendados'; end;
    161, 162: begin arquivo := arquivos[6];descricao := 'Arquivo de Itens Agendados'; end;
  end;

  if (tag = 101) or (tag = 111) or (tag = 121) or
     (tag = 131) or (tag = 141) or (tag = 151) or (tag = 161) then
  begin
    if (application.MessageBox('Atenção: O arquivo importado irá sobrepor os dados atuais do sistema. Deseja continuar?',fmIndex.TITULO,mb_yesno+MB_ICONQUESTION) = 6) then
    begin
      arq := openDialog('arquivo', descricao+' ('+arquivo+')|'+arquivo, '',false,'','',arquivo);
      if arq <> '' then
      begin
        CopyFile(PChar(arq),PChar(dir_dados+ExtractFileName(arq)),false);
        application.MessageBox('Arquivo importado com sucesso!'+#13#10+'O sistema será reiniciado para que as novas configurações tenham efeito!',TITULO,mb_ok+mb_iconinformation);

        {LAZARUS: RunCommand(Application.ExeName, [], _out_) — ShellExecute removido}
        Application.Terminate;
      end;
    end;
  end
  else
  if (tag = 102) or (tag = 112) or (tag = 122) or
     (tag = 132) or (tag = 142) or (tag = 152) or (tag = 162) then
  begin
    if not (FileExists(dir_dados+ExtractFileName(arquivo))) then
    begin
      application.MessageBox(PChar('Não há dados para serem exportados!'),TITULO,mb_ok+mb_iconexclamation);
    end
    else
    begin
      application.MessageBox(PChar('Selecione o diretório onde deverá ser salvo o arquivo '''+arquivo+'''!'),TITULO,mb_ok+mb_iconinformation);
      arq := openDialog('pasta');
      if arq <> '' then
      begin
        CopyFile(PChar(dir_dados+ExtractFileName(arquivo)),PChar(arq+'\'+arquivo),false);
        application.MessageBox(PChar('Arquivo '''+arquivo+''' exportado com sucesso!'),TITULO,mb_ok+mb_iconinformation);
      end;
    end;
  end;
end;

procedure TfmIndex.importColetaneasPerso;
var
  url: string;
begin
  DM.cdsCOLETANEAS_PERSO_IMP.Close;
  if not DM.cdsCOLETANEAS_PERSO_IMP.Active then
  begin
    DM.cdsCOLETANEAS_PERSO_IMP.CreateDataSet;
    DM.cdsCOLETANEAS_PERSO_IMP.IndexName := '';
    DM.cdsCOLETANEAS_PERSO_IMP.IndexFieldNames := 'NOME';
    {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges (DM.cdsCOLETANEAS_PERSO_IMP.LogChanges := False;)}
  end;

  if (FileExists(dir_dados + 'coletaneasUsuario.xml')) then
    DM.cdsCOLETANEAS_PERSO_IMP.LoadFromFile(dir_dados + 'coletaneasUsuario.xml');
  DM.cdsCOLETANEAS_PERSO_IMP.Open;

  DM.qrDEL_COLETANEAS_PERSO.ExecSQL;

  DM.cdsCOLETANEAS_PERSO_IMP.First;
  while not DM.cdsCOLETANEAS_PERSO_IMP.Eof do
  begin
    url := DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('URL').AsString;
    if (DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('URL_INFO').AsString = 'I')
      then url := ExtractFilePath(Application.ExeName) + url;

    DM.qrADD_COLETANEAS_PERSO.Close;
    DM.qrADD_COLETANEAS_PERSO.ParamByName('ID').Value := DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('ID').AsString;
    DM.qrADD_COLETANEAS_PERSO.ParamByName('NOME').Value := DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('NOME').AsString;
    DM.qrADD_COLETANEAS_PERSO.ParamByName('URL').Value := url;
    DM.qrADD_COLETANEAS_PERSO.ExecSQL;


    DM.cdsCOLETANEAS_PERSO_IMP.Next;
  end;
end;

procedure TfmIndex.inputOpenDialog(Sender: TObject);
var
  arq: string;
begin
  arq := openDialog('arquivo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Filter,'',False,ExtractFileDir(TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text));
  if arq <> '' then TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text := arq;
end;

procedure TfmIndex.inputOpenPictureDialog(Sender: TObject);
var
  arq: string;
begin
  arq := openDialog('imagem', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Filter,'',False,ExtractFileDir(TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text));
  if arq <> '' then TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Text := arq;
end;

{LAZARUS: fontconfig API para carregar fonte TTF em runtime no Linux.
 fontconfig é dependência transitiva do GTK2 (já carregado), portanto
 as funções externas estáticas não causam falha de link em runtime.}
{$IFDEF UNIX}
function FcConfigGetCurrent: Pointer; cdecl; external 'fontconfig';
function FcConfigAppFontAddFile(config: Pointer; const fontfile: PChar): LongBool; cdecl; external 'fontconfig';
function FcConfigBuildFonts(config: Pointer): LongBool; cdecl; external 'fontconfig';
{$ENDIF}

procedure TfmIndex.usaFontes(usar: boolean);
var
  dir, fontPath: string;
  {$IFDEF UNIX}cfg: Pointer;{$ENDIF}
begin
  dir := dir_config + 'fontes/';
  fontPath := dir + 'din-condensed-bold.ttf';
  {$IFDEF UNIX}
  {LAZARUS: AddFontResource→fontconfig para adicionar fonte TTF ao processo atual}
  if usar and FileExists(fontPath) then
  begin
    cfg := FcConfigGetCurrent;
    if cfg <> nil then
    begin
      FcConfigAppFontAddFile(cfg, PChar(fontPath));
      FcConfigBuildFonts(cfg);
      {Fallback em fmEditorSlides.pas: Screen.Fonts.IndexOf('DIN Condensed') >= 0}
    end;
  end;
  {usar=false → app encerrando, fontconfig libera ao sair — nenhuma ação necessária}
  {$ELSE}
  {Windows: manter comportamento original AddFontResource/RemoveFontResource}
  //if usar then AddFontResource(PChar(fontPath))
  //else RemoveFontResource(PChar(fontPath));
  {$ENDIF}
end;


procedure TfmIndex.abreHelp;
begin
  if (fHelp <> nil) and (fHelp.Visible) then
  begin
    fHelp.Close;
    Refresh;
  end;
  fIniciando.AppCreateForm(TfHelp, fHelp);
  fHelp.tabPage := '';
  fHelp.ShowModal;
end;

procedure TfmIndex.abreArquivosExcesso;
begin
  fIniciando.AppCreateForm(TfArquivosExcesso, fArquivosExcesso);
  fArquivosExcesso.ShowModal;
end;

procedure TfmIndex.abreArquivosFalta;
begin
  fIniciando.AppCreateForm(TfArquivosFalta, fArquivosFalta);
  fArquivosFalta.ShowModal;
end;

procedure TfmIndex.abreFavoritosManager;
begin
  fIniciando.AppCreateForm(TfFavoritos, fFavoritos);
  fFavoritos.ShowModal;
end;

procedure TfmIndex.abreMonitorHeadless(botao: string);
var
  mon: TMonitor;
begin
  mon := Screen.Monitors[0];
  if botao = 'sorteio' then
  begin
    if fMonitorSorteio <> nil then fMonitorSorteio.Close;
    fIniciando.AppCreateForm(TfMonitorSorteio, fMonitorSorteio);
    fMonitorSorteio.AlphaBlend := False;
    fMonitorSorteio.BorderStyle := bsSizeable;
    fMonitorSorteio.Left := mon.Left; fMonitorSorteio.Top := mon.Top;
    fMonitorSorteio.Width := mon.Width; fMonitorSorteio.Height := mon.Height;
    fMonitorSorteio.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'sorteio_nomes' then
  begin
    if fMonitorSorteioNomes <> nil then fMonitorSorteioNomes.Close;
    fIniciando.AppCreateForm(TfMonitorSorteioNomes, fMonitorSorteioNomes);
    fMonitorSorteioNomes.AlphaBlend := False;
    fMonitorSorteioNomes.BorderStyle := bsSizeable;
    fMonitorSorteioNomes.Left := mon.Left; fMonitorSorteioNomes.Top := mon.Top;
    fMonitorSorteioNomes.Width := mon.Width; fMonitorSorteioNomes.Height := mon.Height;
    fMonitorSorteioNomes.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'cronometro' then
  begin
    if fMonitorCronometro <> nil then fMonitorCronometro.Close;
    fIniciando.AppCreateForm(TfMonitorCronometro, fMonitorCronometro);
    fMonitorCronometro.AlphaBlend := False;
    fMonitorCronometro.BorderStyle := bsSizeable;
    fMonitorCronometro.Left := mon.Left; fMonitorCronometro.Top := mon.Top;
    fMonitorCronometro.Width := mon.Width; fMonitorCronometro.Height := mon.Height;
    fMonitorCronometro.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'relogio' then
  begin
    if fMonitorRelogio <> nil then fMonitorRelogio.Close;
    fIniciando.AppCreateForm(TfMonitorRelogio, fMonitorRelogio);
    fMonitorRelogio.AlphaBlend := False;
    fMonitorRelogio.BorderStyle := bsSizeable;
    fMonitorRelogio.Left := mon.Left; fMonitorRelogio.Top := mon.Top;
    fMonitorRelogio.Width := mon.Width; fMonitorRelogio.Height := mon.Height;
    fMonitorRelogio.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'painel' then
  begin
    if fMonitorPainelDinamico <> nil then fMonitorPainelDinamico.Close;
    fIniciando.AppCreateForm(TfMonitorPainelDinamico, fMonitorPainelDinamico);
    fMonitorPainelDinamico.AlphaBlend := False;
    fMonitorPainelDinamico.BorderStyle := bsSizeable;
    fMonitorPainelDinamico.Left := mon.Left; fMonitorPainelDinamico.Top := mon.Top;
    fMonitorPainelDinamico.Width := mon.Width; fMonitorPainelDinamico.Height := mon.Height;
    fMonitorPainelDinamico.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'texto' then
  begin
    if fMonitorTextoInterativo <> nil then fMonitorTextoInterativo.Close;
    fIniciando.AppCreateForm(TfMonitorTextoInterativo, fMonitorTextoInterativo);
    fMonitorTextoInterativo.AlphaBlend := False;
    fMonitorTextoInterativo.BorderStyle := bsSizeable;
    fMonitorTextoInterativo.Left := mon.Left; fMonitorTextoInterativo.Top := mon.Top;
    fMonitorTextoInterativo.Width := mon.Width; fMonitorTextoInterativo.Height := mon.Height;
    fMonitorTextoInterativo.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'biblia' then
  begin
    if fMonitorBiblia <> nil then fMonitorBiblia.Close;
    fIniciando.AppCreateForm(TfMonitorBiblia, fMonitorBiblia);
    fMonitorBiblia.AlphaBlend := False;
    fMonitorBiblia.BorderStyle := bsSizeable;
    fMonitorBiblia.Left := mon.Left; fMonitorBiblia.Top := mon.Top;
    fMonitorBiblia.Width := mon.Width; fMonitorBiblia.Height := mon.Height;
    fMonitorBiblia.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'biblia_busca' then
  begin
    if fMonitorBibliaBusca <> nil then fMonitorBibliaBusca.Close;
    fIniciando.AppCreateForm(TfMonitorBibliaBusca, fMonitorBibliaBusca);
    fMonitorBibliaBusca.AlphaBlend := False;
    fMonitorBibliaBusca.BorderStyle := bsSizeable;
    fMonitorBibliaBusca.Left := mon.Left; fMonitorBibliaBusca.Top := mon.Top;
    fMonitorBibliaBusca.Width := mon.Width; fMonitorBibliaBusca.Height := mon.Height;
    fMonitorBibliaBusca.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'crono_culto' then
  begin
    if fMonitorCronometroCulto <> nil then fMonitorCronometroCulto.Close;
    fIniciando.AppCreateForm(TfMonitorCronometroCulto, fMonitorCronometroCulto);
    fMonitorCronometroCulto.AlphaBlend := False;
    fMonitorCronometroCulto.BorderStyle := bsSizeable;
    fMonitorCronometroCulto.Left := mon.Left; fMonitorCronometroCulto.Top := mon.Top;
    fMonitorCronometroCulto.Width := mon.Width; fMonitorCronometroCulto.Height := mon.Height;
    fMonitorCronometroCulto.Show;
    copiaDadosTelaExtendida;
  end
  else if botao = 'menu_musicas' then
  begin
    if fMonitorMenuMusicas <> nil then fMonitorMenuMusicas.Close;
    fIniciando.AppCreateForm(TfMonitorMenuMusicas, fMonitorMenuMusicas);
    fMonitorMenuMusicas.AlphaBlend := False;
    fMonitorMenuMusicas.BorderStyle := bsSizeable;
    fMonitorMenuMusicas.Left := mon.Left; fMonitorMenuMusicas.Top := mon.Top;
    fMonitorMenuMusicas.Width := mon.Width; fMonitorMenuMusicas.Height := mon.Height;
    fMonitorMenuMusicas.Show;
    copiaDadosTelaExtendida;
  end;
end;

initialization
  {$I fmMenu.lrs}
  {$I icone056.lrs} {LAZARUS: ícone 40x40 "Copiar Selecionados" (upstream 1570e57)}

end.
