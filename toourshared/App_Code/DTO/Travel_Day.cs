using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Travel_Day의 요약 설명입니다.
/// </summary>
public class Travel_Day
{
    private string trv_day_no;
    private string trv_day_content;
    private string trv_no;

    public Travel_Day()
    {
      
        this.trv_day_content = "";
        this.trv_no = "";
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Trv_day_no { get => trv_day_no; set => trv_day_no = value; }
    public string Trv_day_content { get => trv_day_content; set => trv_day_content = value; }
    public string Trv_no { get => trv_no; set => trv_no = value; }

    public override bool Equals(object obj)
    {
        return obj is Travel_Day day &&
               trv_day_no == day.trv_day_no &&
               trv_day_content == day.trv_day_content &&
               trv_no == day.trv_no;
    }

    public override int GetHashCode()
    {
        var hashCode = 1839752475;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_day_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_day_content);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_no);
        return hashCode;
    }
}