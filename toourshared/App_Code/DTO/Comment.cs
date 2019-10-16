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
    private string cmt_content;
    private string mem_id;

    public Comment(string cmt_no = null, string cmt_rate = null, string cmt_timestamp = null, string trv_no = null, string cmt_content = null, string mem_id = null)
    {
        this.Cmt_no = cmt_no;
        this.Cmt_rate = cmt_rate;
        this.Cmt_timestamp = cmt_timestamp;
        this.Trv_no = trv_no;
        this.Cmt_content = cmt_content;
        this.Mem_id = mem_id;

        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Cmt_no { get => cmt_no; set => cmt_no = value; }
    public string Cmt_rate { get => cmt_rate; set => cmt_rate = value; }
    public string Cmt_timestamp { get => cmt_timestamp; set => cmt_timestamp = value; }
    public string Trv_no { get => trv_no; set => trv_no = value; }
    public string Cmt_content { get => cmt_content; set => cmt_content = value; }
    public string Mem_id { get => mem_id; set => mem_id = value; }

    public override bool Equals(object obj)
    {
        return obj is Comment comment &&
               Cmt_no == comment.Cmt_no &&
               Cmt_rate == comment.Cmt_rate &&
               Cmt_timestamp == comment.Cmt_timestamp &&
               Trv_no == comment.Trv_no &&
               Cmt_content == comment.Cmt_content &&
               Mem_id == comment.Mem_id;
    }

    public override int GetHashCode()
    {
        var hashCode = 757454027;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cmt_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cmt_rate);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cmt_timestamp);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Trv_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Cmt_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_id);
        return hashCode;
    }
}