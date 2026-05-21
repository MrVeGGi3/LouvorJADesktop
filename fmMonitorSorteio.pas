unit fmMonitorSorteio;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/System.*}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, LCLIntf, LCLType, LResources;

type
  TfMonitorSorteio = class(TForm)
    pnlSorteio: TPanel;
    imgSorteio: TImage;
    lmdSorteio: TLabel;
    gSorteio: TProgressBar {LAZARUS: TbsSkinGauge};
    pnlSorteioE: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteio: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    pnlSorteioD: TPanel {LAZARUS: TbsSkinExPanel};
    lbSorteado: TCheckListBox {LAZARUS: TbsSkinOfficeListBox};
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbSorteioItemCheckClick(Sender: TObject);
    procedure pnlSorteioDClose(Sender: TObject);
    procedure pnlSorteioEClose(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorSorteio: TfMonitorSorteio;

implementation


uses fmMenu;

procedure TfMonitorSorteio.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorSorteio.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_Sorteio.ImageIndex := 11;
end;

procedure TfMonitorSorteio.FormClose(Sender: TObject; var Action: TCloseAction);
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

  fmIndex.btExp_Sorteio.ImageIndex := 10;
end;

procedure TfMonitorSorteio.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMonitorSorteio.lbSorteioItemCheckClick(Sender: TObject);
begin
  fmIndex.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  fmIndex.lbSorteio.Checked[lbSorteio.ItemIndex] {LAZARUS: Items[i].Checked->Checked[i]} := lbSorteio.Checked[lbSorteio.ItemIndex] {LAZARUS: Items[i].Checked->Checked[i]};
  fmIndex.lbSorteioItemCheckClick(Sender);
end;

procedure TfMonitorSorteio.pnlSorteioDClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio', 'Numeros Sorteados (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExp.Checked {LAZARUS: TCheckListBox.ItemChecked->Checked}[1] := false;
end;

procedure TfMonitorSorteio.pnlSorteioEClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio', 'Numeros Sorteio (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExp.Checked {LAZARUS: TCheckListBox.ItemChecked->Checked}[0] := false;
end;


initialization
  {$I fmMonitorSorteio.lrs}

end.
