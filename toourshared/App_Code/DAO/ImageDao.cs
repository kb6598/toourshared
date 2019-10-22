using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// ImageDao의 요약 설명입니다.
/// </summary>
public class ImageDao
{
    public ImageDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public int InsertImage(Image image)
    {
        int result;
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.image (mem_id,img_view_name,image_caption)" +
                "VALUES (@mem_id, @img_view_name, @img_caption)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", image.Mem_id);
            cmd.Parameters.AddWithValue("@img_view_name", image.Img_view_name);
            cmd.Parameters.AddWithValue("@img_caption", image.Img_caption);




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