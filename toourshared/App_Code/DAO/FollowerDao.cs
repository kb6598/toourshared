using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// FollowerDao의 요약 설명입니다.
/// </summary>
public class FollowerDao
{
    public FollowerDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public int InsertFollower(Follower follower)
    {

        int result;
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.follower (mem_id,fol_id) VALUES(@mem_id,@fol_id); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@mem_id", follower.Mem_id);
        cmd.Parameters.AddWithValue("@fol_id", follower.Fol_id);
        


        con.Open();

        result = cmd.ExecuteNonQuery();

        con.Close();


        return result;
    }
}