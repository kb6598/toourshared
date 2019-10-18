using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// Travel_DayDao의 요약 설명입니다.
/// </summary>
public class Travel_DayDao
{
    public Travel_DayDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertTravel_Day(Travel_Day travel_day)
    {
        string result = "";
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.travel_day (trv_day_content,trv_no)" +
                "VALUES (@trv_day_content,@trv_no)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_day_content", travel_day.Trv_day_content);
            cmd.Parameters.AddWithValue("@trv_no", travel_day.Trv_no);
          



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