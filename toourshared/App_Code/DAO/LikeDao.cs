using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectLike()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select lik_no, lik_type,mem_id,trv_no  From toourshared.like";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Like selectLikeBylik_no(Like like)
    {

        MyDB mydb = new MyDB();

        Like result = new Like();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.like where lik_no =@lik_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@lik_no", like.lik_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.lik_no = rd["lik_no"].ToString();
                result.Like_type = rd["like_type"].ToString();
                result.Mem_id = rd["mem_id"].ToString();
                result.Trv_no = rd["trv_no"].ToString();
   


                //lstMember.Add(tmpMemberPointer);

                return result;

            }

            con.Close();

        }
        catch (Exception ex)
        {
            Console.Write(ex.ToString());
        }
        return result;
    }

}