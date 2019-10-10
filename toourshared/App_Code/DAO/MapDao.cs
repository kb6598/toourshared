using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

//DB 사용시 필요한 객체들
using System.Data;
using MySql.Data.MySqlClient;
using tooushared.App_Code.Lib;



/// <summary>
/// MapDao의 요약 설명입니다.
/// </summary>
public class MapDao
{

    public MapDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public Map SelectByTrv_day_no(string )
    {

        string Sql = "insert into toourshared.member(toourshared.member.mem_id,toourshared.member.mem_pw,toourshared.member.mem_name) values(@mem_id, @mem_pw, @mem_name)";
        Map result;
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();



            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@mem_id", );
            cmd.Parameters.AddWithValue("@mem_pw", );
            cmd.Parameters.AddWithValue("@mem_name", );

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            rd.Read();

            result = int.Parse(rd["count"].ToString());




            rd.Close();
            con.Close();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.StackTrace);
            //-1 이면 오류
            result = -1;
        }



        return result;
    }
    //public Map Select(Map map)
    //{
    //    Map result;
    //    string Sql = "select map.map_no, map.trv_no from map";
    //    try
    //    {





    //    }
    //    catch (Exception ex)
    //    {
    //        Console.WriteLine(ex.StackTrace);
    //        //-1 이면 오류

    //    }






    //    return result;
    //}
}