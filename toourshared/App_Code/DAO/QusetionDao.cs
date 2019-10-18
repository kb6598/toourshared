using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// QusetionDao의 요약 설명입니다.
/// </summary>
public class QusetionDao
{
    public QusetionDao()
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

        string Sql = "INSERT INTO toourshared.qusetion (qus_title,qus_content,qus_ask) VALUES(@qus_title,@qus_content,@qus_ask); select last_insert_id()";
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
}