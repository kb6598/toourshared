using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// cost의 요약 설명입니다.
/// </summary>
public class cost
{
    private String cos_no;
    public cost(string cos_no = null)
    {
        this.Cos_no = cos_no;

        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Cos_no { get => cos_no; set => cos_no = value; }

    public override bool Equals(object obj)
    {
        return obj is cost cost &&
               Cos_no == cost.Cos_no;
    }

    public override int GetHashCode()
    {
        return -1221565602 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
    }
}   