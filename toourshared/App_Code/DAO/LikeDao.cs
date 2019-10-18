using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// LikeDao의 요약 설명입니다.
/// </summary>
public class LikeDao
{
    public LikeDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertLike(Like like)
    {

        string result = "";
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.like (mem_id,like_type,trv_no) VALUES(@mem_id,@like_type,@trv_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@mem_id", like.Mem_id);
        cmd.Parameters.AddWithValue("@like_type",like.Like_type);
        cmd.Parameters.AddWithValue("@trv_no", like.Trv_no);


        con.Open();

        cmd.ExecuteNonQuery();

        result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
}