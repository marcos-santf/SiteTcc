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
using SiteTcc.Classes;

namespace SiteTCC
{
    public partial class padraoPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["P"] != "1")
            {
                if (!IsPostBack)
                    CarregaControle();
            }
            else
            {
                MenuControl.Visible = false;
            }

            if (Request.QueryString["Param5"] == "home")
            {
                userName.Disabled = true;
                userCpf.Disabled = true;
                userRg.Disabled = true;
                Date.Disabled = true;
                userPhone.Disabled = true;
                userEmail.Disabled = true;
                userResponsavel.Disabled = true;

                pnSenha.Visible = false;

                if (idSenha.Text == "")
                    pnBotao.Visible = true;
                else
                    pnBotao.Visible = false;

                submitButton.Text = "Iniciar Triagem";
            }
            else if (Request.QueryString["Param5"] == "conta")
            {
                submitButton.Text = "Salvar";
                pnAtendimento.Visible = false;
                pnBotao.Visible = true;
                pnSenha.Visible = false;
            }

            if (idSenha.Text == "")
            {
                pnAtendimento.Visible = false;
            }
        }

        private void CarregaControle()
        {
            userDateOfBirth.Visible = false;
            Date.Visible = true;

            string Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

            int CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario, string.Empty, string.Empty, 0);

            userName.Value = (string)ds.Tables[0].Rows[0]["ds_nome"];
            userCpf.Value = (string)ds.Tables[0].Rows[0]["ds_cpf"];
            userRg.Value = (string)ds.Tables[0].Rows[0]["ds_rg"];
            DateTime dataNascimento = (DateTime)ds.Tables[0].Rows[0]["dt_nascimento"];
            Date.Value = dataNascimento.ToString("dd/MM/yyyy");
            userResponsavel.Value = ds.Tables[0].Rows[0]["ds_responsavel"] == DBNull.Value ? string.Empty : (string)ds.Tables[0].Rows[0]["ds_responsavel"];
            userPhone.Value = ds.Tables[0].Rows[0]["ds_telefone"] == DBNull.Value ? string.Empty : (string)ds.Tables[0].Rows[0]["ds_telefone"];
            userEmail.Value = ds.Tables[0].Rows[0]["ds_email"] == DBNull.Value ? string.Empty : (string)ds.Tables[0].Rows[0]["ds_email"];
            idSenha.Text = ds.Tables [1].Rows[0]["nr_senha"] == DBNull.Value ? string.Empty : (string)ds.Tables[1].Rows[0]["nr_senha"];

            if (idSenha.Text == "")
            {
                pnAtendimento.Visible = false;
                pnBotao.Visible = true;
            }
            else
            {
                pnAtendimento.Visible = true;
                pnBotao.Visible = false;
            }
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
            int prioridade = 0;

            if (Request.QueryString["Param5"] == "conta" || Request.QueryString["Param5"] == "home")
            {
                dataNascimento = Date.Value;
                string formatoOriginal = "dd/MM/yyyy";
                DateTime data = DateTime.ParseExact(dataNascimento, formatoOriginal, null);
                dataNascimento = data.ToString("yyyy/MM/dd");
            }

            if (dataNascimento != string.Empty)
            {
                TimeSpan idade = DateTime.Now - Convert.ToDateTime(dataNascimento);
                if (idade.TotalDays < 18 * 365)
                {
                    if (responsavel == string.Empty)
                    {
                        validaDados.ClientMessage(this, "Favor, informar o Responsável.");
                        return;
                    }
                }

                TimeSpan idadeCrianca = DateTime.Now - Convert.ToDateTime(dataNascimento);
                if (idadeCrianca.TotalDays < 13 * 365)
                {
                    prioridade = 1;
                }

                TimeSpan idadeIdoso = DateTime.Now - Convert.ToDateTime(dataNascimento);
                if (idadeIdoso.TotalDays > 64 * 365)
                {
                    prioridade = 2;
                }
            }

            if (Request.QueryString["Param5"] != "conta" && Request.QueryString["Param5"] != "home")
            {
                string senha = userSenha.Value;
                string confirmaSenha = userConfSenha.Value;
                string lembreteSenha = userLembreteSenha.Value;

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
                else if (senha != confirmaSenha)
                {
                    validaDados.ClientMessage(this, "Senhas diferentes.");
                    return;
                }
                else if (lembreteSenha == string.Empty)
                {
                    validaDados.ClientMessage(this, "Favor, informar o Lembrete para Senha.");
                    return;
                }
                else
                {
                    EnviarDadosParaBanco(nomeCompleto, cpf, rg, dataNascimento, responsavel, telefone, email, senha, lembreteSenha, prioridade);
                }
            }
            else if (Request.QueryString["Param5"] == "conta" || Request.QueryString["Param5"] == "home")
            {
                dataNascimento = Date.Value;
                string formatoOriginal = "dd/MM/yyyy";
                DateTime data = DateTime.ParseExact(dataNascimento, formatoOriginal, null);
                dataNascimento = data.ToString("yyyy/MM/dd");

                string Param2 = string.Empty;
                int CodigoUsuario = int.MinValue;
                Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

                CodigoUsuario = Convert.ToInt32(Param2);

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
                else
                {
                    if(Request.QueryString["Param5"] == "conta")
                        AlteraDadosBanco(nomeCompleto, cpf, rg, dataNascimento, responsavel, telefone, email, CodigoUsuario, prioridade,0);
                    else if (Request.QueryString["Param5"] == "home")
                        AlteraDadosBanco(nomeCompleto, cpf, rg, dataNascimento, responsavel, telefone, email, CodigoUsuario, prioridade, 1);

                    CarregaControle();
                }
            }
        }

        private void EnviarDadosParaBanco(string nomeCompleto, string cpf, string rg, string dataNascimento,string responsavel,string telefone,string email,string senha, string lembreteSenha, int prioridade)
        {
            clsValidaDados validaDados = new clsValidaDados();
            string Password = string.Empty;

            try
            {
                Password = clsCriptografia.Encrypt(senha, "Eita#$%Nois##", true);

                // Chama a stored procedure para inserir os dados no banco de dados
                using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["HOSPITALConnectionString"].ConnectionString))
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
                        cmd.Parameters.AddWithValue("@ind_prioridade", prioridade);
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Write("Dados inseridos com sucesso.");
                Response.Redirect("padraoLogin.aspx?Param1=" + cpf + "&Param2=" + senha + "&Param3=0");
            }
            catch (Exception ex)
            {
                validaDados.ClientMessage(this, ex.Message);
                return;
            }
        }

        private void AlteraDadosBanco(string nomeCompleto, string cpf, string rg, string dataNascimento, string responsavel, string telefone, string email, int CodigoUsuario, int prioridade , int tipo)
        {
            clsValidaDados validaDados = new clsValidaDados();

            try
            {
                // Chama a stored procedure para inserir os dados no banco de dados
                using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["HOSPITALConnectionString"].ConnectionString))
                {
                    // Abre a conexão
                    connection.Open();

                    // Criar o comando para a stored procedure
                    using (SqlCommand cmd = new SqlCommand("pr_altera_paciente", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ds_nome", nomeCompleto);
                        cmd.Parameters.AddWithValue("@ds_rg", rg);
                        cmd.Parameters.AddWithValue("@ds_cpf", cpf);
                        cmd.Parameters.AddWithValue("@ds_telefone", telefone);
                        cmd.Parameters.AddWithValue("@dt_nascimento", dataNascimento);
                        cmd.Parameters.AddWithValue("@ds_responsavel", responsavel);
                        cmd.Parameters.AddWithValue("@ds_email", email);
                        cmd.Parameters.AddWithValue("@CodigoUsuario", CodigoUsuario);
                        cmd.Parameters.AddWithValue("@ind_prioridade", prioridade);
                        cmd.Parameters.AddWithValue("@tipo", tipo);
                        cmd.ExecuteNonQuery();
                    }
                }
                validaDados.ClientMessage(this,"Dados inseridos com sucesso.");
            }
            catch (Exception ex)
            {
                validaDados.ClientMessage(this, ex.Message);
                return;
            }
        }
    }
}