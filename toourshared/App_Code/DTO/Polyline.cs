using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Polyline의 요약 설명입니다.
/// </summary>
public class Polyline
{
    private string pol_lin_no;
    private string pol_lin_crd;
    private string pol_lin_title;
    private string pol_lin_content;
    private string cos_no;
    private string map_no;
    public Polyline()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public Polyline(string pol_lin_no, string pol_lin_crd, string pol_lin_title, string pol_lin_content, string cos_no, string map_no)
    {
        this.Pol_lin_no = pol_lin_no;
        this.Pol_lin_crd = pol_lin_crd;
        this.Pol_lin_title = pol_lin_title;
        this.Pol_lin_content = pol_lin_content;
        this.Cos_no = cos_no;
        this.Map_no = map_no;
    }

    public string Pol_lin_no { get => pol_lin_no; set => pol_lin_no = value; }
    public string Pol_lin_crd { get => pol_lin_crd; set => pol_lin_crd = value; }
    public string Pol_lin_title { get => pol_lin_title; set => pol_lin_title = value; }
    public string Pol_lin_content { get => pol_lin_content; set => pol_lin_content = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Map_no { get => map_no; set => map_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Polyline polyline &&
               Pol_lin_no == polyline.Pol_lin_no &&
               Pol_lin_crd == polyline.Pol_lin_crd &&
               Pol_lin_title == polyline.Pol_lin_title &&
               Pol_lin_content == polyline.Pol_lin_content &&
               Cos_no == polyline.Cos_no &&
               Map_no == polyline.Map_no;
    }

    public override int GetHashCode()
    {
        var hashCode = -43435888;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_lin_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_lin_crd);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_lin_title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Pol_lin_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Map_no);
        return hashCode;
    }
}