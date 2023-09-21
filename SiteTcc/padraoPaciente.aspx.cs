using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using SiteTCC.Classes;
using Microsoft.IdentityModel.Tokens;
using System.Globalization;

namespace SiteTCC
{
    public partial class padraoPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["P"] != "1")
                CarregaControle();
            else
                pnAtendimento.Visible = false;
        }
        protected void submitButton_Click(object sender, EventArgs e)
        {
            string nomeCompleto = userName.Value; 
            string cpf = userCpf.Value;
            string dataNascimento = userDateOfBirth.Value;
            string responsavel = userResponsavel.Value;
            string telefone = userPhone.Value; 
            string email = userEmail.Value;
            string senha = userSenha.Value;
            string confirmaSenha = userConfSenha.Value;
        }
        private void CarregaControle()
        {
            string Param2 = string.Empty;
            int CodigoUsuario = int.MinValue;

            Param2 = clsCriptografia.Decrypt(Request.QueryString["Param2"], "Eita#$%Nois##", true);

            CodigoUsuario = Convert.ToInt32(Param2);

            DataSet ds = clsPaciente.RetornaDadosPaciente(CodigoUsuario);

            userName.Value = (string)ds.Tables[0].Rows[0]["ds_nome"];
            userCpf.Value = (string)ds.Tables[0].Rows[0]["ds_cpf"];
            userPhone.Value = (string)ds.Tables[0].Rows[0]["ds_telefone"];
            DateTime dataNascimento = (DateTime)ds.Tables[0].Rows[0]["dt_nascimento"];
            userDateOfBirth.Value = dataNascimento.ToString("dd/MM/yyyy");

            userName.Disabled = true;
            userCpf.Disabled = true;
            userPhone.Disabled = true;
            userDateOfBirth.Disabled = true;
        }
    }
}