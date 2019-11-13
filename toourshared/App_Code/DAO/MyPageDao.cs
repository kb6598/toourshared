using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.DTO;
using tooushared.Lib;

/// <summary>
/// MyPageDao의 요약 설명입니다.
/// </summary>
public class MyPageDao
{
    public MyPageDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    //입력한 멤버의 팔로워들의 글을 가져옵니다.
    public int countMembersFollowersTravelt(Member member)
    {

        MyDB mydb = new MyDB();
        int result = 0;
        MySqlConnection con = null;
        



        try
        {
            con = mydb.GetCon();

            string Sql = "select count(travel.trv_no) as count"+
                           " from travel, follower"+
                           " where travel.mem_id = follower.fol_id AND follower.mem_id = @mem_id";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            while (rd.Read())
            {

                result = int.Parse(rd["count"].ToString());
               
                                                 

            }
            rd.Close();
            con.Close();

        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
            con.Close();
           
        }
        finally
        {
          
            con.Close();
        }
        return result;
    }

    public List<Travel> Test()
    {
        MyDB mydb = new MyDB();
        Travel result;
        List<Travel> resultList = new List<Travel>();
        MySqlConnection con = null;
        MySqlDataReader rd = null;

        try
        {
            con = mydb.GetCon();
            string Sql = "select travel.loc_name as loc_name, travel.mem_id as mem_id, travel.trv_create_time as trv_create_time," +
            " travel.trv_main_img as trv_main_img, travel.trv_no as trv_no, travel.trv_secret as trv_secret," +
            " travel.trv_tag as trv_tag, travel.trv_timestamp as trv_timestamp, travel.trv_title as trv_title," +
            " travel.trv_tot_rate as trv_tot_rate, travel.trv_views as trv_views" +
            " from travel, follower" +
            " where travel.mem_id = follower.fol_id AND follower.mem_id = 'milk9503'" +
            " order by travel.trv_create_time desc " +
            " limit 0, 12";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            rd = cmd.ExecuteReader();

            while (rd.Read())
            {
                result = new Travel();
                result.Trv_no = rd["trv_no"].ToString();
                result.Trv_secret = rd["trv_secret"].ToString();
                result.Trv_views = rd["trv_views"].ToString();
                result.Trv_tot_rate = rd["trv_tot_rate"].ToString();
                result.Trv_main_img = rd["trv_main_img"].ToString();
                result.Trv_title = rd["trv_title"].ToString();
                result.Trv_tag = rd["trv_tag"].ToString();
                result.Trv_timestamp = rd["trv_timestamp"].ToString();
                result.Trv_create_time = rd["trv_create_time"].ToString();
                result.Loc_name = rd["loc_name"].ToString();
                result.Mem_id = rd["mem_id"].ToString();

                resultList.Add(result);
            }

            rd.Close();
            con.Close();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            rd.Close();
            con.Close();

        }
        finally
        {
            rd.Close();
            con.Close();
        }
        return resultList;
    }

    public List<Travel> selectMembersFollowersTravelLimitOrderByTimestampLimit(Member member,int start, int count)
    {

        MyDB mydb = new MyDB();
        Travel result;
        List<Travel> resultList = new List<Travel>();
        MySqlConnection con = null;
        MySqlDataReader rd = null;

        try
        {
            con = mydb.GetCon();

            string Sql = "select travel.loc_name as loc_name, travel.mem_id as mem_id, travel.trv_create_time as trv_create_time,"+
            " travel.trv_main_img as trv_main_img, travel.trv_no as trv_no, travel.trv_secret as trv_secret,"+
            " travel.trv_tag as trv_tag, travel.trv_timestamp as trv_timestamp, travel.trv_title as trv_title,"+ 
            " travel.trv_tot_rate as trv_tot_rate, travel.trv_views as trv_views"+
            " from travel, follower"+
            " where travel.mem_id = follower.fol_id AND follower.mem_id = 'milk9503'"+
            " order by travel.trv_create_time desc "+
            " limit 0, 12";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);
            cmd.Parameters.AddWithValue("@start", start);
            cmd.Parameters.AddWithValue("@end", count);

            con.Open();
            rd = cmd.ExecuteReader();

            while (rd.Read())
            {

                result = new Travel();
                result.Trv_no = rd["trv_no"].ToString();
                result.Trv_secret = rd["trv_secret"].ToString();
                result.Trv_views = rd["trv_views"].ToString();
                result.Trv_tot_rate = rd["trv_tot_rate"].ToString();
                result.Trv_main_img = rd["trv_main_img"].ToString();
                result.Trv_title = rd["trv_title"].ToString();
                result.Trv_tag = rd["trv_tag"].ToString();
                result.Trv_timestamp = rd["trv_timestamp"].ToString();
                result.Trv_create_time = rd["trv_create_time"].ToString();
                result.Loc_name = rd["loc_name"].ToString();
                result.Mem_id = rd["mem_id"].ToString();


                //lstMember.Add(tmpMemberPointer);

                resultList.Add(result);

            }
            rd.Close();
            con.Close();

        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            rd.Close();
            con.Close();

        }
        finally
        {
            rd.Close();
            con.Close();
        }

        return resultList;
    }
}