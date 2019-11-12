using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

/// <summary>
/// MyDB의 요약 설명입니다.
/// </summary>
namespace tooushared.Lib
{
    public class MyDB
    {
        MySqlConnection con = null;

        public MyDB(){
            String connectionString = "server=itbuddy.iptime.org;user=yuhan;database=toourshared;password=yuhan1234;port=8233;max pool size=1;";
            this.con = new MySqlConnection(connectionString);
        }

        public MySqlConnection GetCon()
        {

           
            return this.con;
        }

        public void CloseCon()
        {
            this.con.Close();

        }
      
    }
}