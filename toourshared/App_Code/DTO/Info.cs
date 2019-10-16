using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Info의 요약 설명입니다.
/// </summary>
public class Info
{
    private string inf_no;
    private string inf_crd;
    private string inf_title;
    private string inf_content;
    private string cos_no;
    private string map_no;

    public Info(string inf_no = null, string inf_crd = null, string inf_title = null, string inf_content = null, string cos_no = null, string map_no = null)
    {
        this.Inf_no = inf_no;
        this.Inf_crd = inf_crd;
        this.Inf_title = inf_title;
        this.Inf_content = inf_content;
        this.Cos_no = cos_no;
        this.Map_no = map_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Inf_no { get => inf_no; set => inf_no = value; }
    public string Inf_crd { get => inf_crd; set => inf_crd = value; }
    public string Inf_title { get => inf_title; set => inf_title = value; }
    public string Inf_content { get => inf_content; set => inf_content = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Map_no { get => map_no; set => map_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Info info &&
               Inf_no == info.Inf_no &&
               Inf_crd == info.Inf_crd &&
               Inf_title == info.Inf_title &&
               Inf_content == info.Inf_content &&
               Cos_no == info.Cos_no &&
               Map_no == info.Map_no;
    }

    public override int GetHashCode()
    {
        var hashCode = 245154800;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Inf_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Inf_crd);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Inf_title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Inf_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Map_no);
        return hashCode;
    }
}