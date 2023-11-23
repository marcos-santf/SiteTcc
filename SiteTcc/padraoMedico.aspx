<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="padraoMedico.aspx.cs" Inherits="SiteTcc.padraoMedico" %>
<%@ Register Src="Controls/padraoMenu.ascx" TagName="Menu" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleMedico.css">
    <title>Médico</title>
    <link rel="website icon" type="png" href="img/icons_hospital.png"/>
    <uc:Menu runat="server" ID="MenuControl"/>
</head>
<body>
    <header>
        <h1>Atendimento Médico</h1>
    </header>
    <form id="userForm" runat="server">
        <section id="pnMedico"  class="section-common-style" runat="server" visible="true">
            <h2>Informações do Médico</h2>
            <br>
            <p><h4>Nome do Médico: <input type="text" id="doctorName" runat="server"></p>
            <p><h4>CRM: <input type="text" id="crm" runat="server"></p>
            
            <br>
            <br>
            <br>

            <h2>Informações do Paciente</h2>
            <br>
            <p><h4>Nome Completo: <input type="text" id="patientName" runat="server"></p>
            <br>
            <h3>Senha:  <asp:Label ID="idSenha" Text ="" runat="server"></asp:Label></h3>

            <br>
            <br>
            <br>

            <h2>Informações da Enfermeira</h2>
            <br>
            <p><h4>Nome Completo: <input type="text" id="userName" runat="server"></p>
            <p><h4>COREN: <input type="text" id="userCoren" runat="server"></p>

            <br>
            <br>
            <br>

            <h2>Informações do Atendimento</h2>
            <br>
            <p><h4>Sintomas: <input type="text" id="symptoms" runat="server"></p>
            <p><h4>Pressão: <input type="text" id="pressure" runat="server"></p>
            <p><h4>Batimentos: <input type="text" id="heartRate" runat="server"></p>
            <p><h4>Oxigenação: <input type="text" id="oxygenLevel" runat="server"></p>
            <p><h4>Queixa do Paciente: <input type="text" id="patientComplaint" runat="server"></p>
            <p><h4>Observações: <input type="text" id="observations" runat="server"></p>

            <br>
            <br>
            <br>

            <h2>Prescrição Médica</h2>
            <br>
            <p><h4>Diagnóstico: <input type="text" id="diagnosis" runat="server"></p>
            <p><h4>Prescrição Médica: <input type="text" id="prescription" runat="server"></p>
            <p><h4>Observações: <input type="text" id="doctorObservations" runat="server"></p>

            <br>
            <br>
            <br>

           <asp:RadioButtonList ID="radioOptions" runat="server" CssClass="horizontal-radio">
                <asp:ListItem Text="Encaminhamento" Value="3" />
                <asp:ListItem Text="Exames Diagnósticos" Value="5" />
                <asp:ListItem Text="Encaminhamento Especializado" Value="7" />
                <asp:ListItem Text="Alta" Value="9" Selected="True" />
           </asp:RadioButtonList>

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

        function restoreDefaultText(inputElement) {
            if (inputElement.value === '') {
                inputElement.value = inputElement.defaultValue;
            }
        }
    </script>
</body>
</html>

