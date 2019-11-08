using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using tooushared.DTO;
using tooushared.Lib;

/// <summary>
/// IndexDao의 요약 설명입니다.
/// </summary>
public class IndexDao
{
    public IndexDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public List<String> selectTravelDay(int trv_no)
    {
        int index = 0;
        List<String> returnList = new List<string>();
        string[] strCols = new string[] { "trv_day_no", "trv_day_content", "trv_no" };

        MyDB mydb = new MyDB();
        MySqlConnection con;
        try
        {
            con = mydb.GetCon();
            string Sql = "select * from travel_day where trv_no = " + trv_no;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                String trv_day_no = reader["trv_day_no"].ToString();
                String trv_day_content = reader["trv_day_content"].ToString();
                String trv_no2 = reader["trv_no"].ToString();
                returnList.Add(trv_day_no);
                returnList.Add(trv_day_content);
                returnList.Add(trv_no2);
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e)
        {
            Console.Write(e.StackTrace.ToString());
        }

        return returnList;
    }

    public string selectUserMainImage(String userID)
    {
        string returnStr = "";
        MyDB mydb = new MyDB();
        MySqlConnection con;
        try
        {
            con = mydb.GetCon();
            string Sql = "select mem_img_url from member where mem_id = " + userID;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            MySqlDataReader reader = cmd.ExecuteReader();

            while(reader.Read())
            {
                returnStr = reader["mem_img_url"].ToString();
            }

            reader.Close();
            con.Close();
        }
        catch(Exception e)
        {
            Console.Write(e.StackTrace.ToString());
        }

        return returnStr;
    }

    public List<Travel> selectOrderByTime()
    {
        MyDB mydb = new MyDB();
        Travel result;
        List<Travel> resultList = new List<Travel>();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "select * from toourshared.travel order by trv_create_time desc limit 0, 6";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            MySqlDataReader reader = cmd.ExecuteReader();

            while(reader.Read())
            {
                result = new Travel();
                result.Trv_no = reader["trv_no"].ToString();
                result.Trv_secret = reader["trv_secret"].ToString();
                result.Trv_views = reader["trv_views"].ToString();
                result.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                result.Trv_main_img = reader["trv_main_img"].ToString();
                result.Trv_title = reader["trv_title"].ToString();
                result.Trv_tag = reader["trv_tag"].ToString();
                result.Trv_timestamp = reader["trv_timestamp"].ToString();
                result.Trv_create_time = reader["trv_create_time"].ToString();
                result.Loc_name = reader["loc_name"].ToString();
                result.Mem_id = reader["mem_id"].ToString();
                resultList.Add(result);
            }

            reader.Close();
            con.Close();
        }
        catch(Exception e)
        {
            Console.Write(e.StackTrace.ToString());
        }

        return resultList;
    }
}