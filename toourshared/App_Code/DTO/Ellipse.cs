using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Ellipse의 요약 설명입니다.
/// </summary>
public class Ellipse
{
    private string ell_no;
    private string ell_crd;
    private string ell_title;
    private string ell_content;
    private string cos_no;
    private string map_no;

    public Ellipse(string ell_no = null, string ell_crd = null, string ell_title = null, string ell_content = null, string cos_no = null, string map_no = null)
    {
        this.Ell_no = ell_no;
        this.Ell_crd = ell_crd;
        this.Ell_title = ell_title;
        this.Ell_content = ell_content;
        this.Cos_no = cos_no;
        this.Map_no = map_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Ell_no { get => ell_no; set => ell_no = value; }
    public string Ell_crd { get => ell_crd; set => ell_crd = value; }
    public string Ell_title { get => ell_title; set => ell_title = value; }
    public string Ell_content { get => ell_content; set => ell_content = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Map_no { get => map_no; set => map_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Ellipse ellipse &&
               Ell_no == ellipse.Ell_no &&
               Ell_crd == ellipse.Ell_crd &&
               Ell_title == ellipse.Ell_title &&
               Ell_content == ellipse.Ell_content &&
               Cos_no == ellipse.Cos_no &&
               Map_no == ellipse.Map_no;
    }

    public override int GetHashCode()
    {
        var hashCode = -37177680;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Ell_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Ell_crd);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Ell_title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Ell_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Map_no);
        return hashCode;
    }
}