using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
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
    public int InsertLocation(Location location)
    {

        int result;
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.location (loc_name) VALUES(@loc_name); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@loc_name", location.Loc_name);
        


        con.Open();

        result = cmd.ExecuteNonQuery();

        con.Close();


        return result;
    }
}