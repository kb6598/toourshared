using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// Cost_elementDao의 요약 설명입니다.
/// </summary>
public class Cost_elementDao
{
    public Cost_elementDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertCost_element(Cost_Element cost_Element)
    {
        string result = "";
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.cost_element (cos_no,cos_ele_type,cos_ele_cost,cos_ele_info)" +
                "VALUES (@cos_no,@cos_ele_type,@cos_ele_cost,@cos_ele_info)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@cos_no", cost_Element.Cos_no);
            cmd.Parameters.AddWithValue("@cos_ele_type", cost_Element.Cos_ele_cost);
            cmd.Parameters.AddWithValue("@cos_ele_cost",cost_Element.Cos_ele_cost);
            cmd.Parameters.AddWithValue("@cos_ele_info",cost_Element.Cos_ele_info);




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