using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// QusetionDao의 요약 설명입니다.
/// </summary>
public class QuestionDao
{
    public QuestionDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertQusetion(Question question)
    {

        string result = "";
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.question (qus_title,qus_content,qus_ask) VALUES(@qus_title,@qus_content,@qus_ask); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@qus_title", question.Qus__title);
        cmd.Parameters.AddWithValue("@qus_content",question.Qus_content);
        cmd.Parameters.AddWithValue("@qus_ask", question.Qus_ask);
        

        con.Open();

        cmd.ExecuteNonQuery();

        result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }
    //public void DeleteCommentBy(mem_id)
    public DataSet SelectQusetion()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string sql = "Select qus_no, qus_title, qus_content, qus_ask  From toourshared.question";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);


        return ds;
    }

    public Question selectQuestionByqus_no(Question question)
    {

        MyDB mydb = new MyDB();

        Question result = new Question();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.question where qus_no=@qus_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@qus_no", question.Qus_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Qus_no = rd["qus_no"].ToString();
                result.Qus__title = rd["qus_title"].ToString();
                result.Qus_content = rd["qus_content"].ToString();
                result.Qus_ask = rd["qus_ask"].ToString();
          



                //lstMember.Add(tmpMemberPointer);

                return result;

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
    public List<Question> selectAllQuestion(Question question)
    {
        MyDB mydb = new MyDB();

        List<Question> resultList = new List<Question>();
        Question result;
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT qus_no, qus__title, qus_ask FROM toourshared.question";


            MySqlCommand cmd = new MySqlCommand(Sql, con);
            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            while (rd.Read())
            {

                result = new Question();
                result.Qus_no = rd["qus_no"].ToString();
                result.Qus__title = rd["qus__title"].ToString();
                result.Qus_ask = rd["qus_ask"].ToString();


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
}

