unit fmFormatacao;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, LResources;

type
  TfFormatacao = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    GridPanel2: TPanel {LAZARUS: TGridPanel};
    btSave: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton1: TButton {LAZARUS: TbsSkinButton};
    tabFontes: TTabControl {LAZARUS: TbsSkinTabControl — TTabControl tem .Tabs:TStrings};
    pnlFonte: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    bsSkinStdLabel2: TLabel {LAZARUS: TbsSkinStdLabel};
    fontComboBox: TComboBox {LAZARUS: TbsSkinFontComboBox};
    Panel8: TPanel;
    bsSkinStdLabel3: TLabel {LAZARUS: TbsSkinStdLabel};
    fontTamanho: TSpinEdit {LAZARUS: TbsSkinSpinEdit};
    Panel1: TPanel;
    Panel4: TPanel;
    bsSkinStdLabel108: TLabel {LAZARUS: TbsSkinStdLabel};
    csSorteioCor: TColorButton {LAZARUS: TbsSkinColorButton};
    Panel5: TPanel;
    bsSkinStdLabel1: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinCheckBox1: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinCheckBox2: TCheckBox {LAZARUS: TbsSkinCheckBox};
    bsSkinCheckBox3: TCheckBox {LAZARUS: TbsSkinCheckBox};
    pnlImagem: TPanel;
    Panel3: TPanel;
    Panel9: TPanel;
    bsSkinStdLabel4: TLabel {LAZARUS: TbsSkinStdLabel};
    Panel2: TPanel;
    bsSkinStdLabel5: TLabel {LAZARUS: TbsSkinStdLabel};
    lblFonte: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure tabFontesChange(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure fontComboBoxChange(Sender: TObject);
    procedure mostraFonte();
  private
    { Private declarations }
    fonteLocal: array of Tfont;
  public
    { Public declarations }
    fonte: array of Tfont;
    abas: array of string;
  end;

var
  fFormatacao: TfFormatacao;

implementation



procedure TfFormatacao.bsSkinButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfFormatacao.btSaveClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(fonte)-1 do
    fonte[i] := fonteLocal[i];
  Close;
end;

procedure TfFormatacao.fontComboBoxChange(Sender: TObject);
begin
  fonteLocal[tabFontes.TabIndex].Name := fontComboBox.Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text};
  mostraFonte();
end;

procedure TfFormatacao.FormActivate(Sender: TObject);
var
  i: integer;
  aba: TStringList;
begin
  aba := TStringList.Create;
  aba.Delimiter := ';';

  SetLength(fonteLocal,Length(fonte));

  tabFontes.Tabs.Clear;
  for i := 0 to Length(abas)-1 do
  begin
    if Length(fonte) >= i then
      fonteLocal[i] := fonte[i];

    aba.DelimitedText := abas[i];
    aba[1] := StringReplace(aba[1], '_', ' ', [rfIgnoreCase, rfReplaceAll]);
    tabFontes.Tabs.Add(aba[1]);
  end;
  tabFontes.TabIndex := 0;
  tabFontesChange(Sender);
end;

procedure TfFormatacao.mostraFonte;
begin
  lblFonte.Caption := fontComboBox.Text {LAZARUS: TbsSkinFontComboBox.FontName→.Text};
  lblFonte.Font := fonteLocal[tabFontes.TabIndex];
  lblFonte.Font.Height := Trunc(Panel2.Height/100)*10;
end;

procedure TfFormatacao.tabFontesChange(Sender: TObject);
var
  aba: TStringList;
begin
  aba := TStringList.Create;
  aba.Delimiter := ';';
  aba.DelimitedText := abas[tabFontes.TabIndex];

  pnlFonte.Visible := (aba[0] = 'FONTE');
  pnlImagem.Visible := (aba[0] = 'IMG');

  if (pnlFonte.Visible) then
  begin
    pnlFonte.Align := alClient;
    fontComboBox.Text := fonteLocal[tabFontes.TabIndex].Name;
//    fontTamanho.Value := fonteLocal[tabFontes.TabIndex].Name;
    mostraFonte();
  end
  else if (pnlImagem.Visible) then
  begin
    pnlImagem.Align := alClient;
  end;
end;


initialization
  {$I fmFormatacao.lrs}

end.
