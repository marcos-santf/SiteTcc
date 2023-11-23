using SiteTcc.Classes;
using SiteTCC.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SiteTCC
{
    public partial class padraoMenu1 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["P"] != "1")
            {
                if (!IsPostBack)
                    CarregaControle();
            }
        }
        private void CarregaControle()
        {
            string Param = string.Empty;
            int CodigoPerfil = int.MinValue;

            Param = clsCriptografia.Decrypt(Request.QueryString["Param1"], "Eita#$%Nois##", true);

            CodigoPerfil = Convert.ToInt32(Param);

            if(CodigoPerfil == 3 || CodigoPerfil == 4)
            {

            }
            
        }
    }
}