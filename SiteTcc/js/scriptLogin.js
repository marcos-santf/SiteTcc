function redirecionarParaCadastro() {
    window.location.href = 'padraoPaciente.aspx?P=' + '1';
}
document.getElementById('cadastrar').addEventListener('click', redirecionarParaCadastro);

function validaDadosAcesso() {
    debugger
    var cpf = document.getElementById('cpf').value;
    var password = document.getElementById('password').value;
    if (cpf != null) {
        if (password != null) {
            window.location.href = 'padraoLogin.aspx?Param1=' + cpf + '&Param2=' + password + '&Param3=0';
        }
    }
}
document.getElementById('submit').addEventListener('click', validaDadosAcesso);