using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using System.Web.Services.Description;

namespace SiteTCC.Classes
{
    public class clsValidaDados
    {
        public static DataSet ValidaDados(string cpf, string senha)
        {
            DataSet dataSet = new DataSet();

            try
            {
                // Chama a stored procedure para inserir os dados no banco de dados
                using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MODELOConnectionString"].ConnectionString))
                {
                    // Abre a conexão
                    connection.Open();

                    // Criar o comando para a stored procedure
                    using (SqlCommand cmd = new SqlCommand("pr_valida_acesso", connection))
                    {
                        try
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@ds_cpf", cpf);
                            cmd.Parameters.AddWithValue("@ds_senha", senha);

                            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                            {
                                adapter.Fill(dataSet);
                            }

                            // Retorne o dataSet após o preenchimento bem-sucedido
                            return dataSet;
                        }
                        catch (Exception ex)
                        {
                            // Trate a exceção, se necessário
                            throw new Exception(ex.Message);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Trate a exceção, se necessário
                throw new Exception(ex.Message);
            }
        }

        public void ClientMessage(Control control, string strMessage)
        {
            System.Text.StringBuilder s = new System.Text.StringBuilder();
            s.Append("\n<SCRIPT LANGUAGE='JavaScript'>\n");
            s.Append("	alert('" + strMessage.Replace("'", "") + "');\n");
            s.Append("</SCRIPT>");
            control.Page.ClientScript.RegisterClientScriptBlock(typeof(clsValidaDados), "ShowMessage", s.ToString());
        }

    }
}