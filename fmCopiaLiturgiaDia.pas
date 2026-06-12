unit fmCopiaLiturgiaDia;
{$mode delphi}{$H+} {LAZARUS: port upstream 1570e57 — uses Winapi/Vcl → LCL}

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls;

type
  TfCopiaLiturgiaDia = class(TForm)
  private
    FDiaOrigem: Integer;
    FCbDias: array[1..7] of TCheckBox;
    FCbSobrescrever: TCheckBox;
  public
    constructor CreateDialog(AOwner: TComponent; ADiaOrigem: Integer);
    function GetDiasSelecionados: TArray<Integer>;
    function GetSobrescrever: Boolean;
  end;

implementation

const
  {LAZARUS: literais #231/#225 (Latin-1) renderizavam vazio no LCL (espera UTF-8)}
  NOMES_DIAS: array[1..7] of string = (
    'Domingo', 'Segunda-feira', 'Terça-feira',
    'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'
  );

constructor TfCopiaLiturgiaDia.CreateDialog(AOwner: TComponent; ADiaOrigem: Integer);
var
  lbl: TLabel;
  grp: TGroupBox;
  btn: TButton;
  i: Integer;
  pnlBotoes: TPanel;
begin
  inherited CreateNew(AOwner);
  FDiaOrigem := ADiaOrigem;

  Caption := 'Colar Itens em Outros Dias';
  {LAZARUS: 330x340 cortava o 7º dia (Sábado) e o texto do "Sobrescrever" no GTK2}
  Width := 380;
  Height := 370;
  BorderStyle := bsDialog;
  Position := poOwnerFormCenter;

  lbl := TLabel.Create(Self);
  lbl.Parent := Self;
  lbl.AutoSize := False;
  lbl.Left := 12;
  lbl.Top := 12;
  lbl.Width := Width - 24;
  lbl.Height := 36; {LAZARUS: 32 cortava a 2ª linha do texto no GTK2}
  lbl.WordWrap := True;
  lbl.Caption := 'Selecione os dias para colar os itens copiados:';

  grp := TGroupBox.Create(Self);
  grp.Parent := Self;
  grp.Left := 12;
  grp.Top := 50;
  grp.Width := Width - 24;
  grp.Height := 196; {LAZARUS: 168 cortava o 7º checkbox no GTK2 (caption do groupbox ocupa área cliente)}
  grp.Caption := 'Dias da Semana';

  for i := 1 to 7 do
  begin
    FCbDias[i] := TCheckBox.Create(Self);
    FCbDias[i].Parent := grp;
    FCbDias[i].Left := 16;
    FCbDias[i].Top := 12 + (i - 1) * 23;
    FCbDias[i].Width := 280;
    FCbDias[i].Caption := NOMES_DIAS[i];
    FCbDias[i].Tag := i;
    if i = ADiaOrigem then
    begin
      FCbDias[i].Checked := False;
      FCbDias[i].Enabled := False;
      FCbDias[i].Caption := NOMES_DIAS[i] + ' (origem)';
    end
    else
      FCbDias[i].Checked := True;
  end;

  FCbSobrescrever := TCheckBox.Create(Self);
  FCbSobrescrever.Parent := Self;
  FCbSobrescrever.Left := 12;
  FCbSobrescrever.Top := 256;
  FCbSobrescrever.Width := Width - 24;
  FCbSobrescrever.Caption := 'Sobrescrever todo o conteúdo dos dias selecionados'; {LAZARUS: #250 → UTF-8}
  FCbSobrescrever.Checked := False;

  pnlBotoes := TPanel.Create(Self);
  pnlBotoes.Parent := Self;
  pnlBotoes.Left := 0;
  pnlBotoes.Top := 260;
  pnlBotoes.Width := 322;
  pnlBotoes.Height := 44;
  pnlBotoes.BevelOuter := bvNone;
  pnlBotoes.Align := alBottom;

  btn := TButton.Create(Self);
  btn.Parent := pnlBotoes;
  btn.Left := Width - 196;
  btn.Top := 8;
  btn.Width := 80;
  btn.Height := 28;
  btn.Caption := 'OK';
  btn.Default := True;
  btn.ModalResult := mrOk;

  btn := TButton.Create(Self);
  btn.Parent := pnlBotoes;
  btn.Left := Width - 104;
  btn.Top := 8;
  btn.Width := 80;
  btn.Height := 28;
  btn.Caption := 'Cancelar';
  btn.Cancel := True;
  btn.ModalResult := mrCancel;
end;

function TfCopiaLiturgiaDia.GetDiasSelecionados: TArray<Integer>;
var
  i, count: Integer;
begin
  Result := nil; {LAZARUS: silencia warning 5093 — SetLength abaixo inicializa}
  count := 0;
  for i := 1 to 7 do
    if FCbDias[i].Enabled and FCbDias[i].Checked then
      Inc(count);

  SetLength(Result, count);
  count := 0;
  for i := 1 to 7 do
    if FCbDias[i].Enabled and FCbDias[i].Checked then
    begin
      Result[count] := i;
      Inc(count);
    end;
end;

function TfCopiaLiturgiaDia.GetSobrescrever: Boolean;
begin
  Result := FCbSobrescrever.Checked;
end;

end.
