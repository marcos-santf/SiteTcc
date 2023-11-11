<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="padraoAgenda.aspx.cs" Inherits="SiteTcc.padraoAgenda" %>
<%@ Register Src="Controls/padraoMenu.ascx" TagName="Menu" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleMedico.css">
    <title>Agenda</title>
    <link rel="website icon" type="png" href="img/icons_hospital.png"/>
    <uc:Menu runat="server" ID="MenuControl"/>
</head>
<body>
    <header>
        <h1>Atendimento Médico</h1>
    </header>
    <form id="userForm" runat="server">
        <section id="pnMedico" runat="server" visible="true">
            <asp:GridView ID="gridView" runat="server" AutoGenerateColumns="True"></asp:GridView>
        </section>
    </form>
</body>
</html>

