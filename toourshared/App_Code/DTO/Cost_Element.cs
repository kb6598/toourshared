using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Cost_Element의 요약 설명입니다.
/// </summary>
public class Cost_Element
{
    private string cos_ele_no;
    private string cos_no;
    private string cos_ele_type;
    private string cos_ele_cost;
    private string cos_ele_info;

    public Cost_Element(string cos_ele_no = null, string cos_no = null, string cos_ele_type = null, string cos_ele_cost = null, string cos_ele_info = null)
    {
        this.Cos_ele_no = cos_ele_no;
        this.Cos_no = cos_no;
        this.Cos_ele_type = cos_ele_type;
        this.Cos_ele_cost = cos_ele_cost;
        this.Cos_ele_info = cos_ele_info;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Cos_ele_no { get => cos_ele_no; set => cos_ele_no = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Cos_ele_type { get => cos_ele_type; set => cos_ele_type = value; }
    public string Cos_ele_cost { get => cos_ele_cost; set => cos_ele_cost = value; }
    public string Cos_ele_info { get => cos_ele_info; set => cos_ele_info = value; }

    public override bool Equals(object obj)
    {
        return obj is Cost_Element element &&
               Cos_ele_no == element.Cos_ele_no &&
               Cos_no == element.Cos_no &&
               Cos_ele_type == element.Cos_ele_type &&
               Cos_ele_cost == element.Cos_ele_cost &&
               Cos_ele_info == element.Cos_ele_info;
    }

    public override int GetHashCode()
    {
        var hashCode = -563263250;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_ele_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_ele_type);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_ele_cost);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_ele_info);
        return hashCode;
    }
}