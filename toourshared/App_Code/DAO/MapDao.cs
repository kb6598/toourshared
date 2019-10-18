using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

//DB 사용시 필요한 객체들
using System.Data;
using MySql.Data.MySqlClient;
using tooushared.Lib;
using tooushared.DTO;



/// <summary>
/// MapDao의 요약 설명입니다.
/// </summary>
namespace tooushared.DAO
{
    public class MapDao
    {

        public MapDao()
        {
            //
            // TODO: 여기에 생성자 논리를 추가합니다.
            //
        }
        public string InsertMap(Map map)
        {

            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "INSERT INTO toourshared.map (map_no,trv_day_no) VALUES(@map_no,@trv_day_no); select last_insert_id()";
            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@map_no", map.Map_no);
            cmd.Parameters.AddWithValue("@trv_day_no", map.Trv_day_no);




            con.Open();

            cmd.ExecuteNonQuery();

            string result = cmd.LastInsertedId.ToString();

            con.Close();


            return result;
        }
        //public void DeleteCommentBy(mem_id)


    }
}