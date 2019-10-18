using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tooushared.Lib;

/// <summary>
/// Member_BlockDao의 요약 설명입니다.
/// </summary>
public class Member_BlockDao
{
    public Member_BlockDao()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public int InsertMember_Block(Member_Block member_Block)
    {

        int result;
        MyDB myDB = new MyDB();
        MySqlConnection con = myDB.GetCon();

        string Sql = "INSERT INTO toourshared.member_block (mem_blo_date,mem_ble_length,mem_id) VALUES(@mem_blo_date,@mem_blo_length,@mem_id); select last_insert_id()";
        MySqlCommand cmd = new MySqlCommand(Sql, con);

        cmd.Parameters.AddWithValue("@mem_blo_date", member_Block.Mem_blo_date);
        cmd.Parameters.AddWithValue("@mem_blo_length", member_Block.Mem_blo_length);
        cmd.Parameters.AddWithValue("@mem_id", member_Block.Mem_id);


        con.Open();

        result = cmd.ExecuteNonQuery();

        con.Close();


        return result;
    }
}