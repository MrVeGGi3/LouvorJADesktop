unit fmItensAgendados;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, LResources;

type
  TfItensAgendados = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    pnlCategoria: TPanel {LAZARUS: TbsSkinPanel};
    txtCategoria: TEdit {LAZARUS: TbsSkinEdit};
    lblDescricao: TLabel {LAZARUS: TbsSkinLabel};
    GridPanel2: TPanel {LAZARUS: TGridPanel};
    btSave: TButton {LAZARUS: TbsSkinButton};
    btDel: TButton {LAZARUS: TbsSkinButton};
    pnlItem: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinLabel1: TLabel {LAZARUS: TbsSkinLabel};
    txtArquivo: TFileNameEdit {LAZARUS: TbsSkinFileEdit};
    txtArquivoInfo: TEdit {LAZARUS: TbsSkinEdit};
    procedure FormActivate(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtArquivoEnter(Sender: TObject);
    procedure txtArquivoExit(Sender: TObject);
    procedure txtArquivoButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id: string;
    tipo: string;
  end;

var
  fItensAgendados: TfItensAgendados;

implementation


uses fmMenu, dmComponentes;

procedure TfItensAgendados.btDelClick(Sender: TObject);
begin
  if (application.MessageBox('Deseja realmente excluir este item?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;

  if (tipo = 'CATEGORIA') then
  begin
    DM.cdsCategoriasItensAgendados.Locate('ID', id, []);

    DM.cdsItensAgendados.Locate('CATEGORIA', DM.cdsCategoriasItensAgendados.FieldByName('ID').Value, []);
    if (DM.cdsItensAgendados.RecordCount > 0) then
    begin
      DM.cdsItensAgendados.Delete;
      DM.cdsItensAgendados.MergeChangeLog;
    end;

    DM.cdsCategoriasItensAgendados.Delete;
    DM.cdsCategoriasItensAgendados.MergeChangeLog;

    fmIndex.pnlItensAgendados.Visible := False;
    Close;
  end
  else
  begin
    DM.cdsItensAgendados.Locate('ID', id, []);
    DM.cdsItensAgendados.Delete;
    DM.cdsItensAgendados.MergeChangeLog;
    Close;
  end;
end;

procedure TfItensAgendados.btSaveClick(Sender: TObject);
begin
  if (tipo = 'CATEGORIA') then
  begin
    if (trim(txtCategoria.Text) = '') then
    begin
      Application.MessageBox('Digite o nome da categoria!',fmIndex.TITULO,mb_ok+MB_ICONEXCLAMATION);
      txtCategoria.SetFocus;
      Exit;
    end;

    DM.cdsCategoriasItensAgendados.Locate('ID', id, []);
    DM.cdsCategoriasItensAgendados.Edit;
    DM.cdsCategoriasItensAgendados.FieldByName('NOME').Value := txtCategoria.Text;
    DM.cdsCategoriasItensAgendados.Post;
    DM.cdsCategoriasItensAgendados.MergeChangeLog;
    Close;
  end
  else
  begin
    if (trim(txtArquivo.Text) = '') then
    begin
      Application.MessageBox('Escolha o arquivo!',fmIndex.TITULO,mb_ok+MB_ICONEXCLAMATION);
      txtArquivo.SetFocus;
      Exit;
    end;

    DM.cdsItensAgendados.Locate('ID', id, []);
    DM.cdsItensAgendados.Edit;
    DM.cdsItensAgendados.FieldByName('NOME').Value := ChangeFileExt(ExtractFileName(txtArquivo.Text),'');
    DM.cdsItensAgendados.FieldByName('ARQUIVO').Value := txtArquivo.Text;
    DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').Value := txtArquivoInfo.Text;
    DM.cdsItensAgendados.Post;
    DM.cdsItensAgendados.MergeChangeLog;
    Close;
  end;
end;

procedure TfItensAgendados.FormActivate(Sender: TObject);
begin
  if (tipo = 'CATEGORIA') then
  begin
    fItensAgendados.Caption := 'Editar Categoria';

    DM.cdsCategoriasItensAgendados.Locate('ID', id, []);
    txtCategoria.Text := DM.cdsCategoriasItensAgendados.FieldByName('NOME').AsString;
  end
  else
  begin
    fItensAgendados.Caption := 'Editar Item - '+formatdatetime('dd/mm/yyyy',DM.cdsItensAgendados.FieldByName('DATA').AsDateTime);
    txtArquivo.Text := DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString;
    txtArquivoInfo.Text := DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').AsString;
  end;

  pnlCategoria.Visible := (tipo = 'CATEGORIA');
  pnlItem.Visible := (tipo <> 'CATEGORIA');
end;

procedure TfItensAgendados.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfItensAgendados.txtArquivoButtonClick(Sender: TObject);
var
  arq: string;
begin
  arq := fmIndex.openDialog('arquivo', TFileNameEdit {LAZARUS: TbsSkinFileEdit}(Sender).Filter, 'ItensAgendados');
  if arq <> '' then txtArquivo.Text := arq;
end;

procedure TfItensAgendados.txtArquivoEnter(Sender: TObject);
begin
  txtArquivo.Text := fmIndex.verificaURL(txtArquivo.Text, txtArquivoInfo, true);
end;

procedure TfItensAgendados.txtArquivoExit(Sender: TObject);
begin
  txtArquivo.Text := StringReplace(txtArquivo.Text, '|', '', [rfIgnoreCase, rfReplaceAll]);
  txtArquivo.Text := fmIndex.verificaURL(txtArquivo.Text, txtArquivoInfo, false);
end;


initialization
  {$I fmItensAgendados.lrs}

end.
