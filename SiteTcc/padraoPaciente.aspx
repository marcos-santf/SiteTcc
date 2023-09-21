<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="padraoPaciente.aspx.cs" Inherits="SiteTCC.padraoPaciente" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/stylePaciente.css">
    <title>Front-end do Hospital</title>
</head>
<body>
    <header>
        <h1>Triagem Rápida: Agilizador de Atendimento de Saúde</h1>
    </header>

    <section>
        <h2>Informações do Usuário</h2>
        <form id="userForm" runat="server">
            <p><h4>Nome Completo: </h4><input type="text" id="userName" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>CPF: </h4><input type="text" id="userCpf" onblur="restoreDefaultText(this)" runat="server" oninput="this.value = this.value.replace(/\D/g, '')" /></p>
            <p><h4>Data de Nascimento: </h4><input type="text" id="userDateOfBirth" runat="server" /></p>
            <p><h4>Responsável: </h4><input type="text" id="userResponsavel" onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Telefone: </h4><input type="text" id="userPhone" runat="server" /></p>
            <p><h4>E-mail: </h4><input type="text" id="userEmail"  onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Senha: </h4><input type="password" id="userSenha"  onblur="restoreDefaultText(this)" runat="server" /></p>
            <p><h4>Confirme a senha: </h4><input type="password" id="userConfSenha"  onblur="restoreDefaultText(this)" runat="server" /></p>
            <asp:Button ID="submitButton" runat="server" OnClick="submitButton_Click" Text="Enviar Dados" />
            <%--<button class="action-button" onclick="submitButton_Click">Enviar Dados</button>--%>
        </form>
    </section>

    <section id="pnAtendimento" runat="server" visible="true">
        <h2>Atendimentos Anteriores</h2>
        <ul id="previousAppointments">
            <li>Atendimento 1 - Data: 01/09/2023</li>
            <li>Atendimento 2 - Data: 15/08/2023</li>
            <li>Atendimento 3 - Data: 30/07/2023</li>
        </ul>
    </section>

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

