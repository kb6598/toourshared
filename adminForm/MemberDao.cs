using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using tooushared.DTO;



/// <summary>
/// MemberDao의 요약 설명입니다.
/// </summary>
namespace tooushared.DAO
{
    public class MemberDao
    {
        public MemberDao()
        {
            //
            // TODO: 여기에 생성자 논리를 추가합니다.
            //
        }

        public string InsertMember(Member member)
        {



            string result = "";
            if (member.Mem_id == "" && member.Mem_pw == "" && member.Mem_name == "")
            {
                Console.WriteLine("error parameter value is empty");
              
            }http://localhost:6118/App_Code/DAO/LocationDao.cs
            DataSet ds = new DataSet();
            try
            {
                MyDB myDB = new MyDB();
                MySqlConnection con = myDB.GetCon();




                string Sql = "INSERT INTO toourshared.member (mem_id, mem_state, mem_phone, mem_pw, mem_name, mem_sex, mem_ques, mem_answer, mem_birth, mem_email, mem_reg_datetime, mem_timestmap, mem_img_url)" +
                    " VALUES (@mem_id, @mem_state, @mem_phone, @mem_pw, @mem_name, @mem_sex, @mem_ques, @mem_answer, @mem_birth, @mem_email, @mem_reg_datetime, @mem_timestmap, @mem_img_url)";

                MySqlCommand cmd = new MySqlCommand(Sql, con);

                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);
                cmd.Parameters.AddWithValue("@mem_state", member.Mem_state);
                cmd.Parameters.AddWithValue("@mem_phone", member.Mem_phone);
                cmd.Parameters.AddWithValue("@mem_pw", member.Mem_pw);
                cmd.Parameters.AddWithValue("@mem_name", member.Mem_name);
                cmd.Parameters.AddWithValue("@mem_sex", member.Mem_sex);
                cmd.Parameters.AddWithValue("@mem_ques", member.Mem_ques);
                cmd.Parameters.AddWithValue("@mem_answer", member.Mem_answer);
                cmd.Parameters.AddWithValue("@mem_birth", member.Mem_birth);
                cmd.Parameters.AddWithValue("@mem_email", member.Mem_email);
                cmd.Parameters.AddWithValue("@mem_reg_datetime", member.Mem_reg_datetime);
                cmd.Parameters.AddWithValue("@mem_timestmap", member.Mem_timestmap);
                cmd.Parameters.AddWithValue("@mem_img_url", member.Mem_img_url);




                con.Open();
                cmd.ExecuteNonQuery();

                 result = cmd.LastInsertedId.ToString();

                con.Close();
              

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
                //-1 이면 오류
              

            }


            return result;

        }

        public DataSet SelectMember()
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string sql = "Select mem_id,mem_state, mem_phone, mem_pw, mem_name, mem_sex, mem_ques, mem_answer, mem_birth, mem_email, " +
                "mem_reg_date, mem_timestmap, mem_img_url From toourshared.member";
            MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

            MySqlDataAdapter ad = new MySqlDataAdapter();
            ad.SelectCommand = cmd;
            DataSet ds = new DataSet();
            ad.Fill(ds);


            return ds;
        }

        //public List<Member> selectMember()
        public Member selectMemberByMem_id(Member member)
        {

            MyDB mydb = new MyDB();
            
            Member resultMember = new Member();
            MySqlConnection con;

            try
            {

                con = mydb.GetCon();

                string Sql = "SELECT member.mem_id, member.mem_state, member.mem_phone, member.mem_pw, member.mem_name, member.mem_sex, member.mem_ques, member.mem_answer, member.mem_birth, member.mem_email, member.mem_reg_datetime, member.mem_timestmap, member.mem_img_url FROM toourshared.member where mem_id=@mem_id";

                
                MySqlCommand cmd = new MySqlCommand(Sql, con);

                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);

                con.Open();
                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.HasRows)
                {
                        rd.Read();

                        resultMember.Mem_id = rd["mem_id"].ToString();
                        resultMember.Mem_state = rd["mem_state"].ToString();
                        resultMember.Mem_phone = rd["mem_phone"].ToString();
                        resultMember.Mem_pw = rd["mem_pw"].ToString();
                        resultMember.Mem_name = rd["mem_name"].ToString();
                        resultMember.Mem_sex = rd["mem_sex"].ToString();
                        resultMember.Mem_ques = rd["mem_ques"].ToString();
                        resultMember.Mem_answer = rd["mem_answer"].ToString();
                        resultMember.Mem_birth = rd["mem_birth"].ToString();
                        resultMember.Mem_email = rd["mem_email"].ToString();
                        resultMember.Mem_reg_datetime = rd["mem_reg_datetime"].ToString();
                        resultMember.Mem_timestmap = rd["mem_timestmap"].ToString();
                        resultMember.Mem_img_url = rd["mem_img_url"].ToString();

                        //lstMember.Add(tmpMemberPointer);

                        return resultMember;

                }

                con.Close();


            }
            catch (Exception ex)
            {
                Console.Write(ex.ToString());
            }



            return resultMember;
        }

        public int Login(Member member)
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();
            int count = 0;
            try
            {
                string Sql = "Select * From toourshared.member Where mem_id = @mem_id and mem_pw=@mem_pw";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);
                cmd.Parameters.AddWithValue("@mem_pw", member.Mem_pw);

                con.Open();

                
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    reader.Close();
                    con.Close();
                    count = 1;
                }
                else
                {
                    count = 0;
                }
                return count;
            }
            catch(Exception e)
            {
                
            }
            finally
            {
                con.Close();
            }
            return count;
        }

        public int SelectMem_ID(Member member)
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();

            string Sql = "Select * From toourshared.member Where mem_id = @mem_id";

            MySqlCommand cmd = new MySqlCommand(Sql, con);
            cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);

            con.Open();

            int count = 0;
            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                reader.Close();
                con.Close();
                count = 1;
            }
            else
            {
                count = 0;
            }
            return count;

        }

        public Member FindMemberID(Member member)
        {

            MyDB mydb = new MyDB();

            Member FindID = new Member();
            MySqlConnection con;

            try
            {

                con = mydb.GetCon();

                string Sql = "SELECT member.mem_id FROM toourshared.member where mem_name=@mem_name and mem_birth=@mem_birth and mem_phone=@mem_phone and mem_ques=@mem_ques and mem_answer=@mem_answer";


                MySqlCommand cmd = new MySqlCommand(Sql, con);

                cmd.Parameters.AddWithValue("@mem_name", member.Mem_name);
                cmd.Parameters.AddWithValue("@mem_birth", member.Mem_birth);
                cmd.Parameters.AddWithValue("@mem_phone", member.Mem_phone);
                cmd.Parameters.AddWithValue("@mem_ques", member.Mem_ques);
                cmd.Parameters.AddWithValue("@mem_answer", member.Mem_answer);

                con.Open();
                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.HasRows)
                {
                    rd.Read();

                    FindID.Mem_id = rd["mem_id"].ToString();

                    return FindID;

                }
                con.Close();
            }
            catch (Exception ex)
            {
                Console.Write(ex.ToString());
            }
            return FindID;
        }

        public Member FindMemberPW(Member member)
        {

            MyDB mydb = new MyDB();

            Member FindPW = new Member();
            MySqlConnection con;

            try
            {

                con = mydb.GetCon();

                string Sql = "SELECT member.mem_pw FROM toourshared.member where mem_id=@mem_id and mem_birth=@mem_birth and mem_phone=@mem_phone and mem_ques=@mem_ques and mem_answer=@mem_answer";


                MySqlCommand cmd = new MySqlCommand(Sql, con);

                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);
                cmd.Parameters.AddWithValue("@mem_birth", member.Mem_birth);
                cmd.Parameters.AddWithValue("@mem_phone", member.Mem_phone);
                cmd.Parameters.AddWithValue("@mem_ques", member.Mem_ques);
                cmd.Parameters.AddWithValue("@mem_answer", member.Mem_answer);

                con.Open();
                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.HasRows)
                {
                    rd.Read();

                    FindPW.Mem_pw = rd["mem_pw"].ToString();

                    return FindPW;

                }
                con.Close();
            }
            catch (Exception ex)
            {
                Console.Write(ex.ToString());
            }
            return FindPW;

        }

        public DataSet Select_MemberID()
        {
            MyDB myDB = new MyDB();
            MySqlConnection con2 = myDB.GetCon();

            string sql = "Select travel.mem_id as id from travel, member where member.mem_state= 1 and travel.trv_secret = 3";
            string userID = "";

            MySqlCommand cmd2 = new MySqlCommand(sql, con2);
            con2.Open();

            MySqlDataReader reader = cmd2.ExecuteReader();
            while (reader.Read())
            {
                userID = reader["id"].ToString();
            }

            reader.Close();
            con2.Close();

            string sql2 = "select member_block.mem_blo_no, member_block.mem_id, member_block.mem_blo_date, member_block.mem_blo_length" +
                "from member_block where member_block.mem_id = " + userID;

            cmd2 = new MySqlCommand(sql2, con2);
            MySqlDataAdapter ad = new MySqlDataAdapter();
            ad.SelectCommand = cmd2;

            DataSet ds2 = new DataSet();
            ad.Fill(ds2);
            return ds2;



//인터넷 소스 ...?
/*
            MyDB myDB = new MyDB();
            MySqlConnection con = new MySqlConnection();

            String sql = "SELECT * FROM toourshared.member_block where member_block=@mem_blo_no";

            MySqlCommand cmd = new MySqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@mem_blo_no", member_block.Mem_blo_no);
            MySqlDataReader read_rd;

            string SUM;

            try
            {
                con.Open();
                read_rd = cmd.ExecuteReader();

                if (read_rd.HasRows)
                {
                    while (read_rd.Read())
                    {
                        SUM = read_rd.GetString(0);
                    }
                }

                read_rd.Close();
                con.Close();
            }

            catch (Exception)
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

            return null;*/
        }
    }
}
