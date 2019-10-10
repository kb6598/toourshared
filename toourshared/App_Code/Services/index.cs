using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using tooushared.Lib;
using tooushared.DAO;
using tooushared.DTO;

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
        Member member = new Member('skvudrms54','0','010-2981-2222','1234','나평근','M','출신 초등학교는?','부천남초등학교',)
        memberDao.InsertMember();
    }
}