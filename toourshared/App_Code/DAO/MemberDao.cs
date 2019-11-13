using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using MySql.Data.MySqlClient;
using System.Data;
using tooushared.Lib;
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
            MySqlConnection con = null;
            if (member.Mem_id == "" && member.Mem_pw == "" && member.Mem_name == "")
            {
                Console.WriteLine("error parameter value is empty");
              
            }http://localhost:6118/App_Code/DAO/LocationDao.cs
            DataSet ds = new DataSet();
            try
            {
                MyDB myDB = new MyDB();
                con = myDB.GetCon();




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
                con.Close();


            }
            finally
            {
                con.Close();
            }


            return result;

        }
        public DataSet SelectMember()
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();
            DataSet ds = null;

            try
            {
                string sql = "Select mem_id,mem_state, mem_phone, mem_pw, mem_name, mem_sex, mem_ques, mem_answer, mem_birth, mem_email, " +
                    "mem_reg_date, mem_timestmap, mem_img_url From toourshared.member";
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

        //public List<Member> selectMember()
        public Member selectMemberByMem_id(Member memberDTO)
        {
            MyDB mydb = new MyDB();
            Member mem = new Member();
            MySqlConnection con = null;
            MySqlDataReader rd = null;

            try
            {
                con = mydb.GetCon();
                string Sql = "SELECT * FROM toourshared.member as mem WHERE mem.mem_id = '" + memberDTO.Mem_id + "'";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                con.Open();

                rd = cmd.ExecuteReader();

                if(rd.Read())
                {
                    mem.Mem_id = rd["mem_id"].ToString();
                    mem.Mem_state = rd["mem_state"].ToString();
                    mem.Mem_phone = rd["mem_phone"].ToString();
                    mem.Mem_pw = rd["mem_pw"].ToString();
                    mem.Mem_name = rd["mem_name"].ToString();
                    mem.Mem_sex = rd["mem_sex"].ToString();
                    mem.Mem_ques = rd["mem_ques"].ToString();
                    mem.Mem_answer = rd["mem_answer"].ToString();
                    mem.Mem_birth = rd["mem_birth"].ToString();
                    mem.Mem_email = rd["mem_email"].ToString();
                    mem.Mem_reg_datetime = rd["mem_reg_datetime"].ToString();
                    mem.Mem_timestmap = rd["mem_timestmap"].ToString();
                    mem.Mem_img_url = rd["mem_img_url"].ToString();

                    // mem_img_url 컬럼에 NULL or EMPTY or "noImage" 일 경우 "./img/memberNoImage.png" 로 속성 값 적용
                    if(string.IsNullOrEmpty(mem.Mem_img_url) || mem.Mem_img_url == "noImage")
                        mem.Mem_img_url = "./img/memberNoImage.png";
                }



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
            return mem;
        }

        public int Login(Member member)
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();
            MySqlDataReader rd = null;
            int count = 0;

            try
            {
                string Sql = "Select * From toourshared.member Where mem_id = @mem_id and mem_pw=@mem_pw";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);
                cmd.Parameters.AddWithValue("@mem_pw", member.Mem_pw);

                con.Open();


                rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    count = 1;
                }
                else
                {
                    count = 0;
                }
                
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
            return count;
        }

        public int SelectMem_ID(Member member)
        {
            int count = 0;
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();
            MySqlDataReader reader = null;
            try
            {
                string Sql = "Select * From toourshared.member Where mem_id = @mem_id";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);

                con.Open();


                reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    
                    count = 1;
                }
                else
                {
                    count = 0;
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
            return count;

        }

        public Member FindMemberID(Member member)
        {

            MyDB mydb = new MyDB();

            Member FindID = new Member();
            MySqlConnection con = null;
            MySqlDataReader rd = null;
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
                rd = cmd.ExecuteReader();

                if (rd.HasRows)
                {
                    rd.Read();

                    FindID.Mem_id = rd["mem_id"].ToString();
                    
                   

                }
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
            return FindID;
        }

        public Member FindMemberPW(Member member)
        {

            MyDB mydb = new MyDB();

            Member FindPW = new Member();
            MySqlConnection con = null;
            MySqlDataReader rd = null;
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
                rd = cmd.ExecuteReader();

                if (rd.HasRows)
                {
                    rd.Read();

                    FindPW.Mem_pw = rd["mem_pw"].ToString();

                    rd.Close();
                    con.Close();
                    

                }
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
            return FindPW;

        }

        /*public void UpdateMemberStateByMemId(Member member, int State)
        {
            MyDB mydb = new MyDB();
            MySqlConnection con;

            try
            {
                con = mydb.GetCon();
                String Sql = "UPDATE toourshared.member SET mem_state = " + State + " WHERE mem_id = @mem_id";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception e) {;}
        }*/

        public Member selectMemberBytrv_no(Member member)
        {

            MyDB mydb = new MyDB();

            Member result = new Member();
            MySqlConnection con = null;
            MySqlDataReader rd = null;

            try
            {

                con = mydb.GetCon();

                string Sql = "Select mem_id,mem_state, mem_phone, mem_pw, mem_name, mem_sex, mem_ques, mem_answer, mem_birth, mem_email, " +
                    "mem_reg_date, mem_timestmap, mem_img_url From toourshared.member, toourshared.travel where travel.mem_id = @mem_id and member.mem_id = travel.mem_id";


                MySqlCommand cmd = new MySqlCommand(Sql, con);

                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);

                con.Open();
                rd = cmd.ExecuteReader();

                if (rd.HasRows)
                {
                    rd.Read();

                    result.Mem_id = rd["mem_id"].ToString();
                    result.Mem_state = rd["mem_state"].ToString();
                    result.Mem_phone = rd["mem_phone"].ToString();
                    result.Mem_pw = rd["mem_pw"].ToString();
                    result.Mem_name = rd["mem_name"].ToString();
                    result.Mem_sex = rd["mem_sex"].ToString();
                    result.Mem_ques = rd["mem_ques"].ToString();
                    result.Mem_answer = rd["mem_answer"].ToString();
                    result.Mem_birth = rd["mem_birth"].ToString();
                    result.Mem_email = rd["mem_email"].ToString();
                    result.Mem_reg_datetime = rd["mem_reg_datetime"].ToString();
                    result.Mem_timestmap = rd["mem_timestamp"].ToString();
                    result.Mem_img_url = rd["mem_img_url"].ToString();

                   
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

        // edit 
        public int UpdatetMember(Member member)
        {
            int result = 0;
            MyDB myDB = new MyDB();
            MySqlConnection con = null;
            try
            {
                string Sql = "UPDATE toourshared.member SET mem_pw =@mem_pw, mem_phone =@mem_phone, mem_ques =@mem_ques, mem_answer =@mem_answer, mem_timestmap =@mem_timestmap, mem_img_url =@mem_img_url  WHERE mem_id = @mem_id";


                MySqlCommand cmd = new MySqlCommand(Sql, con);

                cmd.Parameters.AddWithValue("@mem_pw", member.Mem_pw);
                cmd.Parameters.AddWithValue("@mem_phone", member.Mem_phone);
                cmd.Parameters.AddWithValue("@mem_ques", member.Mem_ques);
                cmd.Parameters.AddWithValue("@mem_answer", member.Mem_answer);
                cmd.Parameters.AddWithValue("@mem_timestmap", member.Mem_timestmap);
                cmd.Parameters.AddWithValue("@mem_img_url", member.Mem_img_url);
                cmd.Parameters.AddWithValue("@mem_id", member.Mem_id);

                con.Open();
                cmd.ExecuteNonQuery();

                result = 1;
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

        public void UpdateMemImgUrlByMemID(Member member)
        {
            if (string.IsNullOrEmpty(member.Mem_img_url) || string.IsNullOrEmpty(member.Mem_id))
                return;
            MySqlConnection con = null;
            MyDB mydb = new MyDB();
           

            try
            {
                con = mydb.GetCon();
                string Sql = "UPDATE toourshared.member as mem SET mem.mem_img_url = @image WHERE mem.mem_id = @id";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                cmd.Parameters.AddWithValue("@image", member.Mem_img_url.ToString());
                cmd.Parameters.AddWithValue("@id", member.Mem_id.ToString());
                con.Open();

                cmd.ExecuteNonQuery();
                
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
        }

        // member 존재 유무를 판단해주는 함수(존재하는 경우 true, 존재하지 않는 경우 false 반환)
        public bool IsExistByMemberID(Member member)
        {
            bool returnBool = false;
            int check = 0;
            MySqlConnection con = null;
            MyDB mydb = new MyDB();
            MySqlDataReader reader = null;

            try
            {
                con = mydb.GetCon();
                String Sql = "SELECT count(*) as cnt FROM toourshared.member WHERE mem_id = '" + member.Mem_id + "'";

                MySqlCommand cmd = new MySqlCommand(Sql, con);
                con.Open();

                 reader = cmd.ExecuteReader();
                if(reader.Read())
                {
                    check = int.Parse(reader["cnt"].ToString());
                }

                reader.Close();
                con.Close();

                if (check > 0) // 존재하는 경우 1이 반환될 것이고
                    returnBool = true;
                else // 그렇지 않은 경우 0이 반환될 것이다.
                    returnBool = false;
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

            return returnBool;
        }
    }
}
