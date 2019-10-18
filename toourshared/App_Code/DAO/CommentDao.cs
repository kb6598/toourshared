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
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.comment (trv_no, cmt_content, cmt_rate, cmt_timestamp) VALUES(@trv_no, @cmt_content, @cmt_rate, @cmt_timestamp); select last_insert_id()";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_no", comment.Trv_no);
            cmd.Parameters.AddWithValue("@cmt_content", comment.Cmt_content);
            cmd.Parameters.AddWithValue("@cmt_rate", comment.Cmt_rate);
            cmd.Parameters.AddWithValue("@cmt_timestamp", comment.Cmt_timestamp);

            con.Open();

            result = cmd.ExecuteNonQuery();

            con.Close();


        return result;
    }   
    //public void DeleteCommentBy(mem_id)

    public string select_last(Comment com)
    {
        string cmt_no = "";

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();


        string Sql = "select last_insert_id() as last_pk";
        MySqlCommand cmd = new MySqlCommand(Sql, con);
        con.Open();
        MySqlDataReader reader = cmd.ExecuteReader();
        if (reader.Read())
        {
            cmt_no = reader["last_pk"].ToString();

            reader.Close();
            con.Close();

            return cmt_no;
        }
        else
        {
            cmt_no = null;

            return cmt_no;

        }

        return cmt_no;
        

    }
}