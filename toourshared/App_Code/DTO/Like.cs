using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Like의 요약 설명입니다.
/// </summary>
public class Like
{
    public object lik_no;
    private string mem_id;
    private string like_type;
    private string trv_no;
    
    public Like()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public Like(string mem_id = "", string like_type = "", string trv_no = "")
    {
        this.Mem_id = mem_id;
        this.Like_type = like_type;
        this.Trv_no = trv_no;
    }

    public string Mem_id { get => mem_id; set => mem_id = value; }
    public string Like_type { get => like_type; set => like_type = value; }
    public string Trv_no { get => trv_no; set => trv_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Like like &&
               Mem_id == like.Mem_id &&
               Like_type == like.Like_type &&
               Trv_no == like.Trv_no;
    }

    public override int GetHashCode()
    {
        var hashCode = -703585640;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_id);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Like_type);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Trv_no);
        return hashCode;
    }
}