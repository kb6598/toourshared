﻿using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// Travel_DayDao의 요약 설명입니다.
/// </summary>
public class Travel_DayDao
{
    public Travel_DayDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertTravel_Day(Travel_Day travel_day)
    {
        string result = "";
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.travel_day (trv_day_content,trv_no)" +
                "VALUES (@trv_day_content,@trv_no)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_day_content", travel_day.Trv_day_content);
            cmd.Parameters.AddWithValue("@trv_no", travel_day.Trv_no);
          



            con.Open();
            cmd.ExecuteNonQuery();

            result = cmd.LastInsertedId.ToString();

            con.Close();



        }
        catch (Exception e)
        {
            Console.WriteLine(e.StackTrace);

        }

        return result;
    }
    public DataSet SelectTrvel_Day()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select trv_day_no, trv_day_content, trv_no  From toourshared.trvel_day";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Travel_Day selectTravelDayByTrvNo(Travel_Day travel_day)
    {
        MyDB mydb = new MyDB();
        Travel_Day result = new Travel_Day();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT * FROM toourshared.travel_day where trv_no = @trv_no";
            // 게시글 번호에 해당하는 데이터 긁어오는 SQL

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@trv_no", travel_day.Trv_no);

            con.Open();
            MySqlDataReader reader = cmd.ExecuteReader();

            while(reader.Read())
            {
                result.Trv_day_no = reader["trv_day_no"].ToString();
                result.Trv_day_content = reader["trv_day_content"].ToString();
                result.Trv_no = reader["trv_no"].ToString();
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e) {;}

        return result;
    }

    public Travel_Day selectTrvel_DayBytrv_day_no(Travel_Day travel_Day)
    {

        MyDB mydb = new MyDB();

        Travel_Day result = new Travel_Day();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.travel_day where travel=@trv_day_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_day_no", travel_Day.Trv_day_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.Read())
            {
                result.Trv_day_no = rd["trv_day_no"].ToString();
                result.Trv_day_content = rd["trv_day_content"].ToString();
                result.Trv_no = rd["trv_no"].ToString();
            }

            rd.Close();
            con.Close();
        }
        catch (Exception e) {;}

        return result;
    }

    public int UpdatetTravel_Day(Travel_Day travel_day)
    {
        int result;

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "UPDATE toourshared.travel_day SET trv_no =@trv_no, trv_day_content =@trv_day_content  WHERE Trv_day_no =@trv_day_no";

        MySqlCommand cmd = new MySqlCommand(Sql, con);


        cmd.Parameters.AddWithValue("@trv_no", travel_day.Trv_no);
        cmd.Parameters.AddWithValue("@trv_day_no", travel_day.Trv_day_no);
        cmd.Parameters.AddWithValue("@trv_day_content", travel_day.Trv_day_content);


        con.Open();

        result = cmd.ExecuteNonQuery();


        con.Close();


        return result;
    }

}