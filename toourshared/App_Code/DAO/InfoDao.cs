﻿using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// InfoDao의 요약 설명입니다.
/// </summary>
public class InfoDao
{
    public InfoDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertInfoDao(Info info)
    {

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.info (inf_crd,inf_title,inf_content,cos_no,map_no) VALUES(@inf_crd,@inf_title,@inf_content,@cos_no,@map_no); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@inf_crd", info.Inf_crd);
        cmd.Parameters.AddWithValue("@inf_title", info.Inf_title);
        cmd.Parameters.AddWithValue("@inf_content", info.Inf_content);
        cmd.Parameters.AddWithValue("@cos_no",info.Cos_no);
        cmd.Parameters.AddWithValue("@map_no", info.Map_no);





        con.Open();

        cmd.ExecuteNonQuery();

        string result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectCircle()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select inf_no,inf_crd,inf_title,inf_content,cos_no,map_no  From toourshared.info";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Info selectinfoByinf_no(Info info)
    {

        MyDB mydb = new MyDB();

        Info result = new Info();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.circle where cir_no=@cir_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@inf_no", info.Inf_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Inf_no = rd["inf_no"].ToString();
                result.Inf_crd = rd["inf_crd"].ToString();
                result.Inf_title = rd["inf_title"].ToString();
                result.Inf_content = rd["inf_content"].ToString();
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