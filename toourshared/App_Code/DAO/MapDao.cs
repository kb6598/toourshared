using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// MapDao의 요약 설명입니다.
/// </summary>
public class MapDao
{
    public MapDao()
    {
       
    }


    public string InsertMap(Map map)
    {

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.map ( trv_day_no, map_data, map_route, map_cost) VALUES (@trv_day_no, @map_data, @map_route, @map_cost)";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@map_cost", map.Map_cost);
        cmd.Parameters.AddWithValue("@map_data", map.Map_data);
        cmd.Parameters.AddWithValue("@map_route", map.Map_route);
        cmd.Parameters.AddWithValue("@trv_day_no", map.Trv_day_no);


        con.Open();

        cmd.ExecuteNonQuery();

        string result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }

    public int UpdateMap(Map map)
    {
        int result;

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();


        string Sql = "UPDATE toourshared.map SET trv_day_no = @trv_day_no, map_data = @map_data, map_route = @map_route, map_cost = @map_cost  WHERE map_no = @map_no";


        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@map_no", map.Map_no);
        cmd.Parameters.AddWithValue("@map_cost", map.Map_cost);
        cmd.Parameters.AddWithValue("@map_data", map.Map_data);
        cmd.Parameters.AddWithValue("@map_route", map.Map_route);
        cmd.Parameters.AddWithValue("@trv_day_no", map.Trv_day_no);

        con.Open();

        result = cmd.ExecuteNonQuery();


        con.Close();


        return result;
    }

    public DataSet SelectMap()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "SELECT map_no,trv_day_no, map_data, map_route, map_cost FROM toourshared.map";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }


    public Map selectMapByMap_no(Map map)
    {

        MyDB mydb = new MyDB();

        Map result = new Map();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.map where map_no=@map_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@map_no", map.Map_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {


                result.Map_no = rd["map_no"].ToString();
                result.Map_cost = rd["map_cost"].ToString();
                result.Map_data = rd["map_data"].ToString();
                result.Map_route = rd["map_route"].ToString();
                result.Trv_day_no = rd["trv_day_no"].ToString();
               

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
    public Map selectMapByTrv_day_no(Map map)
    {

        MyDB mydb = new MyDB();

        Map result = new Map();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.map where trv_day_no=@trv_day_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_day_no", map.Trv_day_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {


                result.Map_no = rd["map_no"].ToString();
                result.Map_cost = rd["map_cost"].ToString();
                result.Map_data = rd["map_data"].ToString();
                result.Map_route = rd["map_route"].ToString();
                result.Trv_day_no = rd["trv_day_no"].ToString();


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