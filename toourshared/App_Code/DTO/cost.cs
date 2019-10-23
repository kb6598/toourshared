using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// cost의 요약 설명입니다.
/// </summary>
public class Cost
{

    private String cos_no;
    private String cos_place_name;

    public Cost(string cos_no = null, string cos_place_name = null)
    {
        this.cos_no = cos_no;
        this.cos_place_name = cos_place_name;
    }

    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Cos_place_name { get => cos_place_name; set => cos_place_name = value; }

    public override bool Equals(object obj)
    {
        var cost = obj as Cost;
        return cost != null &&
               cos_no == cost.cos_no &&
               cos_place_name == cost.cos_place_name;
    }

    public override int GetHashCode()
    {
        var hashCode = 1435059540;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(cos_place_name);
        return hashCode;
    }
}   