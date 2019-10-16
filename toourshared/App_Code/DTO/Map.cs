using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Map의 요약 설명입니다.
/// </summary>
public class Map
{
    private string map_no;
    private string trv_day_no;

    public Map(string map_no = null, string trv_day_no = null)
    {
        this.Map_no = map_no;
        this.Trv_day_no = trv_day_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Map_no { get => map_no; set => map_no = value; }
    public string Trv_day_no { get => trv_day_no; set => trv_day_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Map map &&
               Map_no == map.Map_no &&
               Trv_day_no == map.Trv_day_no;
    }

    public override int GetHashCode()
    {
        var hashCode = -1958754331;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Map_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Trv_day_no);
        return hashCode;
    }
}