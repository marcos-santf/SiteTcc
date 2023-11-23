using Microsoft.VisualBasic.ApplicationServices;
using SiteTcc.Classes;
using SiteTCC.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.PeerToPeer;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace SiteTcc
{
    public partial class padraoAgenda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
         {
            if (!IsPostBack)
            {
                cboAgendar_SelectedIndexChanged(null,null);
                radioOptions_SelectedIndexChanged(null, null);
            }
        }

        private void CarregaControle()
        {
            clsValidaDados validaDados = new clsValidaDados();

            string Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

            int CodigoUsuario = Convert.ToInt32(Param2);
            string dataInicio = dtInicio.Value == "" ? string.Empty : dtInicio.Value;
            string dataFim = dtFim.Value == "" ? string.Empty : dtFim.Value;

            if (dataInicio != string.Empty)
            {
                if (dataFim == string.Empty)
                {
                    validaDados.ClientMessage(this, "Por Favor, informar a data final");
                    return;
                }
            }
            else if (dataFim != string.Empty)
            {
                if (dataInicio == string.Empty)
                {
                    validaDados.ClientMessage(this, "Por Favor, informar a data inicial");
                    return;
                }
            }

            string Exame = string.Empty;

            if (cboTipoPesq.SelectedValue != "0")
                Exame = cboTipoPesq.SelectedItem.ToString();

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario, dataInicio, dataFim, Exame ,1);

            DataTable dataTable = ds.Tables[0];

            if (ds.Tables[0].Rows.Count > 0)
            {
                gridView.DataSource = dataTable;
                gridView.DataBind();
            }
            else
            {
                validaDados.ClientMessage(this, "Agendamentos não encontado");
                return;
            }
        }

        protected void radioOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            LimpaControles();

            if (radioOptions.SelectedValue == "0")
            {
                pnAgendamento.Visible = true;
                pnAgenda.Visible = false;
                submitButton.Text = "Agendar";
            }
            else if (radioOptions.SelectedValue == "1")
            {
                pnAgendamento.Visible = false;
                pnAgenda.Visible = true;
                submitButton.Text = "Pesquisar";
            }
        }

        protected void cboAgendar_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboAgendar.SelectedValue == "0")
            {
                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("ID", typeof(int));
                dataTable.Columns.Add("Nome", typeof(string));

                dataTable.Rows.Add(0, "Selecionar");
                dataTable.Rows.Add(1, "Hemograma Completo");
                dataTable.Rows.Add(2, "Glicemia");
                dataTable.Rows.Add(3, "Hepática e Renal");

                cboMarcar.DataSource = dataTable;
                cboMarcar.DataTextField = "Nome";
                cboMarcar.DataValueField = "ID";
                cboMarcar.DataBind();
            }
            else if (cboAgendar.SelectedValue == "1")
            {
                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("ID", typeof(int));
                dataTable.Columns.Add("Nome", typeof(string));

                dataTable.Rows.Add(0, "Selecionar");
                dataTable.Rows.Add(1, "Radiografia Tórax");
                dataTable.Rows.Add(2, "Ultrassonografia Abdominal");
                dataTable.Rows.Add(3, "Mamografia");

                cboMarcar.DataSource = dataTable;
                cboMarcar.DataTextField = "Nome";
                cboMarcar.DataValueField = "ID";
                cboMarcar.DataBind();
            }
            else if (cboAgendar.SelectedValue == "2")
            {
                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("ID", typeof(int));
                dataTable.Columns.Add("Nome", typeof(string));

                dataTable.Rows.Add(0, "Selecionar");
                dataTable.Rows.Add(1, "Entrevista Clínica");
                dataTable.Rows.Add(2, "Teste Psicométricos");
                dataTable.Rows.Add(3, "Avaliação Neuropsicológico");

                cboMarcar.DataSource = dataTable;
                cboMarcar.DataTextField = "Nome";
                cboMarcar.DataValueField = "ID";
                cboMarcar.DataBind();
            }
            else if (cboAgendar.SelectedValue == "3")
            {
                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("ID", typeof(int));
                dataTable.Columns.Add("Nome", typeof(string));

                dataTable.Rows.Add(0, "Selecionar");
                dataTable.Rows.Add(1, "Gripe");
                dataTable.Rows.Add(2, "Hepatites A e B");
                dataTable.Rows.Add(3, "HPV");

                cboMarcar.DataSource = dataTable;
                cboMarcar.DataTextField = "Nome";
                cboMarcar.DataValueField = "ID";
                cboMarcar.DataBind();
            }
        }


        protected void submitButton_Click(object sender, EventArgs e)
        {
            clsUsuario usuario = new clsUsuario();
            clsValidaDados validaDados = new clsValidaDados();

            if (radioOptions.SelectedValue == "0")
            {
                if (dtAgendamento.Value != "")
                {
                    string valorDtAgendamento = dtAgendamento.Value;

                    DateTime dataAgendamento;

                    if (DateTime.TryParse(valorDtAgendamento, out dataAgendamento))
                        if (dataAgendamento < DateTime.Now)
                        {
                            validaDados.ClientMessage(this, "Por favor, informar a data com dois dias de antecedência.");
                            return;
                        }

                    if (cboMarcar.SelectedValue == "0")
                    {
                        validaDados.ClientMessage(this, "Por favor, informar o campo Tipo.");
                        return;
                    }

                    if (cboHora.SelectedValue == "0")
                    {
                        validaDados.ClientMessage(this, "Por favor, informar o Horário.");
                        return;
                    }

                    string Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);
                    int CodigoUsuario = Convert.ToInt32(Param2);

                    string dtAgenda = dtAgendamento.Value;

                    usuario.RetornaIncluiAgenda(CodigoUsuario, dtAgenda, cboAgendar.SelectedItem.ToString(), cboMarcar.SelectedItem.ToString(), cboHora.SelectedItem.ToString());

                    LimpaControles();
                    validaDados.ClientMessage(this, "Agendado com Sucesso.");
                }
                else
                {
                    validaDados.ClientMessage(this, "Por favor, informar a data.");
                    return;
                }
            }
            else if (radioOptions.SelectedValue == "1")
            {
                CarregaControle();
            }
        }

        private void LimpaControles()
        {
            dtAgendamento.Value = "";
            dtInicio.Value = "";
            dtFim.Value = "";
            cboMarcar.SelectedValue = "0";
            cboAgendar.SelectedValue = "0";
            cboHora.SelectedValue = "0";
            cboTipoPesq.SelectedValue = "0";
            gridView.DataSource = null;
            gridView.DataBind();
        }
    }
}