using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Follower의 요약 설명입니다.
/// </summary>
public class Follower
{
    public object fol_no;
    private string mem_id;
    private string fol_id;
    public Follower(string mem_id = null, string fol_id = null)
    {
        this.Mem_id = mem_id;
        this.Fol_id = fol_id;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Mem_id { get => mem_id; set => mem_id = value; }
    public string Fol_id { get => fol_id; set => fol_id = value; }

    public override bool Equals(object obj)
    {
        return obj is Follower follower &&
               Mem_id == follower.Mem_id &&
               Fol_id == follower.Fol_id;
    }

    public override int GetHashCode()
    {
        var hashCode = 1484296080;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_id);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Fol_id);
        return hashCode;
    }
}