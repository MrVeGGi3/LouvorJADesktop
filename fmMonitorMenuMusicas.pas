unit fmMonitorMenuMusicas;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/System.*}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, LCLIntf, LCLType, DBCtrls, DB, LResources;

type
  TfMonitorMenuMusicas = class(TForm)
    Panel1: TPanel;
    DBCtrlGrid: TScrollBox {LAZARUS: TDBCtrlGrid};
    Panel2: TPanel;
    GridPanel2: TPanel {LAZARUS: TGridPanel};
    bsSkinDBText1: TDBText {LAZARUS: TbsSkinDBText};
    ico: TImage {LAZARUS: TbsPngImageView};
    bsSkinDBText2: TDBText {LAZARUS: TbsSkinDBText};
    Panel3: TPanel;
    Panel4: TPanel;
    imgCapa: TImage;
    GridPanel1: TPanel {LAZARUS: TGridPanel};
    lblTitulo: TLabel {LAZARUS: TbsSkinStdLabel};
    lblSubtitulo: TLabel {LAZARUS: TbsSkinStdLabel};
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
  fMonitorMenuMusicas: TfMonitorMenuMusicas;

implementation


uses fmMenu, fmListaMusica;

{ TfMonitorMenuMusicas }

procedure TfMonitorMenuMusicas.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorMenuMusicas.FormActivate(Sender: TObject);
begin
  fListaMusica.btExp_MenuMusicas.ImageIndex := 54;
end;

procedure TfMonitorMenuMusicas.FormClose(Sender: TObject;
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

  fListaMusica.btExp_MenuMusicas.ImageIndex := 53;
end;

procedure TfMonitorMenuMusicas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;


initialization
  {$I fmMonitorMenuMusicas.lrs}

end.
