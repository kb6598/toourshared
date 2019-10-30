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
    private string rep_reason;

    public Report(string rep_no = null, string trv_no = null, string rep_timestap = null, string rep_mem_id = null, string rep_reason = null)
    {
        this.rep_no = rep_no;
        this.trv_no = trv_no;
        this.rep_timestap = rep_timestap;
        this.rep_mem_id = rep_mem_id;
        this.rep_reason = rep_reason;
    }

    public string Rep_no { get => rep_no; set => rep_no = value; }
    public string Trv_no { get => trv_no; set => trv_no = value; }
    public string Rep_timestap { get => rep_timestap; set => rep_timestap = value; }
    public string Rep_mem_id { get => rep_mem_id; set => rep_mem_id = value; }
    public string Rep_reason { get => rep_reason; set => rep_reason = value; }

    public override bool Equals(object obj)
    {
        var report = obj as Report;
        return report != null &&
               rep_no == report.rep_no &&
               trv_no == report.trv_no &&
               rep_timestap == report.rep_timestap &&
               rep_mem_id == report.rep_mem_id &&
               rep_reason == report.rep_reason;
    }

    public override int GetHashCode()
    {
        var hashCode = -1341125686;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(rep_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(rep_timestap);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(rep_mem_id);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(rep_reason);
        return hashCode;
    }
}