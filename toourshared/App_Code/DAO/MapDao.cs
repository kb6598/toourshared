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

        //public void DeleteCommentBy(mem_id)
        public DataSet SelectMap()
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string sql = "Select map_no,trv_day_no  From toourshared.map";
            MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

            MySqlDataAdapter ad = new MySqlDataAdapter();
            ad.SelectCommand = cmd;
            DataSet ds = new DataSet();
            ad.Fill(ds);


            return ds;
        }

        public Map selectMapBymap_no(Map map)
        {

            MyDB mydb = new MyDB();

            Map result = new Map();
            MySqlConnection con;

            try
            {
                con = mydb.GetCon();

                string Sql = "SELECT * FROM toourshared.map where map=@map_no";


                MySqlCommand cmd = new MySqlCommand(Sql, con);

                cmd.Parameters.AddWithValue("@map_no", map.Map_no);

                con.Open();
                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.HasRows)
                {
                    rd.Read();

                    result.Map_no = rd["map_no"].ToString();
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

}