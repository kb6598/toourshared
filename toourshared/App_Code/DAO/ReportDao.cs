using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// ReportDao의 요약 설명입니다.
/// </summary>
public class ReportDao
{
    public ReportDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public int InsertReport(Report report)
    {

        int result;
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.report (trv_no,rep_timestap,rep_mem_id) VALUES(@trv_no,@rep_timestap,@rep_mem_id); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@trv_no", report.Trv_no);
        cmd.Parameters.AddWithValue("@rep_timestap",report.Rep_timestap);
        cmd.Parameters.AddWithValue("@rep_mem_id", report.Rep_mem_id);


        con.Open();

        result = cmd.ExecuteNonQuery();

        con.Close();


        return result;
    }
}