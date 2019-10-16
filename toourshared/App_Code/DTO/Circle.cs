using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Circle의 요약 설명입니다.
/// </summary>
public class Circle
{
    private string cir_no;
    private string cir_crd;
    private string cir_name;
    private string cir_content;
    private string cos_no;
    private string map_no;


    public Circle(string cir_no = null, string cir_crd = null, string cir_name = null, string cir_content = null, string cos_no = null, string map_no = null)
    {
        this.Cir_no = cir_no;
        this.Cir_crd = cir_crd;
        this.Cir_name = cir_name;
        this.Cir_content = cir_content;
        this.Cos_no = cos_no;
        this.Map_no = map_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Cir_no { get => cir_no; set => cir_no = value; }
    public string Cir_crd { get => cir_crd; set => cir_crd = value; }
    public string Cir_name { get => cir_name; set => cir_name = value; }
    public string Cir_content { get => cir_content; set => cir_content = value; }
    public string Cos_no { get => cos_no; set => cos_no = value; }
    public string Map_no { get => map_no; set => map_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Circle circle &&
               Cir_no == circle.Cir_no &&
               Cir_crd == circle.Cir_crd &&
               Cir_name == circle.Cir_name &&
               Cir_content == circle.Cir_content &&
               Cos_no == circle.Cos_no &&
               Map_no == circle.Map_no;
    }

    public override int GetHashCode()
    {
        var hashCode = 2135553553;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cir_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cir_crd);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cir_name);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cir_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cos_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Map_no);
        return hashCode;
    }
}