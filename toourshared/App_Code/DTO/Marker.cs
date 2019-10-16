using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Marker의 요약 설명입니다.
/// </summary>
public class Marker
{
    private string mar_no;
    private string mar_crd;
    private string mar_title;
    private string mar_content;
    private string cos_no;
    private string map_no;

    public Marker(string mar_no = null, string mar_crd = null, string mar_title = null, string mar_content = null, string cos_no = null, string map_no = null)
    {
        this.mar_no = mar_no;
        this.mar_crd = mar_crd;
        this.mar_title = mar_title;
        this.mar_content = mar_content;
        this.cos_no = cos_no;
        this.map_no = map_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Mar_no { get => mar_no; set => mar_no = value; }
    public string Mar_crd { get => mar_crd; set => mar_crd = value; }
    public string Mar_title { get => mar_title; set => mar_title = value; }
    public string Mar_content { get => mar_content; set => mar_content = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Map_no { get => map_no; set => map_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Marker marker &&
               mar_no == marker.mar_no &&
               mar_crd == marker.mar_crd &&
               mar_title == marker.mar_title &&
               mar_content == marker.mar_content &&
               cos_no == marker.cos_no &&
               map_no == marker.map_no;
    }

    public override int GetHashCode()
    {
        var hashCode = -1162036488;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mar_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mar_crd);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mar_title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mar_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(map_no);
        return hashCode;
    }
}