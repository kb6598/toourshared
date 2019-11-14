using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Video의 요약 설명입니다.
/// </summary>
public class Video
{
    private string vid_no;
    private string mem_id;
    private string vid_name;
    private string vid_caption;
    public Video()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public Video(string vid_no = "", string mem_id = "", string vid_name = "", string vid_caption = "")
    {
        this.Vid_no = vid_no;
        this.Mem_id = mem_id;
        this.Vid_name = vid_name;
        this.Vid_caption = vid_caption;
    }

    public string Vid_no { get => vid_no; set => vid_no = value; }
    public string Mem_id { get => mem_id; set => mem_id = value; }
    public string Vid_name { get => vid_name; set => vid_name = value; }
    public string Vid_caption { get => vid_caption; set => vid_caption = value; }

    public override bool Equals(object obj)
    {
        return obj is Video video &&
               Vid_no == video.Vid_no &&
               Mem_id == video.Mem_id &&
               Vid_name == video.Vid_name &&
               Vid_caption == video.Vid_caption;
    }

    public override int GetHashCode()
    {
        var hashCode = -2105617567;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Vid_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_id);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Vid_name);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Vid_caption);
        return hashCode;
    }
}