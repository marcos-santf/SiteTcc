using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using SiteTCC.Classes;
using Microsoft.IdentityModel.Tokens;

namespace SiteTCC
{
    public partial class padraoLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["P"] == "1")
            {
                errorPopupMessage.Visible = true;
                errorPopupMessage.Value = "Dados incorretos.";
            }
            else
            {
                errorPopupMessage.Visible = false;
                errorPopupMessage.Value = "";
            }
        }
    }
}