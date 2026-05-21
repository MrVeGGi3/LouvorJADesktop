unit fmMonitorBibliaBusca;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/System.*}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, LCLIntf, LCLType, LResources;

type
  TfMonitorBibliaBusca = class(TForm)
    pnlBibliaBusca: TPanel;
    imgBibliaBusca: TImage;
    lmdBibliaBuscaTxt: TLabel;
    lmdBibliaBuscaInfo: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorBibliaBusca: TfMonitorBibliaBusca;

implementation


uses fmMenu;

{ TfMonitorBibliaBusca }

procedure TfMonitorBibliaBusca.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorBibliaBusca.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_BibliaBusca.ImageIndex := 11;
end;

procedure TfMonitorBibliaBusca.FormClose(Sender: TObject;
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

  fmIndex.btExp_BibliaBusca.ImageIndex := 10;
end;

procedure TfMonitorBibliaBusca.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;


initialization
  {$I fmMonitorBibliaBusca.lrs}

end.
