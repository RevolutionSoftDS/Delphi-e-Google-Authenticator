unit UAuthenticator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,GoogleOTP, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    tmAtualizaToken: TTimer;
    grTop: TGroupBox;
    TsManual: TToggleSwitch;
    lblinfo: TLabel;
    grbase: TGroupBox;
    btnGerarToken: TButton;
    lblToken: TLabel;
    edtSECRETKEYTOP: TEdit;
    lblSuaKey: TLabel;
    tsAutomatico: TToggleSwitch;
    lblCodigo: TLabel;
    procedure btnGerarTokenClick(Sender: TObject);
    procedure edtSECRETKEYTOPExit(Sender: TObject);
    procedure tsAutomaticoClick(Sender: TObject);
    procedure TsManualClick(Sender: TObject);
    procedure tmAtualizaTokenTimer(Sender: TObject);
  private
    { Private declarations }
    Fkey : String;
    function Validar( codigo : String) : String;
    function SetOTP_SECRET_KEY(Key : String): String;
    function GeraToken(OTPSECRET : String) : String;
  public
    { Public declarations }
    property key  : String read FKey;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



{ TForm1 }


{ TForm1 }

procedure TForm1.btnGerarTokenClick(Sender: TObject);
begin
   lblToken.Caption := GeraToken(Fkey);
end;

procedure TForm1.edtSECRETKEYTOPExit(Sender: TObject);
begin
   SetOTP_SECRET_KEY(edtSECRETKEYTOP.Text);
end;

function TForm1.GeraToken(OTPSECRET: String): String;
var
  vToken : integer;
begin
   if OTPSECRET.IsEmpty then
   begin
     tmAtualizaToken.Enabled:= false;
     raise Exception.Create('Chave n�o informada!');
   end;

   vToken := CalculateOTP(Fkey);
   Result := Format('%.6d',[vToken]);
end;

function TForm1.SetOTP_SECRET_KEY(Key: String): String;
begin
  Fkey := Key;
end;

procedure TForm1.tmAtualizaTokenTimer(Sender: TObject);
begin
  lblToken.Caption := GeraToken(Fkey);
end;

procedure TForm1.tsAutomaticoClick(Sender: TObject);
begin
  if tsAutomatico.State = tssOn then
    edtSECRETKEYTOP.PasswordChar := '*'
  else
    edtSECRETKEYTOP.PasswordChar := #0 ;
end;

procedure TForm1.TsManualClick(Sender: TObject);
begin
  if TsManual.State = tssOn then
  begin
    tmAtualizaToken.Enabled := True;
    btnGerarToken.Visible := False;
  end
  else
  begin
    tmAtualizaToken.Enabled := False;
    btnGerarToken.Visible := True;
   end;
end;

function TForm1.Validar(codigo: String): String;
var
  vCodigo: String;
begin
  result := 'C�digo inv�lido';
  vCodigo := codigo;
  if ValidateTOPT(Fkey,vcodigo.ToInteger) then
  result := 'C�digo V�lido';
end;

end.
