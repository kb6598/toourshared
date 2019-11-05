using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// getSession의 요약 설명입니다.
/// </summary>
public class SessionLib
{
    public SessionLib()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public static Dictionary<string, string> getWriteStatus()
    {

        if (HttpContext.Current.Session["write_status"] != null)
        {
            Dictionary<string, string> readWriteStatus = new Dictionary<string, string>();
            readWriteStatus = (Dictionary<string, string>)HttpContext.Current.Session["write_status"];

            //세션에서 편집 정보를 가져옴
            return readWriteStatus;
        }
        return null;
    }
}