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

    <section id="pnEnfermagem" runat="server" visible="true">
         <section id="pnTituloEnfermagem" style="text-align: center;">
              <h2>Informações da Enfermeira</h2>
         </section>
        <br>
        <p><h4>COREN: </h4><input type="text" id="userCoren" onblur="restoreDefaultText(this)" runat="server" /></p>
        <p><h4>ID do Usuário: </h4><input type="text" id="userId" onblur="restoreDefaultText(this)" runat="server" /></p>
        <p><h4>Nome Completo: </h4><input type="text" id="userName" onblur="restoreDefaultText(this)" runat="server" /></p>
    </section>

     <section id="pnPaciente" runat="server" visible="true">
         <section id="pnTituloPaciente" style="text-align: center;">
            <h2>Informações do Paciente</h2>
        </section>
         <br>
        <p><h4>Nome Completo: </h4><input type="text" id="patientName" onblur="restoreDefaultText(this)" runat="server" /></p>
        <p><h4>CPF: </h4><input type="text" id="patientCpf" onblur="restoreDefaultText(this)" runat="server" /></p>
        <p><h4>Telefone: </h4><input type="text" id="patientPhone" onblur="restoreDefaultText(this)" runat="server" /></p>
        <p><h4>E-mail: </h4><input type="text" id="patientEmail" onblur="restoreDefaultText(this)" runat="server" /></p>
    </section>

    <section id="pnAtendimento" runat="server" visible="true">
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
    </section>

     <section id="pnAtendAnter" runat="server" visible="true">
         <section id="pnTituloAtendAnter" style="text-align: center;">
             <h2>Atendimentos Anteriores</h2>
        </section>
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
    </script>
</body>
</html>

