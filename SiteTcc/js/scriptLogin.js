function mostrarSenha() {
    var inputPass = document.getElementById('password');
    var iconLock = document.getElementById('iconlock');

    if (inputPass.type === 'password') {
        inputPass.setAttribute('type', 'text');
        iconLock.className = 'bx bxs-lock-open-alt';
    } else {
        inputPass.setAttribute('type', 'password');
        iconLock.className = 'bx bxs-lock-alt';
    }
}

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