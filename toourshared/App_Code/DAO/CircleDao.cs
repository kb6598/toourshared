using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// CircleDao의 요약 설명입니다.
/// </summary>
public class CircleDao
{
    public CircleDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public int InsertCircle(Circle circle)
    {

        int result;
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.circle (cir_crd,cir_name,cir_content,cos_no,map_no) VALUES(@cir_crd,@cir_name,@cir_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@cir_crd", circle.Cir_crd);
        cmd.Parameters.AddWithValue("@cir_name",circle.Cir_name);
        cmd.Parameters.AddWithValue("@cir_content",circle.Cir_content);
        cmd.Parameters.AddWithValue("@cos_no", circle.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", circle.Map_no);

        con.Open();

        result = cmd.ExecuteNonQuery();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
}