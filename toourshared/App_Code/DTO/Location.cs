using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Location의 요약 설명입니다.
/// </summary>
public class Location
{
    private string loc_name;

    public Location(string loc_name = null)
    {
        this.Loc_name = loc_name;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Loc_name { get => loc_name; set => loc_name = value; }

    public override bool Equals(object obj)
    {
        return obj is Location location &&
               Loc_name == location.Loc_name;
    }

    public override int GetHashCode()
    {
        return 1124615309 + EqualityComparer<string>.Default.GetHashCode(Loc_name);
    }
}