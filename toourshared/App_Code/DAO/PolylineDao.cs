using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
    public DataSet SelectPolyline()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select pol_lin_no, pol_lin_crd, pol_lin_title, pol_lin_content,cos_no,map_no  From toourshared.polyline";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Polyline selectPolylineBypol_lin_no(Polyline polyline)
    {

        MyDB mydb = new MyDB();

        Polyline result = new Polyline();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.polyline where polyline=@pol_lin_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@pol_lin_no", polyline.Pol_lin_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Pol_lin_no = rd["pol_lin_no"].ToString();
                result.Pol_lin_crd = rd["pol_lin_crd"].ToString();
                result.Pol_lin_title = rd["pol_lin_title"].ToString();
                result.Pol_lin_content = rd["pol_lin_content"].ToString();
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