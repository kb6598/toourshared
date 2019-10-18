using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Report의 요약 설명입니다.
/// </summary>
public class Report
{
private string rep_no;
    private string trv_no;
    private string rep_timestap;
    private string rep_mem_id;
    public Report()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public Report(string trv_no, string rep_timestap, string rep_mem_id)
    {
        this.Trv_no = trv_no;
        this.Rep_timestap = rep_timestap;
        this.Rep_mem_id = rep_mem_id;
    }

    public string Trv_no { get => trv_no; set => trv_no = value; }
    public string Rep_timestap { get => rep_timestap; set => rep_timestap = value; }
    public string Rep_mem_id { get => rep_mem_id; set => rep_mem_id = value; }

    public override bool Equals(object obj)
    {
        return obj is Report report &&
               Trv_no == report.Trv_no &&
               Rep_timestap == report.Rep_timestap &&
               Rep_mem_id == report.Rep_mem_id;
    }

    public override int GetHashCode()
    {
        var hashCode = -697820913;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Trv_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Rep_timestap);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Rep_mem_id);
        return hashCode;
    }
}