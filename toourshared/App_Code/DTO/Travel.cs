using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Travel의 요약 설명입니다.
/// </summary>
public class Travel
{
    private string trv_no;
    private string trv_secret;
    private string trv_views;
    private string trv_tot_rate;
    private string trv_main_img;
    private string trv_title;
    private string trv_tag;
    private string trv_timestamp;
    private string trv_create_time;
    private string loc_name;
    private string mem_id;
    public Travel()
    {
 
        this.trv_secret = "";
        this.trv_views = "";
        this.trv_tot_rate = "";
        this.trv_main_img = "";
        this.trv_title = "";
        this.trv_tag = "";
        this.trv_timestamp = "";
        this.trv_create_time = "";
        this.loc_name = "";
        this.mem_id = "";
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public string Trv_no { get => trv_no; set => trv_no = value; }
    public string Trv_secret { get => trv_secret; set => trv_secret = value; }
    public string Trv_views { get => trv_views; set => trv_views = value; }
    public string Trv_tot_rate { get => trv_tot_rate; set => trv_tot_rate = value; }
    public string Trv_main_img { get => trv_main_img; set => trv_main_img = value; }
    public string Trv_title { get => trv_title; set => trv_title = value; }
    public string Trv_tag { get => trv_tag; set => trv_tag = value; }
    public string Trv_timestamp { get => trv_timestamp; set => trv_timestamp = value; }
    public string Trv_create_time { get => trv_create_time; set => trv_create_time = value; }
    public string Loc_name { get => loc_name; set => loc_name = value; }
    public string Mem_id { get => mem_id; set => mem_id = value; }

    public override bool Equals(object obj)
    {
        return obj is Travel travel &&
               trv_no == travel.trv_no &&
               trv_secret == travel.trv_secret &&
               trv_views == travel.trv_views &&
               trv_tot_rate == travel.trv_tot_rate &&
               trv_main_img == travel.trv_main_img &&
               trv_title == travel.trv_title &&
               trv_tag == travel.trv_tag &&
               trv_timestamp == travel.trv_timestamp &&
               trv_create_time == travel.trv_create_time &&
               loc_name == travel.loc_name &&
               mem_id == travel.mem_id;
    }

    public override int GetHashCode()
    {
        var hashCode = 1521174393;
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_no);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_secret);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_views);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_tot_rate);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_main_img);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_title);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_tag);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_timestamp);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(trv_create_time);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(loc_name);
        hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_id);
        return hashCode;
    }
}