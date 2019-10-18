using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// Cost_TypeDao의 요약 설명입니다.
/// </summary>
public class Cost_TypeDao
{
    public Cost_TypeDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertCost_type(Cost_Type cost_Type)
    {
        string result = "";
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.cost_type (cos_no,cos_ele_type,cos_ele_cost,cos_ele_info)" +
                "VALUES (@cos_no,@cos_ele_type,@cos_ele_cost,@cos_ele_info)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@cos_ele_no", cost_Type.Cos_ele_type);
           




            con.Open();
            cmd.ExecuteNonQuery();

            result = cmd.LastInsertedId.ToString();

            con.Close();



        }
        catch (Exception e)
        {
            Console.WriteLine(e.StackTrace);

        }

        return result;
    }
}
