<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["trv_no"] == null)
        {
            MessageBox.Show("게시글이 존재하지 않습니다.", this.Page);
            Response.Redirect("/index.aspx");
        }
    }

    protected List<String> getTravelByTrvNo()
    {
        int trv_no = int.Parse(Session["trv_no"].ToString()); // 게시글 번호 받기

        Travel travel = new Travel();                        // travel 객체 생성
        List<String> returnList = new List<String>();   // return할 List 생성
        travel.Trv_no = trv_no.ToString();                  // travel 객체에 게시글 번호 넣고

        TravelDao travelDao = new TravelDao();        // TravelDao 객체 생성
        travel = travelDao.selectTravelBytrv_no(travel); // travelDao에서 trv_no를 토대로 데이터 몽땅 긁어온 travel 객체로 바꿔치기

        returnList.Add(travel.Trv_no);
        returnList.Add(travel.Trv_secret);
        returnList.Add(travel.Trv_views);

        double d_totRate = double.Parse(travel.Trv_tot_rate);
        int i_totRate = (int)d_totRate;
        String returnRate = d_totRate.ToString() + "-" + i_totRate.ToString(); // ex: 3.4-3

        returnList.Add(returnRate);
        returnList.Add(travel.Trv_main_img);
        returnList.Add(travel.Trv_title);
        returnList.Add(travel.Trv_tag);
        returnList.Add(travel.Trv_timestamp);
        returnList.Add(travel.Trv_create_time);
        returnList.Add(travel.Loc_name);
        returnList.Add(travel.Mem_id);

        return returnList;
    }

    protected String getTravelDayContentByTrvNo()
    {
        int trv_no = int.Parse(Session["trv_no"].ToString()); // 게시글 번호 받기

        Travel_Day travelDay = new Travel_Day();                         // travel_day 객체 생성
        travelDay.Trv_no = trv_no.ToString();                               // travel_no 집어 넣기
        Travel_DayDao travelDayDao = new Travel_DayDao();         // travel_day DAO 객체 생성

        travelDay = travelDayDao.selectTravelDayByTrvNo(travelDay); // 데이터 가져오고
        string returnStr = travelDay.Trv_day_content.ToString(); // 넣고

        return returnStr; // 뿌리고
    }

    protected int getLikeCountByTrvNo()
    {
        int returnInt = 0;
        int trv_no = int.Parse(Session["trv_no"].ToString()); // 게시글 번호 받고

        Like like = new Like();                   // like 객체 생성
        like.Trv_no = trv_no.ToString();        // like 객채에 데이터 집어넣기
        LikeDao likeDao = new LikeDao();   // likeDao 객체 생성

        returnInt = likeDao.selectLikeCountByTrvNo(like); // 데이터 가져오고
        return returnInt;
    }

    protected List<String> getMemberByTrvNo()
    {
        List<String> returnList = new List<String>();
        int trv_no = int.Parse(Session["trv_no"].ToString()); // 게시글 번호 받고

        Travel travel = new Travel();
        TravelDao travelDao = new TravelDao();

        travel.Trv_no = trv_no.ToString(); // travel 객채에 게시글 번호 삽입
        travel = travelDao.selectTravelBytrv_no(travel); // 바꾸고
        String MemberID = travel.Mem_id.ToString(); // 게시글 번호의 작성자를 구해오고

        Member member = new Member(); // member 객체 생성하고
        member.Mem_id = MemberID; // 객체에 작성자 아이디 삽입하고
        MemberDao memberDao = new MemberDao(); // DAO 생성해서
        member = memberDao.selectMemberByMem_id(member); // 바꾸고

        returnList.Add(member.Mem_id);
        returnList.Add(member.Mem_state);
        returnList.Add(member.Mem_phone);
        returnList.Add(member.Mem_pw);
        returnList.Add(member.Mem_name);
        returnList.Add(member.Mem_sex);
        returnList.Add(member.Mem_ques);
        returnList.Add(member.Mem_answer);
        returnList.Add(member.Mem_email);
        returnList.Add(member.Mem_reg_datetime);
        returnList.Add(member.Mem_timestmap);

        String imgUrl = member.Mem_img_url;
        if (imgUrl == "noImage")
            returnList.Add("./img/noImage.png");
        else
            returnList.Add(imgUrl);
        return returnList;
    }

</script>

<head>
    <title> To Our Shared : milk9503 님의 글 </title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|East+Sea+Dokdo|Jua&display=swap" rel="stylesheet">

    <!-- ICON -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    
    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <style>
        body,
        form {
            margin: 0;
            padding: 0;
            list-style: none;
            min-width: 100%;
            min-height: 100%;
            display: flex;

            line-height: 1;

            /* 전체 배경색 */
            background-color: #00b9f1;
            background-repeat: no-repeat;
        }

        a {
            color: #000;
        }

        a:hover {
            color: #000;
            text-decoration: none;
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
        }

        .topnavLi ul,
        li {
            list-style: none;
            text-decoration: none;
            padding: 0;
            margin: 0;
        }

        .topnavLiItem {
            cursor: default;
            color: white;
            text-decoration: none;
        }

        #nav {
            z-index: 99999;
            position: fixed;
            width: 100%;
            height: auto;
            /* absolute는 부피를 못잡으니까 width 100% */
            overflow: hidden;
            font-size: 25px;

            transition-duration: 0.5s;

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
            transition: .5s;
            cursor: pointer;
            color: #fff;
            text-decoration: none;
        }

        .nav-logo-item:hover {
            transition: font .5s;
            font-size: 27.5px;
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

        #main {
            width: 100%;
            margin-top: 250px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 0 0 100px;
        }

        .board {
            width: 1500px;
            height: auto;
            display: flex;
            flex-direction: column;
        }

        .board-header {
            width: 100%;
            height: 130px;
            font-size: 50px;
            padding: 20px;
            display: flex;
            align-items: center;
            background-color: #e2e2e2;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .good-item{
            font-size: 25px;
            padding-left: 30px;
        }
        
        .goodBtn{
            width: 30px;
            height: 30px;
            display: flex;
            justify-content: center;
            border: none;
            outline: none;
            background-color: transparent;
        }
        
        .good-cnt{
            cursor: default;
            color: orangered;
            font-size: 30px;
            font-weight: 700;
            margin-top: 3px;
        }

        .board-writer {
            width: 100%;
            height: 60px;
            font-size: 15px;
            padding: 10px 10px 0;
            display: flex;
            flex-direction: row;
            align-items: center;
            background-color: #e2e2e2;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .writer-ImageItem {
            width: 50px;
            height: 50px;
            border-radius: 100%;
        }

        .writer-Text {
            padding-left: 5px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .writerID {
            font-size: 17px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .writerTime {
            cursor: default;
            color: dimgray;
            font-size: 13px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .board-score {
            width: 100%;
            height: 50px;
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
            padding-right: 10px;
            background-color: #e2e2e2;
            border-bottom: .5px solid rgba(0, 0, 0, .2);
        }

        .star {
            cursor: default;
            font-size: 25px;
            transition-duration: .5s;
        }

        .star:hover {
            text-shadow: 0 0 15px yellow;
        }

        .score {
            cursor: default;
            margin-top: 10px;
            font-size: 15px;
            color: dimgray;
        }

        .board-content {
            width: 100%;
            height: 800px;
            background-color: #eee;
            display: flex;
            justify-content: center;
        }

        .board-map {
            margin: 10px 0 10px 10px;
            width: 1100px;
            height: 780px;
            border: .5px solid rgba(0, 0, 0, .2);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .board-travel {
            margin: 10px;
            width: 380px;
            height: 780px;
        }

        .travel-root {
            width: 380px;
            height: 390px;
            display: flex;
            flex-direction: column;
            background-color: #eee;
        }

        .travel-cost {
            width: 380px;
            height: 390px;
            display: flex;
            flex-direction: column;
            background-color: #eee;
        }
        
        rootitem, costitem{
            width: 100%;
            height: auto;
            display: flex;
            flex-direction: column;
        }
        
        root-header, cost-header{
            width: 100%;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #e2e2e2;
            border: .5px solid rgba(0, 0, 0, .2);
        }
        
        root-content, cost-content{
            width: 100%;
            height: 340px;
            background-color: #eee;
            padding: 10px;
            overflow: auto;
            border-left: .5px solid rgba(0, 0, 0, .2);
            border-right: .5px solid rgba(0, 0, 0, .2);
            border-bottom: .5px solid rgba(0, 0, 0, .2);
        }
        
        content-item{
            width: 100%;
            height: auto;
            display: flex;
            padding-top: 5px;
            padding-bottom: 15px;
            flex-direction: column;
        }
        
        content-header{
            width: 100%;
            font-size: 15px;
            padding-left: 5px;
            border-left: 4px solid firebrick;
            font-family: 'Noto Sans KR', sans-serif;
        }
        content-body{
            width: 100%;
            padding-top: 10px;
            padding-left: 10px;
            color: rgba(0, 0, 0, .6);
            font-size: 13px;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .content-ul{
            margin: 0;
            padding-left: 15px;
        }
        .content-li{
            list-style: decimal;
            padding-top: 5px;
        }
        
        .board-part{
            width: 1500px;
            height: auto;
            margin-top: 100px;
            display: flex;
            flex-direction: column;
        }
        
        .part-board-header{
            width: 100%;
            height: 130px;
            font-size: 50px;
            padding: 20px;
            display: flex;
            align-items: center;
            background-color: #e2e2e2;
            border-bottom: .5px solid rgba(0, 0, 0, .2);
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        .part-board-content {
            width: 100%;
            height: 800px;
            background-color: #eee;
            display: flex;
            justify-content: center;
        }

        .part-board-map {
            margin: 10px 0 10px 10px;
            width: 1100px;
            height: 780px;
            border: .5px solid rgba(0, 0, 0, .2);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .part-board-travel {
            margin: 10px;
            width: 380px;
            height: 780px;
        }

        .part-travel-root {
            width: 380px;
            height: 390px;
            display: flex;
            flex-direction: column;
            background-color: #eee;
        }

        .part-travel-cost {
            width: 380px;
            height: 390px;
            display: flex;
            flex-direction: column;
            background-color: #eee;
        }
        
        .part-content-ul{
            margin: 0;
            padding-left: 15px;
        }
        
        .part-content-li{
            list-style: decimal;
            padding-top: 5px;
        }
        
        .part-board-story{
            width: 100%;
            height: 700px;
            background-color: #eee;
            padding: 10px;
        }
        
        .part-story{
            width: 100%;
            height: 680px;
            background-color: #eee;
            border: 0.5px solid rgba(0, 0, 0, .2);
            border-top: 4px dashed rgba(0, 0, 0, .5);
            overflow: auto;
            padding: 10px;
        }
        
        .board-hashtag{
            margin-top: 100px;
            width: 1500px;
            height: 100px;
            background-color: #eee;
            display: flex;
            flex-direction: row;
            padding: 35px;
        }
        
        .board-reply{
            margin-top: 10px;
            width: 1500px;
            height: 700px;
            background-color: #eee;
            display: flex;
            flex-direction: column;
        }
        
        .reply-header{
            width: 100%;
            height: 80px;
            display: flex;
            align-items: center;
            padding: 25px;
            font-size: 25px;
            background-color: #e2e2e2;
            border-bottom: .5px solid rgba(0, 0, 0, .5);
            box-shadow: 0px 0px 10px rgba(0, 0, 0, .19);
        }

        .reply-header > span{
            cursor: default;
        }
        
        .reply-header > .replyCount{
            color: orangered;
        }
        
        .reply-contents{
            width: 100%;
            height: 400px;
            overflow: auto;
            border-bottom: .5px solid rgba(0, 0, 0, .5);
        }
        
        .replyItem{
            width: 100%;
            height: 90px;
            display: flex;
            padding: 10px;
            align-items: center;
            border-bottom: .5px solid rgba(0, 0, 0, .2);
        }
        
        .reply-writer{
            width: 200px;
            display: flex;
            padding: 0px 10px;
            flex-direction: row;
            align-items: center;
        }
        
        .reply-content{
            width: 1130px;
            display: flex;
            padding: 0px 10px;
            align-items: center;
            justify-content: center;
        }
        
        .reply-score{
            width: 170px;
            padding: 10px;
            justify-content: center;
            align-items: center;
        }
        
        .reply-write{
            padding: 20px 10px 10px;
        }
        
        #reply-write-text{
            width: 1475px;
            height: 150px;
            padding: 10px;
            outline: none;
            resize: none;
            color: rgba(0, 0, 0, .7);
            font-size: 25px;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        .reply-write-item{
            width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
            padding: 10px 7px 10px 10px;
        }
        
        .reply-write-limit{
            padding-right: 10px;
        }
        
        #limitText{
            cursor: default;
            font-size: 18px;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        .replyButton{
            width: 100px;
            height: 30px;
            outline: none;
            color: #fff;
            font-size: 14px;
            font-weight: 300;
            border: 1px solid orange;
            background-color: orange;
            transition-duration: .5s;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        .replyButton:hover{
            background-color: darkorange;
        }
        
        .hashtag{
            cursor: pointer;
            width: auto;
            padding: 7px;
            color: #fff;
            height: 30px;
            font-size: 13px;
            background-color: rgba(0, 0, 0, 0.5);
            font-family: 'Noto Sans KR', sans-serif;
            transition-duration: .5s;
            margin-right: 10px;
        }
        
        .hashtag:hover{
            background-color: rgba(0, 0, 0, .8);
        }

        .reply-star-input{
            margin-right: 30px;
            height: 30px;
        }
        
        .reply-star-input .reply-star{
            width: 50px;
            font-size: 13px;
            padding: 5px;
            outline: none;
            color: dimgray;
            border: .5px solid rgba(0, 0, 0, .1);
            text-align-last: center;
        }
        
    </style>

    <script>
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
        
        $(function() {
            $('#reply-write-text').keyup(function(e) {
                var content = $(this).val();
                $('#limitText').html("(" + content.length + " / 200)");

                if (content.length > 200) {
                    $(this).val(content.substring(0, 200));
                    $('#limitText').html("(200 / 200)");
                }
            });
            $('#reply-write-text').keyup();
        });
    </script>
</head>
<body>
    <form>
        <!-- navigation -->
        <div id="nav" class="topnav">
            <ul class="topnavUl">
                <li class="topnavLi">
                    <div class="nav-logo">
                        <a href="index.aspx" class="nav-logo-item">To Our Shared</a>
                    </div>
                </li>
                <li class="topnavLi">
                    <a class="topnavLiItem">Intro</a>
                    <ul>
                        <li><a href="#">TOUPLE</a></li>
                    </ul>
                </li>
                <li class="topnavLi">
                    <a class="topnavLiItem">Shared</a>
                    <ul>
                        <li><a href="search.aspx">검색</a></li>
                    </ul>
                </li>
                <li class="topnavLi">
                    <a class="topnavLiItem">Event</a>
                    <ul>
                        <li><a>진행중인 이벤트</a></li>
                        <li><a>종료된 이벤트</a></li>
                    </ul>
                </li>
                <li class="topnavLi">
                    <a class="topnavLiItem">Help</a>
                    <ul>
                        <li><a href="FAQ.aspx">자주 찾는 질문</a></li>
                    </ul>
                </li>
                <li class="topnavLi">
                 <% if (Session["mem_id"] != null)
                     {%>
				<a href = "#" ><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                <ul>
                    <li><asp:Button ID="btnMypage" runat="server" Text="마이페이지"  /></li>
                    <li><asp:Button ID="btnLogout" runat="server" Text="로그아웃" /></li>

                </ul>
                 <%} %>
                </li>
            </ul>
        </div>
        <%
            // ============== Data Init ================

            List<String> TravelList = getTravelByTrvNo();                     // 해당 게시글의 데이터
            List<String> MemberList = getMemberByTrvNo();              // 해당 게시글 작성자의 데이터
            String TravelDay_Content = getTravelDayContentByTrvNo();  // 해당 게시글의 내용

            int goodCnt = getLikeCountByTrvNo();                             // 추천 수
            string[] totRateArr = TravelList[3].Split(new char[] { '-' });       // 해당 게시글 평점(0.0-0) 형식이라 Split작업
            int starCount = int.Parse(totRateArr[1]);                            // 해당 게시글의 평점(별 수)
            string starScore = totRateArr[0];                                       // 해당 게시글의 평점(소수)
            string starText = "";

            for(int i = 0; i < starCount; i++) // 별 수만큼 for문 반복해서 starText 변수에 ⭐ 삽입
                starText += "⭐";

            // ======================================
        %>
        <div id="main">
            <div class="board">
                <div class="board-header">
                    <div class = "header-item"><%Response.Write(TravelList[5].ToString());%></div>
                    <div class = "good-item">
                        <button class = "goodBtn">👍</button>
                    </div>
                    <div class = "good-cnt"><%Response.Write(goodCnt);%></div>
                </div>
                <div class="board-writer">
                    <div class="writer-Image">
                        <a href="#">
                            <img src="<%Response.Write(MemberList[12].ToString());%>" alt="writerImage" class="writer-ImageItem" />
                        </a>
                    </div>
                    <div class="writer-Text">
                        <div class="writerID">
                            <a href="#">
                                <%Response.Write(MemberList[0].ToString());%>
                            </a>
                        </div>
                        <div class="writerTime"><%Response.Write(TravelList[8].ToString());%></div>
                    </div>
                </div>
                <div class="board-score">
                    <span class="star"><%Response.Write(starText);%></span>
                    <span class="score">(<%Response.Write(starScore.ToString());%>)</span>
                </div>
                <div class="board-content">
                    <div class="board-map">지도 넣을 곳<br />지도 넣을 때 style 가셔서<br />display, align-items, justify-content 지워주세요</div>
                    <div class="board-travel">
                        <div class="travel-root">
                            <rootitem>
                                <root-header>여행 간 경로</root-header>
                                <root-content>
                                    <content-item>
                                        <content-header>1일 차</content-header>
                                        <content-body>
                                            <ul class = "content-ul">
                                                <li class = "content-li">서울</li>
                                                <li class = "content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                    <content-item>
                                        <content-header>2일 차</content-header>
                                        <content-body>
                                            <ul class = "content-ul">
                                                <li class = "content-li">서울</li>
                                                <li class = "content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                </root-content>
                            </rootitem>
                        </div>
                        <div class="travel-cost">
                            <costitem>
                                <cost-header>여행 간 경비</cost-header>
                                <cost-content>
                                    <content-item>
                                        <content-header>1일 차</content-header>
                                        <content-body>
                                            <ul class="content-ul">
                                                <li class="content-li">식비 5000원 (햄버거)</li>
                                                <li class="content-li">교통비 2500원 (버스)</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                    <content-item>
                                        <content-header>2일 차</content-header>
                                        <content-body>
                                            <ul class="content-ul">
                                                <li class="content-li">식비 5000원 (햄버거)</li>
                                                <li class="content-li">교통비 2500원 (버스)</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                </cost-content>
                            </costitem>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class = "board-part">
                <div class = "part-board-header">1일 차</div>
                <div class = "part-board-content">
                    <div class = "part-board-map">지도 넣을 곳<br />지도 넣을 때 style 가셔서<br />display, align-items, justify-content 지워주세요</div>
                    <div class = "part-board-travel">
                        <div class = "part-travel-root">
                            <rootitem>
                                <root-header>여행 간 경로</root-header>
                                <root-content>
                                    <content-item>
                                        <content-header>여행 경로</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">서울</li>
                                                <li class = "part-content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                </root-content>
                            </rootitem>
                        </div>
                        <div class = "part-travel-cost">
                            <costitem>
                                <cost-header>여행 간 경비</cost-header>
                                <cost-content>
                                    <content-item>
                                        <content-header>여행 경비</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">식비 5000원 (햄버거)</li>
                                                <li class = "part-content-li">교통비 2500원 (버스)</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                </cost-content>
                            </costitem>
                        </div>
                    </div>
                </div>
                <div class = "part-board-story">
                    <div class = "part-story">
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                    </div>
                </div>
            </div>
            <div class = "board-part">
                <div class = "part-board-header">2일 차</div>
                <div class = "part-board-content">
                    <div class = "part-board-map">지도 넣을 곳<br />지도 넣을 때 style 가셔서<br />display, align-items, justify-content 지워주세요</div>
                    <div class = "part-board-travel">
                        <div class = "part-travel-root">
                            <rootitem>
                                <root-header>여행 간 경로</root-header>
                                <root-content>
                                    <content-item>
                                        <content-header>여행 경로</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">서울</li>
                                                <li class = "part-content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                    <content-item>
                                        <content-header>여행 경로</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">서울</li>
                                                <li class = "part-content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                    <content-item>
                                        <content-header>여행 경로</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">서울</li>
                                                <li class = "part-content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                    <content-item>
                                        <content-header>여행 경로</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">서울</li>
                                                <li class = "part-content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                    <content-item>
                                        <content-header>여행 경로</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">서울</li>
                                                <li class = "part-content-li">서울</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                </root-content>
                            </rootitem>
                        </div>
                        <div class = "part-travel-cost">
                            <costitem>
                                <cost-header>여행 간 경비</cost-header>
                                <cost-content>
                                    <content-item>
                                        <content-header>여행 경비</content-header>
                                        <content-body>
                                            <ul class = "part-content-ul">
                                                <li class = "part-content-li">식비 5000원 (햄버거)</li>
                                                <li class = "part-content-li">교통비 2500원 (버스)</li>
                                            </ul>
                                        </content-body>
                                    </content-item>
                                </cost-content>
                            </costitem>
                        </div>
                    </div>
                </div>
                <div class = "part-board-story">
                    <div class = "part-story">
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                        재밌는 이야기<br/><br/>
                        <img src = "https://source.unsplash.com/category/nature/300x300" style="width: 300px; height: 300px;"><br/><br/>
                    </div>
                </div>
            </div>
            
            <div class = "board-hashtag">
                <a href = "#"><div class = "hashtag">#여행</div></a>
                <a href = "#"><div class = "hashtag">#아랄라라라랄</div></a>
                <a href = "#"><div class = "hashtag">#테스트</div></a>
            </div>
            <div class = "board-reply">
                <div class = "reply-header">
                    <span class="replyText">댓글</span>&nbsp;
                    <span class="replyCount">5</span>
                </div>
                <div class = "reply-contents">
                    <div class = "replyItem">
                        <div class = "reply-writer">
                            <div class="writer-Image">
                                <a href="#">
                                    <img src="./img/areaImage.jpg" alt="writerImage" class="writer-ImageItem" />
                                </a>
                            </div>
                            <div class="writer-Text">
                                <div class="writerID">
                                    <a href="#">
                                        milk9503
                                    </a>
                                </div>
                                <div class="writerTime">2019-11-04 22:00</div>
                            </div>
                        </div>
                        <div class = "reply-content">
                            멋지네용
                        </div>
                        <div class = "reply-score">
                            <span class="star">⭐⭐⭐</span>
                            <span class="score">(3.3)</span>
                        </div>
                    </div>
                    <div class = "replyItem">
                        <div class = "reply-writer">
                            <div class="writer-Image">
                                <a href="#">
                                    <img src="./img/areaImage.jpg" alt="writerImage" class="writer-ImageItem" />
                                </a>
                            </div>
                            <div class="writer-Text">
                                <div class="writerID">
                                    <a href="#">
                                        milk9503
                                    </a>
                                </div>
                                <div class="writerTime">2019-11-04 22:00</div>
                            </div>
                        </div>
                        <div class = "reply-content">
                            멋지네용
                        </div>
                        <div class = "reply-score">
                            <span class="star">⭐⭐⭐</span>
                            <span class="score">(3.3)</span>
                        </div>
                    </div>
                    <div class = "replyItem">
                        <div class = "reply-writer">
                            <div class="writer-Image">
                                <a href="#">
                                    <img src="./img/areaImage.jpg" alt="writerImage" class="writer-ImageItem" />
                                </a>
                            </div>
                            <div class="writer-Text">
                                <div class="writerID">
                                    <a href="#">
                                        milk9503
                                    </a>
                                </div>
                                <div class="writerTime">2019-11-04 22:00</div>
                            </div>
                        </div>
                        <div class = "reply-content">
                            멋지네용
                        </div>
                        <div class = "reply-score">
                            <span class="star">⭐⭐⭐</span>
                            <span class="score">(3.3)</span>
                        </div>
                    </div>
                    <div class = "replyItem">
                        <div class = "reply-writer">
                            <div class="writer-Image">
                                <a href="#">
                                    <img src="./img/areaImage.jpg" alt="writerImage" class="writer-ImageItem" />
                                </a>
                            </div>
                            <div class="writer-Text">
                                <div class="writerID">
                                    <a href="#">
                                        milk9503
                                    </a>
                                </div>
                                <div class="writerTime">2019-11-04 22:00</div>
                            </div>
                        </div>
                        <div class = "reply-content">
                            멋지네용
                        </div>
                        <div class = "reply-score">
                            <span class="star">⭐⭐⭐</span>
                            <span class="score">(3.3)</span>
                        </div>
                    </div>
                    <div class = "replyItem">
                        <div class = "reply-writer">
                            <div class="writer-Image">
                                <a href="#">
                                    <img src="./img/areaImage.jpg" alt="writerImage" class="writer-ImageItem" />
                                </a>
                            </div>
                            <div class="writer-Text">
                                <div class="writerID">
                                    <a href="#">
                                        milk9503
                                    </a>
                                </div>
                                <div class="writerTime">2019-11-04 22:00</div>
                            </div>
                        </div>
                        <div class = "reply-content">
                            멋지네용
                        </div>
                        <div class = "reply-score">
                            <span class="star">⭐⭐⭐</span>
                            <span class="score">(3.3)</span>
                        </div>
                    </div>
                </div>
                <div class = "reply-write">
                    <div class = "reply-write-input">
                        <textarea id="reply-write-text"></textarea>
                    </div>
                    <div class = "reply-write-item">
                        <span class="star" style="font-size: 18px; padding-right: 3px; padding-bottom: 3px;">⭐</span>
                        <div class = "reply-star-input">
                            <select class = "reply-star">
                                <option value="5">5</option>
                                <option value="4">4</option>
                                <option value="3" selected>3</option>
                                <option value="2">2</option>
                                <option value="1">1</option>
                            </select>
                        </div>
                        <div class = "reply-write-limit">
                            <span id = "limitText">(0 / 200)</span>
                        </div>
                        <div class = "reply-write-btn"></div>
                            <button class="replyButton">등록</button>
                    </div>
                </div>
            </div>
            
        </div>
        <div id="footer">
            
        </div>
    </form>
</body>
</html>
