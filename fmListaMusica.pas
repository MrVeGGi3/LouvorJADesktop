unit fmListaMusica;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, LResources;

type
  TfListaMusica = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    Panel1: TPanel;
    imgCapa: TImage;
    GridPanel1: TPanel {LAZARUS: TGridPanel};
    lblTitulo: TLabel {LAZARUS: TbsSkinStdLabel};
    lblSubtitulo: TLabel {LAZARUS: TbsSkinStdLabel};
    DBCtrlGrid: TScrollBox {LAZARUS: TDBCtrlGrid};
    Panel2: TPanel;
    GridPanel2: TPanel {LAZARUS: TGridPanel};
    bsSkinDBText1: TDBText {LAZARUS: TbsSkinDBText};
    ico: TImage {LAZARUS: TbsPngImageView};
    bsSkinDBText2: TDBText {LAZARUS: TbsSkinDBText};
    Panel3: TPanel;
    pnlBotoes: TPanel;
    bsSkinSpeedButton6: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    btExp_MenuMusicas: TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton};
    bsPngImageView1: TImage {LAZARUS: TbsPngImageView};
    btSlidePB: TImage {LAZARUS: TbsPngImageView};
    btMusica: TImage {LAZARUS: TbsPngImageView};
    btMusicaPB: TImage {LAZARUS: TbsPngImageView};
    btLetra: TImage {LAZARUS: TbsPngImageView};
    btSlideLetra: TImage {LAZARUS: TbsPngImageView};
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DBCtrlGridClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton6Click(Sender: TObject);
    procedure btExp_MenuMusicasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBCtrlGridPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TDBCtrlGrid}; Index: Integer);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure btExp_MenuMusicasShowTrackMenu(Sender: TObject);
    procedure lstMusicasClick(Sender: TObject);
  private
    lstMusicas: TListBox;
    FArqPaths: TStringList; {LAZARUS: caminhos paralelos aos itens no modo arquivo}
    procedure garanteListaMusicas;
  public
    id_album: integer;
    dir: string;
    inicio: Boolean;
    DataSource: TDataSource; {LAZARUS: campo manual — TScrollBox nao tem DataSource como TDBCtrlGrid}
    destructor Destroy; override;
  end;

var
  fListaMusica: TfListaMusica;

implementation


uses fmMenu, dmComponentes, fmMonitorMenuMusicas;

destructor TfListaMusica.Destroy;
begin
  FArqPaths.Free;
  inherited Destroy;
end;

{LAZARUS: o TDBCtrlGrid original iterava os registros; o TScrollBox substituto
 mostrava só o registro corrente. Lista todas as entradas num TListBox criado
 em runtime — usado pelos modos BD (dsMUSICAS) e arquivo (dsArquivos).}
procedure TfListaMusica.garanteListaMusicas;
begin
  if lstMusicas <> nil then Exit;
  Panel2.Parent := Self;
  Panel2.Align := alBottom;
  DBCtrlGrid.Visible := False;
  lstMusicas := TListBox.Create(Self);
  lstMusicas.Parent := Self;
  lstMusicas.Align := alClient;
  lstMusicas.Color := $232323;
  lstMusicas.Font.Color := clWhite;
  lstMusicas.Font.Height := 20;
  lstMusicas.Font.Name := 'Arial';
  lstMusicas.ItemHeight := 40;
  lstMusicas.OnClick := lstMusicasClick;
end;

procedure TfListaMusica.bsSkinSpeedButton6Click(Sender: TObject);
begin
  fmIndex.abreLetraMusicaAlbum(DM.qrMUSICAS.FieldByName('ID_ALBUM').AsInteger);
end;

procedure TfListaMusica.btExp_MenuMusicasClick(Sender: TObject);
begin
  fmIndex.expandirArea(Sender);
end;

procedure TfListaMusica.btExp_MenuMusicasShowTrackMenu(Sender: TObject);
var
  tag: integer;
begin
  fmIndex.botao_trmenu := TSpeedButton {LAZARUS: TbsSkinMenuSpeedButton}(Sender);
  tag := fmIndex.botao_trmenu.tag;
  fmIndex.monitores(tag);
end;

procedure TfListaMusica.DBCtrlGridClick(Sender: TObject);
begin
  if DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS
    then fmIndex.dbctrlMusicasClick(Sender)
    else fmIndex.abrirArquivo(DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)}.DataSet.FieldByName('DIR').AsString);
end;

procedure TfListaMusica.DBCtrlGridPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TDBCtrlGrid};
  Index: Integer);
begin
  if DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} <> DM.dsMUSICAS then Exit;

  if (DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)}.DataSet.FieldByName('URL_INSTRUMENTAL').AsString <> '') then
  begin
    btSlidePB.Visible := true;
    btMusicaPB.Visible := true;
    {LAZARUS: GridPanel2.ColumnCollection → TPanel sem ColumnCollection — stub}
  end
  else
  begin
    btSlidePB.Visible := false;
    btMusicaPB.Visible := false;
    {LAZARUS: GridPanel2.ColumnCollection → TPanel sem ColumnCollection — stub}
  end;
end;

procedure TfListaMusica.FormActivate(Sender: TObject);
var
  sr : TSearchRec;
  iRetorno : Integer;
  i: integer;
begin
  if (inicio <> true) then
  begin
    inicio := True;

    fmIndex.monitor_bt_label(btExp_MenuMusicas);

    bsPngImageView1.Visible := (DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS);
    btSlidePB.Visible := (DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS);
    btSlideLetra.Visible := (DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS);
    btMusica.Visible := (DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS);
    btMusicaPB.Visible := (DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS);
    btLetra.Visible := (DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS);

    if DataSource {LAZARUS: DBCtrlGrid.DataSource → campo DataSource (TScrollBox sem DataSource)} = DM.dsMUSICAS then
    begin
      DM.qrMUSICAS.Close;
      DM.qrMUSICAS.ParamByName('ID_ALBUM').Value := id_album;
      DM.qrMUSICAS.Open;

      // Build scrollable list of all songs (TDBCtrlGrid iterava registros; TScrollBox não)
      garanteListaMusicas;
      lstMusicas.Items.Clear;
      DM.qrMUSICAS.First;
      while not DM.qrMUSICAS.EOF do
      begin
        lstMusicas.Items.AddObject(
          DM.qrMUSICAS.FieldByName('FAIXA').AsString + '  ' + DM.qrMUSICAS.FieldByName('NOME').AsString,
          TObject(PtrInt(DM.qrMUSICAS.FieldByName('ID').AsInteger))
        );
        DM.qrMUSICAS.Next;
      end;
      DM.qrMUSICAS.First;

      if (fMonitorMenuMusicas <> nil) then
      begin
        fmIndex.copiaDadosTelaExtendida();
      end;
    end
    else
    begin
      DBCtrlGrid.Visible := False;
      if not DM.cdsArquivos.Active then
      begin
        DM.cdsArquivos.CreateDataSet;
      end;
      DM.cdsArquivos.Open;
      {LAZARUS: EmptyDataSet → TBufDataset sem EmptyDataSet — loop de deleção}
      DM.cdsArquivos.First;
      while not DM.cdsArquivos.EOF do DM.cdsArquivos.Delete;

      dir := StringReplace(dir,'\',PathDelim,[rfIgnoreCase, rfReplaceAll]); {LAZARUS: normaliza separador Windows→OS}
      dir := IncludeTrailingPathDelimiter(dir);

      if not(DirectoryExists(dir)) then
        Exit;

      iRetorno := FindFirst(dir + '*.*', faAnyFile, sr);
      i := 0;
      while iRetorno = 0 do
      begin
        if (sr.Name <> '.') and (sr.Name <> '..') then
          if sr.Attr <> faDirectory then
          begin
            i := i+1;
            DM.cdsArquivos.Append;
            DM.cdsArquivos.FieldByName('FAIXA').Value := i;
            DM.cdsArquivos.FieldByName('NOME').Value := ChangeFileExt(sr.Name,'');
            DM.cdsArquivos.FieldByName('DIR').Value := dir+sr.Name;
            DM.cdsArquivos.Post;
          end;
          iRetorno := FindNext(sr);
      end;
      FindClose(sr);
      DM.cdsArquivos.First;

      {LAZARUS: lista TODOS os arquivos no TListBox (o TScrollBox mostrava só o
       registro corrente — limitação conhecida do substituto do TDBCtrlGrid)}
      garanteListaMusicas;
      lstMusicas.Items.Clear;
      if FArqPaths = nil then FArqPaths := TStringList.Create;
      FArqPaths.Clear;
      DM.cdsArquivos.First;
      while not DM.cdsArquivos.EOF do
      begin
        lstMusicas.Items.Add(
          DM.cdsArquivos.FieldByName('FAIXA').AsString + '  ' +
          DM.cdsArquivos.FieldByName('NOME').AsString);
        FArqPaths.Add(DM.cdsArquivos.FieldByName('DIR').AsString);
        DM.cdsArquivos.Next;
      end;
      DM.cdsArquivos.First;
    end;

    FormResize(Sender);
  end;
end;

procedure TfListaMusica.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if (btExp_MenuMusicas.ImageIndex = 54)
  //  then btExp_MenuMusicasClick(btExp_MenuMusicas);
end;

procedure TfListaMusica.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfListaMusica.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Down', Sender, Shift, MousePos, Handled);
end;

procedure TfListaMusica.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Up', Sender, Shift, MousePos, Handled);
end;

procedure TfListaMusica.lstMusicasClick(Sender: TObject);
var
  id: Integer;
  caminho: string;
begin
  if lstMusicas.ItemIndex < 0 then Exit;
  if DataSource = DM.dsMUSICAS then
  begin
    id := PtrInt(lstMusicas.Items.Objects[lstMusicas.ItemIndex]);
    if not DM.qrMUSICAS.Locate('ID', id, []) then Exit;
    fmIndex.dbctrlMusicasClick(lstMusicas);
  end
  else
  begin
    {LAZARUS: modo arquivo (dsArquivos) — abre o arquivo clicado}
    if (FArqPaths = nil) or (lstMusicas.ItemIndex >= FArqPaths.Count) then Exit;
    caminho := FArqPaths[lstMusicas.ItemIndex];
    DM.cdsArquivos.Locate('DIR', caminho, []);
    fmIndex.abrirArquivo(caminho);
  end;
end;

procedure TfListaMusica.FormResize(Sender: TObject);
begin
  {LAZARUS: DBCtrlGrid.RowCount → TScrollBox sem RowCount — stub}
end;


initialization
  {$I fmListaMusica.lrs}

end.
