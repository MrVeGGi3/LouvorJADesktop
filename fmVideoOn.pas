unit fmVideoOn;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos System.*/Vcl.*/SHDocVw/OleCtrls — TWebBrowser OLE indisponivel no Linux}
  SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, LCLIntf, LCLType, LResources;

type
  TfVideoOn = class(TForm)
    wbVideo: TMemo {LAZARUS: TWebBrowser - OLE indisponível no Linux};
    mmHTML: TMemo;
    pnlLoading: TPanel;
    lblLoading: TLabel {LAZARUS: TbsSkinLabel};
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    {LAZARUS: wbVideoDocumentComplete removido — IDispatch/OleVariant são Windows COM}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    videoID: string;
    id: string;
  end;

var
  fVideoOn: TfVideoOn;

implementation


uses
  fmMenu;

procedure TfVideoOn.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;

procedure TfVideoOn.FormActivate(Sender: TObject);
var
  dir: string;
begin
  if (Trim(videoID) = '') then
    Exit;

  id := videoID;
  videoID := '';

  wbVideo.Visible := false;
  pnlLoading.Visible := not wbVideo.Visible;

  dir := fmIndex.dir_temp + 'video.html';
  mmHTML.Lines.SaveToFile(dir);
  {LAZARUS: wbVideo.Navigate removido — TWebBrowser OLE não disponível no Linux}
  wbVideo.Lines.Text := 'Vídeo: ' + id; {LAZARUS: placeholder — usar WebKitGTK futuramente}
end;

procedure TfVideoOn.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  if (fVideoOn.AlphaBlendValue > 0) then
  begin
    if fmIndex.ckFadeForm.Checked then
    begin
      for i := fVideoOn.AlphaBlendValue downto 0 do
      begin
        fVideoOn.AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else fVideoOn.AlphaBlendValue := 0;
  end;
  wbVideo.Lines.Clear; {LAZARUS: wbVideo.Navigate('about:blank') removido}
end;

procedure TfVideoOn.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

{LAZARUS: wbVideoDocumentComplete removido — era evento OLE TWebBrowser}


initialization
  {$I fmVideoOn.lrs}

end.
