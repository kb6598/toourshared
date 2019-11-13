using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
    public string InsertVideo(Video video)
    {
        string result = "";
        MySqlConnection con = null;
        try
        {
            MyDB myDB = new MyDB();
            con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.video (mem_id,vid_name,vid_caption)" +
                "VALUES (@mem_id, @vid_name, @vid_caption)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", video.Mem_id);
            cmd.Parameters.AddWithValue("@vid_name", video.Vid_name);
            cmd.Parameters.AddWithValue("@vid_caption", video.Vid_caption);
            



            con.Open();

            cmd.ExecuteNonQuery();

             result = cmd.LastInsertedId.ToString();
            con.Close();

            

        }
        catch (Exception e)
        {
            Console.WriteLine(e.StackTrace);
            con.Close();
        }
        finally
        {
            con.Close();
        }
        return result;
    }
    public DataSet SelectVideo()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();
        DataSet ds = null;
        try { 
        string sql = "Select vid_no, mem_id, vid_name, vid_caption  From toourshared.video";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
       
        ad.Fill(ds);
    }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            con.Close();

        }
        finally
        {
            con.Close();
        }
        return ds;
    }

    public Video selectVideoByvid_no(Video video)
    {

        MyDB mydb = new MyDB();

        Video result = new Video();
        MySqlConnection con = null;
        MySqlDataReader rd = null;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.video where vid_no=@vid_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@vid_no", video.Vid_no);

            con.Open();
            rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Vid_no = rd["vid_no"].ToString();
                result.Mem_id = rd["mem_id"].ToString();
                result.Vid_name = rd["vid_name"].ToString();
                result.Vid_caption = rd["vid_caption"].ToString();




                //lstMember.Add(tmpMemberPointer);

                return result;

            }
            rd.Close();
            con.Close();

        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            rd.Close();
            con.Close();

        }

        finally
        {
            rd.Close();
            con.Close();
        }
        return result;
    }
}