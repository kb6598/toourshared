using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using MySql.Data.MySqlClient;
using System.Data;
using tooushared.Lib;
using tooushared.DTO;

/// <summary>
/// TravelDao의 요약 설명입니다.
/// </summary>
public class TravelDao
{
    public TravelDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public int InsertTravel (Travel travel)
    {
        int result;
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.travel (trv_secret, trv_views, trv_tot_rate, trv_main_img, trv_title, trv_tag, trv_timestamp, trv_create_time, loc_name, mem_id)" +
                "VALUES (@trv_secret, @trv_views, @trv_tot_rate, @trv_main_img, @trv_title, @trv_tag, @trv_timestamp, @trv_create_time, @loc_name,@mem_id)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_secret", travel.Trv_secret);
            cmd.Parameters.AddWithValue("@trv_views", travel.Trv_views);
            cmd.Parameters.AddWithValue("@trv_tot_rate", travel.Trv_tot_rate);
            cmd.Parameters.AddWithValue("@trv_main_img", travel.Trv_main_img);
            cmd.Parameters.AddWithValue("@trv_title", travel.Trv_title);
            cmd.Parameters.AddWithValue("@trv_tag", travel.Trv_tag);



            con.Open();


            con.Close();

            result = cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            Console.WriteLine(e.StackTrace);
            result = -1;
        }

        return result;
    }
}