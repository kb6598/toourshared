using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using MySql.Data.MySqlClient;
using System.Data;
using tooushared.Lib;
using tooushared.DTO;


/// <summary>
/// CommentDao의 요약 설명입니다.
/// </summary>
public class CommentDao
{
    public CommentDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }


    public int InsertComment(Comment comment)
    {
        int result;
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.comment (trv_no, cmt_content, cmt_rate, cmt_timestamp) VALUES(@trv_no, @cmt_content, @cmt_rate, @cmt_timestamp)";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_no", comment.Trv_no);
            cmd.Parameters.AddWithValue("@cmt_content", comment.Cmt_content);
            cmd.Parameters.AddWithValue("@cmt_rate", comment.Cmt_rate);
            cmd.Parameters.AddWithValue("@cmt_timestamp", comment.Cmt_timestamp);

            con.Open();


            con.Close();

            result = cmd.ExecuteNonQuery();

        }
        catch(Exception e)
        {
            Console.WriteLine(e.StackTrace);
            result = -1;
        }

        return result;
    }
    public void DeleteCommentByCom_idMem_id(mem_id)
}