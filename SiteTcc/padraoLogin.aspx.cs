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
            if (cpf.Value != "" && password.Value != "")
            {
                string Param1 = string.Empty;
                Param1 = clsCriptografia.Encrypt(password.Value, "Eita#$%Nois##", true);

                ValidaDadosBanco(cpf.Value, Param1);
            }
        }

        private void ValidaDadosBanco(string cpf, string senha)
        {
            string Param1 = string.Empty;
            string Param2 = string.Empty;
            string Param3 = string.Empty;
            string Param4 = string.Empty;
            string DirecionaPagina = string.Empty;
            string CodigoUsuario = string.Empty;
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
                    CodigoUsuario = Convert.ToInt32(ds.Tables[0].Rows[0]["cd_usuario"]).ToString();
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
                return;
            }

            if (DirecionaPagina == "2")
                Response.Redirect("padraoPaciente.aspx?Param1=" + Param1 + "&Param2=" + Param2 + "&Param3=" + Param3 + "&Param4=" + Param4 + "&Param5=" + CodigoUsuario + "&Param6=home");
            else if (DirecionaPagina == "3")
                Response.Redirect("padraoEnfermagem.aspx?Param1=" + Param1 + "&Param2=" + Param2 + "&Param3=" + Param3 + "&Param4=" + Param4 + "&Param5=" + CodigoUsuario + "&Param6=home");
            else if (DirecionaPagina == "4")
                Response.Redirect("padraoMedico.aspx?Param1=" + Param1 + "&Param2=" + Param2 + "&Param3=" + Param3 + "&Param4=" + Param4 + "&Param5=" + CodigoUsuario + "&Param6=home");
        }
    }
}