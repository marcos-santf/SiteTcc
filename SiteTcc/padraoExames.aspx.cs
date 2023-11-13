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
    public partial class padraoExames : System.Web.UI.Page
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
                Response.Redirect("padraoLogin.aspx");
            }
        }

        private void CarregaControle()
        {
            string Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

            int CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario, string.Empty, string.Empty, 0);

            DataTable dataTable = ds.Tables[2];

            gridView.DataSource = dataTable;
            gridView.DataBind();
        }
    }
}