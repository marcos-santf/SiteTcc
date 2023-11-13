<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="padraoEnfermagem.aspx.cs" Inherits="SiteTcc.padraoEnfermagem" %>
<%@ Register Src="Controls/padraoMenu.ascx" TagName="Menu" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleEnfermagem.css">
    <title>Enfermagem</title>
    <link rel="website icon" type="png" href="img/icons_hospital.png"/>
    <uc:Menu runat="server" ID="MenuControl"/>
</head>
<body>
    <header>
        <h1>Triagem</h1>
    </header>
    <form id="userForm" runat="server">
        <section id="pnEnfermagem" runat="server" visible="true" class="section-common-style">
             <section id="pnTituloEnfermagem" style="text-align: center;">
                  <h2>Informações da Enfermeira</h2>
             </section>
            <br>
            <p><h4>COREN: </h4><input type="text" id="userCoren" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Nome Completo: </h4><input type="text" id="userName" onblur="restoreDefaultText(this)" runat="server" /></p>

            <br>
            <br>
            <br>

            <section id="pnTituloPaciente" style="text-align: center;">
                <h2>Informações do Paciente</h2>
            </section>
             <br>
            <p><h4>Nome Completo: </h4><input type="text" id="patientName" onblur="restoreDefaultText(this)" runat="server" /></p>
            <br>
            <h3>Senha:  <asp:Label ID="idSenha" Text ="" runat="server"></asp:Label></h3>
            
            <br>
            <br>
            <br>

            <section id="pnTituloAtendimento" style="text-align: center;">
                <h2>Informações do Atendimento</h2>
            </section>
            <br>
            <p><h4>Sintomas: </h4><input type="text" id="symptoms" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Pressão: </h4><input type="text" id="pressure" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Batimentos: </h4><input type="text" id="heartRate" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Oxigenação: </h4><input type="text" id="oxygenLevel" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Queixa do Paciente: </h4><input type="text" id="patientComplaint" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Observações: </h4><input type="text" id="observations" onblur="restoreDefaultText(this)" runat="server" /></p>
            <br><br><br>
            <section id="pnBotao" runat="server" style="text-align: center; margin-top: 20px;">
                <asp:Button ID="submitButton" runat="server" Text="Enviar Dados" OnClick="submitButton_Click" CssClass="action-button" />
            </section>
            <br>
        </section>
    </form>
    <script>
        function clearDefaultText(inputElement) {
            if (inputElement.value === inputElement.defaultValue) {
                inputElement.value = '';
            }
        }
    </script>
</body>
</html>

