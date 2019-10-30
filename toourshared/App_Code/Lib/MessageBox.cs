using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// MessageBox의 요약 설명입니다.
/// </summary>
public static class MessageBox
{
    public static void Show(string message, Page page)
    {
        page.ClientScript.RegisterStartupScript(page.GetType(), "MessageBox", "alert(\"" + message.Replace(@"\", @"\\") + "\");", true);

        // 가져다가 쓸때 예시 : MessageBox.Show("내용", this.Page)
    }
}