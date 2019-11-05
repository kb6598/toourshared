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
    private string map_data;
    private string map_route;
    private string map_cost;

    public Map(string map_no =null, string trv_day_no =null, string map_data = null, string map_route = null, string map_cost = null)
    {
        this.Map_no = map_no;
        this.Trv_day_no = trv_day_no;
        this.Map_data = map_data;
        this.Map_route = map_route;
        this.Map_cost = map_cost;
    }

    public string Map_no { get => map_no; set => map_no = value; }
    public string Trv_day_no { get => trv_day_no; set => trv_day_no = value; }
    public string Map_data { get => map_data; set => map_data = value; }
    public string Map_route { get => map_route; set => map_route = value; }
    public string Map_cost { get => map_cost; set => map_cost = value; }

    public override bool Equals(object obj)
    {
        var map = obj as Map;
        return map != null &&
               Map_no == map.Map_no &&
               Trv_day_no == map.Trv_day_no &&
               Map_data == map.Map_data &&
               Map_route == map.Map_route &&
               Map_cost == map.Map_cost;
    }
}