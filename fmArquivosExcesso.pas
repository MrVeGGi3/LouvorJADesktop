unit fmArquivosExcesso;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, ZDataset, LResources;

type
  TfArquivosExcesso = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    bsSkinPanel2: TPanel {LAZARUS: TbsSkinPanel};
    lbl1: TLabel {LAZARUS: TbsSkinStdLabel};
    gpBotoes: TPanel {LAZARUS: TGridPanel};
    bsSkinSpeedButton53: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton54: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton55: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinPanel1: TPanel {LAZARUS: TbsSkinPanel};
    lblStatus: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinButton2: TButton {LAZARUS: TbsSkinButton};
    btApaga: TButton {LAZARUS: TbsSkinButton};
    gProgresso: TProgressBar;
    lvArquivos: TListView {LAZARUS: TbsSkinListView};
    lbArquivos: TListBox;
    qrVERIFICA: TZQuery {LAZARUS: TFDQuery};
    tmrFecha: TTimer;
    bsSkinScrollBar8: TScrollBar {LAZARUS: TbsSkinScrollBar};
    btVerifica: TButton {LAZARUS: TbsSkinButton};
    procedure FormActivate(Sender: TObject);
    procedure verificaArquivos();
    function listaArquivos(raiz,dir: string): TStringList;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure btVerificaClick(Sender: TObject);
    procedure btApagaClick(Sender: TObject);
    procedure bsSkinSpeedButton53Click(Sender: TObject);
    procedure bsSkinSpeedButton54Click(Sender: TObject);
    procedure bsSkinSpeedButton55Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fArquivosExcesso: TfArquivosExcesso;

implementation


uses fmMenu, fmIniciando;

procedure TfArquivosExcesso.bsSkinButton2Click(Sender: TObject);
begin
  tmrFecha.Enabled := False;
  qrVERIFICA.Last;
  tmrFecha.Enabled := True;
end;

procedure TfArquivosExcesso.bsSkinSpeedButton53Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lvArquivos.Items.Count - 1
    do lvArquivos.Items.Item[i].Checked := True;
end;

procedure TfArquivosExcesso.bsSkinSpeedButton54Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lvArquivos.Items.Count - 1
    do lvArquivos.Items.Item[i].Checked := False;
end;

procedure TfArquivosExcesso.bsSkinSpeedButton55Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lvArquivos.Items.Count - 1
    do lvArquivos.Items.Item[i].Checked := not lvArquivos.Items.Item[i].Checked;
end;

procedure TfArquivosExcesso.btApagaClick(Sender: TObject);
var
  i: Integer;
begin
  if (application.MessageBox(PChar('Atenção: Este recurso irá apagar os arquivos selecionados. Uma vez apagado, não é possível recuperar estes arquivos. Deseja realmente apagar estes arquivos?'), fmIndex.titulo, mb_yesno + MB_ICONWARNING) <> 6)
    then Exit;

  for i := 0 to lvArquivos.Items.Count - 1 do
  begin
    if (lvArquivos.Items.Item[i].Checked) then
      DeleteFile(ExtractFilePath(application.ExeName)+lvArquivos.Items.Item[i].SubItems[0]);
  end;
  verificaArquivos();
end;

procedure TfArquivosExcesso.btVerificaClick(Sender: TObject);
begin
  verificaArquivos();
end;

procedure TfArquivosExcesso.FormActivate(Sender: TObject);
begin
  verificaArquivos();
end;

procedure TfArquivosExcesso.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

function TfArquivosExcesso.listaArquivos(raiz,dir: string): TStringList;
var
  f : Integer;
  SearchRec: TSearchRec;
  items,subitems: TStringList;
begin
  items := TStringList.Create;
  items.Clear;

  subitems := TStringList.Create;
  subitems.Clear;

  f := FindFirst(raiz+dir+'*.*', faAnyFile, SearchRec);
  While f = 0 do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
    begin
      if DirectoryExists(raiz + dir + SearchRec.Name) then
      begin
        if (dir+SearchRec.Name <> 'config\imagens_hlp') then //ignorar diretorio
        begin
          subitems.Clear;
          subitems := listaArquivos(raiz,dir + SearchRec.Name + '\');
          if subitems.Count <= 0
            then RemoveDir(dir + SearchRec.Name)
            else items.AddStrings(subitems);
        end;
      end
      else items.Add(dir + SearchRec.Name);
    end;
    f := FindNext(SearchRec);
  end;
  Result := items;
end;

procedure TfArquivosExcesso.tmrFechaTimer(Sender: TObject);
begin
  lblStatus.Caption := '';
  Close;
end;

procedure TfArquivosExcesso.verificaArquivos;
var
  Item: TListItem;
  i: Integer;
  url: string;
begin
  gpBotoes.Visible := False;

  gProgresso.Visible := True;
  gProgresso.Style := pbstMarquee;
  lblStatus.Caption := 'Localizando arquivos...';
  lvArquivos.Items.Clear;

  lbArquivos.Items.Clear;
  lbArquivos.Items := listaArquivos(ExtractFilePath(Application.ExeName),'');

  qrVERIFICA.Close;
  qrVERIFICA.Open;
  qrVERIFICA.First;
  gProgresso.Style := pbstNormal;
  gProgresso.Position := 0;
  gProgresso.Max := qrVERIFICA.RecordCount;
  btApaga.Enabled := False;
  btVerifica.Enabled := False;

  lblStatus.Caption := 'Verificando arquivos...';
  while not qrVERIFICA.eof do
  begin
    url := qrVERIFICA.FieldByName('URL').AsString;
    if (fIniciando.paramexec.Strings.Values['dir_config'] <> '') then
      url := StringReplace(url,'config\',fIniciando.paramexec.Strings.Values['dir_config']+'\',[rfIgnoreCase, rfReplaceAll]);

    gProgresso.Position := qrVERIFICA.RecNo;
    i := lbArquivos.Items.IndexOf(url);
    if (i >= 0)
      then lbArquivos.Items.Delete(i);

    Application.ProcessMessages;
    qrVERIFICA.Next;
  end;

  lblStatus.Caption := 'Listando arquivos...';
  lvArquivos.Items.Clear;
  gProgresso.Position := 0;
  gProgresso.Max := lbArquivos.Items.Count;
  for i := 0 to lbArquivos.Items.Count-1 do
  begin
    gProgresso.Position := i;
    Item := lvArquivos.Items.Add;
    Item.Checked := False;
    Item.Caption := ExtractFileName(lbArquivos.Items[i]);
    Item.SubItems.Add(lbArquivos.Items[i]);
  end;

  lblStatus.Caption := '';
  btApaga.Enabled := True;
  btVerifica.Enabled := True;
  gProgresso.Visible := False;

  gpBotoes.Visible := true;

  if lvArquivos.Items.Count <= 0
    then application.MessageBox('Nenhum arquivo em excesso encontrado!', fmIndex.titulo, mb_ok + MB_ICONINFORMATION)
    else application.MessageBox(PChar('Sua coletânea possui '+inttostr(lvArquivos.Items.Count) + ' arquivo(s) em excesso. Marque os arquivos que deseja apagar e pressione o botão "Apagar Arquivos Selecionados".'), fmIndex.titulo, mb_ok + mb_iconinformation);
end;


initialization
  {$I fmArquivosExcesso.lrs}

end.
