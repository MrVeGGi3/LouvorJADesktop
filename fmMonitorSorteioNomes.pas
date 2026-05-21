unit fmMonitorSorteioNomes;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/System.*}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, LCLIntf, LCLType, LResources;

type
  TfMonitorSorteioNomes = class(TForm)
    pnlSorteioNM: TPanel;
    imgSorteioNM: TImage;
    lmdSorteioNM: TLabel;
    gSorteioNM: TProgressBar {LAZARUS: TbsSkinGauge};
    pnlSorteioNME: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteioNM: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    pnlSorteioNMD: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteadoNM: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbSorteioNMItemCheckClick(Sender: TObject);
    procedure pnlSorteioNMDClose(Sender: TObject);
    procedure pnlSorteioNMEClose(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorSorteioNomes: TfMonitorSorteioNomes;

implementation


uses fmMenu;

procedure TfMonitorSorteioNomes.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorSorteioNomes.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_SorteioNM.ImageIndex := 11;
end;

procedure TfMonitorSorteioNomes.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: integer;
begin
  if (AlphaBlendValue > 0) then
  begin
    if fmIndex.ckFadeForm.Checked then
    begin
      for i := AlphaBlendValue downto 0 do
      begin
        AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else AlphaBlendValue := 0;
  end;

  fmIndex.btExp_SorteioNM.ImageIndex := 10;
end;

procedure TfMonitorSorteioNomes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMonitorSorteioNomes.lbSorteioNMItemCheckClick(Sender: TObject);
begin
  fmIndex.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  {LAZARUS: TCheckListBox.Items[i].Checked → TCheckListBox.Checked[i]}
  fmIndex.lbSorteioNM.Checked[lbSorteioNM.ItemIndex] := lbSorteioNM.Checked[lbSorteioNM.ItemIndex];
  fmIndex.lbSorteioNMItemCheckClick(Sender);
end;

procedure TfMonitorSorteioNomes.pnlSorteioNMDClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExpNM.Checked {LAZARUS: TCheckListBox.ItemChecked→Checked}[1] := false;
end;

procedure TfMonitorSorteioNomes.pnlSorteioNMEClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExpNM.Checked {LAZARUS: TCheckListBox.ItemChecked→Checked}[0] := false;
end;


initialization
  {$I fmMonitorSorteioNomes.lrs}

end.
