using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// EllipseDao의 요약 설명입니다.
/// </summary>
public class EllipseDao
{
    public EllipseDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string InsertEllopse(Ellipse ellipse)
    {

        
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.ellipse (ell_crd,ell_title,ell_content,cos_no,map_no) VALUES(@ell_crd,@ell_title,@ell_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@ell_crd", ellipse.Ell_crd);
        cmd.Parameters.AddWithValue("@ell_title", ellipse.Ell_title);
        cmd.Parameters.AddWithValue("@ell_content", ellipse.Ell_content);
        cmd.Parameters.AddWithValue("@cos_no", ellipse.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", ellipse.Map_no);

        con.Open();

        cmd.ExecuteNonQuery();

        string result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectEllipse()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select ell_no,ell_crd,ell_title,ell_content,cos_no,map_no  From toourshared.ellipse";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Ellipse selectEllipseByell_no(Ellipse ellipse)
    {

        MyDB mydb = new MyDB();

        Ellipse result = new Ellipse();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.ellipse where ell_no =@ell_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@ell_no", ellipse.Ell_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Ell_no = rd["ell_no"].ToString();
                result.Ell_crd = rd["ell_crd"].ToString();
                result.Ell_title = rd["ell_title"].ToString();
                result.Ell_content = rd["ell_content"].ToString();
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