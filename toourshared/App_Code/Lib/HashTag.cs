using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// HashTag의 요약 설명입니다.
/// </summary>
public static class HashTag
{   
    public static List<String> Split(String hashtagParam) // 해쉬태그가 들어있는 문자열을 분류해서 List로 반환하는 메소드
    {
        List<String> Lists = new List<String>(); // 반환할 List 객체
        string[] strArr = hashtagParam.Split(new char[] { ' ' }); // 스페이스바 기준으로 분류하기 때문에 스페이스바로 스플릿

        for(int i = 0; i < strArr.Length; i++) // 배열의 수 만큼 for문 반복
        {
            Lists.Add(strArr[i]);
        }

        return Lists;
    }
}