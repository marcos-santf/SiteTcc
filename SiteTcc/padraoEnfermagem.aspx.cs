using Microsoft.VisualBasic.ApplicationServices;
using SiteTcc.Classes;
using SiteTCC.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace SiteTcc
{
    public partial class padraoEnfermagem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["P"] != "1")
            {
                if (!IsPostBack)
                    CarregaControle();
            }

            userCoren.Disabled = true;
            userName.Disabled = true;
            patientName.Disabled = true;
        }

        private void CarregaControle()
        {
            string Param2 = string.Empty;
            int CodigoUsuario = int.MinValue;

            Param2 = Request.QueryString["Param5"];

            CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario);

            userName.Value = (string)ds.Tables[0].Rows[0]["ds_nome"];
            userCoren.Value = (string)ds.Tables[1].Rows[0]["ds_coren"];

            if (ds.Tables[2].Rows.Count > 0)
            {
                patientName.Value = (string)ds.Tables[2].Rows[0]["ds_nome_paciente"];
                idSenha.Text = ds.Tables[2].Rows[0]["nr_senha"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["nr_senha"];
            }
            else
                pnBotao.Visible = false;
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            string Param2 = string.Empty;
            int CodigoUsuario = int.MinValue;

            Param2 = Request.QueryString["Param5"];

            CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario);


            string sintomas = symptoms.Value;
            string pressao = pressure.Value;
            string batimento = heartRate.Value;
            string oxigenacao = oxygenLevel.Value;
            string queixaPaciente = patientComplaint.Value;
            string obs = observations.Value;
            string cdExame = ds.Tables[2].Rows[0]["cd_exame"].ToString();
            string prioridade = ds.Tables[2].Rows[0]["ind_prioridade"].ToString();

            EnviarDadosPaciente(cdExame, sintomas, pressao, batimento, oxigenacao, queixaPaciente, obs, prioridade);
        }

        private void EnviarDadosPaciente(string cdExame, string sintomas, string pressao, string batimento, string oxigenacao, string queixaPaciente, string obs, string prioridade)
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
                    using (SqlCommand cmd = new SqlCommand("pr_envia_dados_paciente", connection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@cd_exame", cdExame);
                        cmd.Parameters.AddWithValue("@ds_sintomas", sintomas);
                        cmd.Parameters.AddWithValue("@ds_pressao", pressao);
                        cmd.Parameters.AddWithValue("@ds_batimento", batimento);
                        cmd.Parameters.AddWithValue("@ds_oxigenacao", oxigenacao);
                        cmd.Parameters.AddWithValue("@ds_queixa_paciente", queixaPaciente);
                        cmd.Parameters.AddWithValue("@ds_observacoes_enfermagem", obs);
                        cmd.Parameters.AddWithValue("@ind_prioridade", prioridade);
                        cmd.ExecuteNonQuery();
                    }
                }
                Response.StatusCode = 200;
                validaDados.ClientMessage(this, "Dados inseridos com sucesso.");

                LimpaControles();
                CarregaControle();
            }
            catch (Exception ex)
            {
                validaDados.ClientMessage(this, ex.Message);
                return;
            }
        }

        private void LimpaControles()
        {
            symptoms.Value = string.Empty;
            pressure.Value = string.Empty;
            heartRate.Value = string.Empty;
            oxygenLevel.Value = string.Empty;
            patientComplaint.Value = string.Empty;
            observations.Value = string.Empty;
            patientName.Value = string.Empty;
            idSenha.Text = string.Empty;
        }
    }
}