<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="padraoMenu.ascx.cs" Inherits="SiteTCC.padraoMenu1" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SideBar</title>
    <link rel="stylesheet" href="css/styleMenu.css">
    <link rel="stylesheet" href="css/styleMenuCanto.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <script src="https://cdn.lordicon.com/ritcuqlt.js"></script>
</head>
<body>
    <nav class="menu-lateral">
        <div class="btn-expandir">
            <i class="bi bi-list" id="btn-exp"></i>
        </div><!--btn-expandir-->
        <ul>
            <li class="item-menu">
                <a href="#" class="item-menu" type="submit" id="home">
                    <span class="icon"><i class="bi bi-house-door"></i></span>
                    <span class="txt-link">Início</span>
                </a>
            </li>
            <li class="item-menu">
                <a href="#" class="item-menu" type="submit" id="exame">
                    <span class="icon"><i class="bi bi-file-earmark-medical"></i></span>
                    <span class="txt-link">Exames</span>
                </a>
            </li>
            <li class="item-menu">
                <a href="#" class="item-menu" type="submit" id="agenda">
                    <span class="icon"><i class="bi bi-calendar3"></i></span>
                    <span class="txt-link">Agendar</span>
                </a>
            </li>
            <%--<li class="item-menu">
                <a href="#" type="submit" id="config" visible="false">
                    <span class="icon"><i class="bi bi-gear"></i></span>
                    <span class="txt-link">Configurações</span>
                </a>
            </li>--%>
            <li class="item-menu">
                <a href="#" class="item-menu" type="submit" id="conta">
                    <span class="icon"><i class="bi bi-person-circle"></i></span>
                    <span class="txt-link">Conta</span>
                </a>
            </li>
            <li class="item-menu">
                <a href="#" class="item-menu" type="submit" id="sair">
                    <span class="icon"><i class="bi bi-arrow-left"></i></span>
                    <span class="txt-link">Sair</span>
                </a>
            </li>
        </ul>
    </nav><!--menu-lateral-->
    <script src="js/scriptMenu.js"></script>
    <script src="js/scriptMenuCanto.js"></script>
</body>
</html>