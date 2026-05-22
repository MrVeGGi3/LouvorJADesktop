program LouvorJA;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}cthreads,{$ENDIF}
  Forms,
  Interfaces,
  Classes,
  LResources,
  StdCtrls,
  Buttons,
  ExtCtrls,
  Spin,
  dmComponentes in 'dmComponentes.pas' {DM: TDataModule},
  fmIniciando in 'fmIniciando.pas' {fIniciando},
  fmMenu in 'fmMenu.pas' {fmIndex},
  fmLetra in 'fmLetra.pas' {fLetra},
  fmNovaVersao in 'fmNovaVersao.pas' {fNovaVersao},
  fmAtualiza in 'fmAtualiza.pas' {fAtualiza},
  fmHelp in 'fmHelp.pas' {fHelp},
  fmVideoOn in 'fmVideoOn.pas' {fVideoOn},
  fmFavoritos in 'fmFavoritos.pas' {fFavoritos},
  fmMusica in 'fmMusica.pas' {fMusica},
  fmListaMusica in 'fmListaMusica.pas' {fListaMusica},
  fmMusicaOperador in 'fmMusicaOperador.pas' {fMusicaOperador},
  fmLiturgia in 'fmLiturgia.pas' {fLiturgia},
  fmArquivosFalta in 'fmArquivosFalta.pas' {fArquivosFalta},
  fmBuscaMusica in 'fmBuscaMusica.pas' {fBuscaMusica},
  fmArquivosExcesso in 'fmArquivosExcesso.pas' {fArquivosExcesso},
  fmItensAgendados in 'fmItensAgendados.pas' {fItensAgendados},
  fmFormatacao in 'fmFormatacao.pas' {fFormatacao},
  fmEditorSlides in 'fmEditorSlides.pas' {fEditorSlides},
  fmPlayer in 'fmPlayer.pas' {fPlayer},
  fmTransmitir in 'fmTransmitir.pas' {fTransmitir},
  fmMusicaRetorno in 'fmMusicaRetorno.pas' {fMusicaRetorno},
  fmMonitorRelogio in 'fmMonitorRelogio.pas' {fMonitorRelogio},
  fmMonitorTextoInterativo in 'fmMonitorTextoInterativo.pas' {fMonitorTextoInterativo},
  fmMonitorPainelDinamico in 'fmMonitorPainelDinamico.pas' {fMonitorPainelDinamico},
  fmMonitorCronometro in 'fmMonitorCronometro.pas' {fMonitorCronometro},
  fmMonitorSorteioNomes in 'fmMonitorSorteioNomes.pas' {fMonitorSorteioNomes},
  fmMonitorSorteio in 'fmMonitorSorteio.pas' {fMonitorSorteio},
  fmMonitorCronometroCulto in 'fmMonitorCronometroCulto.pas' {fMonitorCronometroCulto},
  fmMonitorBibliaBusca in 'fmMonitorBibliaBusca.pas' {fMonitorBibliaBusca},
  fmMonitorBiblia in 'fmMonitorBiblia.pas' {fMonitorBiblia},
  fmMonitorMenuMusicas in 'fmMonitorMenuMusicas.pas' {fMonitorMenuMusicas},
  fmIdentificaMonitores in 'fmIdentificaMonitores.pas' {fIdentificaMonitores},
  bass in 'components/bass24/delphi/bass.pas';

{$R LouvorJA.res}

procedure RegisterLegacySkipProperties;
{ Registra propriedades do BusinessSkinForm (TbsSkin*) e VCL-only que não
  existem no LCL, evitando o dialog "Unknown property" ao carregar os .lfm. }
const
  BSF = 'BusinessSkinForm';
  VCL = 'VCL-only';
begin
  // TbsRibbonPage -> TTabSheet
  RegisterPropertyToSkip(TComponent, 'HotScroll',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'CanScroll',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'ScrollOffset',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'ScrollTimerInterval',    BSF, '');
  // TbsRibbonGroup -> TPanel
  RegisterPropertyToSkip(TComponent, 'ShowDialogButton',       BSF, '');
  // Propriedades gerais TbsSkin*
  RegisterPropertyToSkip(TComponent, 'DefaultWidth',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultHeight',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'CheckedMode',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'WidthWithCaption',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'WidthWithCaptions',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'WidthWithoutCaption',    BSF, '');
  RegisterPropertyToSkip(TComponent, 'WidthWithoutCaptions',   BSF, '');
  RegisterPropertyToSkip(TComponent, 'DrawSkin',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'DrawSkinLines',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'DrawGraphicFields',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'SkinSupport',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'SkinPopupMenu',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'GlowEffect',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'GlowSize',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'CtrlAlphaBlend',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'CtrlAlphaBlendAnimation',BSF, '');
  RegisterPropertyToSkip(TComponent, 'CtrlAlphaBlendValue',    BSF, '');
  RegisterPropertyToSkip(TComponent, 'MenuAlphaBlend',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'MenuAlphaBlendAnimation',BSF, '');
  RegisterPropertyToSkip(TComponent, 'MenuAlphaBlendValue',    BSF, '');
  RegisterPropertyToSkip(TComponent, 'MenuUseSkinFont',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'NumGlyphs',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'Spacing',                BSF, '');
  RegisterPropertyToSkip(TComponent, 'ImageList',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'ImageIndex',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'FreeOnClose',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'NewStyle',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'Moveable',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'RollKind',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'RollState',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'SizeGrip',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'Sizeable',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowRollButton',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowCloseButton',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowCloseButtons',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowFocus',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowPercent',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowProgressText',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowItemTitles',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowThumbnails',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowHiddenFiles',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowMoreColor',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowAutoColor',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'ShowBoder',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'TabsBGTransparent',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'TabsInCenter',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'TabsOffset',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'TabSpacing',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'TabHeight',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'TabExtededDraw',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'ToolButtonsTransparent', BSF, '');
  RegisterPropertyToSkip(TComponent, 'ToolButtonStyle',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'TrackButtonMode',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'TrackPosition',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'TextInHorizontal',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'TextHeight',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'WallpaperStretch',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'VisibleButtons',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'VScrollBar',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'HScrollBar',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'UseSkinColor',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'UseSkinItemHeight',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'UseSkinCellHeight',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'UseUnderLine',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'UseColumnsFont',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'UseImagesMenuCaption',   BSF, '');
  RegisterPropertyToSkip(TComponent, 'UseImagesMenuImage',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ValueType',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'DividerMode',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'DividerType',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'ItemLayout',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'ItemMargin',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'ItemSpacing',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'ItemWidth',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'ItemSkinDataName',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'ItemsEx',                BSF, '');
  RegisterPropertyToSkip(TComponent, 'HeaderHeight',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'HeaderLeftAlignment',    BSF, '');
  RegisterPropertyToSkip(TComponent, 'HeaderSkinDataName',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'LVHeaderSkinDataName',   BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxWidth',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxCaptionMode',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxCaptionAlignment',BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxDefaultItemHeight',BSF,'');
  RegisterPropertyToSkip(TComponent, 'ListBoxDragCursor',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxDragKind',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxDragMode',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxTabOrder',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxTabStop',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxUseSkinFont',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxUseSkinItemHeight',BSF,'');
  RegisterPropertyToSkip(TComponent, 'PickListBoxCaptionMode', BSF, '');
  RegisterPropertyToSkip(TComponent, 'PickListBoxSkinDataName',BSF, '');
  RegisterPropertyToSkip(TComponent, 'PopupMaxRowCount',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'ProgressAnimationPause', BSF, '');
  RegisterPropertyToSkip(TComponent, 'SaveMultiSelection',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ScrollType',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'SelectedColor',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'SelectedImageIndex',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'MouseMoveChangeIndex',   BSF, '');
  RegisterPropertyToSkip(TComponent, 'MouseWheelSupport',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'MultiSelection',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'AutoColor',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'AutoShowHideCaptions',   BSF, '');
  RegisterPropertyToSkip(TComponent, 'AdjustControls',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'AlternateRow',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'BitMapBG',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'BothMarkerWidth',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonHeight',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonImageIndex',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonMode',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonOptions',          BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonWidth',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'ColorValue',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'ColSizingWithLine',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultActiveFontColor', BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultCellHeight',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultColor',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultItemHeight',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultRowHeight',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultSize',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'DialogHeight',           BSF, '');
  RegisterPropertyToSkip(TComponent, 'DialogMinHeight',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'DialogMinWidth',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'DialogWidth',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'DlgCtrlSkinData',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'DlgSkinData',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'ExtandedSelect',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'FontName',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'HostName',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'LeftImageDownIndex',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'LeftImageHotIndex',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'LeftImageIndex',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'LinkType',               BSF, '');
  RegisterPropertyToSkip(TComponent, 'PanelBorder',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'PanelHeight',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'PanelWidth',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'RealWidth',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'RightImageDownIndex',    BSF, '');
  RegisterPropertyToSkip(TComponent, 'RightImageHotIndex',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'RightImageIndex',        BSF, '');
  RegisterPropertyToSkip(TComponent, 'SupportUpDownKeys',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'TitleAlignment',         BSF, '');
  RegisterPropertyToSkip(TComponent, 'OverwritePromt',         BSF, '');
  // TSpinEdit/TFloatSpinEdit: Text e Decimal não existem no LCL (usa Value)
  RegisterPropertyToSkip(TSpinEdit,      'Text',          BSF, '');
  RegisterPropertyToSkip(TSpinEdit,      'Decimal',       BSF, '');
  RegisterPropertyToSkip(TSpinEdit,      'EditorEnabled', BSF, '');
  RegisterPropertyToSkip(TFloatSpinEdit, 'Text',          BSF, '');
  RegisterPropertyToSkip(TFloatSpinEdit, 'EditorEnabled', BSF, '');
  // Propriedades BSF que aparecem em muitos tipos de componentes — registradas em
  // TComponent para cobertura geral. DoPropertyNotFound só dispara quando a propriedade
  // NÃO está publicada no RTTI do componente, portanto componentes LCL que possuem
  // a propriedade real (ex: TForm.BorderStyle, TWinControl.TabOrder, TCheckBox.Checked)
  // não são afetados.
  RegisterPropertyToSkip(TComponent,   'EditorEnabled',  BSF, '');
  RegisterPropertyToSkip(TComponent,   'Checked',        BSF, '');
  RegisterPropertyToSkip(TComponent,   'Down',           BSF, '');
  RegisterPropertyToSkip(TComponent,   'Flat',           BSF, '');
  RegisterPropertyToSkip(TComponent,   'GroupIndex',     BSF, '');
  RegisterPropertyToSkip(TComponent,   'Layout',         BSF, '');
  RegisterPropertyToSkip(TComponent,   'TabOrder',       BSF, ''); // TWinControl tem real TabOrder → não afetado
  RegisterPropertyToSkip(TComponent,   'TabStop',        BSF, ''); // TWinControl tem real TabStop → não afetado
  RegisterPropertyToSkip(TComponent,   'Transparent',    BSF, '');
  RegisterPropertyToSkip(TComponent,   'AlphaBlend',     BSF, ''); // TForm tem real AlphaBlend → não afetado
  RegisterPropertyToSkip(TComponent,   'AlphaBlendValue',BSF, '');
  RegisterPropertyToSkip(TComponent,   'BorderStyle',    BSF, ''); // TForm/TMemo/TEdit têm real BorderStyle → não afetados
  RegisterPropertyToSkip(TComponent,   'OnClose',             BSF, ''); // TForm tem real OnClose → não afetado
  RegisterPropertyToSkip(TComponent,   'OnDialogButtonClick', BSF, '');
  // Eventos BSF-específicos que não existem no LCL
  RegisterPropertyToSkip(TComponent,   'OnShowTrackMenu',     BSF, '');
  RegisterPropertyToSkip(TComponent,   'OnPaintPanel',        BSF, '');
  RegisterPropertyToSkip(TComponent,   'OnButtonClick',       BSF, '');
  RegisterPropertyToSkip(TComponent,   'OnButtonClicked',     BSF, '');
  RegisterPropertyToSkip(TComponent,   'OnCommandGet',        BSF, '');
  RegisterPropertyToSkip(TComponent,   'OnItemCheckClick',    BSF, '');
  RegisterPropertyToSkip(TComponent,   'OnChangeColor',       BSF, '');
  RegisterPropertyToSkip(TComponent,   'Radio',          BSF, '');
  RegisterPropertyToSkip(TComponent,   'Execute',        BSF, '');
  // VCL-only (Windows)
  RegisterPropertyToSkip(TComponent, 'Ctl3D',                  VCL, '');
  RegisterPropertyToSkip(TComponent, 'ParentCtl3D',            VCL, '');
  RegisterPropertyToSkip(TComponent, 'DoubleBuffered',         VCL, '');
  RegisterPropertyToSkip(TComponent, 'ParentDoubleBuffered',   VCL, '');
  RegisterPropertyToSkip(TComponent, 'ParentBackground',       VCL, '');
  // Skins/nomes de skin referenciados (não existem no LCL)
  RegisterPropertyToSkip(TComponent, 'BothSkinDataName',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonSkinDataName',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonsSkinDataName',    BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonTabSkinDataName',  BSF, '');
  RegisterPropertyToSkip(TComponent, 'CheckSkinDataName',      BSF, '');
  // Sub-objetos de fonte BSF-específicos (Font sub-objects não existem no LCL)
  RegisterPropertyToSkip(TComponent, 'ButtonDefaultFont',      BSF, '');
  RegisterPropertyToSkip(TComponent, 'DefaultCaptionFont',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxDefaultCaptionFont', BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxDefaultFont',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ListBoxFont',            BSF, '');
  RegisterPropertyToSkip(TComponent, 'MenuDefaultFont',        BSF, '');
  // VCL-only: comportamento de seleção e controles Windows
  RegisterPropertyToSkip(TComponent, 'HideSelection',          VCL, '');
  RegisterPropertyToSkip(TComponent, 'OldCreateOrder',         VCL, '');
  RegisterPropertyToSkip(TComponent, 'ShowCheckBoxes',         VCL, '');
  RegisterPropertyToSkip(TComponent, 'HorizontalExtent',       VCL, '');
  RegisterPropertyToSkip(TComponent, 'AutoComplete',           BSF, ''); // BSF property em TCheckListBox — TComboBox LCL tem AutoComplete real
  RegisterPropertyToSkip(TComponent, 'RowCount',               BSF, ''); // BSF property em TCheckListBox — TStringGrid LCL tem RowCount real
  RegisterPropertyToSkip(TComponent, 'Align',                  BSF, ''); // BSF publica Align em TTabSheet — LCL TTabSheet não publica, demais controles têm Align real
  RegisterPropertyToSkip(TComponent, 'Title',                  BSF, ''); // BSF TButton sub-título — não existe no LCL
  // TDBGrid: propriedades na seção public (não published) — não disponíveis via RTTI/LFM
  RegisterPropertyToSkip(TComponent, 'GridLineColor',           VCL, ''); // TDBGrid.GridLineColor é public, não published
  RegisterPropertyToSkip(TComponent, 'FocusColor',              VCL, '');
  RegisterPropertyToSkip(TComponent, 'EditorBorderStyle',       VCL, '');
  RegisterPropertyToSkip(TComponent, 'ExtendedColSizing',       VCL, '');
  RegisterPropertyToSkip(TComponent, 'FastEditing',             VCL, '');
  RegisterPropertyToSkip(TComponent, 'FocusRectVisible',        VCL, '');
  RegisterPropertyToSkip(TComponent, 'Both',                    BSF, ''); // BSF TScrollBar combinado H+V — não existe no LCL
  RegisterPropertyToSkip(TComponent, 'Caption',                 BSF, ''); // BSF publica Caption em TStatusBar/TScrollBar — LCL não publica; demais controles têm Caption real
  RegisterPropertyToSkip(TComponent, 'Images',                  BSF, ''); // BSF TComboBox/TButton — TPopupMenu/TToolBar LCL têm Images real
  // BSF TDBCtrlGrid properties — convertido para TScrollBox no LCL
  RegisterPropertyToSkip(TComponent, 'DataSource',              BSF, ''); // BSF TDBCtrlGrid — TDBGrid/TDBEdit LCL têm DataSource real
  RegisterPropertyToSkip(TComponent, 'PanelHeight',             BSF, '');
  RegisterPropertyToSkip(TComponent, 'PanelWidth',              BSF, '');
  RegisterPropertyToSkip(TComponent, 'OnPaintPanel',            BSF, '');
  // BSF TProgressBar — LCL usa Min/Max/Position/Orientation em vez de MinValue/MaxValue/Value/Vertical
  RegisterPropertyToSkip(TComponent, 'MinValue',                BSF, ''); // TSpinEdit.MinValue é published — não será afetado
  RegisterPropertyToSkip(TComponent, 'MaxValue',                BSF, ''); // TSpinEdit.MaxValue é published — não será afetado
  RegisterPropertyToSkip(TComponent, 'Value',                   BSF, ''); // TSpinEdit.Value é published — não será afetado
  RegisterPropertyToSkip(TComponent, 'Vertical',                BSF, ''); // BSF TProgressBar — LCL usa Orientation
  RegisterPropertyToSkip(TComponent, 'ShowLines',               BSF, ''); // BSF TCheckListBox — não existe no LCL
  RegisterPropertyToSkip(TComponent, 'Checked',                 BSF, ''); // BSF TToolBar property — TToolButton tem Down, não Checked
  RegisterPropertyToSkip(TComponent, 'Spacing',                 BSF, ''); // BSF TToolBar Spacing — não existe no LCL TToolBar
  RegisterPropertyToSkip(TComponent, 'AllowDelete',             BSF, ''); // TbsDBCtrlGrid — convertido para TScrollBox no LCL
  RegisterPropertyToSkip(TComponent, 'AllowInsert',             BSF, ''); // TbsDBCtrlGrid — convertido para TScrollBox no LCL
  RegisterPropertyToSkip(TComponent, 'ColCount',                BSF, ''); // TbsDBCtrlGrid — TStringGrid LCL tem ColCount real → não afetado
end;

begin
  RegisterLegacySkipProperties;
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfIniciando, fIniciando);
  Application.CreateForm(TfPlayer, fPlayer);
  Application.CreateForm(TfTransmitir, fTransmitir);
  Application.Run;
end.
