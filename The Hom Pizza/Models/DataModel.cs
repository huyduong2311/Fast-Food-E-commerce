using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace The_Hom_Pizza.Models
{
    public class DataModel
    {
        //public static string connectionString = "Server=(local);Database=TheHomePizza2;Trusted_Connection=True";
        public static string connectionString = "Data Source=PizzaSQL2.mssql.somee.com;Initial Catalog=PizzaSQL2;User ID=huynl_SQLLogin_1;Password=Qc_huy231103;TrustServerCertificate=True;";

        public string xulydulieu(string text)
        {
            String s = text.Replace(",", "&44;");
            s = s.Replace("\"", "&34;");
            s = s.Replace("'", "&39;");
            return s;
        }
        public ArrayList get(String sql)
        {
            ArrayList datalist = new ArrayList();
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand command = new SqlCommand(sql, connection);

            connection.Open();

            using (SqlDataReader r = command.ExecuteReader())
            {
                while (r.Read())
                {
                    ArrayList row = new ArrayList();
                    for (int i = 0; i < r.FieldCount; i++)
                    {
                        row.Add(xulydulieu(r.GetValue(i).ToString()));
                    }
                    datalist.Add(row);
                }
            }
            connection.Close();
            return datalist;
        }
    }
}