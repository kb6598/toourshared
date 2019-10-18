using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
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

    public int InsertEllopse(Ellipse ellipse)
    {

        int result;
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

        result = cmd.ExecuteNonQuery();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
}