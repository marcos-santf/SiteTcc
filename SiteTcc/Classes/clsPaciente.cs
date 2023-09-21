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
    public class clsPaciente
    {
        public static DataSet RetornaDadosPaciente(int CodigoUsuario)
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
                    using (SqlCommand cmd = new SqlCommand("pr_retorna_dados_paciente", connection))
                    {
                        try
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@cd_usuario", CodigoUsuario);

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
    }
}