using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Image의 요약 설명입니다.
/// </summary>
public class Image
{
    private string img_no;
    private string mem_id;
    private string img_view_name;
    private string img_caption;

    public Image(string img_no = "", string mem_id = "", string img_view_name = "", string img_caption = "")
    {
        this.Img_no = img_no;
        this.Mem_id = mem_id;
        this.Img_view_name = img_view_name;
        this.Img_caption = img_caption;
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Img_no { get => img_no; set => img_no = value; }
    public string Mem_id { get => mem_id; set => mem_id = value; }
    public string Img_view_name { get => img_view_name; set => img_view_name = value; }
    public string Img_caption { get => img_caption; set => img_caption = value; }

    public override bool Equals(object obj)
    {
        return obj is Image image &&
               Img_no == image.Img_no &&
               Mem_id == image.Mem_id &&
               Img_view_name == image.Img_view_name &&
               Img_caption == image.Img_caption;
    }

    public override int GetHashCode()
    {
        var hashCode = -1234862073;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Img_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Mem_id);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Img_view_name);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Img_caption);
        return hashCode;
    }
}