# OTIMIZAÇÃO DO ATENDIMENTO HOSPITALAR

![Bitbucket open pull requests](https://github.com/marcos-santf/SiteTcc/blob/master/SiteTcc/img/pagina%20principal.png)

> A proposta contempla a compatibilidade do aplicativo com os sistemas hospitalares existentes, assegurando uma sincronização eficiente de dados e um acesso otimizado a registros médicos centralizados.


## 💻 Pré-requisitos

Antes de começar, verifique se você atendeu aos seguintes requisitos:

- Instalar a versão mais recente de `SQL Server Management Studio (SSMS)` em https://www.microsoft.com/pt-br/sql-server/sql-server-downloads
- Conecte o banco de dados SQL Sever `SiteTcc/Banco de Dados/Acesso Banco de Dados.txt`.
- Instalar a versão mais recente de `Microsoft Visual Studio` em https://visualstudio.microsoft.com/pt-br/downloads/
- Ter uma máquina `Windows`.
- Se preferir, acessar o link direto do sistema: https://medopticare.azurewebsites.net/padraoLogin


## ☕ Usando Sistema

Para utilizar a Otimização do Atendimento Hospitalar, siga as funcionalidades do sistema:

```
Após realizar os pré-requisitos, será possivel se cadastrar no sistema para conseguir acessar:

Informações pessoais: 
- Nome Completo
- CPF
- RG
- Data de Nascimento
- Responsável
- Telefone
- E-mail 

 Fila da triagem:
- Será gerado uma senha sequencial conforme sua idade e emergência.

Exames Anteriores:
- Nome do Paciente
- Enfermeira Responsável
- Médico Responsável
- Data do Exame
- Sintomas
- Pressão Arterial
- Batimentos Cardíacos
- Oxigenação
- Queixas do Paciente
- Observações Enfermagem
- Diagnóstico Médico
- Prescrição Médica

Agendar Exames, Consultas e Vacinas:
- Data
- Hora
- Agendar Exame, Consulta ou Vacina
- Tipo de Exame, Consulta ou Vacina

Atualizar dados pessoais:
- Responsável
- Telefone
- E-mail


Também será possível acessar o sistema como médico ou enfermeiro para testes. Para isso, utilize o arquivo com os 
dados de acesso em SiteTcc/Banco de Dados/Acessos enfermagem-medicos.txt.

As senhas da triagem serão direcionadas automaticamente aos médicos e enfermeiros com a menor ou nenhuma fila de espera. 
Caso esteja conectado a esses perfis e logo em seguida incluir um paciente, recarregue a página da enfermagem, que será 
a primeira a receber as informações para que os dados sejam apresentados. O mesmo ocorre com acessos ao login de médicos, 
caso finalize o processo de enfermagem.
```


## 🤝 Colaboradores

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/marcos-santf" title="GitHub Marcos Antonio">
        <img src="https://avatars.githubusercontent.com/u/107215855?s=400&u=27867e68f4ced8ce49ca830f3189f8465733f8a9&v=4" width="100px;" alt="Foto do Marcos Antonio GitHub"/><br>
        <sub>
          <b>Marcos Antonio</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/ryfe-r" title="GitHub Rafael Fernades">
        <img src="https://avatars.githubusercontent.com/u/71154052?v=4" width="100px;" alt="Foto do Rafael Fernades no GitHub"/><br>
        <sub>
          <b>Rafael Fernades</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/07GabrielSouza" title="GitHub Gabriel Souza">
        <img src="https://avatars.githubusercontent.com/u/167651835?v=4" width="100px;" alt="Foto do Gabriel Souza no GitHub"/><br>
        <sub>
          <b>Gabriel Souza</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
