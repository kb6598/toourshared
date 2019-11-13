using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// LocationDao의 요약 설명입니다.
/// </summary>
public class LocationDao
{
    public LocationDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertLocation(Location location)
    {

        string result = "";
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();
        try
        {
            string Sql = "INSERT INTO toourshared.location (loc_name) VALUES(@loc_name); select last_insert_id()";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@loc_name", location.Loc_name);



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
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectLocation()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();
        DataSet ds = null;

        try
        {

            string sql = "Select loc_name  From toourshared.location";
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

    public Location selectLocationByloc_name(Location location)
    {

        MyDB mydb = new MyDB();

        Location result = new Location();
       
        MySqlConnection con = null;
        MySqlDataReader rd = null;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.location where loc_name =@loc_name";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@loc_name",location.Loc_name);

            con.Open();
            rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Loc_name = rd["loc_name"].ToString();
                


                //lstMember.Add(tmpMemberPointer);

                return result;

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

}