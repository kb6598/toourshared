using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// PolygonDao의 요약 설명입니다.
/// </summary>
public class PolygonDao
{
    public PolygonDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertPolygon(Polygon polygon)
    {

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.polygon (pol_gon_crd,pol_gon_title,pol_gon_content,cos_no,map_no) VALUES(@pol_gon_crd,@pol_gon_title,@pol_gon_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@pol_gon_crd", polygon.Pol_gon_crd);
        cmd.Parameters.AddWithValue("@pol_gon_title", polygon.Pol_gon_title);
        cmd.Parameters.AddWithValue("@pol_gon_content", polygon.Pol_gon_content);
        cmd.Parameters.AddWithValue("@cos_no", polygon.Pol_gon_content);
        cmd.Parameters.AddWithValue("@map_no", polygon.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", polygon.Map_no);



        con.Open();

        cmd.ExecuteNonQuery();

        string result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
}