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
    public partial class padraoAgenda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Criar um exemplo de DataTable com dados de exemplo
                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("ID", typeof(int));
                dataTable.Columns.Add("Nome", typeof(string));
                dataTable.Rows.Add(1, "João");
                dataTable.Rows.Add(2, "Maria");
                dataTable.Rows.Add(3, "Pedro");

                // Configurar a fonte de dados do GridView
                gridView.DataSource = dataTable;
                gridView.DataBind();
            }

        }
    }
}