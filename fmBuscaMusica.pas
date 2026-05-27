unit fmBuscaMusica;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, ZDataset, LResources;

type
  TfBuscaMusica = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    GridPanel3: TPanel {LAZARUS: TGridPanel};
    txtBusca: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinStdLabel5: TLabel {LAZARUS: TbsSkinStdLabel};
    DBGrid1: TDBGrid {LAZARUS: TbsSkinDBGrid};
    qrBUSCA: TZQuery {LAZARUS: TFDQuery};
    dsBUSCA: TDataSource;
    stBusca: TStatusBar {LAZARUS: TbsSkinStatusBar};
    bsSkinScrollBar7: TScrollBar {LAZARUS: TbsSkinScrollBar};
    stBusca_0: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    stBusca_1: TStatusPanel {LAZARUS: TbsSkinStatusPanel};
    procedure txtBuscaChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure txtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    id: integer;
  end;

var
  fBuscaMusica: TfBuscaMusica;

implementation


uses fmMenu, dmComponentes;

procedure TfBuscaMusica.DBGrid1DblClick(Sender: TObject);
begin
  id := qrBUSCA.FieldByName('ID').AsInteger;
  close;
end;

procedure TfBuscaMusica.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn};
  State: TGridDrawState);
{LAZARUS: TPngImage/PngImages removidos — TImageList.Draw substitui TbsPngImageList.PngImages[n].PngImage}
var
  fixRect: TRect;
begin
  Canvas.Brush.Style := bsClear;
  if (qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and (Column.FieldName = 'ICONE1') then
  begin
    fixRect := Rect;
    fixRect.Top := Rect.Top + 1;
    fixRect.Bottom := Rect.Top + 17;
    fixRect.Left := Rect.Left + 1;
    fixRect.Right := Rect.Left + 17;
    DM.ico_16x16.Draw(TDBGrid(Sender).Canvas, fixRect.Left, fixRect.Top, 82);
  end;
  if (qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S') and (Column.FieldName = 'ICONE1') then
  begin
    fixRect := Rect;
    fixRect.Top := Rect.Top + 1;
    fixRect.Bottom := Rect.Top + 17;
    fixRect.Left := Rect.Left + 1;
    fixRect.Right := Rect.Left + 17;
    DM.ico_16x16.Draw(TDBGrid(Sender).Canvas, fixRect.Left, fixRect.Top, 37);
  end;
  if (qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '') and (Column.FieldName = 'ICONE2') then
  begin
    fixRect := Rect;
    fixRect.Top := Rect.Top + 1;
    fixRect.Bottom := Rect.Top + 17;
    fixRect.Left := Rect.Left + 1;
    fixRect.Right := Rect.Left + 17;
    DM.ico_16x16.Draw(TDBGrid(Sender).Canvas, fixRect.Left, fixRect.Top, 103);
  end;
end;

procedure TfBuscaMusica.FormActivate(Sender: TObject);
begin
  {LAZARUS: conectar TStatusPanel ao Panels collection criado pelo LFM}
  if (stBusca_0 = nil) and (stBusca.Panels.Count >= 2) then begin
    stBusca_0 := stBusca.Panels[0];
    stBusca_1 := stBusca.Panels[1];
  end;
  id := -1;
  txtBusca.Text := '';
  txtBuscaChange(Sender);
end;

procedure TfBuscaMusica.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfBuscaMusica.FormResize(Sender: TObject);
begin
  dbGrid1.Columns[2].Width := dbGrid1.Width - dbGrid1.Columns[0].Width - dbGrid1.Columns[1].Width;
end;

procedure TfBuscaMusica.txtBuscaChange(Sender: TObject);
var
  valor: string;
  nr: integer;
  c: integer;
begin
  dbGrid1.Columns[2].Width := dbGrid1.Width - dbGrid1.Columns[0].Width - dbGrid1.Columns[1].Width;
  valor := trim(txtBusca.Text);
  stBusca_0.Text {LAZARUS: TStatusPanel.caption→Text} := '';
  if trim(valor) <> '' then
  begin
    val(txtBusca.Text, nr, c);
    if c = 0 then
    begin
      stBusca_0.Text {LAZARUS: TStatusPanel.caption→Text} := 'Buscando hino nº: ' + valor;
    end
    else
    begin
      stBusca_0.Text {LAZARUS: TStatusPanel.caption→Text} := 'Buscando música nome: ''' + valor + '''';
    end;
  end;

  qrBUSCA.Close;
  qrBUSCA.ParamByName('VALOR').AsString := fmIndex.termo_busca(valor);
  qrBUSCA.Open;

  stBusca_1.Text {LAZARUS: TStatusPanel.caption→Text} := fmIndex.qtItens(qrBUSCA,'música encontrada','músicas encontrados','Nenhuma música encontrado');
  fmIndex.corCampoBusca(qrBUSCA, txtBusca,DBGrid1);
  dbGrid1.Columns[2].Width := dbGrid1.Width - dbGrid1.Columns[0].Width - dbGrid1.Columns[1].Width;
end;

procedure TfBuscaMusica.txtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid1DblClick(Sender);
  end;
end;

procedure TfBuscaMusica.txtBuscaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.edtKeyUp(Sender,Key,Shift);
end;


initialization
  {$I fmBuscaMusica.lrs}

end.
