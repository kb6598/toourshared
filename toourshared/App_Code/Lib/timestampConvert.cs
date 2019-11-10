using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// timestampConvert의 요약 설명입니다.
/// </summary>
public static class timestampConvert
{
    public static string TimeStampToString(string timestamp)
    {
        string paramStr = timestamp;
        // yyyy-mm-dd 오전/오후 HH:MM:SS (H가 12이상이면 오후, 미만이면 오전)
        string[] splitArr = paramStr.Split(new char[] { ' ' });
        string YMD = splitArr[0];
        string MAD = splitArr[1];
        string HMS = splitArr[2];

        if (string.IsNullOrEmpty(YMD) == true || string.IsNullOrEmpty(MAD) == true || string.IsNullOrEmpty(HMS) == true)
        {
            // 하나라도 NULL OR "" 일 경우 
            return paramStr;
        }
        else
        {
            string[] ymdArr = YMD.Split(new char[] { '-' });
            string YEAR = ymdArr[0];
            string MONTH = ymdArr[1];
            string DAY = ymdArr[2];
            YEAR = YEAR.Substring(2, 2);

            string[] hmsArr = HMS.Split(new char[] { ':' });
            string HOUR = hmsArr[0];
            string MINUTE = hmsArr[1];
            string SECOND = hmsArr[2];

            int i_hour = int.Parse(HOUR.ToString());
            if (MAD == "오후")
                i_hour += 12;

            HOUR = i_hour.ToString();

            string returnStr = MONTH + "-" + DAY + "  " + HOUR + ":" + MINUTE;
            return returnStr;
        }
    }
}