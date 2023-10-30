var current = null;
document.querySelector('#cpf').addEventListener('focus', function (e) {
    if (current) current.pause();
    current = anime({
        targets: 'path',
        strokeDashoffset: {
            value: 0,
            duration: 700,
            easing: 'easeOutQuart'
        },
        strokeDasharray: {
            value: '240 1386',
            duration: 700,
            easing: 'easeOutQuart'
        }
    });
});
document.querySelector('#password').addEventListener('focus', function (e) {
    if (current) current.pause();
    current = anime({
        targets: 'path',
        strokeDashoffset: {
            value: -336,
            duration: 700,
            easing: 'easeOutQuart'
        },
        strokeDasharray: {
            value: '240 1386',
            duration: 700,
            easing: 'easeOutQuart'
        }
    });
});
function redirecionarParaCadastro() {
    window.location.href = 'padraoPaciente.aspx?P=' + '1';
}
document.getElementById('cadastrar').addEventListener('click', redirecionarParaCadastro);

function validaDadosAcesso() {
    var cpf = document.getElementById('cpf').value;
    var password = document.getElementById('password').value;

    window.location.href = 'Default.aspx?Param1=' + cpf + '&Param2=' + password + '&Param3=0';
}
document.getElementById('submit').addEventListener('click', validaDadosAcesso);
