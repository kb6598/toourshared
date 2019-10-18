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


    public string InsertComment(Comment comment)
    {

            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.comment (trv_no, cmt_content, cmt_rate, cmt_timestamp) VALUES(@trv_no, @cmt_content, @cmt_rate, @cmt_timestamp); select last_insert_id()";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_no", comment.Trv_no);
            cmd.Parameters.AddWithValue("@cmt_content", comment.Cmt_content);
            cmd.Parameters.AddWithValue("@cmt_rate", comment.Cmt_rate);
            cmd.Parameters.AddWithValue("@cmt_timestamp", comment.Cmt_timestamp);

            con.Open();

            cmd.ExecuteNonQuery();

            string result = cmd.LastInsertedId.ToString();

            con.Close();


        return result;
    }   
    //public void DeleteCommentBy(mem_id)


    public int UpdateComment(Comment comment)
    {
        int result;

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "UPDATE toourshared.comment SET cmt_content=@cmt_content, cmt_rate=@cmt_rate, cmt_timestamp=@cmt_timestamp, mem_id=@mem_id where cmt_no=@cmt_no";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@cmt_content", comment.Cmt_content);
        cmd.Parameters.AddWithValue("@cmt_rate", comment.Cmt_rate);
        cmd.Parameters.AddWithValue("@cmt_timestamp", comment.Cmt_timestamp);
        cmd.Parameters.AddWithValue("@mem_id", comment.Mem_id);
        cmd.Parameters.AddWithValue("@cmt_no", comment.Cmt_no);

        con.Open();

        result = cmd.ExecuteNonQuery();


        con.Close();


        return result;
    }

    public int DeleteComment(Comment comment)
    {
        int result;

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "DELETE FROM toourshared.comment WHERE cmt_no=@cmt_no";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@cmt_no", comment.Cmt_no);

        con.Open();

        result = cmd.ExecuteNonQuery();

        con.Close();

        return result;

    }


    public DataSet SelectComment()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select cmt_no, cmt_content, cmt_rate, cmt_timestamp, mem_id  From toourshared.comment";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);
       

        return ds;
    }

    public Comment selectCommentByCmt_no(Comment comment)
    {

        MyDB mydb = new MyDB();

        Comment resultComment = new Comment();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.comment where cmt_no=@cmt_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@cmt_no", comment.Cmt_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                resultComment.Cmt_content = rd["cmt_content"].ToString();
                resultComment.Cmt_rate = rd["cmt_rate"].ToString();
                resultComment.Cmt_timestamp = rd["cmt_timestamp"].ToString();
                resultComment.Mem_id = rd["mem_id"].ToString();


                //lstMember.Add(tmpMemberPointer);

                return resultComment;

            }

            con.Close();

        }
        catch (Exception ex)
        {
            Console.Write(ex.ToString());
        }
        return resultComment;
    }

}