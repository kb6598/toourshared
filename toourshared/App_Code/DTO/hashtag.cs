using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// hashtag의 요약 설명입니다.
/// </summary>
public class Hashtag
{
    private string has_no;
    public Hashtag()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public Hashtag(string has_no)
    {
        this.has_no = has_no;
    }

    public string Has_no { get => has_no; set => has_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Hashtag hashtag &&
               Has_no == hashtag.Has_no;
    }

    public override int GetHashCode()
    {
        return 261585291 + EqualityComparer<string>.Default.GetHashCode(Has_no);
    }
}