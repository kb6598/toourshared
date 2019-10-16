using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Cost_Type의 요약 설명입니다.
/// </summary>
public class Cost_Type
{
    private string cos_ele_type;

    public Cost_Type(string cos_ele_type = null)
    {
        this.Cos_ele_type = cos_ele_type;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Cos_ele_type { get => cos_ele_type; set => cos_ele_type = value; }

    public override bool Equals(object obj)
    {
        return obj is Cost_Type type &&
               Cos_ele_type == type.Cos_ele_type;
    }

    public override int GetHashCode()
    {
        return 640452272 + EqualityComparer<string>.Default.GetHashCode(Cos_ele_type);
    }
}