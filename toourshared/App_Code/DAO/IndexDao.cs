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
        MySqlConnection con = null;
        MySqlDataReader rd = null;
        try
        {
            con = mydb.GetCon();
            string Sql = "select * from travel_day where trv_no = " + trv_no;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            rd = cmd.ExecuteReader();

            while (rd.Read())
            {
                String trv_day_no = rd["trv_day_no"].ToString();
                String trv_day_content = rd["trv_day_content"].ToString();
                String trv_no2 = rd["trv_no"].ToString();
                returnList.Add(trv_day_no);
                returnList.Add(trv_day_content);
                returnList.Add(trv_no2);
            }


        }
        catch (Exception e)
        {
            Console.Write(e.StackTrace.ToString());
            rd.Close();
            con.Close();
        }
        finally
        {
            rd.Close();
            con.Close();
        }
        return returnList;
    }

    public string selectUserMainImage(String userID)
    {
        string returnStr = "";
        MyDB mydb = new MyDB();
        MySqlConnection con = null;
        MySqlDataReader rd = null;
        try
        {
            con = mydb.GetCon();
            string Sql = "select mem_img_url from member where mem_id = " + userID;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            rd = cmd.ExecuteReader();

            while(rd.Read())
            {
                returnStr = reader["mem_img_url"].ToString();
            }


        }
        catch(Exception e)
        {
            Console.Write(e.StackTrace.ToString());
            rd.Close();
            con.Close();
        }
        finally
        {
            rd.Close();
            con.Close();
        }

        return returnStr;
    }

}