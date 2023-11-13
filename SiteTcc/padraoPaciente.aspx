<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="padraoPaciente.aspx.cs" Inherits="SiteTCC.padraoPaciente" %>
<%@ Register Src="Controls/padraoMenu.ascx" TagName="Menu" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleCampoPadrao.css">
    <link rel="stylesheet" href="css/stylePaciente.css">
    <title>Paciente</title>
    <link rel="website icon" type="png" href="img/icons_hospital.png"/>
     <uc:Menu runat="server" ID="MenuControl"/>
</head>
<body>
    <form id="userForm" runat="server">
        <header>
            <h1>Dados</h1>
        </header>
        <section id="pnAtendimento" class="section-common-style" runat="server" visible="true">
            <section id="pnTituloSenha" style="text-align: center;">
                 <h2>SENHA</h2>
            </section>
            
            <section id="pnGeraSenha" runat="server" style="text-align: center; margin-top: 20px;">
                <asp:Label ID="idSenha" Text ="" runat="server"></asp:Label>
            </section>
         </section>

        <section id="pnPaciente" class="section-common-style" runat="server" visible="true">
            <section id="pnTitulo" style="text-align: center;">
                 <h2>Informações do Paciente</h2>
            </section>
            <br>
            <p><h4>Nome Completo: </h4><input type="text" id="userName" runat="server" /></p>
            <p><h4>CPF: </h4><input type="text" id="userCpf" runat="server" oninput="this.value = this.value.replace(/\D/g, '')" /></p>
            <p><h4>RG: </h4><input type="text" id="userRg" runat="server" /></p>
            <p><h4>Data de Nascimento: </h4><input type="date" id="userDateOfBirth" runat="server" CssClass="estilo-data"/><input type="text" id="Date" runat="server" visible="false"/></p>
            <p><h4>Responsável: </h4><input type="text" id="userResponsavel" runat="server" /></p>
            <p><h4>Telefone: </h4><input type="text" id="userPhone" runat="server" /></p>
            <p><h4>E-mail: </h4><input type="text" id="userEmail"  runat="server" /></p>
            <section id="pnSenha" runat="server">
                <p><h4>Senha: </h4><input type="password" id="userSenha" runat="server" /></p>
                <p><h4>Confirme a senha: </h4><input type="password" id="userConfSenha" runat="server" /></p>
                <p><h4>Lembrete Senha: </h4><input type="text" id="userLembreteSenha" runat="server" /></p>
            </section>
            <section id="pnBotao" runat="server" style="text-align: center; margin-top: 20px;">
                    <asp:Button ID="submitButton" runat="server" Text="Enviar Dados" OnClick="submitButton_Click" CssClass="action-button" />
            </section>
        </section>
    </form>
    <script>
        function clearDefaultText(inputElement) {
            if (inputElement.value === inputElement.defaultValue) {
                inputElement.value = '';
            }
        }

        function restoreDefaultText(inputElement) {
            if (inputElement.value === '') {
                inputElement.value = inputElement.defaultValue;
            }
        }
    </script>
</body>
</html>

