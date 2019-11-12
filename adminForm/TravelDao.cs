using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;


/// <summary>
/// TravelDao의 요약 설명입니다.
/// </summary>
public class TravelDao
{
    public TravelDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string InsertTravel(Travel travel)
    {
        string result = "";
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.travel (trv_secret, trv_views, trv_tot_rate, trv_main_img, trv_title, trv_tag, trv_create_time, loc_name, mem_id) " +
                "VALUES (@trv_secret, @trv_views, @trv_tot_rate, @trv_main_img, @trv_title, @trv_tag, @trv_create_time, @loc_name, @mem_id)";




            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_secret", travel.Trv_secret);
            cmd.Parameters.AddWithValue("@trv_views", travel.Trv_views);
            cmd.Parameters.AddWithValue("@trv_tot_rate", travel.Trv_tot_rate);
            cmd.Parameters.AddWithValue("@trv_main_img", travel.Trv_main_img);
            cmd.Parameters.AddWithValue("@trv_title", travel.Trv_title);
            cmd.Parameters.AddWithValue("@trv_tag", travel.Trv_tag);
            cmd.Parameters.AddWithValue("@loc_name", travel.Loc_name);
            cmd.Parameters.AddWithValue("@mem_id", travel.Mem_id);
            cmd.Parameters.AddWithValue("@trv_create_time", travel.Trv_create_time);



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
    public DataSet SelectTravel()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select trv_no, trv_secret, trv_views, trv_tot_rate, trv_main_img, trv_title, trv_tag," +
            "trv_timestamp, trv_create_time, loc_name,mem_id From toourshared.travel";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

 
    public Travel selectTravelBytrv_no(Travel travel)
    {

        MyDB mydb = new MyDB();

        Travel result = new Travel();
        MySqlConnection con;

        try
        {

            con = mydb.GetCon();

            string Sql = "SELECT trv_no, trv_secret, trv_views, trv_tot_rate, trv_main_img, trv_title, trv_tag, trv_timestamp, trv_create_time, loc_name, mem_id FROM toourshared.travel where trv_no=@trv_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_no", travel.Trv_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

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

                return result;

            }

            con.Close();


        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }



        return result;
    }

    public DataSet selectTravelByMem_id(Travel travel)
    {

        MyDB mydb = new MyDB();

        DataSet result = new DataSet();
        MySqlConnection con;

        con = mydb.GetCon();

        string Sql = "SELECT * FROM toourshared.travel where mem_id=@mem_id";


        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@mem_id", travel.Mem_id);

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public List<Travel> selectTravelListByMem_id(Travel travel)
    {
        MyDB mydb = new MyDB();

        List<Travel> resultList = new List<Travel>();
        Travel result;
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.travel where mem_id=@mem_id";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", travel.Mem_id);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

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

            con.Close();


        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }
        return resultList;
    }

    public int UpdatetTravel(Travel travel)
    {
        int result;

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "UPDATE toourshared.travel SET trv_secret =@trv_secret, trv_views =@trv_views, trv_tot_rate =@trv_tot_rate, trv_main_img =@trv_main_img, trv_title =@trv_title, trv_tag =@trv_tag, trv_timestamp =@trv_timestamp, trv_create_time =@trv_create_time, loc_name =@loc_name, mem_id =@mem_id  WHERE trv_no =@trv_no"; 

        MySqlCommand cmd = new MySqlCommand(Sql, con);
                cmd.Parameters.AddWithValue("@trv_no", travel.Trv_no);


        cmd.Parameters.AddWithValue("@loc_name", travel.Loc_name);
        cmd.Parameters.AddWithValue("@mem_id", travel.Mem_id);
        cmd.Parameters.AddWithValue("@trv_create_time", travel.Trv_create_time);
        cmd.Parameters.AddWithValue("@trv_main_img", travel.Trv_main_img);

        cmd.Parameters.AddWithValue("@trv_secret", travel.Trv_secret);
        cmd.Parameters.AddWithValue("@trv_tag", travel.Trv_tag);
        cmd.Parameters.AddWithValue("@trv_timestamp", travel.Trv_timestamp);
        cmd.Parameters.AddWithValue("@trv_title", travel.Trv_title);
        cmd.Parameters.AddWithValue("@trv_tot_rate", travel.Trv_tot_rate);
        cmd.Parameters.AddWithValue("@trv_views", travel.Trv_views);

        con.Open();

        result = cmd.ExecuteNonQuery();

        con.Close();

        return result;
    }

}