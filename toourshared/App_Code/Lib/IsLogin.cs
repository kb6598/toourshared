using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// IsLogin의 요약 설명입니다.
/// </summary>
public class IsLogin
{
    public IsLogin()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public static bool isLogin()
    {
        
        if (HttpContext.Current.Session["mem_id"] == null) return false;
        else return true;
    }
}