using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// VideoDao의 요약 설명입니다.
/// </summary>
public class VideoDao
{
    public VideoDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public int InsertVideo(Video video)
    {
        int result;
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.video (mem_id,vid_name,vid_caption)" +
                "VALUES (@mem_id, @vid_name, @vid_caption)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", video.Mem_id);
            cmd.Parameters.AddWithValue("@vid_name", video.Vid_name);
            cmd.Parameters.AddWithValue("@vid_caption", video.Vid_caption);
            



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