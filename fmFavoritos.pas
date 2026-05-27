unit fmFavoritos;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, LResources;

type
  TfFavoritos = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    dbcFavoritos: TScrollBox {LAZARUS: TbsSkinDBCtrlGrid};
    Panel1: TPanel;
    Image1: TImage {LAZARUS: TbsPngImageView};
    imgFavBtDown: TImage {LAZARUS: TbsPngImageView};
    imgFavBtUp: TImage {LAZARUS: TbsPngImageView};
    skLitItem: TDBText {LAZARUS: TbsSkinDBText};
    imFavIcon: TImage {LAZARUS: TbsPngImageView};
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbcFavoritosPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TDBCtrlGrid}; Index: Integer);
    procedure Image1Click(Sender: TObject);
    procedure imgFavBtUpClick(Sender: TObject);
    procedure imgFavBtDownClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fFavoritos: TfFavoritos;

implementation


uses fmMenu, dmComponentes;

procedure TfFavoritos.dbcFavoritosPaintPanel(DBCtrlGrid: TScrollBox {LAZARUS: TDBCtrlGrid};
  Index: Integer);
var
  icon: Integer;
begin
  icon := DM.cdsFavoritos.FieldByName('IMAGEM').AsInteger;

  imFavIcon.ImageIndex := icon;

  imFavIcon.Visible := (DM.cdsFavoritos.RecordCount > 0);
  skLitItem.Visible := (DM.cdsFavoritos.RecordCount > 0);
  imgFavBtUp.Visible := (DM.cdsFavoritos.RecordCount > 0);
  imgFavBtDown.Visible := (DM.cdsFavoritos.RecordCount > 0);
  Image1.Visible := (DM.cdsFavoritos.RecordCount > 0);

  if (DM.cdsFavoritos.RecordCount > 0) then
  begin
    imgFavBtUp.Visible := (DM.cdsFavoritos.RecNo > 1);
    imgFavBtDown.Visible := (DM.cdsFavoritos.RecNo < DM.cdsFavoritos.RecordCount);
  end;
end;

procedure TfFavoritos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfFavoritos.Image1Click(Sender: TObject);
var
  nome: string;
begin
  if DM.cdsFavoritos.RecordCount <= 0 then
    Exit;

  nome := DM.cdsFavoritos.FieldByName('NOME').AsString;

  DM.cdsFavoritos.Delete;

  fmIndex.carregaFavoritos();
  application.messagebox(PChar('Página '''+nome+''' removida com sucesso dos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
end;

procedure TfFavoritos.imgFavBtDownClick(Sender: TObject);
var
  id, nid: string;
  ordem, nordem: integer;
begin
  if DM.cdsFavoritos.RecordCount <= 0 then
    Exit;
  if DM.cdsFavoritos.RecNo >= DM.cdsFavoritos.RecordCount then
    Exit;

  id := DM.cdsFavoritos.FieldByName('ID').AsString;
  ordem := DM.cdsFavoritos.fieldbyname('ORDEM').AsInteger;

  DM.cdsFavoritos.Next;
  nid := DM.cdsFavoritos.fieldbyname('ID').AsString;
  nordem := DM.cdsFavoritos.fieldbyname('ORDEM').AsInteger;

  DM.cdsFavoritos.Edit;
  DM.cdsFavoritos.FieldByName('ORDEM').Value := ordem;
  DM.cdsFavoritos.Post;

  DM.cdsFavoritos.Locate('ID', id, []);
  DM.cdsFavoritos.Edit;
  DM.cdsFavoritos.FieldByName('ORDEM').Value := nordem;
  DM.cdsFavoritos.Post;

  fmIndex.carregaFavoritos();
end;

procedure TfFavoritos.imgFavBtUpClick(Sender: TObject);
var
  id, nid: string;
  ordem, nordem: integer;
begin
  if DM.cdsFavoritos.RecordCount <= 0 then
    Exit;
  if DM.cdsFavoritos.RecNo <= 1 then
    Exit;

  id := DM.cdsFavoritos.FieldByName('ID').AsString;
  ordem := DM.cdsFavoritos.fieldbyname('ORDEM').AsInteger;

  DM.cdsFavoritos.Prior;
  nid := DM.cdsFavoritos.fieldbyname('ID').AsString;
  nordem := DM.cdsFavoritos.fieldbyname('ORDEM').AsInteger;

  DM.cdsFavoritos.Edit;
  DM.cdsFavoritos.FieldByName('ORDEM').Value := ordem;
  DM.cdsFavoritos.Post;

  DM.cdsFavoritos.Locate('ID', id, []);
  DM.cdsFavoritos.Edit;
  DM.cdsFavoritos.FieldByName('ORDEM').Value := nordem;
  DM.cdsFavoritos.Post;

  fmIndex.carregaFavoritos();
end;


initialization
  {$I fmFavoritos.lrs}

end.
