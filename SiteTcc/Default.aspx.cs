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
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Param6"] != null)
            {
                DirecionaMenu();
            }
            else
            {
                Response.Redirect("padraoLogin.aspx");
            }
        }

        private void DirecionaMenu()
        {
            string DirecionaPagina = string.Empty;

            DirecionaPagina = clsCriptografia.Decrypt(Request.QueryString["Param1"], "Eita#$%Nois##", true);

            if (Request.QueryString["Param6"] == "home")
            {
                if (DirecionaPagina == "2")
                    Response.Redirect("padraoPaciente.aspx?Param1=" + Request.QueryString["Param1"] + "&Param2=" + Request.QueryString["Param2"] + "&Param3=" + Request.QueryString["Param3"] + "&Param4=" + Request.QueryString["Param4"] + "&Param5=" + Request.QueryString["Param5"] + "&Param6=home");
                else if (DirecionaPagina == "3")
                    Response.Redirect("padraoEnfermagem.aspx?Param1=" + Request.QueryString["Param1"] + "&Param2=" + Request.QueryString["Param2"] + "&Param3=" + Request.QueryString["Param3"] + "&Param4=" + Request.QueryString["Param4"] + "&Param5=" + Request.QueryString["Param5"] + "&Param6=home");
                else if (DirecionaPagina == "4")
                    Response.Redirect("padraoMedico.aspx?Param1=" + Request.QueryString["Param1"] + "&Param2=" + Request.QueryString["Param2"] + "&Param3=" + Request.QueryString["Param3"] + "&Param4=" + Request.QueryString["Param4"] + "&Param5=" + Request.QueryString["Param5"] + "&Param6=home");
            }
            else if (Request.QueryString["Param6"] == "conta")
            {
                if (DirecionaPagina == "2")
                    Response.Redirect("padraoPaciente.aspx?Param1=" + Request.QueryString["Param1"] + "&Param2=" + Request.QueryString["Param2"] + "&Param3=" + Request.QueryString["Param3"] + "&Param4=" + Request.QueryString["Param4"] + "&Param5=" + Request.QueryString["Param5"] + "&Param6=conta");
                else if (DirecionaPagina == "3")
                    Response.Redirect("padraoEnfermagem.aspx?Param1=" + Request.QueryString["Param1"] + "&Param2=" + Request.QueryString["Param2"] + "&Param3=" + Request.QueryString["Param3"] + "&Param4=" + Request.QueryString["Param4"] + "&Param5=" + Request.QueryString["Param5"] + "&Param6=conta");
                else if (DirecionaPagina == "4")
                    Response.Redirect("padraoMedico.aspx?Param1=" + Request.QueryString["Param1"] + "&Param2=" + Request.QueryString["Param2"] + "&Param3=" + Request.QueryString["Param3"] + "&Param4=" + Request.QueryString["Param4"] + "&Param5=" + Request.QueryString["Param5"] + "&Param6=conta");
            }
        }
    }
}