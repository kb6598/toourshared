using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// MarkerDao의 요약 설명입니다.
/// </summary>
public class MarkerDao
{
    public MarkerDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertMarker(Marker marker)
    {

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.marker (mar_crd,mar_title,mar_content,cos_no,map_no) VALUES(@mar_crd,@mar_title,@mar_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@mar_crd", marker.Mar_crd);
        cmd.Parameters.AddWithValue("@mar_title", marker.Mar_title);
        cmd.Parameters.AddWithValue("@mar_content", marker.Mar_content);
        cmd.Parameters.AddWithValue("@cos_no", marker.Cos_no);
        cmd.Parameters.AddWithValue("@map_no",marker.Map_no);





        con.Open();

        cmd.ExecuteNonQuery();

        string result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
}