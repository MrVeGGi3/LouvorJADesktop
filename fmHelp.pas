unit fmHelp;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/OleCtrls/SHDocVw/ActiveX — TWebBrowser (OLE) indisponível no Linux}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, LCLIntf, LCLType, FPHTTPClient, LResources;

type
  TfHelp = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    bsSkinPanel2: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinPanel1: TPanel {LAZARUS: TbsSkinPanel};
    lblStatus: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinButton2: TButton {LAZARUS: TbsSkinButton};
    wbNew: TMemo {LAZARUS: TWebBrowser — WebKitGTK pendente};
    bsSkinButton1: TButton {LAZARUS: TbsSkinButton};
    procedure bsSkinButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tabPage: string;
  end;

var
  fHelp: TfHelp;

implementation

uses
  fmMenu, dmComponentes, fmIniciando;


{LAZARUS: WBLoadHTML removido — TWebBrowser (Windows OLE/COM) não disponível no Linux sem WebKitGTK}

procedure TfHelp.bsSkinButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfHelp.bsSkinButton2Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['help'+fIniciando.LANG];
  if url = '' then
    Application.MessageBox(
      PChar('Não foi possível acessar a ajuda! Acesse a ajuda em https://louvorja.com.br!'),
      fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    OpenURL(url); {LAZARUS: ShellExecute → OpenURL (LCLIntf)}
end;

procedure TfHelp.FormActivate(Sender: TObject);
var
  url: string;
begin
  {LAZARUS: TWebBrowser/TIdHTTP removidos — mostrar URL no TMemo como stub}
  url := fmIndex.param.Strings.Values['version_log'];
  if url <> '' then
  begin
    url := url + '?lang=' + fIniciando.LANG + '&version=' + fmIndex.lblVersao.Caption;
    wbNew.Text := '(Ajuda disponível em: ' + url + ')' + #13#10 +
                  'Use o botão "Acessar Ajuda" para abrir no navegador.';
    {LAZARUS: wbNew.Navigate → wbNew.Text — WebKitGTK pendente}
  end;
end;


initialization
  {$I fmHelp.lrs}

end.
