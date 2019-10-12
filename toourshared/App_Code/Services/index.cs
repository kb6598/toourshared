using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using tooushared.DAO;
using tooushared.DTO;
using tooushared.Lib;



/// <summary>
/// index의 요약 설명입니다.
/// index 페이지에 필요한 서비스를 정의
/// DAO를 이용하여 최종 결과물 생성
/// </summary>
public class index
{
    public index()
    {

        MemberDao memberDao = new MemberDao();
        Member member = new Member("skvudrms54", "0", "010-8892-3312", "skvudrms54", "나평근", "남", "출신 초등학교는?", "부천남초등학교", "19950519", "skvudrms54@naver.com", TimeLib.GetToday(), TimeLib.GetToday(), "upload/skvudrms54/img/1.jpg");
        memberDao.InsertMember(member);
    }
    static void Main(string[] args)
    {
        MemberDao memberDao = new MemberDao();
        Member member = new Member("skvudrms54", "0", "010-8892-3312", "skvudrms54", "나평근", "남", "출신 초등학교는?", "부천남초등학교", "19950519", "skvudrms54@naver.com", TimeLib.GetToday(), TimeLib.GetToday(), "upload/skvudrms54/img/1.jpg");
        memberDao.InsertMember(member);


        List<Member> lstMembers = memberDao.selectMember();


        foreach(var i in lstMembers)
        {
            Console.WriteLine(i.Mem_id +":"+i.Mem_name);
        }
    }
}