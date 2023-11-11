<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="padraoExames.aspx.cs" Inherits="SiteTcc.padraoExames" %>
<%@ Register Src="Controls/padraoMenu.ascx" TagName="Menu" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleExames.css">
    <title>Agenda</title>
    <link rel="website icon" type="png" href="img/icons_hospital.png"/>
    <uc:Menu runat="server" ID="MenuControl"/>
</head>
<body>
    <header>
        <h1>Exames Anteriores</h1>
    </header>
    <form id="userForm" runat="server">
        <section id="pnExame" runat="server" visible="true">
            <asp:GridView ID="gridView" runat="server" AutoGenerateColumns="True"></asp:GridView>
        </section>
    </form>
</body>
</html>

