using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// CostDao의 요약 설명입니다.
/// </summary>
public class CostDao
{
    public CostDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public string InsertCost(Cost cost)
    {

        string result="";



        if (cost.Cos_no == "" )
        {
            Console.WriteLine("error parameter value is empty");
            
        }
        DataSet ds = new DataSet();
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();




            string Sql = "INSERT INTO toourshared.cost (cos.no)" +
                " VALUES (@cos.no)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@cos_no", cost.Cos_no);
           




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
    public List<Cost> selectMember()
    {

        MyDB mydb = new MyDB();
        List<Cost> lstMember = new List<Cost>();
        Cost tmpMemberPointer;
        MySqlConnection con;

        try
        {

            con = mydb.GetCon();

            string Sql = "SELECT cost.cos_no";


            MySqlCommand cmd = new MySqlCommand(Sql, con);

            con.Open();
            MySqlDataReader rd = cmd.ExecuteReader();

            if (rd.HasRows)
            {


                while (rd.Read())
                {
                    tmpMemberPointer = new Cost();

                    tmpMemberPointer.Cos_no = rd["cos_no"].ToString();
                    

                    lstMember.Add(tmpMemberPointer);


                }
            }

            con.Close();


        }
        catch (Exception ex)
        {
            Console.Write(ex.ToString());
        }



        return lstMember;
    }
    public void DeleteByCostNo(Cost cost)
    {
        int result;
        if (cost.Cos_no == "")
        {
            Console.WriteLine("error parameter value is empty");
            result = -2;
        }
        DataSet ds = new DataSet();
        try
        {
            MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();




            string Sql = "DELETE FROME toourshared.cost (cos_no)" +
                "WHERE ID (@cos_no)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@cos_no", cost.Cos_no);





            con.Open();


            con.Close();
            result = cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.StackTrace);
            //-1 이면 오류
            result = -1;

        }


    

    }
}
