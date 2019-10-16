using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Comment의 요약 설명입니다.
/// </summary>
public class Comment
{
    private string cmt_no;
    private string cmt_rate;
    private string cmt_timestamp;
    private string trv_no;

    public Comment(string cmt_no = null, string cmt_rate = null, string cmt_timestamp = null, string trv_no = null)
    {
        this.cmt_no = cmt_no;
        this.cmt_rate = cmt_rate;
        this.cmt_timestamp = cmt_timestamp;
        this.trv_no = trv_no;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Cmt_no { get => cmt_no; set => cmt_no = value; }
    public string Cmt_rate { get => cmt_rate; set => cmt_rate = value; }
    public string Cmt_timestamp { get => cmt_timestamp; set => cmt_timestamp = value; }
    public string Trv_no { get => trv_no; set => trv_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Comment comment &&
               cmt_no == comment.cmt_no &&
               cmt_rate == comment.cmt_rate &&
               cmt_timestamp == comment.cmt_timestamp &&
               trv_no == comment.trv_no;
    }

    public override int GetHashCode()
    {
        var hashCode = 1538121900;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(cmt_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(cmt_rate);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(cmt_timestamp);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_no);
        return hashCode;
    }
}