<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="padraoAgenda.aspx.cs" Inherits="SiteTcc.padraoAgenda" %>
<%@ Register Src="Controls/padraoMenu.ascx" TagName="Menu" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleAgenda.css">
    <link rel="stylesheet" href="css/styleCampoPadrao.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
     <link rel="website icon" type="png" href="img/icons_hospital.png"/>
    <title>Agenda</title>
    <uc:Menu runat="server" ID="MenuControl"/>
</head>
<body>
    <header>
        <h1>Agendamento</h1>
    </header>
    <form id="userForm" runat="server">
        <section id="pnOptions" class="section-common-style" runat="server" visible="true">
            <asp:RadioButtonList ID="radioOptions" runat="server" CssClass="horizontal-radio" AutoPostBack="true" OnSelectedIndexChanged="radioOptions_SelectedIndexChanged">
                <asp:ListItem Text="Agendar" Value="0" Selected="True" />
                <asp:ListItem Text="Exames Agendados" Value="1" />
            </asp:RadioButtonList>
            <br/>
            <br/>
            <br/>
            <section id="pnAgendamento" runat="server" visible="true">
                <div class="date-input-container">
                    <h4 style="margin-left: 26px; margin-right: 5px;">Data: </h4>
                    <input type="date" id="dtAgendamento" runat="server" CssClass="estilo-data"/>
                    <h4 style="margin-left: 10px; margin-right: 5px;" id="idHora" runat="server">Hora: </h4>
                    <asp:DropDownList ID="cboHora" runat="server" CssClass="estilo-cbo" required="true">
                        <asp:ListItem Text="Selecionar" Value="0" />
                        <asp:ListItem Text="09:00" Value="1" />
                        <asp:ListItem Text="09:30" Value="2" />
                        <asp:ListItem Text="10:00" Value="3" />
                        <asp:ListItem Text="10:30" Value="4" />
                        <asp:ListItem Text="11:00" Value="5" />
                        <asp:ListItem Text="11:30" Value="6" />
                        <asp:ListItem Text="12:00" Value="7" />
                        <asp:ListItem Text="13:00" Value="8" />
                        <asp:ListItem Text="13:30" Value="9" />
                        <asp:ListItem Text="14:00" Value="10" />
                        <asp:ListItem Text="14:30" Value="11" />
                        <asp:ListItem Text="15:00" Value="12" />
                        <asp:ListItem Text="15:30" Value="13" />
                        <asp:ListItem Text="16:00" Value="14" />
                    </asp:DropDownList>
               </div>
               <div class="date-input-container">
                    <h4 style="margin-right: 5px;">Agendar: </h4>
                    <asp:DropDownList ID="cboAgendar" runat="server" CssClass="estilo-cbo" AutoPostBack="true" OnSelectedIndexChanged="cboAgendar_SelectedIndexChanged">
                        <asp:ListItem Text="Exame de Sangue" Value="0" />
                        <asp:ListItem Text="Exames de Imagem" Value="1" />
                        <asp:ListItem Text="Exames Psicológicos" Value="2" />
                        <asp:ListItem Text="Vacina" Value="3" />
                    </asp:DropDownList>
                    <h4 style="margin-left: 10px; margin-right: 8px;" id="idMarcar" runat="server">Tipo: </h4>
                    <asp:DropDownList ID="cboMarcar" runat="server" CssClass="estilo-cbo" AutoGenerateColumns="True"></asp:DropDownList>
                </div>
            </section>
           <section id="pnAgenda" runat="server" visible="false">
               <div class="date-input-container">
                    <h4 style="margin-right: 5px;">De: </h4>
                    <input type="date" id="dtInicio" runat="server" CssClass="estilo-data"/>
                    <h4 style="margin-left: 15px; margin-right: 5px;">Até: </h4>
                    <input type="date" id="dtFim" runat="server" CssClass="estilo-data"/>
                    <h4 style="margin-left: 15px; margin-right: 5px;">Tipo: </h4>
                    <asp:DropDownList ID="cboTipoPesq" runat="server" CssClass="estilo-cbo">
                        <asp:ListItem Text="Selecionar" Value="0" />
                        <asp:ListItem Text="Exame de Sangue" Value="1" />
                        <asp:ListItem Text="Exames de Imagem" Value="2" />
                        <asp:ListItem Text="Exames Psicológicos" Value="3" />
                        <asp:ListItem Text="Vacina" Value="4" />
                    </asp:DropDownList>
               </div>
               <br/>
               <asp:GridView ID="gridView" runat="server" OnRowDataBound="gridView_RowDataBound" OnRowCommand="gridView_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Cancelar">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnAcao" runat="server" ImageUrl="~/img/iconLixeira.png" CommandName="CANCELAR" CommandArgument='<%# Container.DataItemIndex %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>


            </section>
            <br><br><br><br>
            <section id="pnBotao" runat="server" style="text-align: center; margin-top: 20px;">
                 <asp:Button ID="submitButton" runat="server" Text="Pesquisar" OnClick="submitButton_Click" CssClass="action-button" />
                 <br><br>
            </section>
        </section>
    </form>
    <script  src="js/scriptAgenda.js"></script>
</body>
</html>

