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

        try
        {
            string Sql = "INSERT INTO toourshared.like (mem_id,like_type,trv_no) VALUES(@mem_id,@like_type,@trv_no); select last_insert_id()";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", like.Mem_id);
            cmd.Parameters.AddWithValue("@like_type", like.Like_type);
            cmd.Parameters.AddWithValue("@trv_no", like.Trv_no);


            con.Open();

            cmd.ExecuteNonQuery();

            result = cmd.LastInsertedId.ToString();


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

        return result;
    }
    //public void DeleteCommentBy(mem_id)

    public void DeleteLike(Like like)
    {
        MyDB mydb = new MyDB();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "DELETE FROM toourshared.like WHERE mem_id = @mem_id AND trv_no = @trv_no";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@mem_id", like.Mem_id);
            cmd.Parameters.AddWithValue("@trv_no", like.Trv_no);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch(Exception e){;}
    }
    public DataSet SelectLike()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();
        DataSet ds = null;

        try
        {
            string sql = "Select lik_no, lik_type,mem_id,trv_no  From toourshared.like";
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

    public int selectLikeCountByTrvNo(Like like)
    {
        MyDB mydb = new MyDB();
        int result = 0;
        MySqlConnection con = null;
        MySqlDataReader reader = null;
        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT COUNT(*) as cnt FROM toourshared.like Where trv_no = @trv_no";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@trv_no", like.Trv_no);

            con.Open();
            reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                result = int.Parse(reader["cnt"].ToString());
            }


        }
        catch (Exception e)
        {
            reader.Close();
            con.Close();
        }
        finally
        {
            reader.Close();
            con.Close();
        }

        return result;
    }

    public Like selectLikeBylik_no(Like like)
    {
        MyDB mydb = new MyDB();
        MySqlConnection con = null;
        MySqlDataReader rd = null;
        Like result = new Like();


        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.like where lik_no =@lik_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@lik_no", like.lik_no);

            con.Open();
            rd = cmd.ExecuteReader();

            if (rd.Read())
            {
                result.lik_no = rd["lik_no"].ToString();
                result.Like_type = rd["like_type"].ToString();
                result.Mem_id = rd["mem_id"].ToString();
                result.Trv_no = rd["trv_no"].ToString();

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

    public bool IsExistLikeTrvNoByMemID(Like like)
    {
        MyDB mydb = new MyDB();
        MySqlConnection con;
        int getCount = 0;

        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT count(*) as cnt FROM toourshared.like WHERE mem_id = @mem_id AND trv_no = @trv_no";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@mem_id", like.Mem_id);
            cmd.Parameters.AddWithValue("@trv_no", like.Trv_no);

            con.Open();
            MySqlDataReader reader = cmd.ExecuteReader();

            if(reader.Read())
            {
                getCount = int.Parse(reader["cnt"].ToString());
            }

            reader.Close();
            con.Close();
        }
        catch(Exception e){;}

        if (getCount > 0) // 존재할 시 1 이상일거고
            return true;
        else // 존재하지 않는 경우
            return false;
    }
}