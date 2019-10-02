using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Member의 요약 설명입니다.
/// </summary>
public class Member
{
    public Member()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public int InsertMember(string id, string pw, string name, string sex, string birth, string phone, string question, string answer)
    {
        SqlConnection con = new SqlConnection(_conString);
        string sql = "Insert into Member(id, pw, name, sex, birth, phone, question, answer) values(@UserID, @Password, @Name, @Birth, @Phone, @Address)";
        SqlCommand cmd = new SqlCommand(sql, con);  // sql커맨드 객체 (sql 문과, con 안에) 생성 
        //양식-> parameter 가져오기
        cmd.Parameters.AddWithValue("@ID", id);
        cmd.Parameters.AddWithValue("@PW", pw);
        cmd.Parameters.AddWithValue("@Name", name);
        cmd.Parameters.AddWithValue("@Birth", birth);
        cmd.Parameters.AddWithValue("@Phone", phone);
        cmd.Parameters.AddWithValue("@Question", question);
        cmd.Parameters.AddWithValue("@Answer", answer);

        con.Open();
        int count = cmd.ExecuteNonQuery();
        con.Close();

        return count;
    }
}