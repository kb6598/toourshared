<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("./index.aspx");
    }

    protected void btnMypage_Click(object sender, EventArgs e)
    {
        if(Session["mem_id"] == null)
        {
            return;
        }
        else
        {
            string QueryString = Session["mem_id"].ToString(); // 현재 세션의 마이 페이지로 가야 하므로 세션 ToString() 받아서 redirect에 넘김
            Response.Redirect("./MyPage.aspx?mem_id=" + QueryString);
        }
    }

    protected void btnJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("./join.aspx");
    }

    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("./find_idpw.aspx");
    }


    //최신순
    protected string orderByTime()
    {
        string memberMainImage = ""; // 작성자 메인 이미지
        string travelMainImage = ""; // 게시글 메인 이미지
        string locName = ""; // 선택한 지역 명
        int locIndex = 0; // 쿼리스트링 받아올 인덱스 변수(locArr에 사용할 변수)
        int trCount = 0; // 테이블 <tr> 태그 적당할 때 넣어주기 위한 변수
        string[] locArr = new string[] { "", "서울", "경기", "인천", "충청", "강원", "전라", "경상", "제주" };

        if (Request.QueryString["loc"] != null) // 지역선택한 게 있을 때(쿼리스트링이 존재할 때)
        {
            locIndex = int.Parse(Request.QueryString["loc"].ToString());
            locName = locArr[locIndex];
        }

        Member member; // 작성자의 데이터를 긁어올 DTO 변수 선언
        Travel_Day travelDay; // 게시글 내용을 긁어올 DTO 변수 선언

        MemberDao memberDao = new MemberDao(); // 작성자 데이터 접근을 위한 DAO
        TravelDao travelDao = new TravelDao(); // 게시글 데이터에 접근하기 위한 DAO
        Travel_DayDao travelDayDao = new Travel_DayDao(); // 게시글 내용에 접근하기 위한 DAO
        List<Travel> travelList = travelDao.getIndexTravelOrderByCreateTimeDesc(locName); // 인덱스에 나타낼 Travel(최신순) (limit 0, 6);

        String returnStr = "                                <div class = \"SlideBody\">\n" +
                                "                                    <table>\n" +
                                "                                        <tr>\n";

        for (int i = 0; i < travelList.Count; i++)
        {
            member = new Member(); // DTO 객체 생성
            member.Mem_id = travelList[i].Mem_id;
            member = memberDao.selectMemberByMem_id(member); // 게시글의 작성자를 파라미터 값으로(member DTO) 가지는 DAO에 접근하여 memberDTO 반환

            memberMainImage = member.Mem_img_url; // 반환받은 memberDTO 객체의 메인이미지를 뿌려준다.
            if (string.IsNullOrEmpty(memberMainImage) || memberMainImage == "noImage") // 변수에 담긴 값이 null, Empty, noImage 일 경우
                memberMainImage = "./img/memberNoImage.png";

            travelMainImage = travelList[i].Trv_main_img; // 게시글의 메인 이미지를 가져온다.
            if (string.IsNullOrEmpty(travelMainImage) || travelMainImage == "noImage") // 변수에 담긴 값이 null, Empty, noImage 일 경우
                travelMainImage = "./img/noImage.png";

            travelDay = new Travel_Day();
            travelDay.Trv_no = travelList[i].Trv_no;
            travelDay = travelDayDao.selectTravelDayByTrvNo(travelDay); // 게시글 번호를 파라미터 값으로(travel_day DTO) 가지는 DAO에 접근하여 travel_dayDTO 반환

            returnStr += "" +
                   "<td>\n" +
                    "   <div class=\"tableContainer\">\n" +
                    "       <img src=\"" + travelMainImage + "\" alt=\"" + travelMainImage + "_mainImage\"/>\n" +
                    "       <div class=\"tableOverlay\">\n" +
                    "           <div class=\"tableText\">\n" +
                    "               <div class=\"tableInfo\">\n" +
                    "                   <div class = \"tableImage\">\n" +
                    "                       <a href = \"MyPage.aspx?mem_id=" + travelList[i].Mem_id + "\">" +
                    "                           <img src = \"" + memberMainImage + "\" alt=\"" + memberMainImage + "_mainImage\"/ style=\"width: 40px; height: 40px; border-radius: 100%; border:none;\">" +
                    "                       </a>\n" +
                    "                   </div>\n" +
                    "                   <div class=\"tableUserInfo\">\n" +
                    "                       <div class=\"tableUserName\">\n" +
                    "                           <a href = \"MyPage.aspx?mem_id=" + travelList[i].Mem_id + "\">" + travelList[i].Mem_id + "</a>\n" +
                    "                       </div>\n" +
                    "                       <div class=\"tableTime\">" + timestampConvert.TimeStampToString(travelList[i].Trv_create_time) + "</div>\n" +
                    "                   </div>\n" +
                    "                   <div class = \"tableGoUrl\">\n" +
                    "                       <a href = \"board.aspx?trv_no=" + travelList[i].Trv_no + "\" class=\"goUrlItem\">" +
                    "                           <i class='far fa-arrow-alt-circle-right'></i>" +
                    "                       </a>\n" +
                    "                   </div>\n" +
                    "               </div>\n" +
                    "               <div class=\"tableData\">\n" +
                    "                   <div class=\"tableBody\">" + travelDay.Trv_day_content + "</div>\n" +
                    "               </div>\n" +
                    "           </div>\n" +
                    "       </div>\n" +
                    "   </div>\n" +
                    "</td>\n";

            trCount++;
            if (trCount >= 3)
            {
                trCount = 0;
                returnStr += "" +
                    "</tr>\n" +
                    "<tr>\n";
            }
        }

        returnStr += "" +
            "</tr>\n" +
            "</table>\n" +
            "</div>\n";

        return returnStr;
    }

    // 평점순
    protected string orderByTotRate()
    {
        string memberMainImage = ""; // 작성자 메인 이미지
        string travelMainImage = ""; // 게시글 메인 이미지
        string locName = ""; // 선택한 지역 명
        int locIndex = 0; // 쿼리스트링 받아올 인덱스 변수(locArr에 사용할 변수)
        int trCount = 0; // 테이블 <tr> 태그 적당할 때 넣어주기 위한 변수
        string[] locArr = new string[] { "", "서울", "경기", "인천", "충청", "강원", "전라", "경상", "제주" };

        if (Request.QueryString["loc"] != null) // 지역선택한 게 있을 때(쿼리스트링이 존재할 때)
        {
            locIndex = int.Parse(Request.QueryString["loc"].ToString());
            locName = locArr[locIndex];
        }

        Member member; // 작성자의 데이터를 긁어올 DTO 변수 선언
        Travel_Day travelDay; // 게시글 내용을 긁어올 DTO 변수 선언

        MemberDao memberDao = new MemberDao(); // 작성자 데이터 접근을 위한 DAO
        TravelDao travelDao = new TravelDao(); // 게시글 데이터에 접근하기 위한 DAO
        Travel_DayDao travelDayDao = new Travel_DayDao(); // 게시글 내용에 접근하기 위한 DAO
        List<Travel> travelList = travelDao.getIndexTravelOrderByTotRateDesc(locName); // 인덱스에 나타낼 Travel(평점순) (limit 0, 6);

        String returnStr = "                                <div class = \"SlideBody\">\n" +
                                "                                    <table>\n" +
                                "                                        <tr>\n";

        for (int i = 0; i < travelList.Count; i++)
        {
            member = new Member(); // DTO 객체 생성
            member.Mem_id = travelList[i].Mem_id;
            member = memberDao.selectMemberByMem_id(member); // 게시글의 작성자를 파라미터 값으로(member DTO) 가지는 DAO에 접근하여 memberDTO 반환

            memberMainImage = member.Mem_img_url; // 반환받은 memberDTO 객체의 메인이미지를 뿌려준다.
            if (string.IsNullOrEmpty(memberMainImage) || memberMainImage == "noImage") // 변수에 담긴 값이 null, Empty, noImage 일 경우
                memberMainImage = "./img/memberNoImage.png";

            travelMainImage = travelList[i].Trv_main_img; // 게시글의 메인 이미지를 가져온다.
            if (string.IsNullOrEmpty(travelMainImage) || travelMainImage == "noImage") // 변수에 담긴 값이 null, Empty, noImage 일 경우
                travelMainImage = "./img/noImage.png";

            travelDay = new Travel_Day();
            travelDay.Trv_no = travelList[i].Trv_no;
            travelDay = travelDayDao.selectTravelDayByTrvNo(travelDay); // 게시글 번호를 파라미터 값으로(travel_day DTO) 가지는 DAO에 접근하여 travel_dayDTO 반환

            returnStr += "" +
                   "<td>\n" +
                    "   <div class=\"tableContainer\">\n" +
                    "       <img src=\"" + travelMainImage + "\" alt=\"" + travelMainImage + "_mainImage\"/>\n" +
                    "       <div class=\"tableOverlay\">\n" +
                    "           <div class=\"tableText\">\n" +
                    "               <div class=\"tableInfo\">\n" +
                    "                   <div class = \"tableImage\">\n" +
                    "                       <a href = \"MyPage.aspx?mem_id=" + travelList[i].Mem_id + "\">" +
                    "                           <img src = \"" + memberMainImage + "\" alt=\"" + memberMainImage + "_mainImage\"/ style=\"width: 40px; height: 40px; border-radius: 100%; border:none;\">" +
                    "                       </a>\n" +
                    "                   </div>\n" +
                    "                   <div class=\"tableUserInfo\">\n" +
                    "                       <div class=\"tableUserName\">\n" +
                    "                           <a href = \"MyPage.aspx?mem_id=" + travelList[i].Mem_id + "\">" + travelList[i].Mem_id + "</a>\n" +
                    "                       </div>\n" +
                    "                       <div class=\"tableTime\">" + timestampConvert.TimeStampToString(travelList[i].Trv_create_time) + "</div>\n" +
                    "                   </div>\n" +
                    "                   <div class = \"tableGoUrl\">\n" +
                    "                       <a href = \"board.aspx?trv_no=" + travelList[i].Trv_no + "\" class=\"goUrlItem\">" +
                    "                           <i class='far fa-arrow-alt-circle-right'></i>" +
                    "                       </a>\n" +
                    "                   </div>\n" +
                    "               </div>\n" +
                    "               <div class=\"tableData\">\n" +
                    "                   <div class=\"tableBody\">" + travelDay.Trv_day_content + "</div>\n" +
                    "               </div>\n" +
                    "           </div>\n" +
                    "       </div>\n" +
                    "   </div>\n" +
                    "</td>\n";

            trCount++;
            if (trCount >= 3)
            {
                trCount = 0;
                returnStr += "" +
                    "</tr>\n" +
                    "<tr>\n";
            }
        }

        returnStr += "" +
            "</tr>\n" +
            "</table>\n" +
            "</div>\n";

        return returnStr;
    }

    // 구독자 순
    protected string orderByFollower()
    {
        string memberMainImage = ""; // 작성자 메인 이미지
        string travelMainImage = ""; // 게시글 메인 이미지
        string locName = ""; // 선택한 지역 명
        int locIndex = 0; // 쿼리스트링 받아올 인덱스 변수(locArr에 사용할 변수)
        int trCount = 0; // 테이블 <tr> 태그 적당할 때 넣어주기 위한 변수
        string[] locArr = new string[] { "", "서울", "경기", "인천", "충청", "강원", "전라", "경상", "제주" };

        if (Request.QueryString["loc"] != null) // 지역선택한 게 있을 때(쿼리스트링이 존재할 때)
        {
            locIndex = int.Parse(Request.QueryString["loc"].ToString());
            locName = locArr[locIndex];
        }

        Member member; // 작성자의 데이터를 긁어올 DTO 변수 선언
        Travel_Day travelDay; // 게시글 내용을 긁어올 DTO 변수 선언

        MemberDao memberDao = new MemberDao(); // 작성자 데이터 접근을 위한 DAO
        TravelDao travelDao = new TravelDao(); // 게시글 데이터에 접근하기 위한 DAO
        Travel_DayDao travelDayDao = new Travel_DayDao(); // 게시글 내용에 접근하기 위한 DAO
        List<Travel> travelList = travelDao.getIndexTravelOrderByFollowerDesc(locName); // 인덱스에 나타낼 Travel(평점순) (limit 0, 6);

        String returnStr = "                                <div class = \"SlideBody\">\n" +
                                "                                    <table>\n" +
                                "                                        <tr>\n";

        for (int i = 0; i < travelList.Count; i++)
        {
            member = new Member(); // DTO 객체 생성
            member.Mem_id = travelList[i].Mem_id;
            member = memberDao.selectMemberByMem_id(member); // 게시글의 작성자를 파라미터 값으로(member DTO) 가지는 DAO에 접근하여 memberDTO 반환

            memberMainImage = member.Mem_img_url; // 반환받은 memberDTO 객체의 메인이미지를 뿌려준다.
            if (string.IsNullOrEmpty(memberMainImage) || memberMainImage == "noImage") // 변수에 담긴 값이 null, Empty, noImage 일 경우
                memberMainImage = "./img/memberNoImage.png";

            travelMainImage = travelList[i].Trv_main_img; // 게시글의 메인 이미지를 가져온다.
            if (string.IsNullOrEmpty(travelMainImage) || travelMainImage == "noImage") // 변수에 담긴 값이 null, Empty, noImage 일 경우
                travelMainImage = "./img/noImage.png";

            travelDay = new Travel_Day();
            travelDay.Trv_no = travelList[i].Trv_no;
            travelDay = travelDayDao.selectTravelDayByTrvNo(travelDay); // 게시글 번호를 파라미터 값으로(travel_day DTO) 가지는 DAO에 접근하여 travel_dayDTO 반환

            returnStr += "" +
                   "<td>\n" +
                    "   <div class=\"tableContainer\">\n" +
                    "       <img src=\"" + travelMainImage + "\" alt=\"" + travelMainImage + "_mainImage\"/>\n" +
                    "       <div class=\"tableOverlay\">\n" +
                    "           <div class=\"tableText\">\n" +
                    "               <div class=\"tableInfo\">\n" +
                    "                   <div class = \"tableImage\">\n" +
                    "                       <a href = \"MyPage.aspx?mem_id=" + travelList[i].Mem_id + "\">" +
                    "                           <img src = \"" + memberMainImage + "\" alt=\"" + memberMainImage + "_mainImage\"/ style=\"width: 40px; height: 40px; border-radius: 100%; border:none;\">" +
                    "                       </a>\n" +
                    "                   </div>\n" +
                    "                   <div class=\"tableUserInfo\">\n" +
                    "                       <div class=\"tableUserName\">\n" +
                    "                           <a href = \"MyPage.aspx?mem_id=" + travelList[i].Mem_id + "\">" + travelList[i].Mem_id + "</a>\n" +
                    "                       </div>\n" +
                    "                       <div class=\"tableTime\">" + timestampConvert.TimeStampToString(travelList[i].Trv_create_time) + "</div>\n" +
                    "                   </div>\n" +
                    "                   <div class = \"tableGoUrl\">\n" +
                    "                       <a href = \"board.aspx?trv_no=" + travelList[i].Trv_no + "\" class=\"goUrlItem\">" +
                    "                           <i class='far fa-arrow-alt-circle-right'></i>" +
                    "                       </a>\n" +
                    "                   </div>\n" +
                    "               </div>\n" +
                    "               <div class=\"tableData\">\n" +
                    "                   <div class=\"tableBody\">" + travelDay.Trv_day_content + "</div>\n" +
                    "               </div>\n" +
                    "           </div>\n" +
                    "       </div>\n" +
                    "   </div>\n" +
                    "</td>\n";

            trCount++;
            if (trCount >= 3)
            {
                trCount = 0;
                returnStr += "" +
                    "</tr>\n" +
                    "<tr>\n";
            }
        }

        returnStr += "" +
            "</tr>\n" +
            "</table>\n" +
            "</div>\n";

        return returnStr;
    }

    protected string localCodeToName()
    {
        if (Request.QueryString["loc"] != null)
        {
            string[] strArray = new string[] { "전", "서울", "경기", "인천", "충청", "강원", "전라", "경상", "제주" };
            int code = int.Parse(Request.QueryString["loc"].ToString());
            string returnStr = "<span style=\"color: orange;\">";

            returnStr += strArray[code] + " 지역 ";
            returnStr += "</span>";

            return returnStr;
        }
        else
        {
            string returnStr = "<span style=\"color: orange;\">전 지역 </span>";
            return returnStr;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.inpTxt.Attributes["onkeyPress"] = "if(event.keyCode == 13) {" + Page.GetPostBackEventReference(this.inputBtn) + "; return false; }";       // 아이디 입력창에서 ENTER 키 누를 때 BtnLogin이 눌러지도록.
    }

    // 검색 창 옆에 있는 버튼 눌렀을 경우 발생할 이벤트
    protected void inputBtn_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(inpTxt.Text))
            return;
        else
        {
            Response.Redirect("./search.aspx?searchType=1&text=" + inpTxt.Text);
        }
    }
</script>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|Jua&display=swap" rel="stylesheet">

    <!-- Icon -->
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            list-style: none;

            line-height: 1;

            /* 전체 배경색 */
            background-color: #00b9f1;
            background-repeat: no-repeat;
            animation: animBackColor 5s infinite;
            animation-direction: alternate;
        }

        .topnavUl {
            margin: 0;
            padding: 0;

            list-style: none;
            text-decoration: none;

            font-size: 20px;
            font-family: '맑은고딕';
        }

        .topnavLi {
            margin: 0;
            padding: 0;

            list-style: none;
            text-decoration: none;

            font-size: 20px;
            font-family: '맑은고딕';

            cursor : default;
        }

        .topnavLi ul,
        li {
            list-style: none;
            text-decoration: none;
            padding: 0;
            margin: 0;
        }

        a {
            color: white;
            text-decoration: none;
        }

        #nav {
            z-index: 99999;
            position: absolute;
            width: 100%;
            /* absolute는 부피를 못잡으니까 width 100% */
            overflow: hidden;
            font-size: 25px;

            transition-duration: 0.5s;
            position: fixed;

        }

        #nav:hover {
            height: 250px;
            transition: background .5s;
            background-color: rgba(249, 192, 12, 0.95);
        }

        #nav>ul {
            text-align: center;
            font-family: 'Mansalva', cursive;
            font-size: 25px;
        }

        #nav>ul>li {
            display: inline-block;
            position: relative;

            padding: 0px 50px;
        }

        #nav>ul>li>a {
            display: block;
            padding: 30px 15px 20px;
            line-height: 30px;
            transition: color 0.9s;
            transition: background 0.4s;

            /* 부트스트랩 적용 후 nav 효과 적용이 되는걸 방지하기 위해 */
            text-decoration: none;


            /* 상단 메뉴 글씨 색 */
            color: white;
        }

        #nav>ul>li:hover>a {
            /* 메뉴에 마우스 올렸을 때 발생할 스타일(1Depth) */
            transition: border .5s;
            border-bottom: 3px solid #ff7473;

        }

        #nav ul ul {
            /*display: none;*/
            position: absolute;
            width: 100%;
            /* absolute는 부피를 가질 수 없다 */
            margin: 0px -50px;
        }

        #nav ul ul a {
            /* 2Depth li Style */
            display: block;
            line-height: 40px;
            font-size: 14px;
            color: white;
        }

        #nav ul ul a:hover {
            /* SubMenu 마우스 올렸을 때 발생할 스타일 */
            font-weight: bold;

            /* 부트스트랩 적용 후 nav 효과 적용이 되는걸 방지하기 위해 */
            text-decoration: none;
        }

        #nav li:hover ul {
            display: block;
        }

        #nav li:nth-child(1) ul {
            left: 0;
            width: 100%;
        }

        .nav-logo {
            /* 웹 사이트 좌측 상단에 위치한 로고 div style */
        }

        .nav-logo-item {
            font-family: 'Mansalva', cursive;
            font-size: 25px;
            transition-duration: .5s;
        }

        .nav-logo-item:hover {
            transition-duration: .5s;
            font-size: 28px;
            color: white;

            /* 부트스트랩 적용 후 텍스트에 적용되는 효과 방지를 위해 */
            text-decoration: none;
        }

        .nav-log-area {
            /* 로그인, 로그아웃 영역 */
            width: 150px;
            height: 40px;

            padding-bottom: 5px;
            border: 2px solid white;
            border-radius: 15px;

            transition: .5s;

        }

        .nav-log-item {
            font-size: 20px;
            border: none;
            outline: none;
            cursor: pointer;

            margin-top: 8px;
            color: white;
            background-color: transparent;
        }

        .navJoinBtn{
            border: none;
            outline: none;
            background-color: transparent;
            color: white;
            font-size: 14px;
            padding-bottom: 20px;
        }

        .navFindBtn:hover, .navJoinBtn:hover{
            font-weight: bold;
        }

        .navFindBtn{
            border: none;
            outline: none;
            background-color: transparent;
            color: white;
            font-size: 14px;
        }

        /* 창 크기 조절 시 nav display none 설정 */
        @media only screen and (max-width: 1600px) {
            .topnav {
                display: none;
            }

            .topnav>ul>li>.nav-logo>.nav-logo-item {
                float: left;
                display: block;
            }
        }

        .section {
            text-align: center;
            padding-top: 21px;

            color: white;
        }

        .section01 {
            text-align: center;
            display: inline-block;

            /* 배경 높이 */
            height: 700px;
        }

        .section01-title {
            padding: 50px 0px 30px;
            transition-duration: .9s;
        }

        .section01-title:hover {
            text-shadow: 1px 2px 15px rgb(255, 255, 255);
            transition-duration: .9s;
        }

        .section01-title1 {
            font-size: 45px;
            font-weight: bold;
            font-family: 'Mansalva', cursive;

            cursor: default;
            /* Title 그림자 */
            /*text-shadow: 0px 0px 15px;*/
        }

        .section01-title2 {
            cursor: default;
            font-size: 12px;
            font-family: 'Nanum Gothic', sans-serif;
        }

        .section01-input {
            width: 500px;
            display: flex;
            background-color: white;
            border-radius: 5px;
        }

        .section01-inputText1 {
            width: 450px;
            padding: 15px 15px 18px 17px;
            border: none;
            line-height: 17px;
            font-size: 14px;
            color: #9b9b9b;
            box-sizing: border-box;
            outline: none;
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .section01-inputButton1 {
            width: 50px;
            height: 50px;
            border: none;
            outline: none;
            cursor: pointer;
            box-sizing: border-box;
            transition-duration: .5s;
            color: black;
            background-color: #FFBC42;
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
        }

        .section01-inputButton1:hover {
            opacity: .5s;
            background-color: #505898;
            transition-duration: .5s;
        }

        .section02 {
            height: 880px;
            color: black;

            background-color: #f4f5f9;
        }

        .area {
            width: 100%;
            height: 180px;
        }

        .areaImage {
            max-width: 100%;
            height: inherit;
            background: url(./img/areaImage.jpg) no-repeat center 0;
            background-repeat: no-repeat;
        }

        .areaContent {
            margin: 0 auto;
            width: 1100px;
        }

        .areaAlign {
            display: flex;
            position: relative;
        }

        .areaItem {
            display: flex;
        }

        .areaTxt {
            width: 330px;
        }

        .areaItem h2 {
            position: absolute;
            left: -2px;
            top: 53px;
            font-size: 26px;
            font-weight: 500;
            letter-spacing: -2px;
            color: #fff;
            font-weight: normal;
            text-align: left;
        }

        .areaSlide {
            width: 770px;
            height: 180px;
            display: flex;
        }

        .carousel-inner {
            top: 5px;
            width: 700px;
            padding: 0px 150px 0;
        }

        .carousel-inner img {
            width: 220px;
            height: 135px;
        }

        .carousel-item a {
            text-decoration: none;
        }

        .carousel-item a:hover .carousel-img-sty {
            transition-duration: .5s;

        }

        .carousel-detail {
            display: flex;
        }

        .carousel-img {
            padding-left: 60px;
        }

        .carousel-img-sty {
            /*border-radius: 15px;*/
            border-radius: 15px;
            border: 1px solid white;
        }

        .carousel-txt {
            width: 220px;
            height: 135px;

            text-align: center;
            padding-top: 55px;
            padding-left: 10px;

            color: white;
            text-decoration: none;
        }

        sub {
            font-size: 55%;
            line-height: 0;
            position: relative;
            vertical-align: baseline;
        }

        /* mainSlide */

        .mainSlide {
            width: 100%;
            height: 800px;
            display: inline-block;
            text-align: center;
            position: relative;
        }

        .mainSlideContainer {
            width: 100%;
        }

        .carousel-indicators {
            position: absolute;
            display: -ms-flexbox;
            display: flex;
            flex-direction: row;
            -ms-flex-pack: center;
            justify-content: center;
            align-items: center;
            padding-left: 0;
            margin-right: 15%;
            margin-left: 15%;
            list-style: none;
        }

        .mainSlide .mainSlideContainer .carousel-indicators ol {
            margin-top: 0px;
            margin-bottom: 1rem;
        }

        .mainSlide .mainSlideContainer .carousel-indicators li {
            box-sizing: content-box;
            -ms-flex: 0 1 auto;
            flex: 0 1 auto;
            width: 30px;
            height: 5px;
            margin-right: 5px;
            margin-left: 5px;
            text-indent: -999px;
            cursor: pointer;
            background-color: #08182b;
            background-clip: padding-box;
            border-top: 10px solid transparent;
            border-bottom: 10px solid transparent;
            opacity: .5;
            transition: opacity .6s ease;
        }

        .mainSlide .mainSlideContainer .carousel-indicators .active {
            opacity: 1;
            background-color: #ee2560;
        }

        .mainSlide .mainSlideContainer .carousel-inner {
            display: inline-block;
            text-align: center;
            width: 1200px;
            height: 670px;
        }

        .mainSlide .mainSlideContainer .carousel-inner .carousel-item {
            padding: 30px 0px;
        }

        #mainSlide .carousel-control-prev {
            z-index: 1;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-align: center;
            align-items: center;
            -ms-flex-pack: center;
            justify-content: center;
            width: 100px;
            height: 80px;
            color: #fff;
            margin-top: 300px;
            margin-left: 100px;
            background-color: black;
            transition: opacity .85s ease;
        }

        #mainSlide .carousel-control-next {
            z-index: 1;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-align: center;
            align-items: center;
            -ms-flex-pack: center;
            justify-content: center;
            width: 100px;
            height: 80px;
            color: #fff;
            margin-top: 300px;
            margin-right: 100px;
            background-color: black;
            transition: opacity .85s ease;
        }

        .SlideTitle {
            padding: 0px 0px 20px;
            width: 100%;
        }

        .SlideTitle label {
            font-size: 16px;
            font-weight: 700;
            width: 150px;
            height: 50px;

            color: #272625;
            line-height: 45px;
        }

        .tableContainer {
            position: relative;
            width: 100%;
            height: auto;
        }

        .tableContainer img {
            display: block;
            width: 300px;
            height: 250px;

            border: 0.5px solid #a3a1a1;
        }

        .tableOverlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background-color: rgba(0, 0, 0, 0.85);
            overflow: hidden;
            width: 100%;
            height: 0;
            transition: .3s ease;
        }

        .tableContainer:hover .tableOverlay {
            height: 100%;
        }

        .tableText {
            color: white;
            font-size: 14px;
            position: absolute;
            top: 50%;
            left: 50%;
            -webkit-transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
            text-align: center;
        }

        .tableInfo {
            display: flex;
            flex-direction: row;
            align-items: center;
            padding-left: 5px;
            height: 50px;

            /* 사진과 영역의 가로를 같게 */
            width: 300px;
        }

        .tableGoUrl{
            display: flex;
            height: 50px;
            width: 300px;
            padding-right: 10px;
            font-size: 30px;
            align-items: center;
            justify-content: flex-end;
        }

        .tableInfo .tableUserName {
            width: 100%;
            height: 25px;
            text-align: left;
            padding: 5px 0px 0px 10px;

            font-size: 17px;
        }

        .tableInfo .tableTime {
            width: 100px;
            height: 10px;
            text-align: left;
            padding: 0px 0px 0px 10px;
        }

        .tableData {
            display: block;
            height: 200px;

            /* 사진과 영역의 세로를 같게 */
            width: 300px;
            padding: 10px;
            text-align: left;
            overflow-x: hidden;
            overflow-y: scroll;
        }

        .section03 {
            height: 750px;
            background-color: #dddfe6;
        }

        .relAndTou {
            display: flex;
        }

        .relArea {
            width: 50%;
            padding-top: 260px;
            padding-left: 100px;
        }

        .relArea:hover .exStyle {
            width: 450px;
            margin-top: -40px;
            transition-duration: .5s;
        }

        .exStyle {
            width: 250px;
            height: auto;

            border: 2px solid dimgray;
            border-radius: 8px;

            transition-duration: .5s;
        }

        .toupleArea {
            width: 50%;
            color: black;
            font-weight: 700;
            text-align: center;
            padding: 230px 70px 110px 0px;

            cursor: default;
            font-size: 50px;
        }

        .TOUPLE {
            padding: 20px;
        }

        .TOUR {
            padding-right: 35px;
        }

        .PEOPLE {
            padding-right: 20px;
        }

        .toupleArea:hover .toupleSpan1 {
            font-size: 70px;
            color: #fcbe32;
            padding-right: 30px;
            transition-duration: .5s;
            height: 350px;
        }

        .toupleSpan1 {
            width: 100%;
            transition-duration: .5s;
        }

        .toupleSpan2 {
            font-size: 50px;
        }

        .relTxt1 {
            color: black;
            padding: 15px 0px;
            font-size: 25px;
            font-family: 'Nanum Gothic', sans-serif;
            cursor: default;
        }

        .relTxt2 {
            width: auto;
            text-align: center;
            color: black;
            font-weight: 600;
            font-size: 14px;
            font-family: 'Nanum Gothic', sans-serif;
            cursor: default;
        }

        @keyframes animBackColor
        {
                0% { background-color: rgb(0, 185, 241); }
                50% { background-color: rgb(0, 162, 208); }
                100% { background-color: rgb(0, 141, 183); }
        }

    </style>

    <script language="javascript">
        /* scroll할 때 발생할 이벤트 */
        window.onscroll = function() {
            scrollFunction();
        }

        function scrollFunction() {
            var nav = $("nav");
            var v_scroll = $(window).scrollTop();

            if (v_scroll >= 20) {
                document.getElementById("nav").style.background = "rgba(249, 192, 12, 0.95)";
            } else if (v_scroll <= 0) {
                document.getElementById("nav").style.background = "";
            }
        }


        /* TOUPLE 텍스트 효과 (PLE) */

        $(function() {
            $('#tA').hover(function() {
                $('#ple').css('padding-left', '30px');
            }, function() {
                // on mouseout, reset the background colour
                $('#ple').css('padding-left', '');
            });
        });


        /* 버튼 VALUE 효과 */
        $(function() {
            $('#inputBtn').hover(function() {
                $('#inputBtn').val("🌝");
            }, function() {
                // on mouseout, reset the background colour
                $('#inputBtn').val("🌞");
            });
        });

    </script>

</head>

<body>
<form name="form1" runat="server">
    <!-- navbar 영역 -->
    <div id="nav" class="topnav">
        <ul class="topnavUl">
            <li class="topnavLi">
                <div class="nav-logo">
                    <a href="index.aspx" class="nav-logo-item">To Our Shared</a>
                </div>
            </li>
            <li class="topnavLi">
                <a>Intro</a>
                <ul>
                    <li><a href="#relAndTOU">TOUPLE</a></li>
                </ul>
            </li>
            <li class="topnavLi">
                <a>Shared</a>
                <ul>
                    <li><a href="search.aspx">검색</a></li>
                </ul>
            </li>
            <li class="topnavLi">
                <a>Event</a>
                <ul>
                    <li><a>진행중인 이벤트</a></li>
                    <li><a>종료된 이벤트</a></li>
                </ul>
            </li>
            <li class="topnavLi">
                <a>Help</a>
                <ul>
                    <li><a href="FAQ.aspx">자주 찾는 질문</a></li>
                </ul>
            </li>
        <% 
            if (IsLogin.isLogin() == false)
            {
        %>
            <li class="topnavLi">
                <div class="nav-log">
                    <a>
                        <div class="nav-log-area">
                            <asp:Button ID="btnLogin" runat="server" Text="로그인" class="nav-log-item" PostBackUrl="./login.aspx"/>
                        </div>
                    </a>
                </div>
                <ul>
                    <br />
                    <li><asp:Button ID="btnJoin" runat="server" Text="회원가입" OnClick="btnJoin_Click" class ="navJoinBtn"/></li>
                    <li><asp:Button ID="btnFindIDPW" runat="server" Text="계정찾기" OnClick="btnFindIDPW_Click" class ="navFindBtn" /></li>
                </ul>
            </li>
        <%  
            }
            else
            {
        %>
            <li class = "topnavLi" >
				<a><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                <ul>
                    <li><asp:Button ID="btnMypage" runat="server" Text="마이페이지" OnClick="btnMypage_Click" class ="navJoinBtn"/></li>
                    <li><asp:Button ID="btnLogout" runat="server" Text="로그아웃" OnClick="btnLogout_Click" class ="navFindBtn"/></li>

                </ul>
            </li>
        <% 
            }
        %>
        </ul>
    </div>

    <!-- 메인 영역 -->
    <div class="section">
        <!-- 검색 창 영역 -->
        <div class="section01">
            <div style="padding-top: 200px; padding-bottom: 30px;">
            </div>
            <div class="section01-title">
                <div class="section01-title1">
                    To Our Shared
                </div>
                <div class="section01-title2">
                    여행동안 겪었던 인상깊은 추억들을 공유해보세요.
                </div>
            </div>
            <div class="section01-input">
                <div>
                    <asp:TextBox ID="inpTxt" runat="server" Placeholder="키워드를 입력해보세요! ex) 커피, 제주도" CssClass="section01-inputText1"/>
                </div>
                <div>
                    <asp:Button ID="inputBtn" runat="server" Text="🌞" CssClass="section01-inputButton1" OnClick="inputBtn_Click"/>
                </div>
            </div>
        </div>

        <!-- 지역 선택 및 메인 슬라이드 영역 -->
        <div class="section02">

            <!-- 지역 선택 영역 -->
            <div class="area">
                <div class="areaImage">
                    <div class="areaContent">
                        <div class="areaAlign">
                            <div class="areaItem">
                                <div class="areaTxt">
                                    <h2>
                                        지역 검색<br />
                                        <sub>지역 명을 누르면 해당 지역의 리뷰를 확인하실 수 있습니다.</sub><br />
                                        <sub>전체/서울/경기/인천/충청/강원/전라/경상/제주</sub>
                                    </h2>
                                </div>
                                <div class="areaSlide">
                                    <div id="areas" class="carousel slide" data-ride="carousel">
                                        <!-- Indicators -->
                                        <ul class="carousel-indicators">
                                            <li data-target="#areas" data-slide-to="0" class="active"></li>
                                            <li data-target="#areas" data-slide-to="1"></li>
                                            <li data-target="#areas" data-slide-to="2"></li>
                                            <li data-target="#areas" data-slide-to="3"></li>
                                            <li data-target="#areas" data-slide-to="4"></li>
                                            <li data-target="#areas" data-slide-to="5"></li>
                                            <li data-target="#areas" data-slide-to="6"></li>
                                            <li data-target="#areas" data-slide-to="7"></li>
                                            <li data-target="#areas" data-slide-to="8"></li>
                                        </ul>

                                        <!-- The slideshow -->
                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=0">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/전체.png" alt="전 지역" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">전 지역</div>
                                                            <div class="carousel-txt-sub">ALL</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=1">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/서울.jpg" alt="서울" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">서울</div>
                                                            <div class="carousel-txt-sub">SEOUL</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=2">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/경기도.jpg" alt="경기도" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">경기도</div>
                                                            <div class="carousel-txt-sub">GYEONGGIDO</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=3">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/인천.jpg" alt="인천" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">인천</div>
                                                            <div class="carousel-txt-sub">INCHEON</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/충청도.jpg" alt="충청도" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">충청도</div>
                                                            <div class="carousel-txt-sub">CHUNGCHEONGDO</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=5">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/강원도.jpg" alt="강원도" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">강원도</div>
                                                            <div class="carousel-txt-sub">GANGWONDO</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=6">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/전라도.jpg" alt="전라도" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">전라도</div>
                                                            <div class="carousel-txt-sub">JEOLLADO</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=7">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/경상도.jpg" alt="경상도" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">경상도</div>
                                                            <div class="carousel-txt-sub">GYEONGSANGDO</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="carousel-item">
                                                <a href="<%Response.Write(HttpContext.Current.Request.Url.AbsolutePath);%>?loc=8">
                                                    <div class="carousel-detail">
                                                        <div class="carousel-img">
                                                            <img src="./img/제주도.jpg" alt="제주도" class="carousel-img-sty">
                                                        </div>
                                                        <div class="carousel-txt">
                                                            <div class="carousel-txt-title">제주도</div>
                                                            <div class="carousel-txt-sub">JEJU ISLAND</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Left and right controls -->
                                        <a class="carousel-control-prev" href="#areas" data-slide="prev">
                                            <span class="carousel-control-prev-icon"></span>
                                        </a>
                                        <a class="carousel-control-next" href="#areas" data-slide="next">
                                            <span class="carousel-control-next-icon"></span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 메인 슬라이드 영역 -->
            <div class="mainSlide">
                <div class="mainSlideContainer">
                    <div id="mainSlide" class="carousel slide" data-ride="carousel">

                        <div class="carousel-prev">
                            <a class="carousel-control-prev" href="#mainSlide" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </div>

                        <div class="carousel-next">
                            <a class="carousel-control-next" href="#mainSlide" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>

                        <div class="carousel-inner">

                            <!-- 최신 순-->
                            <div class="carousel-item active">
                                <div class="SlideTitle">
                                    <label><%Response.Write(localCodeToName());%>최신 순</label>
                                </div>
                                <% Response.Write(orderByTime()); %>
                            </div>

                            <!-- 평점 순-->
                            <div class="carousel-item">
                                <div class="SlideTitle">
                                    <label><%Response.Write(localCodeToName());%>평점 순</label>
                                </div>
                                <% Response.Write(orderByTotRate()); %>
                            </div>

                            <!-- 구독자 순 -->
                            <div class="carousel-item">
                                <div class="SlideTitle">
                                    <label><%Response.Write(localCodeToName());%>구독자 순</label>
                                </div>
                                <% Response.Write(orderByFollower()); %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 소개 영역 -->
        <div class="section03" id="relAndTOU">

            <!-- 관계도 및 TOUPLE 영역 -->
            <div class="relAndTou">

                <!-- 관계도 영역 -->
                <div class="relArea">
                    <div>
                        <img src="./img/relation.png" class="exStyle" alt="관계">
                    </div>
                    <div>
                        <div class="relTxt1">TO OUR SHARED 관계도</div>
                        <div class="relTxt2">TRAVELER는 마음에 드는 경로를 골라서 여행만 다니면 됩니다.</div>
                    </div>
                </div>

                <!-- TOUPLE 영역 -->
                <div id="tA" class="toupleArea">
                    <div class="TOUPLE">
                        <span class="toupleSpan1">TOUPLE?</span>
                    </div>
                    <div class="TOUR">
                        <span class="toupleSpan1">TOU</span><span class="toupleSpan2">R</span><span class="toupleSpan1">+</span>
                    </div>
                    <div class="PEOPLE">
                        <span class="toupleSpan2">PEO</span><span id="ple" class="toupleSpan1">PLE</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>

</html>

