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
    public partial class padraoMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["P"] != "1")
            {
                if (!IsPostBack)
                    CarregaControle();
            }

            doctorName.Disabled = true;
            crm.Disabled = true;
            patientName.Disabled = true;
            userCoren.Disabled = true;
            userName.Disabled = true;
            symptoms.Disabled = true;
            pressure.Disabled = true;
            heartRate.Disabled = true;
            oxygenLevel.Disabled = true;
            patientComplaint.Disabled = true;
            observations.Disabled = true;
        }

        private void CarregaControle()
        {
            string Param2 = string.Empty;
            int CodigoUsuario = int.MinValue;

            Param2 = Request.QueryString["Param5"];

            CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario);

            doctorName.Value = (string)ds.Tables[0].Rows[0]["ds_nome"];
            crm.Value = (string)ds.Tables[1].Rows[0]["ds_crm"];

            if (ds.Tables[2].Rows.Count > 0)
            {
                patientName.Value = (string)ds.Tables[2].Rows[0]["ds_nome_paciente"];
                idSenha.Text = ds.Tables[2].Rows[0]["nr_senha"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["nr_senha"];
                symptoms.Value = ds.Tables[2].Rows[0]["ds_sintomas"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_sintomas"];
                pressure.Value = ds.Tables[2].Rows[0]["ds_pressao"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_pressao"];
                heartRate.Value = ds.Tables[2].Rows[0]["ds_batimento"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_batimento"];
                oxygenLevel.Value = ds.Tables[2].Rows[0]["ds_oxigenacao"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_oxigenacao"];
                patientComplaint.Value = ds.Tables[2].Rows[0]["ds_queixa_paciente"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_queixa_paciente"];
                observations.Value = ds.Tables[2].Rows[0]["ds_observacoes_enfermagem"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_observacoes_enfermagem"];
                userName.Value = ds.Tables[2].Rows[0]["ds_nome_enfermagem"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_nome_enfermagem"];
                userCoren.Value = ds.Tables[2].Rows[0]["ds_coren"] == DBNull.Value ? string.Empty : (string)ds.Tables[2].Rows[0]["ds_coren"];
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

            string diagnosticoMed = diagnosis.Value;
            string prescMed = prescription.Value;
            string obsMed = doctorObservations.Value;
            string cdExame = ds.Tables[2].Rows[0]["cd_exame"].ToString();
            string prioridade = ds.Tables[2].Rows[0]["ind_prioridade"].ToString();

            EnviarDadosPaciente(cdExame, diagnosticoMed, prescMed, obsMed, prioridade);
        }

        private void EnviarDadosPaciente(string cdExame, string diagnosticoMed, string prescMed, string obsMed,string prioridade)
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
                        cmd.Parameters.AddWithValue("@ds_diagnostico_medico", diagnosticoMed);
                        cmd.Parameters.AddWithValue("@ds_prescricao_medica", prescMed);
                        cmd.Parameters.AddWithValue("@ds_observacao_medica", prioridade);
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
            userName.Value = string.Empty;
            userCoren.Value = string.Empty;
            diagnosis.Value = string.Empty;
            prescription.Value = string.Empty;
            doctorObservations.Value = string.Empty;
        }
    }
}