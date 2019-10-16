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


    public void InsertComment(Comment comment)
    {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.comment (trv_no, cmt_content, mem_id ,cmt_rate, cmt_timestamp) VALUES(@trv_no, @cmt_content, @mem_id ,@cmt_rate, @cmt_timestamp)";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_no", comment.Trv_no);
            cmd.Parameters.AddWithValue("@cmt_content", comment.Cmt_content);
            cmd.Parameters.AddWithValue("@cmt_rate", comment.Cmt_rate);
            cmd.Parameters.AddWithValue("@mem_id", comment.Mem_id);
            cmd.Parameters.AddWithValue("@cmt_timestamp", comment.Cmt_timestamp);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

    }


}