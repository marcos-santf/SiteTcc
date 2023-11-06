using Microsoft.VisualBasic.ApplicationServices;
using SiteTcc.Classes;
using SiteTCC.Classes;
using System;
using System.Collections.Generic;
using System.Data;
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
                CarregaControle();

            doctorName.Disabled = true;
            crm.Disabled = true;
            patientName.Disabled = true;
            patientCpf.Disabled = true;
            patientPhone.Disabled = true;
            patientEmail.Disabled = true;
            userCoren.Disabled = true;
            userName.Disabled = true;
        }

        private void CarregaControle()
        {
            string Param2 = string.Empty;
            int CodigoUsuario = int.MinValue;

            Param2 = Request.QueryString["Param5"];

            CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario);

            doctorName.Value = (string)ds.Tables[0].Rows[0]["ds_nome"];
            crm.Value = (string)ds.Tables[0].Rows[0]["ds_crm"];
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {

        }

    }
}