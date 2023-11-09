function redirecionarParaCadastro() {
    window.location.href = 'padraoPaciente.aspx?P=' + '1';
}
document.getElementById('cadastrar').addEventListener('click', redirecionarParaCadastro);

function validaDadosAcesso() {
    var cpf = document.getElementById('cpf').value;
    var password = document.getElementById('password').value;
    if (cpf.trim() !== "" && password.trim() !== "") {
        window.location.href = 'padraoLogin.aspx';
    }
}
document.getElementById('submit').addEventListener('click', validaDadosAcesso);