using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Member_Block의 요약 설명입니다.
/// </summary>
public class Member_Block
{
    private string mem_blo_no;
    private string mem_blo_date;
    private string mem_blo_length;
    private string mem_id;

    public Member_Block(string mem_blo_no = "", string mem_blo_date = "", string mem_blo_length = "", string mem_id = "")
    {
        this.Mem_blo_no = mem_blo_no;
        this.Mem_blo_date = mem_blo_date;
        this.Mem_blo_length = mem_blo_length;
        this.Mem_id = mem_id;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Mem_blo_no { get => mem_blo_no; set => mem_blo_no = value; }
    public string Mem_blo_date { get => mem_blo_date; set => mem_blo_date = value; }
    public string Mem_blo_length { get => mem_blo_length; set => mem_blo_length = value; }
    public string Mem_id { get => mem_id; set => mem_id = value; }

    public override bool Equals(object obj)
    {
        return obj is Member_Block block &&
               Mem_blo_no == block.Mem_blo_no &&
               Mem_blo_date == block.Mem_blo_date &&
               Mem_blo_length == block.Mem_blo_length &&
               Mem_id == block.Mem_id;
    }

    public override int GetHashCode()
    {
        var hashCode = 1150595096;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_blo_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_blo_date);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_blo_length);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_id);
        return hashCode;
    }
}