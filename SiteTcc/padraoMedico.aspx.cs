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
        }

        private void CarregaControle()
        {
            string Param2 = string.Empty;
            int CodigoUsuario = int.MinValue;

            Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

            CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsUsuario.RetornaDadosUsuario(CodigoUsuario);
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {

        }

    }
}