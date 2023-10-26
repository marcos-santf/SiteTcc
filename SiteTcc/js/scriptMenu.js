// Verifica se há um item ativo no localStorage
var ativo = localStorage.getItem('menu-ativo');

// Se houver um item ativo, defina-o como ativo
if (ativo) {
    var elementoAtivo = document.getElementById(ativo);
    if (elementoAtivo) {
        elementoAtivo.classList.add('ativo');
    }
}

// Seleciona os itens de menu
var menuItem = document.querySelectorAll('.item-menu a');

function selectLink() {
    menuItem.forEach((item) => {
        item.classList.remove('ativo');
    });
    this.classList.add('ativo');

    // Armazena o ID do item ativo no localStorage
    localStorage.setItem('menu-ativo', this.id);
}

menuItem.forEach((item) => {
    item.addEventListener('click', selectLink);
});

// Expandir o menu

var btnExp = document.querySelector('#btn-exp');
var menuSide = document.querySelector('.menu-lateral');

btnExp.addEventListener('click', function () {
    menuSide.classList.toggle('expandir');
});

function redirecionarParaHome() {
    var urlParams = new URLSearchParams(window.location.search);
    var Param1 = urlParams.get("Param1");
    var Param2 = urlParams.get("Param2");
    var Param3 = urlParams.get("Param3");
    var Param4 = urlParams.get("Param4");
    var Param5 = urlParams.get("Param5");

    var novoURL = 'Default.aspx?Param1=' + Param1 + '&Param2=' + Param2 + '&Param3=' + Param3 + '&Param4=' + Param4 + '&Param5=' + Param5 + '&Param6=home';

    window.location.href = novoURL;
}

document.getElementById('home').addEventListener('click', redirecionarParaHome);

function redirecionarParaConta() {
    var urlParams = new URLSearchParams(window.location.search);
    var Param1 = urlParams.get("Param1");
    var Param2 = urlParams.get("Param2");
    var Param3 = urlParams.get("Param3");
    var Param4 = urlParams.get("Param4");
    var Param5 = urlParams.get("Param5");

    var novoURL = 'Default.aspx?Param1=' + Param1 + '&Param2=' + Param2 + '&Param3=' + Param3 + '&Param4=' + Param4 + '&Param5=' + Param5 + '&Param6=conta';

    window.location.href = novoURL;
}

document.getElementById('conta').addEventListener('click', redirecionarParaConta);

function Sair() {
    localStorage.clear();

    window.location.href = 'padraoLogin.aspx';
}

document.getElementById('sair').addEventListener('click', Sair);
