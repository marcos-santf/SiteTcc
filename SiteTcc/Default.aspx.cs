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
            if (Request.QueryString["Param1"] != null)
            {
                if (Request.QueryString["Param6"] != null)
                {
                    DirecionaMenu();
                }
                else
                {
                    string Param1 = string.Empty;
                    Param1 = clsCriptografia.Encrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

                    ValidaDadosBanco(Request.QueryString["Param1"], Param1);
                }
            }
        }

        private void ValidaDadosBanco(string cpf, string senha)
        {
            string Param1 = string.Empty;
            string Param2 = string.Empty;
            string Param3 = string.Empty;
            string Param4 = string.Empty;
            string DirecionaPagina = string.Empty;
            string ts = string.Empty;
            try
            {
                DataSet ds = clsValidaDados.ValidaDados(cpf, senha);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Param1 = clsCriptografia.Encrypt(Convert.ToInt32(ds.Tables[0].Rows[0]["cd_perfil"]).ToString(), "Eita#$%Nois##", true);
                    Param2 = clsCriptografia.Encrypt(Convert.ToInt32(ds.Tables[0].Rows[0]["cd_usuario"]).ToString(), "Eita#$%Nois##", true);
                    Param3 = clsCriptografia.Encrypt("designer", "Eita#$%Nois##", true);
                    Param4 = clsCriptografia.Encrypt(cpf, "Eita#$%Nois##", true);

                    DirecionaPagina = Convert.ToInt32(ds.Tables[0].Rows[0]["cd_perfil"]).ToString();
                }
                else
                {
                    clsValidaDados validaDados = new clsValidaDados();
                    validaDados.ClientMessage(this, "CPF e Senha incorretos.");
                }
            }
            catch (Exception ex)
            {
                clsValidaDados validaDados = new clsValidaDados();
                validaDados.ClientMessage(this, "CPF e Senha incorretos.");

                Response.Redirect("padraoLogin.aspx?P=" + "1");
            }

            ts = clsCriptografia.Encrypt(Param2, "Eita#$%Nois##", true);

            if (DirecionaPagina == "2")
                Response.Redirect("padraoPaciente.aspx?Param1=" + Param1 + "&Param2=" + Param2 + "&Param3=" + Param3 + "&Param4=" + Param4 + "&Param5=" + DirecionaPagina + "&Param6=home");
            else if (DirecionaPagina == "3")
                Response.Redirect("padraoEnfermagem.aspx?Param1=" + Param1 + "&Param2=" + Param2 + "&Param3=" + Param3 + "&Param4=" + Param4 + "&Param5=" + DirecionaPagina + "&Param6=home");
            else if (DirecionaPagina == "4")
                Response.Redirect("padraoMedico.aspx?Param1=" + Param1 + "&Param2=" + Param2 + "&Param3=" + Param3 + "&Param4=" + Param4 + "&Param5=" + DirecionaPagina + "&Param6=home");
        }

        private void DirecionaMenu()
        {
            string DirecionaPagina = string.Empty;

            DirecionaPagina = Request.QueryString["Param5"];

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