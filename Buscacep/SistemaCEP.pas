unit SistemaCEP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, REST.Types, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  IdAntiFreezeBase, IdAntiFreeze, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IdHTTP,IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdAttachmentFile, IdText,XMLDoc, XMLIntf ;

type
  TForm1 = class(TForm)
    LblIdentidade: TLabel;
    EdtIdentidade: TEdit;
    LblNome: TLabel;
    EdtNome: TEdit;
    LblTelefone: TLabel;
    EdtTelefone: TEdit;
    LblCPF: TLabel;
    EdtEmail: TEdit;
    LblEmail: TLabel;
    LblEndereco: TLabel;
    SpeedButton1: TSpeedButton;
    FDMTCep: TFDMemTable;
    RESTClientCEP: TRESTClient;
    RESTRequestCEP: TRESTRequest;
    RESTResponseCEp: TRESTResponse;
    RESTResponseDataSetAdapterCEP: TRESTResponseDataSetAdapter;
    MeditCep: TMaskEdit;
    EdtCPF: TEdit;
    Panel1: TPanel;
    EdtNr: TEdit;
    Label2: TLabel;
    EdtRua: TEdit;
    Edtbairro: TEdit;
    Label4: TLabel;
    Editcomple: TEdit;
    Label3: TLabel;
    Label1: TLabel;
    EdtCidade: TEdit;
    Label5: TLabel;
    EdtEstado: TEdit;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    EdtPais: TEdit;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtNomeExit(Sender: TObject);
    procedure EdtCPFExit(Sender: TObject);
    procedure EdtIdentidadeExit(Sender: TObject);
    procedure EdtEmailExit(Sender: TObject);
    procedure EdtTelefoneExit(Sender: TObject);
    procedure MeditCepExit(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.EdtCPFExit(Sender: TObject);
begin
   if EdtCPF.Text = '' then
   begin
     Messagedlg('CPF Não informado!',mtError,[mbok],0);
     EdtCPF.SetFocus;
     Exit
   end;

end;

procedure TForm1.EdtEmailExit(Sender: TObject);
var
i : Integer;
begin

   if EdtEmail.Text = '' then
   begin
     Messagedlg('Email Não informado!',mtError,[mbok],0);
     EdtEmail.SetFocus;
     Exit
   end;

  i := Pos('@', EdtEmail.Text);
  if i = 0 then
  begin
     Messagedlg('Email Não é valido !',mtError,[mbok],0);
     EdtEmail.SetFocus;
     Exit

  end;

end;

procedure TForm1.EdtIdentidadeExit(Sender: TObject);
begin

   if EdtIdentidade.Text = '' then
   begin
     Messagedlg('Numero Identidade Não informado!',mtError,[mbok],0);
     EdtIdentidade.SetFocus;
     Exit
   end;

end;

procedure TForm1.EdtNomeExit(Sender: TObject);
begin

   if EdtNome.Text = '' then
   begin
     Messagedlg('Nome do cliente Não informado!',mtError,[mbok],0);
     EdtNome.SetFocus;
     Exit
   end;

end;

procedure TForm1.EdtTelefoneExit(Sender: TObject);
begin

   if EdtTelefone.Text = '' then
   begin
     Messagedlg('Telefone de contato Não informado!',mtError,[mbok],0);
     EdtTelefone.SetFocus;
     Exit
   end;

end;

procedure TForm1.MeditCepExit(Sender: TObject);
begin

   if MeditCep.Text = '' then
   begin
     Messagedlg('CEP Não informado!',mtError,[mbok],0);
     MeditCep.SetFocus;
     Exit
   end;


end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin


  RESTRequestCEP.Params[0].Value := MeditCep.Text;
  RESTRequestCEP.Execute;

  FDMTCep.Open;

  EdtRua.Text     := FDMTCep.FieldByName('logradouro').AsString;
  Editcomple.Text := FDMTCep.FieldByName('complemento').AsString;
  Edtbairro.Text  := FDMTCep.FieldByName('bairro').AsString;
  EdtEstado.Text  := FDMTCep.FieldByName('uf').AsString;
  EdtCidade.Text  := FDMTCep.FieldByName('localidade').AsString;




end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin

  EdtNr.ReadOnly      := False;
  EdtRua.ReadOnly     := False;
  Edtbairro.ReadOnly  := False;
  EdtCidade.ReadOnly  := False;
  EdtEstado.ReadOnly  := False;
  Editcomple.ReadOnly := False;
  EdtNr.SetFocus;


end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin


  EdtNr.ReadOnly      := true;
  EdtRua.ReadOnly     := true;
  Edtbairro.ReadOnly  := true;
  EdtCidade.ReadOnly  := true;
  EdtEstado.ReadOnly  := true;
  Editcomple.ReadOnly := true;

  if EdtPais.Text = '' then
  begin
     Messagedlg('País Não informado!',mtError,[mbok],0);
     EdtPais.SetFocus;
     Exit
  end;

  if EdtNr.Text = '' then
  begin
     Messagedlg('Numero da residencia Não informado!',mtError,[mbok],0);
     EdtNr.SetFocus;
     Exit
  end;

  if Editcomple.Text = '' then
  begin
     Messagedlg('Complemento Não informado!',mtError,[mbok],0);
     Editcomple.SetFocus;
     Exit
  end;

end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
  sAnexo: string;

  XMLDocument: TXMLDocument;
  NodeTabela, NodeRegistro, NodeEndereco: IXMLNode;
  I: Integer;

begin

  if EdtPais.Text = '' then
  begin
     Messagedlg('País Não informado!',mtError,[mbok],0);
     EdtPais.SetFocus;
     Exit
  end;

  if EdtNr.Text = '' then
  begin
     Messagedlg('Numero da residencia Não informado!',mtError,[mbok],0);
     EdtNr.SetFocus;
     Exit
  end;

  if Editcomple.Text = '' then
  begin
     Messagedlg('Complemento Não informado!',mtError,[mbok],0);
     Editcomple.SetFocus;
     Exit
  end;


   XMLDocument := TXMLDocument.Create(Self);
   try
     XMLDocument.Active := True;
     NodeTabela := XMLDocument.AddChild('Pessoa' + EdtCPF.Text);
     NodeRegistro := NodeTabela.AddChild('Pessoais');
     NodeRegistro.ChildValues['Nome']        := EdtNome.Text;
     NodeRegistro.ChildValues['CPF']         := EdtCPF.Text;
     NodeRegistro.ChildValues['Identidade']  := EdtIdentidade.Text;
     NodeRegistro.ChildValues['Email']       := EdtEmail.Text;
     NodeRegistro.ChildValues['Telefone']    := EdtTelefone.Text;
     NodeEndereco := NodeRegistro.AddChild('Endereco');
     NodeEndereco.ChildValues['Logradouro']  :=  EdtRua.Text;
     NodeEndereco.ChildValues['Numero']      :=  EdtNr.Text;
     NodeEndereco.ChildValues['Complemento'] :=  Editcomple.Text;
     NodeEndereco.ChildValues['Bairro']      :=  Edtbairro.Text;
     NodeEndereco.ChildValues['Cidade']      :=  EdtCidade.Text;
     NodeEndereco.ChildValues['Estado']      :=  EdtEstado.Text;
     NodeEndereco.ChildValues['País']        :=  EdtPais.Text;

     if FileExists('C:\Cadastros\'+EdtCPF.Text+'.xml') then
     begin
       DeleteFile('C:\Cadastros\'+EdtCPF.Text+'.xml');
     end;

     XMLDocument.SaveToFile('C:\Cadastros\'+EdtCPF.Text+'.xml');
   finally
     XMLDocument.Free;
   end;

  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
  IdSMTP := TIdSMTP.Create(Self);
  IdMessage := TIdMessage.Create(Self);

  try

    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    IdSMTP.IOHandler := IdSSLIOHandlerSocket;

    IdSMTP.UseTLS := utUseImplicitTLS;
    IdSMTP.AuthType := satDefault;
    IdSMTP.Port := 465;
    IdSMTP.Host := 'smtp.gmail.com';

    IdSMTP.Username := 'marceloaplicativo35@gmail.com';
    IdSMTP.Password := '32227874a.?';
    IdMessage.From.Address := 'marceloaplicativo35@gmail.com';

    IdMessage.From.Name := ' - Infositemas  Cadastro de Pessoas- ';
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.Add.Text := EdtEmail.Text;
    IdMessage.Subject := 'Em anexo os dados informado no nosso cadastro. ' + DateToStr(Now);
    IdMessage.Encoding := meMIME;


    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body.Add('Ola, Você esta recebendo seus dados cadastros junto a infosistemas.');
    IdText.Body.Add(' ');
    IdText.Body.Add(' Dados Pessoais ');
    IdText.Body.Add(' ');
    IdText.Body.Add('Nome Completo : ' +  EdtNome.Text + ',  CPF:' + EdtCPF.Text + '.' );
    IdText.Body.Add('Numero Identidade : ' +  EdtIdentidade.Text + ',  Email:' + EdtEmail.Text + '.' );
    IdText.Body.Add('Telefone de contato : ' +  EdtTelefone.Text + ',  CEP:' + MeditCep.Text + '.' );
    IdText.Body.Add(' ');
    IdText.Body.Add(' Dados Complementares (Endereço)  ');
    IdText.Body.Add(' ');
    IdText.Body.Add('Rua : ' +  EdtRua.Text + ',  Numero:' + EdtNr.Text + ' , Complemento' + Editcomple.Text  +  '.' );
    IdText.Body.Add('Bairro : ' +  Edtbairro.Text + ',  Cidade:' + EdtCidade.Text +  '/'  + EdtEstado.Text + '.' );
    IdText.Body.Add('País : ' +  EdtPais.Text+ '.' );
    IdText.Body.Add(' ');
    IdText.Body.Add('Obrigado pelo seu cadastro junto a Infositemas  ');

    IdText.ContentType := 'text/plain; charset=iso-8859-1';


    sAnexo := 'C:\cadastros\'+EdtCPF.Text+'.xml';
    if FileExists(sAnexo) then
    begin
      TIdAttachmentFile.Create(IdMessage.MessageParts, sAnexo);
    end;


    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on E: Exception do
      begin
       Messagedlg('Erro na autenticacao;!',mtError,[mbok],0);
       end;
    end;


    try
      IdSMTP.Send(IdMessage);
       Messagedlg('Enviado com sucesso!',mtError,[mbok],0);
    except
      on E: Exception do
      begin
        Messagedlg('Deu erro',mtError,[mbok],0);
      end;
    end;

  finally
    IdSMTP.Disconnect;
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
  end;


end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  Close;
end;

end.



