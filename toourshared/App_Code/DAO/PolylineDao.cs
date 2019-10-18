using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// PolylineDao의 요약 설명입니다.
/// </summary>
public class PolylineDao
{
    public PolylineDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertPolyline(Polyline polyline)
    {

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.polyline (pol_lin_crd,pol_lin_title,pol_lin_content,cos_no,map_no) VALUES(@pol_lin_crd,@pol_lin_title,@pol_lin_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@pol_lin_crd", polyline.Pol_lin_crd);
        cmd.Parameters.AddWithValue("@pol_lin_title", polyline.Pol_lin_title);
        cmd.Parameters.AddWithValue("@pol_lin_content", polyline.Pol_lin_content);
        cmd.Parameters.AddWithValue("@cos_no", polyline.Pol_lin_content);
        cmd.Parameters.AddWithValue("@map_no", polyline.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", polyline.Map_no);



        con.Open();

        cmd.ExecuteNonQuery();

        string result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)


}