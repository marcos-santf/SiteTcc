
//Seleciona os itens clicado
var menuItem = document.querySelectorAll('.item-menu')

function selectLink() {
    menuItem.forEach((item) =>
        item.classList.remove('ativo')
    )
    this.classList.add('ativo')
}

menuItem.forEach((item) =>
    item.addEventListener('click', selectLink)
)

//Expandir o menu

var btnExp = document.querySelector('#btn-exp')
var menuSide = document.querySelector('.menu-lateral')

btnExp.addEventListener('click', function () {
    menuSide.classList.toggle('expandir')
})

function redirecionarParaHome() {
    debugger
    var urlParams = new URLSearchParams(window.location.search);
    var Param1 = urlParams.get("Param1");
    var Param2 = urlParams.get("Param2");
    var Param3 = urlParams.get("Param3");
    var Param4 = urlParams.get("Param4");
    var Param5 = urlParams.get("Param5");

    var novoURL = 'Default.aspx?Param1=' + Param1 + '&Param2=' + Param2 + '&Param3=' + Param3 + '&Param4=' + Param4 + '&Param5=' + Param5 + '&Param6=house';

    window.location.href = novoURL;
}
document.getElementById('house').addEventListener('click', redirecionarParaHome);

function Sair() {
    debugger
    window.location.href = 'padraoLogin.aspx';
}
document.getElementById('sair').addEventListener('click', Sair);

