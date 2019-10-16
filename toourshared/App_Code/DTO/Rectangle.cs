using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Rectangle의 요약 설명입니다.
/// </summary>
public class Rectangle
{
    private string rec_no;
    private string rec_crd;
    private string rec_title;
    private string rec_content;
    private string cos_no;
    private string map_no;

    public Rectangle(string rec_no = null, string rec_crd = null, string rec_title = null, string rec_content = null, string cos_no = null, string map_no = null)
    {
        this.Rec_no = rec_no;
        this.Rec_crd = rec_crd;
        this.Rec_title = rec_title;
        this.Rec_content = rec_content;
        this.Cos_no = cos_no;
        this.Map_no = map_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Rec_no { get => rec_no; set => rec_no = value; }
    public string Rec_crd { get => rec_crd; set => rec_crd = value; }
    public string Rec_title { get => rec_title; set => rec_title = value; }
    public string Rec_content { get => rec_content; set => rec_content = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Map_no { get => map_no; set => map_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Rectangle rectangle &&
               Rec_no == rectangle.Rec_no &&
               Rec_crd == rectangle.Rec_crd &&
               Rec_title == rectangle.Rec_title &&
               Rec_content == rectangle.Rec_content &&
               Cos_no == rectangle.Cos_no &&
               Map_no == rectangle.Map_no;
    }

    public override int GetHashCode()
    {
        var hashCode = 968260532;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Rec_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Rec_crd);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Rec_title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Rec_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Map_no);
        return hashCode;
    }
}