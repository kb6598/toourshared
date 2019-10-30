using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
    public DataSet SelectMarker()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select mar_no, mar_crd, mar_title, mar_content, cos_no, map_no  From toourshared.marker";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Marker selectMarkerBymar_no(Marker marker)
    {

        MyDB mydb = new MyDB();

        Marker result = new Marker();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.marker where marker=@mar_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mar_no", marker.Mar_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Mar_no = rd["mar_no"].ToString();
                result.Mar_crd = rd["mar_crd"].ToString();
                result.Mar_title = rd["mar_title"].ToString();
                result.Mar_content = rd["mar_content"].ToString();
                result.Cos_no = rd["cos_no"].ToString();
                result.Map_no = rd["map_no"].ToString();


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


