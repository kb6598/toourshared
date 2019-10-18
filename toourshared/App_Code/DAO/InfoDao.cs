using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// InfoDao의 요약 설명입니다.
/// </summary>
public class InfoDao
{
    public InfoDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertInfoDao(Info info)
    {

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.info (inf_crd,inf_title,inf_content,cos_no,map_no) VALUES(@inf_crd,@inf_title,@inf_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@inf_crd", info.Inf_crd);
        cmd.Parameters.AddWithValue("@inf_title", info.Inf_title);
        cmd.Parameters.AddWithValue("@inf_content", info.Inf_content);
        cmd.Parameters.AddWithValue("@cos_no",info.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", info.Map_no);





        con.Open();

        cmd.ExecuteNonQuery();

        string result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
}