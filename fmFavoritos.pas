unit fmFavoritos;
{$mode delphi}{$H+} {LAZARUS: reescrito com TListBox — TbsSkinDBCtrlGrid não disponível no LCL}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LCLIntf, LCLType, LResources;

type
  TfFavoritos = class(TForm)
    lbFavoritos: TListBox;
    pnlBottom: TPanel;
    btnUp: TButton;
    btnDown: TButton;
    btnRemove: TButton;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    procedure populaListbox;
    procedure atualizaOrdem;
  public
  end;

var
  fFavoritos: TfFavoritos;

implementation

uses fmMenu, dmComponentes;

procedure TfFavoritos.populaListbox;
begin
  if not DM.cdsFavoritos.Active then
    fmIndex.carregaFavoritos;
  if not DM.cdsFavoritos.Active then Exit;
  lbFavoritos.Items.Clear;
  DM.cdsFavoritos.First;
  while not DM.cdsFavoritos.EOF do
  begin
    lbFavoritos.Items.Add(DM.cdsFavoritos.FieldByName('NOME').AsString);
    DM.cdsFavoritos.Next;
  end;
end;

procedure TfFavoritos.atualizaOrdem;
var
  i: Integer;
begin
  DM.cdsFavoritos.First;
  for i := 0 to lbFavoritos.Items.Count - 1 do
  begin
    if DM.cdsFavoritos.FieldByName('NOME').AsString <> lbFavoritos.Items[i] then
    begin
      if DM.cdsFavoritos.Locate('NOME', lbFavoritos.Items[i], []) then
      begin
        DM.cdsFavoritos.Edit;
        DM.cdsFavoritos.FieldByName('ORDEM').Value := i + 1;
        DM.cdsFavoritos.Post;
      end;
    end
    else
    begin
      DM.cdsFavoritos.Edit;
      DM.cdsFavoritos.FieldByName('ORDEM').Value := i + 1;
      DM.cdsFavoritos.Post;
    end;
    DM.cdsFavoritos.Next;
  end;
end;

procedure TfFavoritos.FormShow(Sender: TObject);
begin
  populaListbox;
end;

procedure TfFavoritos.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfFavoritos.btnUpClick(Sender: TObject);
var
  idx: Integer;
  nome: string;
begin
  idx := lbFavoritos.ItemIndex;
  if idx <= 0 then Exit;
  nome := lbFavoritos.Items[idx];
  lbFavoritos.Items[idx] := lbFavoritos.Items[idx - 1];
  lbFavoritos.Items[idx - 1] := nome;
  lbFavoritos.ItemIndex := idx - 1;
  atualizaOrdem;
  fmIndex.carregaFavoritos;
end;

procedure TfFavoritos.btnDownClick(Sender: TObject);
var
  idx: Integer;
  nome: string;
begin
  idx := lbFavoritos.ItemIndex;
  if (idx < 0) or (idx >= lbFavoritos.Items.Count - 1) then Exit;
  nome := lbFavoritos.Items[idx];
  lbFavoritos.Items[idx] := lbFavoritos.Items[idx + 1];
  lbFavoritos.Items[idx + 1] := nome;
  lbFavoritos.ItemIndex := idx + 1;
  atualizaOrdem;
  fmIndex.carregaFavoritos;
end;

procedure TfFavoritos.btnRemoveClick(Sender: TObject);
var
  idx: Integer;
  nome: string;
begin
  idx := lbFavoritos.ItemIndex;
  if idx < 0 then Exit;
  nome := lbFavoritos.Items[idx];
  if DM.cdsFavoritos.Locate('NOME', nome, []) then
    DM.cdsFavoritos.Delete;
  lbFavoritos.Items.Delete(idx);
  fmIndex.carregaFavoritos;
  Application.MessageBox(PChar('Página ''' + nome + ''' removida com sucesso dos favoritos!'),
    fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
end;

procedure TfFavoritos.btnCloseClick(Sender: TObject);
begin
  Close;
end;


initialization
  {$I fmFavoritos.lrs}

end.
