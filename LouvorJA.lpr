program LouvorJA;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}cthreads,{$ENDIF}
  Forms,
  Interfaces,
  Classes,
  LResources,
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
  // VCL-only (Windows)
  RegisterPropertyToSkip(TComponent, 'Ctl3D',                  VCL, '');
  RegisterPropertyToSkip(TComponent, 'ParentCtl3D',            VCL, '');
  RegisterPropertyToSkip(TComponent, 'ParentDoubleBuffered',   VCL, '');
  RegisterPropertyToSkip(TComponent, 'ParentBackground',       VCL, '');
  // Skins/nomes de skin referenciados (não existem no LCL)
  RegisterPropertyToSkip(TComponent, 'BothSkinDataName',       BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonSkinDataName',     BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonsSkinDataName',    BSF, '');
  RegisterPropertyToSkip(TComponent, 'ButtonTabSkinDataName',  BSF, '');
  RegisterPropertyToSkip(TComponent, 'CheckSkinDataName',      BSF, '');
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
