using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Polygon의 요약 설명입니다.
/// </summary>
public class Polygon
{
    private string pol_gon_no;
    private string pol_gon_crd;
    private string pol_gon_title;
    private string pol_gon_content;
    private string cos_no;
    private string map_no;

    public Polygon(string pol_gon_no = null, string pol_gon_crd = null, string pol_gon_title = null, string pol_gon_content = null, string cos_no = null, string map_no = null)
    {
        this.Pol_gon_no = pol_gon_no;
        this.Pol_gon_crd = pol_gon_crd;
        this.Pol_gon_title = pol_gon_title;
        this.Pol_gon_content = pol_gon_content;
        this.Cos_no = cos_no;
        this.Map_no = map_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Pol_gon_no { get => pol_gon_no; set => pol_gon_no = value; }
    public string Pol_gon_crd { get => pol_gon_crd; set => pol_gon_crd = value; }
    public string Pol_gon_title { get => pol_gon_title; set => pol_gon_title = value; }
    public string Pol_gon_content { get => pol_gon_content; set => pol_gon_content = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Map_no { get => map_no; set => map_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Polygon polygon &&
               Pol_gon_no == polygon.Pol_gon_no &&
               Pol_gon_crd == polygon.Pol_gon_crd &&
               Pol_gon_title == polygon.Pol_gon_title &&
               Pol_gon_content == polygon.Pol_gon_content &&
               Cos_no == polygon.Cos_no &&
               Map_no == polygon.Map_no;
    }

    public override int GetHashCode()
    {
        var hashCode = 1247654904;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_gon_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_gon_crd);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_gon_title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_gon_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Map_no);
        return hashCode;
    }
}