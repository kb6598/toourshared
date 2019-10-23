using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectCost_type()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select cos_ele_type  From toourshared.cost_type";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Cost_Type selectCos_typeByCos_ele_type(Cost_Type cost_Type)
    {

        MyDB mydb = new MyDB();

        Cost_Type result = new Cost_Type();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.cost_type where cos_ele_type=@cos_ele_type";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@cos_ele_type", cost_Type.Cos_ele_type);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Cos_ele_type = rd["cos_ele_type"].ToString();
                


                //lstMember.Add(tmpMemberPointer);

                return result;

            }

            con.Close();

        }
        catch (Exception ex)
        {
            Console.Write(ex.ToString());
        }
        return result;
    }

}
