using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;



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

    public string InsertReport(Report report)
    {

        string result = "";
        MyDB myDB = new MyDB();
        MySql.Data.MySqlClient.MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.report (trv_no,rep_timestap,rep_mem_id, rep_reason) VALUES(@trv_no,@rep_timestap,@rep_mem_id, @rep_reason); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@trv_no", report.Trv_no);
        cmd.Parameters.AddWithValue("@rep_timestap", report.Rep_timestap);
        cmd.Parameters.AddWithValue("@rep_mem_id", report.Rep_mem_id);
        cmd.Parameters.AddWithValue("@rep_reason", report.Rep_reason);


        con.Open();

        cmd.ExecuteNonQuery();

        result = cmd.LastInsertedId.ToString();

        con.Close();


        return result;
    }

    public DataSet SelectReport()
    {
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        //string sql = "Select rep_no, trv_no, rep_timestap, rep_mem_id  From toourshared.report";
        string sql = "Select * From report";
        MySqlCommand cmd = new MySqlCommand(sql, con); // 커맨드(sql문을 con에서 수행하기 위한 명령문) 생성 DB에서 수행시킬 명령 생성   

        MySqlDataAdapter ad = new MySqlDataAdapter();
        ad.SelectCommand = cmd;
        DataSet ds = new DataSet();
        ad.Fill(ds);
       
        return ds;
    }

    public Report selectReportByrep_no(Report report)
    {

        MyDB mydb = new MyDB();

        Report result = new Report();
        MySqlConnection con;

        try
        {
            con = mydb.GetCon();

            string Sql = "SELECT * FROM toourshared.report where rep_no=@rep_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@rep_no", report.Rep_no);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {
                rd.Read();

                result.Rep_no = rd["rep_no"].ToString();
                result.Trv_no = rd["trv_no"].ToString();
                result.Rep_timestap = rd["rep_timestap"].ToString();
                result.Rep_mem_id = rd["rep_mem_id"].ToString();

                //lstMember.Add(tmpMemberPointer);
                return result;
            }

            con.Close();

        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }
        return result;
    }
}