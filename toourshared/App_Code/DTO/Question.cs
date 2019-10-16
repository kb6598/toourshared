using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Question의 요약 설명입니다.
/// </summary>
public class Question
{
    private string qus_no;
    private string qus__title;
    private string qus_content;
    private string qus_ask;

    public Question(string qus_no = null, string qus__title = null, string qus_content = null, string qus_ask = null)
    {
        this.Qus_no = qus_no;
        this.Qus__title = qus__title;
        this.Qus_content = qus_content;
        this.Qus_ask = qus_ask;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Qus_no { get => qus_no; set => qus_no = value; }
    public string Qus__title { get => qus__title; set => qus__title = value; }
    public string Qus_content { get => qus_content; set => qus_content = value; }
    public string Qus_ask { get => qus_ask; set => qus_ask = value; }

    public override bool Equals(object obj)
    {
        return obj is Question question &&
               Qus_no == question.Qus_no &&
               Qus__title == question.Qus__title &&
               Qus_content == question.Qus_content &&
               Qus_ask == question.Qus_ask;
    }

    public override int GetHashCode()
    {
        var hashCode = -146080650;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Qus_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Qus__title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Qus_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Qus_ask);
        return hashCode;
    }
}