using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
    public DataSet SelectPolygon()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select pol_gon_no, pol_gon_crd, pol_gon_title, pol_gon_content,cos_no,map_no  From toourshared.polygon";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Polygon selectPolygonBypol_gon_no(Polygon polygon)
    {

        MyDB mydb = new MyDB();

        Polygon result = new Polygon();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.polygon where polygon=@pol_gon_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@pol_gon_no", polygon.Pol_gon_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Pol_gon_no = rd["pol_gon_no"].ToString();
                result.Pol_gon_crd = rd["pol_gon_crd"].ToString();
                result.Pol_gon_title = rd["pol_gon_title"].ToString();
                result.Pol_gon_content = rd["pol_gon_content"].ToString();
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