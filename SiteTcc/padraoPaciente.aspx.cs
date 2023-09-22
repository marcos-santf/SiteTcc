using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using SiteTCC.Classes;
using Microsoft.IdentityModel.Tokens;
using System.Globalization;

namespace SiteTCC
{
    public partial class padraoPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["P"] != "1")
                CarregaControle();
            else
                pnAtendimento.Visible = false;
        }
        protected void submitButton_Click(object sender, EventArgs e)
        {
            clsValidaDados validaDados = new clsValidaDados();

            string nomeCompleto = userName.Value;
            string cpf = userCpf.Value;
            string rg = userRg.Value;
            string dataNascimento = userDateOfBirth.Value;
            string responsavel = userResponsavel.Value;
            string telefone = userPhone.Value;
            string email = userEmail.Value;
            string senha = userSenha.Value;
            string confirmaSenha = userConfSenha.Value;
            string lembreteSenha = userLembreteSenha.Value;

            if (dataNascimento != string.Empty)
            {
                TimeSpan idade = DateTime.Now - Convert.ToDateTime(dataNascimento);
                if (idade.TotalDays < 18 * 365)
                {
                    validaDados.ClientMessage(this, "Favor, informar o Responsável.");
                    return;
                }
            }

            if (nomeCompleto == string.Empty)
            {
                validaDados.ClientMessage(this, "Favor, informar o Nome.");
                return;
            }
            else if (cpf == string.Empty)
            {
                validaDados.ClientMessage(this, "Favor, informar o CPF.");
                return;
            }
            else if (rg == string.Empty)
            {
                validaDados.ClientMessage(this, "Favor, informar o RG.");
                return;
            }
            else if (dataNascimento == string.Empty)
            {
                validaDados.ClientMessage(this, "Favor, informar a Data de Nascimento.");
                return;
            }
            else if (senha == string.Empty)
            {
                validaDados.ClientMessage(this, "Favor, informar a Senha.");
                return;
            }
            else if (lembreteSenha == string.Empty)
            {
                validaDados.ClientMessage(this, "Favor, informar o Lembrete para Senha.");
                return;
            }
            else if (senha != confirmaSenha)
            {
                validaDados.ClientMessage(this, "Senhas diferentes.");
                return;
            }
            else
            {
                EnviarDadosParaBanco(nomeCompleto, cpf, rg, dataNascimento, responsavel, telefone, email, senha, lembreteSenha);
            }
        }
        private void CarregaControle()
        {
            userDateOfBirth.Visible = false;
            Date.Visible = true;
            string Param2 = string.Empty;
            int CodigoUsuario = int.MinValue;

            Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

            CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsPaciente.RetornaDadosPaciente(CodigoUsuario);

            userName.Value = (string)ds.Tables[0].Rows[0]["ds_nome"];
            userCpf.Value = (string)ds.Tables[0].Rows[0]["ds_cpf"];
            userRg.Value = (string)ds.Tables[0].Rows[0]["ds_rg"];
            DateTime dataNascimento = (DateTime)ds.Tables[0].Rows[0]["dt_nascimento"];
            Date.Value = dataNascimento.ToString("dd/MM/yyyy");
            userResponsavel.Value = (string)ds.Tables[0].Rows[0]["ds_responsavel"];
            userPhone.Value = (string)ds.Tables[0].Rows[0]["ds_telefone"];
            userEmail.Value = (string)ds.Tables[0].Rows[0]["ds_email"];

            if(userName.Value != string.Empty)
                userName.Disabled = true;
            if (userCpf.Value != string.Empty)
                userCpf.Disabled = true;
            if (Date.Value != string.Empty)
                Date.Disabled = true;
            if (userPhone.Value != string.Empty)
                userPhone.Disabled = true;
            if (userEmail.Value != string.Empty)
                userEmail.Disabled = true;

            pnSenha.Visible = false;
        }

        private void EnviarDadosParaBanco(string nomeCompleto, string cpf, string rg, string dataNascimento,string responsavel,string telefone,string email,string senha, string lembreteSenha)
        {
            clsValidaDados validaDados = new clsValidaDados();
            string Password = string.Empty;

            try
            {
                Password = clsCriptografia.Encrypt(senha, "Eita#$%Nois##", true);

                // Chama a stored procedure para inserir os dados no banco de dados
                using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MODELOConnectionString"].ConnectionString))
                {
                    // Abre a conexão
                    connection.Open();

                    // Criar o comando para a stored procedure
                    using (SqlCommand cmd = new SqlCommand("pr_inclui_paciente", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ds_nome", nomeCompleto);
                        cmd.Parameters.AddWithValue("@ds_rg", rg);
                        cmd.Parameters.AddWithValue("@ds_cpf", cpf);
                        cmd.Parameters.AddWithValue("@ds_telefone", telefone);
                        cmd.Parameters.AddWithValue("@dt_nascimento", dataNascimento);
                        cmd.Parameters.AddWithValue("@ds_responsavel", responsavel);
                        cmd.Parameters.AddWithValue("@ds_email", email);
                        cmd.Parameters.AddWithValue("@ds_senha", Password);
                        cmd.Parameters.AddWithValue("@ds_lembrete_senha", lembreteSenha);
                        cmd.ExecuteNonQuery();
                    }
                }
                Response.StatusCode = 200;
                Response.Write("Dados inseridos com sucesso.");
                Response.Redirect("padraoLogin.aspx");
            }
            catch (Exception ex)
            {
                validaDados.ClientMessage(this, ex.Message);
                return;
            }
        }
    }
}