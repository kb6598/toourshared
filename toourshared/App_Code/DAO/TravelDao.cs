using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using MySql.Data.MySqlClient;
using System.Data;
using tooushared.Lib;
using tooushared.DTO;

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

            string Sql = "SELECT trv_no, trv_secret, trv_views, trv_tot_rate, trv_main_img, trv_title, trv_tag, trv_timestamp, trv_create_time, loc_name, mem_id FROM toourshared.travel where trv_no=@trv_no and trv_tot_rate is not null";


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
            }

            rd.Close();
            con.Close();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }



        return result;
    }

    public int countTravelBytrv_no(Travel travel)
    {

        MyDB mydb = new MyDB();

        int result = 0;
        MySqlConnection con;

        try
        {

            con = mydb.GetCon();

            string Sql = "SELECT count(trv_no) as count FROM toourshared.travel where mem_id=@mem_id";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_no", travel.Trv_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result = int.Parse(rd["count"].ToString());


                //lstMember.Add(tmpMemberPointer);
            }

            rd.Close();
            con.Close();
            return result;


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

    public Travel selectTravelByMemID(Travel travel)
    {
        if(string.IsNullOrEmpty(travel.Mem_id.ToString())) // DTO 내 Mem_id 에 데이터가 Null OR Empty 인 경우 null 반환
        {
            return null;
        }

        MyDB mydb = new MyDB();
        Travel result = new Travel();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT * FROM toourshared.travel WHERE mem_id = '" + travel.Mem_id.ToString() + "'";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if(rd.Read())
            {
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
            }

            rd.Close();
            con.Close();
        }
        catch (Exception ex){;}

        return result;
    }

    public List<Travel> selectTravelListByMem_id(Travel travel, int limit1 = -1, int limit2 = -1)
    {
        MyDB mydb = new MyDB();

        List<Travel> resultList = new List<Travel>();
        Travel result;
        MySqlConnection con;
        string Sql = "";

        try
        {
            con = mydb.GetCon();
            if (limit1 != -1 && limit2 != -1)
                Sql = "SELECT * FROM toourshared.travel WHERE mem_id = @mem_id ORDER BY trv_create_time DESC LIMIT " + limit1 + ", " + limit2;
            else
                Sql = "SELECT * FROM toourshared.travel WHERE mem_id = @mem_id";


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

            rd.Close();
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

        cmd.Parameters.AddWithValue("@loc_name", travel.Loc_name);
        cmd.Parameters.AddWithValue("@mem_id", travel.Mem_id);
        cmd.Parameters.AddWithValue("@trv_create_time", travel.Trv_create_time);
        cmd.Parameters.AddWithValue("@trv_main_img", travel.Trv_main_img);
        cmd.Parameters.AddWithValue("@trv_no", travel.Trv_no);
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

    public List<Travel> getIndexTravelOrderByCreateTimeDesc(string locName = "")
    {
        MyDB mydb = new MyDB();
        Travel travel;
        List<Travel> returnList = new List<Travel>();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "";

            if (string.IsNullOrEmpty(locName) || locName == "")
            {
                Sql = "SELECT * FROM toourshared.travel ORDER BY trv_create_time DESC limit 0, 6";
            }
            else
            {
                Sql = "SELECT * FROM toourshared.travel WHERE loc_name like '%" + locName + "%' ORDER BY trv_create_time DESC limit 0, 6";
            }

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                travel = new Travel();
                travel.Trv_no = reader["trv_no"].ToString();
                travel.Trv_secret = reader["trv_secret"].ToString();
                travel.Trv_views = reader["trv_views"].ToString();
                travel.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                travel.Trv_main_img = reader["trv_main_img"].ToString();
                travel.Trv_title = reader["trv_title"].ToString();
                travel.Trv_tag = reader["trv_tag"].ToString();
                travel.Trv_timestamp = reader["trv_timestamp"].ToString();
                travel.Trv_create_time = reader["trv_create_time"].ToString();
                travel.Loc_name = reader["loc_name"].ToString();
                travel.Mem_id = reader["mem_id"].ToString();

                returnList.Add(travel);
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e) {; }

        return returnList;
    }

    public List<Travel> getIndexTravelOrderByTotRateDesc(string locName = "")
    {
        MyDB mydb = new MyDB();
        Travel travel;
        List<Travel> returnList = new List<Travel>();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "";

            if (string.IsNullOrEmpty(locName) || locName == "")
            {
                Sql = "SELECT * FROM toourshared.travel ORDER BY trv_tot_rate DESC limit 0, 6";
            }
            else
            {
                Sql = "SELECT * FROM toourshared.travel WHERE loc_name like '%" + locName + "%' ORDER BY trv_tot_rate DESC limit 0, 6";
            }

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                travel = new Travel();
                travel.Trv_no = reader["trv_no"].ToString();
                travel.Trv_secret = reader["trv_secret"].ToString();
                travel.Trv_views = reader["trv_views"].ToString();
                travel.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                travel.Trv_main_img = reader["trv_main_img"].ToString();
                travel.Trv_title = reader["trv_title"].ToString();
                travel.Trv_tag = reader["trv_tag"].ToString();
                travel.Trv_timestamp = reader["trv_timestamp"].ToString();
                travel.Trv_create_time = reader["trv_create_time"].ToString();
                travel.Loc_name = reader["loc_name"].ToString();
                travel.Mem_id = reader["mem_id"].ToString();

                returnList.Add(travel);
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e) {; }

        return returnList;
    }

    public List<Travel> getIndexTravelOrderByFollowerDesc(string locName = "")
    {
        MyDB mydb = new MyDB();
        Travel travel;
        List<Travel> returnList = new List<Travel>();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "";

            if (string.IsNullOrEmpty(locName) || locName == "")
            {
                Sql = "SELECT *, count(distinct(`follower`.`fol_id`)) as followers FROM toourshared.travel, toourshared.follower as follower WHERE travel.mem_id = follower.mem_id GROUP BY travel.trv_no ORDER BY trv_create_time DESC, followers DESC LIMIT 0, 6";
            }
            else
            {
                Sql = "SELECT *, count(distinct(`follower`.`fol_id`)) as followers FROM toourshared.travel, toourshared.follower as follower WHERE travel.mem_id = follower.mem_id AND travel.loc_name = '%" + locName + "%' GROUP BY travel.trv_no ORDER BY trv_create_time DESC, followers DESC LIMIT 0, 6";
            }

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                travel = new Travel();
                travel.Trv_no = reader["trv_no"].ToString();
                travel.Trv_secret = reader["trv_secret"].ToString();
                travel.Trv_views = reader["trv_views"].ToString();
                travel.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                travel.Trv_main_img = reader["trv_main_img"].ToString();
                travel.Trv_title = reader["trv_title"].ToString();
                travel.Trv_tag = reader["trv_tag"].ToString();
                travel.Trv_timestamp = reader["trv_timestamp"].ToString();
                travel.Trv_create_time = reader["trv_create_time"].ToString();
                travel.Loc_name = reader["loc_name"].ToString();
                travel.Mem_id = reader["mem_id"].ToString();

                returnList.Add(travel);
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e) {; }

        return returnList;
    }

    public List<Travel> selectTravelListByMem_idNLimitOrderByDate(Travel travel, int start, int count)
    {
        MyDB mydb = new MyDB();

        List<Travel> resultList = new List<Travel>();
        Travel result;
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT * FROM toourshared.travel where mem_id=@mem_id order by trv_create_time limit @start,@count";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@mem_id", travel.Mem_id);
            cmd.Parameters.AddWithValue("@start", start);
            cmd.Parameters.AddWithValue("@count", count);

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

            rd.Close();
            con.Close();


        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }



        return resultList;
    }
    public List<Travel> SelectTagTravel(Travel travel, string keyword, int start, int count)
    {
        MyDB mydb = new MyDB();

        List<Travel> resultList = new List<Travel>();
        Travel result;
        MySqlConnection con;
        try
        {



            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.travel where trv_tag like '%" + keyword + "%' order by trv_create_time desc limit @start,@count";


            MySqlCommand cmd = new MySqlCommand(Sql, con);


            cmd.Parameters.AddWithValue("@keyword", travel.Trv_tag);
            cmd.Parameters.AddWithValue("@start", start);
            cmd.Parameters.AddWithValue("@count", count);

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

                //lstMember.Add(tmpMemberPointer);

                resultList.Add(result);

            }

            rd.Close();
            con.Close();


        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }



        return resultList;
    }

    public List<Travel> selectAll(Travel travel, string date, string loc, string title, string tag, string orderBy)
    {
        MyDB mydb = new MyDB();

        List<Travel> resultList = new List<Travel>();
        Travel result;
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT * FROM toourshared.travel where " + date + " loc_name LIKE" + loc + " or trv_title LIKE " + title + " or trv_tag LIKE " + tag + " " + orderBy;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
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


                //lstMember.Add(tmpMemberPointer);

                resultList.Add(result);


            }

            rd.Close();
            con.Close();


        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }

        return resultList;
    }

    // 최신 순 게시글 총 카운트 구해오는 함수
    public int getTravelCountOrderByCreateTimeDesc(string searchText)
    {
        // defalut param limit 0, 5
        int returnInt = 0;
        String Sql = "";
        MyDB mydb = new MyDB();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            if (string.IsNullOrEmpty(searchText) == true)
                Sql = "SELECT count(distinct(`travel`.`trv_no`)) as cnt FROM toourshared.travel ORDER BY trv_create_time DESC";
            else
                Sql = "select count(distinct(`travel`.`trv_no`)) as cnt from toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map where (travel.trv_no = travel_day.trv_no) AND (travel_day.trv_day_no = map.trv_day_no) AND ((travel.trv_title like '%" + searchText + "%') OR (travel.trv_tag like '%" + searchText + "%') OR (travel_day.trv_day_content like '%" + searchText + "%') OR (map.map_route like '%" + searchText + "')) ORDER BY trv_create_time DESC";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                returnInt = int.Parse(reader["cnt"].ToString());
            }

            reader.Close();
            con.Close();

        }
        catch (Exception e) {; }

        return returnInt;
    }

    // 인기(평점) 순 게시글 총 카운트 구해오는 함수
    public int getTravelCountOrderByTotRateDesc(string searchText, int limit1 = 0, int limit2 = 5)
    {
        // defalut param limit 0, 5
        int returnInt = 0;
        String Sql = "";
        MyDB mydb = new MyDB();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            if (string.IsNullOrEmpty(searchText) == true)
                Sql = "SELECT count(distinct(`travel`.`trv_no`)) as cnt FROM toourshared.travel ORDER BY trv_tot_rate DESC";
            else
                Sql = "select count(distinct(`travel`.`trv_no`)) as cnt from toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map where (travel.trv_no = travel_day.trv_no) AND (travel_day.trv_day_no = map.trv_day_no) AND ((travel.trv_title like '%" + searchText + "%') OR (travel.trv_tag like '%" + searchText + "%') OR (travel_day.trv_day_content like '%" + searchText + "%') OR (map.map_route like '%" + searchText + "')) ORDER BY trv_tot_rate DESC";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                returnInt = int.Parse(reader["cnt"].ToString());
            }

            reader.Close();
            con.Close();

        }
        catch (Exception e) {; }

        return returnInt;
    }

    // 팔로워 게시글 카운트 구해오는 함수
    public int getTravelCountOrderByFollowerDesc(string searchText)
    {
        // defalut param limit 0, 5
        int returnInt = 0;
        String Sql = "";
        MyDB mydb = new MyDB();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            if (string.IsNullOrEmpty(searchText) == true)
                Sql = "SELECT count(distinct((`travel`.`trv_no`))) as trvNoCnt, count(distinct(follower.fol_id)) as folCnt FROM toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map, toourshared.follower as follower WHERE((travel.trv_no = travel_day.trv_no) AND(travel_day.trv_day_no = map.trv_day_no) AND(travel.mem_id = follower.mem_id)) ORDER BY travel.trv_create_time DESC, folCnt DESC";
            else
                Sql = "SELECT count(distinct((`travel`.`trv_no`))) as trvNoCnt, count(distinct(follower.fol_id)) as folCnt FROM toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map, toourshared.follower as follower WHERE((travel.trv_no = travel_day.trv_no) AND(travel_day.trv_day_no = map.trv_day_no) AND(travel.mem_id = follower.mem_id)) AND ((travel.trv_title like '%" + searchText + "%') OR(travel.trv_tag like '%" + searchText + "%') OR(travel_day.trv_day_content like '%" + searchText + "%') OR(map.map_route like '%" + searchText + "%')) ORDER BY travel.trv_create_time DESC, folCnt DESC";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                returnInt = int.Parse(reader["trvNoCnt"].ToString());
            }

            reader.Close();
            con.Close();

        }
        catch (Exception e) {; }

        return returnInt;
    }

    // HOT순 게시글 총 카운트 구해오는 함수
    public int getTravelCountOrderByHotDesc(string searchText, int limit1 = 0, int limit2 = 5)
    {
        // defalut param limit 0, 5
        int returnInt = 0;
        String Sql = "";
        MyDB mydb = new MyDB();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            if (string.IsNullOrEmpty(searchText) == true)
                Sql = "SELECT count(distinct(travel.trv_no)) as trvNo, count(lik.mem_id) as cnt FROM toourshared.like as lik, toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map WHERE(travel.trv_no = lik.trv_no AND travel.trv_no = travel_day.trv_no AND travel_day.trv_day_no = map.trv_day_no) AND date(travel.trv_create_time) between date_sub(sysdate(), INTERVAL 14 DAY) and date(sysdate()) order by cnt desc";
            else
                Sql = "SELECT count(distinct(travel.trv_no)) as trvNo, count(lik.mem_id) as cnt FROM toourshared.like as lik, toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map WHERE(travel.trv_no = lik.trv_no AND travel.trv_no = travel_day.trv_no AND travel_day.trv_day_no = map.trv_day_no) AND date(travel.trv_create_time) between date_sub(sysdate(), INTERVAL 14 DAY) and date(sysdate()) AND ((travel.trv_title like '%" + searchText + "%') OR (travel.trv_tag like '%" + searchText + "%') OR (travel_day.trv_day_content like '%" + searchText + "%') OR (map.map_route like '%" + searchText + "%')) order by cnt desc";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                returnInt = int.Parse(reader["trvNo"].ToString());
            }

            reader.Close();
            con.Close();

        }
        catch (Exception e) {; }

        return returnInt;
    }

    // 최신 순 Travel DTO List형식으로 반환하는 함수
    public List<Travel> getTravelOrderByCreateTimeDesc(string searchText, int limit1 = 0, int limit2 = 5)
    {
        // default param limit 0, 5
        MyDB mydb = new MyDB();
        string Sql;
        Travel travel;
        List<Travel> returnList = new List<Travel>();
        MySqlConnection con;
        MySqlCommand cmd;
        int testTmp = 0;

        try
        {
            con = mydb.GetCon();
            System.Diagnostics.Debug.WriteLine("string.IsNullOrEmpty(" + searchText + ") : " + string.IsNullOrEmpty(searchText));

            if (string.IsNullOrEmpty(searchText) == true)
            {
                Sql = "SELECT distinct(`travel`.`trv_no`) as trv_no, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id FROM toourshared.travel ORDER BY trv_create_time DESC limit " + limit1 + ", " + limit2;
            }
            else
            {
                Sql = "select distinct(`travel`.`trv_no`) as trv_no, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id " +
                "from toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map " +
                "where (travel.trv_no = travel_day.trv_no) AND (travel_day.trv_day_no = map.trv_day_no) AND " +
                "((travel.trv_title like '%" + searchText + "%') OR (travel.trv_tag like '%" + searchText + "%') OR (travel_day.trv_day_content like '%" + searchText + "%') OR (map.map_route like '%" + searchText + "%')) " +
                "ORDER BY travel.trv_create_time DESC limit " + limit1 + ", " + limit2;
            }

            cmd = new MySqlCommand(Sql, con);

            con.Open();
            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                travel = new Travel();
                travel.Trv_no = reader["trv_no"].ToString();
                travel.Trv_secret = reader["trv_secret"].ToString();
                travel.Trv_views = reader["trv_views"].ToString();
                travel.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                travel.Trv_main_img = reader["trv_main_img"].ToString();
                travel.Trv_title = reader["trv_title"].ToString();
                travel.Trv_tag = reader["trv_tag"].ToString();
                travel.Trv_timestamp = reader["trv_timestamp"].ToString();
                travel.Trv_create_time = reader["trv_create_time"].ToString();
                travel.Loc_name = reader["loc_name"].ToString();
                travel.Mem_id = reader["mem_id"].ToString();
                travel.ToString();

                returnList.Add(travel);
                testTmp++;
            }

            System.Diagnostics.Debug.WriteLine("(제목: " + searchText + ") " + testTmp);

            reader.Close();
            con.Close();
        }
        catch (Exception e) {; }

        return returnList;
    }

    // 평점 순 Travel DTO List형식으로 반환하는 함수
    public List<Travel> getTravelOrderByTotRateDesc(string searchText, int limit1 = 0, int limit2 = 5)
    {
        // default param limit 0, 5
        MyDB mydb = new MyDB();
        string Sql = "";
        Travel travel;
        List<Travel> returnList = new List<Travel>();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            if (string.IsNullOrEmpty(searchText) == true)
                Sql = "SELECT distinct(`travel`.`trv_no`) as trv_no, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id " +
                "FROM toourshared.travel ORDER BY trv_tot_rate DESC limit " + limit1 + ", " + limit2;
            else
                Sql = "select distinct(`travel`.`trv_no`) as trv_no, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id " +
                "from toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map " +
                "where (travel.trv_no = travel_day.trv_no) AND (travel_day.trv_day_no = map.trv_day_no) AND " +
                "((travel.trv_title like '%" + searchText + "%') OR (travel.trv_tag like '%" + searchText + "%') OR (travel_day.trv_day_content like '%" + searchText + "%') OR (map.map_route like '%" + searchText + "%')) " +
                "ORDER BY travel.trv_tot_rate DESC limit " + limit1 + ", " + limit2;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                travel = new Travel();
                travel.Trv_no = reader["trv_no"].ToString();
                travel.Trv_secret = reader["trv_secret"].ToString();
                travel.Trv_views = reader["trv_views"].ToString();
                travel.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                travel.Trv_main_img = reader["trv_main_img"].ToString();
                travel.Trv_title = reader["trv_title"].ToString();
                travel.Trv_tag = reader["trv_tag"].ToString();
                travel.Trv_timestamp = reader["trv_timestamp"].ToString();
                travel.Trv_create_time = reader["trv_create_time"].ToString();
                travel.Loc_name = reader["loc_name"].ToString();
                travel.Mem_id = reader["mem_id"].ToString();

                returnList.Add(travel);
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e) {; }

        return returnList;
    }

    // 팔로워 순 Travel DTO List형식으로 반환하는 함수
    public List<Travel> getTravelOrderByFollowerDesc(string searchText, int limit1 = 0, int limit2 = 5)
    {
        // default param limit 0, 5
        MyDB mydb = new MyDB();
        string Sql = "";
        Travel travel;
        List<Travel> returnList = new List<Travel>();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            if (string.IsNullOrEmpty(searchText) == true)
                Sql = "SELECT distinct((`travel`.`trv_no`)) as trvNo, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id, count(distinct(follower.fol_id)) as folCnt FROM toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map, toourshared.follower as follower WHERE ((travel.trv_no = travel_day.trv_no) AND (travel_day.trv_day_no = map.trv_day_no) AND (travel.mem_id = follower.mem_id)) GROUP BY trvNO ORDER BY travel.trv_create_time DESC, folCnt DESC LIMIT " + limit1 + ", " + limit2;
            else
                Sql = "SELECT distinct((`travel`.`trv_no`)) as trvNo, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id, count(distinct(follower.fol_id)) as folCnt FROM toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map, toourshared.follower as follower WHERE ((travel.trv_no = travel_day.trv_no) AND (travel_day.trv_day_no = map.trv_day_no) AND (travel.mem_id = follower.mem_id)) AND ((travel.trv_title like '%" + searchText + "%') OR (travel.trv_tag like '%" + searchText + "%') OR (travel_day.trv_day_content like '%" + searchText + "%') OR (map.map_route like '%" + searchText + "%')) GROUP BY trvNO ORDER BY travel.trv_create_time DESC, folCnt DESC LIMIT " + limit1 + ", " + limit2;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                travel = new Travel();
                travel.Trv_no = reader["trvNo"].ToString();
                travel.Trv_secret = reader["trv_secret"].ToString();
                travel.Trv_views = reader["trv_views"].ToString();
                travel.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                travel.Trv_main_img = reader["trv_main_img"].ToString();
                travel.Trv_title = reader["trv_title"].ToString();
                travel.Trv_tag = reader["trv_tag"].ToString();
                travel.Trv_timestamp = reader["trv_timestamp"].ToString();
                travel.Trv_create_time = reader["trv_create_time"].ToString();
                travel.Loc_name = reader["loc_name"].ToString();
                travel.Mem_id = reader["mem_id"].ToString();

                returnList.Add(travel);
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e) {; }

        return returnList;
    }

    // HOT 순 Travel DTO List형식으로 반환하는 함수
    public List<Travel> getTravelOrderByHotDesc(string searchText, int limit1 = 0, int limit2 = 5)
    {
        // default param limit 0, 5
        MyDB mydb = new MyDB();
        string Sql = "";
        Travel travel;
        List<Travel> returnList = new List<Travel>();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            if (string.IsNullOrEmpty(searchText) == true)
                Sql = "SELECT distinct((`travel`.`trv_no`)) as trvNo, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id, count(lik.mem_id) as cnt FROM toourshared.like as lik, toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map WHERE(travel.trv_no = lik.trv_no AND travel.trv_no = travel_day.trv_no AND travel_day.trv_day_no = map.trv_day_no) AND date(travel.trv_create_time) between date_sub(sysdate(), INTERVAL 14 DAY) and date(sysdate()) group by travel.trv_no order by cnt desc limit " + limit1 + ", " + limit2;
            else
                Sql = "SELECT distinct((`travel`.`trv_no`)) as trvNo, `travel`.`trv_secret` as trv_secret, `travel`.`trv_views` as trv_views, `travel`.`trv_tot_rate` as trv_tot_rate, `travel`.`trv_main_img` as trv_main_img, `travel`.`trv_title` as trv_title, `travel`.`trv_tag` as trv_tag, `travel`.`trv_timestamp` as trv_timestamp, `travel`.`trv_create_time` as trv_create_time, `travel`.`loc_name` as loc_name, `travel`.`mem_id` as mem_id, count(lik.mem_id) as cnt FROM toourshared.like as lik, toourshared.travel as travel, toourshared.travel_day as travel_day, toourshared.map as map WHERE(travel.trv_no = lik.trv_no AND travel.trv_no = travel_day.trv_no AND travel_day.trv_day_no = map.trv_day_no) AND date(travel.trv_create_time) between date_sub(sysdate(), INTERVAL 14 DAY) and date(sysdate()) AND ((travel.trv_title like '%" + searchText + "%') OR (travel.trv_tag like '%" + searchText + "%') OR (travel_day.trv_day_content like '%" + searchText + "%') OR (map.map_route like '%" + searchText + "%')) group by travel.trv_no order by cnt desc limit " + limit1 + ", " + limit2;

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();

            MySqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                travel = new Travel();
                travel.Trv_no = reader["trvNo"].ToString();
                travel.Trv_secret = reader["trv_secret"].ToString();
                travel.Trv_views = reader["trv_views"].ToString();
                travel.Trv_tot_rate = reader["trv_tot_rate"].ToString();
                travel.Trv_main_img = reader["trv_main_img"].ToString();
                travel.Trv_title = reader["trv_title"].ToString();
                travel.Trv_tag = reader["trv_tag"].ToString();
                travel.Trv_timestamp = reader["trv_timestamp"].ToString();
                travel.Trv_create_time = reader["trv_create_time"].ToString();
                travel.Loc_name = reader["loc_name"].ToString();
                travel.Mem_id = reader["mem_id"].ToString();

                returnList.Add(travel);
            }

            reader.Close();
            con.Close();
        }
        catch (Exception e) {; }

        return returnList;
    }

    public List<Travel> travel_count(Travel travel, string date, string loc, string title, string tag, string orderBy)
    {
        MyDB mydb = new MyDB();
        List<Travel> resultList = new List<Travel>();
        Travel result;

        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT count(*) FROM toourshared.travel where " + date + "loc_name LIKE" + loc + "or trv_title LIKE " + title + "or trv_tag LIKE " + tag + " " + orderBy;


            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            while (rd.Read())
            {
                result = new Travel();

                result.Trv_no = rd["trv_no"].ToString();

                resultList.Add(result);
            }

            rd.Close();
            con.Close();


        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }



        return resultList;
    }

    // 게시글 번호를 받아 그 게시글의 평균 평점을 최신화 해주는 함수
    public void setTotRateByTrvNo(int trv_no)
    {
        Travel travel = new Travel();
        TravelDao travelDao = new TravelDao();
        CommentDao commentDao = new CommentDao();

        MyDB mydb = new MyDB();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();
            String Sql = "UPDATE toourshared.travel as trv SET trv.trv_tot_rate = (SELECT sum(cmt.cmt_rate) / count(cmt.cmt_rate) as trv_tot_rate FROM comment as cmt WHERE trv_no = " + trv_no.ToString() + ") WHERE trv_no = " + trv_no.ToString();

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception e) {;}
    }

    // 아이디를 받으면 그 아이디가 작성한 게시글의 카운트를 반환하는 함수
    public int getTravelCountByMemId(string memberID)
    {
        if (String.IsNullOrEmpty(memberID)) // 파라미터로 받은 memberID 값이 null 혹은 empty 인 경우 0을 반환한다.
        {
            return 0;
        }
        else
        {
            MyDB myDB = new MyDB();
            MySqlConnection con;
            int returnInt = 0;

            try
            {
                con = myDB.GetCon();
                String Sql = "SELECT count(*) as cnt FROM toourshared.travel WHERE mem_id = '" + memberID + "'";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                con.Open();

                MySqlDataReader reader = cmd.ExecuteReader();
                if(reader.Read())
                {
                    returnInt = int.Parse(reader["cnt"].ToString());
                }

                reader.Close();
                con.Close();
            }
            catch (Exception e) {; }

            return returnInt;
        }
    }
}


