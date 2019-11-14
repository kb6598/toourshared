using MySql.Data.MySqlClient;
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
        MySqlConnection con = null;
        try
        {
            MyDB myDB = new MyDB();
           
            con = myDB.GetCon();

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
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            con.Close();

        }
        finally
        {
            con.Close();
        }
        return result;
    }
    public DataSet SelectTrvel_Day()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();
        DataSet ds = null;
        try { 

        string sql = "Select trv_day_no, trv_day_content, trv_no  From toourshared.trvel_day";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        
        ad.Fill(ds);
    }
         catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            con.Close();

        }
        finally
        {
            con.Close();
        }
        return ds;
    }

    public List<Travel_Day> selectTravelDayListByTrvNo(Travel_Day travel_day)
    {
        MyDB mydb = new MyDB();
        List<Travel_Day> returnList = new List<Travel_Day>();

        Travel_Day result;
        MySqlConnection con = null;
        MySqlDataReader reader = null;

        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT * FROM toourshared.travel_day WHERE trv_no = @trv_no order by trv_day_no asc";
            // 게시글 번호에 해당하는 데이터 여러개를 긁어오는 SQL

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@trv_no", travel_day.Trv_no);

            con.Open();
            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                result = new Travel_Day();
                result.Trv_day_no = reader["trv_day_no"].ToString();
                result.Trv_day_content = reader["trv_day_content"].ToString();
                result.Trv_no = reader["trv_day_content"].ToString();
                returnList.Add(result);
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            reader.Close();
            con.Close();

        }
        finally
        {
            reader.Close();
            con.Close();
        }
        return returnList;
    }

    public Travel_Day selectTravelDayByTrvNo(Travel_Day travel_day)
    {
        MyDB mydb = new MyDB();
        Travel_Day result = new Travel_Day();
        MySqlConnection con = null;
        MySqlDataReader reader = null;

        try
        {
            con = mydb.GetCon();
            string Sql = "SELECT * FROM toourshared.travel_day where trv_no = @trv_no";
            // 게시글 번호에 해당하는 데이터 긁어오는 SQL

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@trv_no", travel_day.Trv_no);

            con.Open();
            reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                result.Trv_day_no = reader["trv_day_no"].ToString();
                result.Trv_day_content = reader["trv_day_content"].ToString();
                result.Trv_no = reader["trv_no"].ToString();
            }

            reader.Close();
            con.Close();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            reader.Close();
            con.Close();

        }
        finally
        {
            reader.Close();
            con.Close();
        }

        return result;
    }

    public Travel_Day selectTrvel_DayBytrv_day_no(Travel_Day travel_Day)
    {

        MyDB mydb = new MyDB();

        Travel_Day result = new Travel_Day();
        MySqlConnection con = null;
        MySqlDataReader rd = null;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.travel_day where trv_day_no=@trv_day_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_day_no", travel_Day.Trv_day_no);

            con.Open();
             rd = cmd.ExecuteReader();

            if (rd.Read())
            {
                result.Trv_day_no = rd["trv_day_no"].ToString();
                result.Trv_day_content = rd["trv_day_content"].ToString();
                result.Trv_no = rd["trv_no"].ToString();
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


        return result;
    }

    public int UpdatetTravel_Day(Travel_Day travel_day)
    {
        int result = 0;

        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        try { 
        string Sql = "UPDATE toourshared.travel_day SET trv_no =@trv_no, trv_day_content =@trv_day_content  WHERE Trv_day_no =@trv_day_no";

        MySqlCommand cmd = new MySqlCommand(Sql, con);


        cmd.Parameters.AddWithValue("@trv_no", travel_day.Trv_no);
        cmd.Parameters.AddWithValue("@trv_day_no", travel_day.Trv_day_no);
        cmd.Parameters.AddWithValue("@trv_day_content", travel_day.Trv_day_content);


        con.Open();

        result = cmd.ExecuteNonQuery();


        con.Close();
    }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
            con.Close();

        }
        finally
        {
            con.Close();
        }

        return result;
    }

    public int getTravelCountByTrvNo(string trv_no)
    {
        if (String.IsNullOrEmpty(trv_no)) // 파라미터로 받은 memberID 값이 null 혹은 empty 인 경우 0을 반환한다.
        {
            return 0;
        }
        else
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = null;
            MySqlDataReader reader = null;
            int returnInt = 0;

            try
            {
                con = myDB.GetCon();
                String Sql = "SELECT count(*) as cnt FROM toourshared.travel_day WHERE trv_no = '" + trv_no + "'";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                con.Open();

                reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    returnInt = int.Parse(reader["cnt"].ToString());
                }

                reader.Close();
                con.Close();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.StackTrace.ToString());
                reader.Close();
                con.Close();

            }
            finally
            {
                reader.Close();
                con.Close();
            }
            return returnInt;
        }
    }


}
