using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// RectangleDao의 요약 설명입니다.
/// </summary>
public class RectangleDao
{
    public RectangleDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertRectangle(Rectangle rectangle)
    {

        string result = "";
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.rectangle (rec_crd,rec_title,rec_content,cos_no,map_no) VALUES(@rec_crd,@rec_title,@rec_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@rec_crd", rectangle.Rec_crd);
        cmd.Parameters.AddWithValue("@rec_title",rectangle.Rec_title);
        cmd.Parameters.AddWithValue("@rec_content",rectangle.Rec_content);
        cmd.Parameters.AddWithValue("@cos_no", rectangle.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", rectangle.Map_no);

        con.Open();

        cmd.ExecuteNonQuery();

         result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
}