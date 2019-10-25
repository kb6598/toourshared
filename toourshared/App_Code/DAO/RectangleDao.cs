using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// RectangleDao의 요약 설명입니다.
/// </summary>
public class RectangleDao
{
    public RectangleDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertRectangle(Rectangle rectangle)
    {

        string result = "";
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.rectangle (rec_crd,rec_title,rec_content,cos_no,map_no) VALUES(@rec_crd,@rec_title,@rec_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@rec_crd", rectangle.Rec_crd);
        cmd.Parameters.AddWithValue("@rec_title",rectangle.Rec_title);
        cmd.Parameters.AddWithValue("@rec_content",rectangle.Rec_content);
        cmd.Parameters.AddWithValue("@cos_no", rectangle.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", rectangle.Map_no);

        con.Open();

        cmd.ExecuteNonQuery();

         result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectRectamgle()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select rec_no, rec_crd, rec_title, rec_content, cos_no, map_no  From toourshared.rectangle";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Rectangle selectRectangleByrec_no(Rectangle rectangle)
    {

        MyDB mydb = new MyDB();

        Rectangle result = new Rectangle();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.rectangle where rectamgle=@rec_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@rec_no", rectangle.Rec_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Rec_no = rd["rec_no"].ToString();
                result.Rec_crd = rd["rec_crd"].ToString();
                result.Rec_title = rd["rec_title"].ToString();
                result.Rec_content = rd["rec_content"].ToString();
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