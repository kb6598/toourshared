using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectImage()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select img_no,mem_id,img_view_name,img_caption  From toourshared.image";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Image selectImageByimg_no(Image image)
    {

        MyDB mydb = new MyDB();

        Image result = new Image();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.image where img_no =@img_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@img_no", image.Img_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Img_no = rd["img_no"].ToString();
                result.Mem_id = rd["mem_id"].ToString();
                result.Img_view_name = rd["img_view_name"].ToString();
                result.Img_caption = rd["img_caption"].ToString();
               


                //lstMember.Add(tmpMemberPointer);

                return result;

            }
            rd.Close();
            con.Close();

        }
        catch (Exception ex)
        {
            Console.Write(ex.ToString());
        }
        return result;
    }

}