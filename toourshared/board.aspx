<%@ Page Language="C#" %>

<%@ Import Namespace="Newtonsoft.Json.Linq" %>

<!DOCTYPE html>

<script runat="server">
    //http://localhost:6118/board.aspx?trv_no=176
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["trv_no"] == null)
        {
            System.Diagnostics.Debug.WriteLine("지금 되는건가용?");
            Response.Redirect("/index.aspx");
        }
        bindMapData();
    }


    protected List<String> getTravelByTrvNo()
    {
        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받기

        Travel travel = new Travel();                        // travel 객체 생성
        List<String> returnList = new List<String>();   // return할 List 생성
        travel.Trv_no = trv_no.ToString();                  // travel 객체에 게시글 번호 넣고

        TravelDao travelDao = new TravelDao();        // TravelDao 객체 생성
        travel = travelDao.selectTravelBytrv_no(travel); // travelDao에서 trv_no를 토대로 데이터 몽땅 긁어온 travel 객체로 바꿔치기

        returnList.Add(travel.Trv_no);
        returnList.Add(travel.Trv_secret);
        returnList.Add(travel.Trv_views);

        try
        {
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
        }
        catch (Exception e) {; }
        return returnList;
    }

    public List<String> getTravelDayListByTrvNo()
    {
        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받기

        Travel_Day travelDay = new Travel_Day();                         // travel_day 객체 생성
        travelDay.Trv_no = trv_no.ToString();                               // travel_no 집어 넣기
        Travel_DayDao travelDayDao = new Travel_DayDao();         // travel_day DAO 객체 생성

        List<Travel_Day> travelDayList = travelDayDao.selectTravelDayListByTrvNo(travelDay);
        // 게시글 번호에 해당하는 그 게시글의 모든 게시글 내용들(N일 차) 오름차순으로 구해온다.

        List<String> returnList = new List<String>();
        for (int i = 0; i < travelDayList.Count; i++)
        {
            returnList.Add(travelDayList[i].Trv_day_content); // 게시글들을 구해온다.
        }

        return returnList;
    }

    protected List<Map> getMapListByTrvDayNo()
    {
        List<Map> resultList = new List<Map>();
        Map inMap = new Map();
        Map outMap = new Map();

        MapDao mapDao = new MapDao();





        return resultList;
    }


    protected int getLikeCountByTrvNo()
    {
        int returnInt = 0;
        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받고

        Like like = new Like();                   // like 객체 생성
        like.Trv_no = trv_no.ToString();        // like 객채에 데이터 집어넣기
        LikeDao likeDao = new LikeDao();   // likeDao 객체 생성

        returnInt = likeDao.selectLikeCountByTrvNo(like); // 데이터 가져오고
        return returnInt;
    }

    protected List<String> getMemberByTrvNo()
    {
        List<String> returnList = new List<String>();
        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받고

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
        returnList.Add(member.Mem_birth);
        returnList.Add(member.Mem_email);
        returnList.Add(member.Mem_reg_datetime);
        returnList.Add(member.Mem_timestmap);

        String imgUrl = member.Mem_img_url;
        if (imgUrl == "noImage")
            returnList.Add("./img/memberNoImage.png");
        else
            returnList.Add(imgUrl);
        return returnList;
    }

    protected List<String> getHashTagList()
    {
        List<String> TravelList = getTravelByTrvNo(); // 해당 게시글의 데이터
        return HashTag.Split(TravelList[6].ToString());
    }

    protected List<Comment> getCommentListByTrvNo()
    {
        List<Comment> returnList = new List<Comment>();
        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받고

        Travel travel = new Travel(); // Travel 객체 생성 및
        travel.Trv_no = trv_no.ToString(); // 게시글 번호 삽입

        CommentDao commentDao = new CommentDao(); // cmtDao 생성
        returnList = commentDao.selectCommentListByTrvNo(travel); // List받아오고

        return returnList;
    }

    protected int getCommentByTrvNo()
    {
        int returnInt = 0;
        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받고

        Travel travel = new Travel(); // Travel 객체 생성 및
        travel.Trv_no = trv_no.ToString(); // 게시글 번호 삽입

        CommentDao commentDao = new CommentDao(); // cmtDao 생성
        returnInt = commentDao.selectCommentCountByTrvNo(travel);

        return returnInt;
    }


    protected List<Map> getMapByTrvDayNo()
    {
        List<Map> mapList = new List<Map>();

        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받기

        Travel_Day travelDay = new Travel_Day();                         // travel_day 객체 생성
        travelDay.Trv_no = trv_no.ToString();                               // travel_no 집어 넣기
        Travel_DayDao travelDayDao = new Travel_DayDao();         // travel_day DAO 객체 생성

        List<Travel_Day> travelDayList = travelDayDao.selectTravelDayListByTrvNo(travelDay);
        // 게시글 번호에 해당하는 그 게시글의 모든 게시글 내용들(N일 차) 오름차순으로 구해온다.

        Map inMap = new Map();
        Map tmpMap;
        MapDao mapDao = new MapDao();
        foreach (var item in travelDayList)
        {
            inMap.Trv_day_no = item.Trv_day_no;
            tmpMap = new Map();
            tmpMap = mapDao.selectMapByTrv_day_no(inMap);
            mapList.Add(tmpMap);
        }
        return mapList;
    }

    protected List<string> testRouteCost()
    {
        List<string> mapRouteCost = new List<string>();

        int trv_no = int.Parse(Request.QueryString["trv_no"].ToString()); // 게시글 번호 받기

        Travel_Day travelDay = new Travel_Day();                         // travel_day 객체 생성
        travelDay.Trv_no = trv_no.ToString();                               // travel_no 집어 넣기
        Travel_DayDao travelDayDao = new Travel_DayDao();         // travel_day DAO 객체 생성

        List<Travel_Day> travelDayList = travelDayDao.selectTravelDayListByTrvNo(travelDay);
        // 게시글 번호에 해당하는 그 게시글의 모든 게시글 내용들(N일 차) 오름차순으로 구해온다.

        Map inMap = new Map();
        Map tmpMap;
        MapDao mapDao = new MapDao();
        foreach (var item in travelDayList)
        {
            inMap.Trv_day_no = item.Trv_day_no;
            tmpMap = new Map();
            tmpMap = mapDao.selectMapByTrv_day_no(inMap);
            mapRouteCost.Add(tmpMap.Map_route);
            mapRouteCost.Add(tmpMap.Map_cost);
        }
        return mapRouteCost;
    }

    protected void bindMapData()
    {
        List<Map> mapList = getMapByTrvDayNo();

        HtmlInputHidden tmpHidden;
        int index = 0;
        foreach (var map in mapList)
        {
            tmpHidden = new HtmlInputHidden();
            tmpHidden.Name = "mapData_" + index;
            tmpHidden.ID = "mapData_" + index; // set the id
            tmpHidden.Value = map.Map_data;
            PlaceHolder_hidden.Controls.Add(tmpHidden);
            index++;
        }
    }

<<<<<<< HEAD
    protected string HtmlSpecialChars(string Str)
    {
        string returnStr = "";
        returnStr = returnStr.Replace("&", "&amp;");
        returnStr = returnStr.Replace(">", "&gt;");
        returnStr = returnStr.Replace("<", "&lt;");
        returnStr = returnStr.Replace("'", "&#039;");

        return returnStr;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        int memberScore = int.Parse(replyStarList.SelectedValue.ToString()); // 유저가 선택한 평점

        if(memberScore == 0)
        {
            Response.Write("<script language='javascript'>alert('게시글에 대한 평점(⭐)을 선택해주세요.');</script language='javascript'>");
        }
        else
        {
            if (Request.QueryString["trv_no"] == null)
            {
                Response.Write("<script language='javascript'>alert('세션이 만료되었습니다. 다시 접근해주세요.');</script language='javascript'>");
                Response.Redirect("/index.aspx");
            }
            else
            {
                string trv_no = Request.QueryString["trv_no"].ToString(); // 현재 게시글의 번호를 받고
                string cmt = replyWriteText.Text.ToString();

                Comment comment = new Comment(); // commentDTO 객체 생성하고 속성 집어넣기
                comment.Trv_no = trv_no.ToString();
                comment.Cmt_content = cmt.ToString();
                comment.Cmt_rate = memberScore.ToString();
                comment.Cmt_timestamp = TimeLib.GetTimeStamp().ToString();

                CommentDao commentDao = new CommentDao(); // commentDAO 객체 생성
                commentDao.InsertComment(comment); // comment 데이터 삽입
=======

>>>>>>> 8451cd397e6e51e1676f374e17130bcebf3bb693

                TravelDao travelDao = new TravelDao();
                travelDao.setTotRateByTrvNo(int.Parse(trv_no.ToString()), memberScore); // TotRate 최신화 작업
            }
        }
    }

</script>

<head>
    <title>To Our Shared : milk9503 님의 글 </title>

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
    <!--KAKAO-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>
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

            #nav > ul {
                text-align: center;
                font-family: 'Mansalva', cursive;
                font-size: 25px;
            }

                #nav > ul > li {
                    display: inline-block;
                    position: relative;
                    padding: 0px 50px;
                }

                    #nav > ul > li > a {
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

                    #nav > ul > li:hover > a {
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

                .topnav > ul > li > .nav-logo > .nav-logo-item {
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

        .good-item {
            font-size: 25px;
            padding-left: 30px;
        }

        .goodBtn {
            width: 30px;
            height: 30px;
            display: flex;
            justify-content: center;
            border: none;
            outline: none;
            background-color: transparent;
        }

        .good-cnt {
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

        rootitem, costitem {
            width: 100%;
            height: auto;
            display: flex;
            flex-direction: column;
        }

        root-header, cost-header {
            width: 100%;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #e2e2e2;
            border: .5px solid rgba(0, 0, 0, .2);
        }

        root-content, cost-content {
            width: 100%;
            height: 340px;
            background-color: #eee;
            padding: 10px;
            overflow: auto;
            border-left: .5px solid rgba(0, 0, 0, .2);
            border-right: .5px solid rgba(0, 0, 0, .2);
            border-bottom: .5px solid rgba(0, 0, 0, .2);
        }

        content-item {
            width: 100%;
            height: auto;
            display: flex;
            padding-top: 5px;
            padding-bottom: 15px;
            flex-direction: column;
        }

        content-header {
            width: 100%;
            font-size: 15px;
            padding-left: 5px;
            border-left: 4px solid firebrick;
            font-family: 'Noto Sans KR', sans-serif;
        }

        content-body {
            width: 100%;
            padding-top: 10px;
            padding-left: 10px;
            color: rgba(0, 0, 0, .6);
            font-size: 13px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .content-ul {
            margin: 0;
            padding-left: 15px;
        }

        .content-li {
            list-style: decimal;
            padding-top: 5px;
        }

        .board-part {
            width: 1500px;
            height: auto;
            display: flex;
            flex-direction: column;
        }

        .part-board-header {
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

        .part-content-ul {
            margin: 0;
            padding-left: 15px;
        }

        .part-content-li {
            list-style: decimal;
            padding-top: 5px;
        }

        .part-board-story {
            width: 100%;
            height: 700px;
            background-color: #eee;
            padding: 10px;
        }

        .part-story {
            width: 100%;
            height: 680px;
            background-color: #eee;
            border: 0.5px solid rgba(0, 0, 0, .2);
            border-top: .5px solid rgba(0, 0, 0, .2);
            overflow: auto;
            padding: 10px;
        }

        .board-hashtag {
            width: 1500px;
            height: 100px;
            background-color: #eee;
            display: flex;
            flex-direction: row;
            padding: 35px;
        }

        .board-reply {
            margin-top: 100px;
            width: 1500px;
            height: 700px;
            background-color: #eee;
            display: flex;
            flex-direction: column;
        }

        .reply-header {
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

            .reply-header > span {
                cursor: default;
            }

            .reply-header > .replyCount {
                color: orangered;
            }

        .reply-contents {
            width: 100%;
            height: 400px;
            overflow: auto;
            border-bottom: .5px solid rgba(0, 0, 0, .5);
        }

        .replyItem {
            width: 100%;
            height: 90px;
            display: flex;
            padding: 10px;
            align-items: center;
            border-bottom: .5px solid rgba(0, 0, 0, .2);
        }

        .reply-writer {
            width: 200px;
            display: flex;
            padding: 0px 10px;
            flex-direction: row;
            align-items: center;
        }

        .reply-content {
            width: 1130px;
            display: flex;
            padding: 0px 10px;
            align-items: center;
            justify-content: center;
        }

        .reply-score {
            width: 170px;
            padding: 10px;
            justify-content: center;
            align-items: center;
        }

            .reply-score .star {
                font-size: 16px;
            }

        .reply-write {
            padding: 20px 10px 10px;
        }

        #replyWriteText {
            width: 1475px;
            height: 150px;
            padding: 10px;
            outline: none;
            resize: none;
            color: rgba(0, 0, 0, .7);
            font-size: 25px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .reply-write-item {
            width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
            padding: 10px 7px 10px 10px;
        }

        .reply-write-limit {
            padding-right: 10px;
        }

        #limitText {
            cursor: default;
            font-size: 18px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .replyButton {
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

            .replyButton:hover {
                background-color: darkorange;
            }

        .hashtag {
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

            .hashtag:hover {
                background-color: rgba(0, 0, 0, .8);
            }

        .reply-star-input {
            margin-right: 30px;
            height: 30px;
        }

            .reply-star-input .reply-star {
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
        window.onscroll = function () {
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

        $(function () {
            $('#replyWriteText').keyup(function (e) {
                var content = $(this).val();
                $('#limitText').html("(" + content.length + " / 200)");

                if (content.length > 200) {
                    $(this).val(content.substring(0, 200));
                    $('#limitText').html("(200 / 200)");
                }
            });
            $('#replyWriteText').keyup();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
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
                    <a href="#"><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                    <ul>
                        <li>
                            <asp:Button ID="btnMypage" runat="server" Text="마이페이지" /></li>
                        <li>
                            <asp:Button ID="btnLogout" runat="server" Text="로그아웃" /></li>

                    </ul>
                    <%} %>
                </li>
            </ul>
        </div>
        <%
            // ============== Data Init ================

            List<String> TravelList = getTravelByTrvNo();                        // 해당 게시글의 데이터
            List<String> MemberList = getMemberByTrvNo();                 // 해당 게시글의 작성자의 데이터
            List<String> TravelDayContents = getTravelDayListByTrvNo();  // 해당 게시글의 내용 데이터
            List<Comment> CommentList = getCommentListByTrvNo();    // 해당 게시글의 댓글 데이터
            List<Map> mapList = getMapByTrvDayNo();
            List<string> mapRouteCost = testRouteCost();


            int day = 0;                                                                // 일 차
            int goodCnt = getLikeCountByTrvNo();                             // 추천 수
            string[] totRateArr = TravelList[3].Split(new char[] { '-' });       // 해당 게시글 평점(0.0-0) 형식이라 Split작업
            int starCount = int.Parse(totRateArr[1]);                            // 해당 게시글의 평점(별 수)
            string starScore = totRateArr[0];                                     // 해당 게시글의 평점(소수)
            string starText = "";
            int replyCount = getCommentByTrvNo();                          // 해당 게시글의 댓글 수

            for (int i = 0; i < starCount; i++) // 별 수만큼 for문 반복해서 starText 변수에 ⭐ 삽입
                starText += "⭐";

            // ======================================
        %>
        <div id="main">
            <div class="board">
                <div class="board-header">
                    <div class="header-item"><%Response.Write(TravelList[5].ToString());%></div>
                    <div class="good-item">
                        <button class="goodBtn">👍</button>
                    </div>
                    <div class="good-cnt"><%Response.Write(goodCnt);%></div>
                </div>
                <div class="board-writer">
                    <div class="writer-Image">
                        <a href="MyPage.aspx?mem_id=<%Response.Write(MemberList[0].ToString());%>">
                            <img src="<%Response.Write(MemberList[12].ToString());%>" alt="writerImage" class="writer-ImageItem" />
                        </a>
                    </div>
                    <div class="writer-Text">
                        <div class="writerID">
                            <a href="MyPage.aspx?mem_id=<%Response.Write(MemberList[0].ToString());%>">
                                <%Response.Write(MemberList[0].ToString());%>
                            </a>
                        </div>
                        <div class="writerTime"><%Response.Write(TravelList[8].ToString());%></div>
                    </div>
                </div>
                <div class="board-score">
<%
    if (starCount > 0)
    {

        Response.Write("                    <span class=\"star\">" + starText + "</span>\n" +
        "                   <span class=\"score\">(" + starScore.ToString() + ")</span>\n");

    }
%>
                </div>
                <div class="board-content">
                    <div class="board-map" id="total_map"></div>
                    <div class="board-travel">
                        <div class="travel-root">
                            <rootitem>
                                <root-header>여행 간 경로</root-header>
                                <root-content>
                                    <% 
                                        try
                                        {
                                            //Response.Write(mapRouteCost[0]);
                                            string str = mapRouteCost[0];
                                            JArray ja = JArray.Parse(str);

                                            string placename = "";
                                            string roadaddress = "";
                                            string addressname = "";
                                            string phone = "";
                                            foreach (var item in ja)
                                            {
                                                placename = item["place_name"].ToString();
                                                if (item["road_address_name"].ToString() != "undefined") roadaddress = item["road_address_name"].ToString();
                                                phone = item["phone"].ToString();

                                                Response.Write(placename + "<br />");
                                                Response.Write(roadaddress + "<br />");
                                                Response.Write(phone + "<br /><br />");
                                            }

                                        }
                                        catch (Exception ex)
                                        {
                                            System.Diagnostics.Debug.WriteLine(ex.ToString());
                                        }

                                        %>
                                </root-content>
                            </rootitem>
                        </div>
                        <div class="travel-cost">
                            <costitem>
                                <cost-header>여행 간 경비</cost-header>
                                <cost-content>
                                     <% 
                                         try
                                         {
                                             //Response.Write(mapRouteCost[0]);
                                             string str = mapRouteCost[1];
                                             JArray ja = JArray.Parse(mapRouteCost[1]);
                                             JArray ja2 = JArray.Parse(ja[2]["itemList"].ToString());

                                             string placename = "";
                                             string placename2 = "";
                                             string placename3 = "";
                                             foreach (var item in ja2)
                                             {
                                                 placename = item["costType"].ToString();
                                                 placename2 = item["cost"].ToString();
                                                 placename3 = item["info"].ToString();
                                                 Response.Write(placename + "    " + placename2 + "     " + placename3);
                                             }



                                         }
                                         catch (Exception ex)
                                         {
                                             System.Diagnostics.Debug.WriteLine(ex.ToString());
                                         }

                                        %>
                                </cost-content>
                            </costitem>
                        </div>
                    </div>
                </div>
            </div>

            <%
                for (int i = 0; i < TravelDayContents.Count; i++)
                {
                    Response.Write("" +
                    "<div class = \"board-part\">\n" +
                        "<div class = \"part-board-header\">" + (day + 1) + "일 차</div>\n" +
                        "<div class = \"part-board-content\">\n" +
                            "<div class = \"part-board-map\"id='map_" + i + "'></div>\n" +
                            "<div class = \"part-board-travel\">\n" +
                                "<div class = \"part-travel-root\">\n" +
                                    "<rootitem>\n" +
                                        "<root-header>여행 간 경로</root-header>\n" +
                                        "<root-content>\n" +
                                            "<content-item>\n" +
                                                "<content-header>여행 경로</content-header>\n" +
                                                "<content-body>\n" +
                                                "</content-body>\n" +
                                            "</content-item>\n" +
                                        "</root-content>\n" +
                                    "</rootitem>\n" +
                                "</div>\n" +
                                "<div class = \"part-travel-cost\">\n" +
                                    "<costitem>\n" +
                                        "<cost-header>여행 간 경비</cost-header>\n" +
                                        "<cost-content>\n" +
                                            "<content-item>\n" +
                                                "<content-header>여행 경비</content-header>\n" +
                                                "<content-body>\n" +
                                                "</content-body>\n" +
                                            "</content-item>\n" +
                                        "</cost-content>\n" +
                                    "</costitem>\n" +
                                "</div>\n" +
                            "</div>\n" +
                        "</div>\n" +
                        "<div class = \"part-board-story\">\n" +
                            "<div class = \"part-story\">\n" +
                                TravelDayContents[day++] + "\n" +
                            "</div>\n" +
                        "</div>\n" +
                    "</div>\n");
                }
            %>

            <div class="board-hashtag">
                <%
                    // hashtag 누르면 search.aspx?hashtag=○○○○ 로 이동
                    List<String> hashtagList = getHashTagList();
                    for (int i = 0; i < hashtagList.Count; i++)
                    {
                        Response.Write("<a href = \"search.aspx?hashtag=" + hashtagList[i].ToString() + "\"><div class = \"hashtag\">" + hashtagList[i].ToString() + "</div></a>\n");
                    }
                %>
            </div>

            <div class="board-reply">
                <div class="reply-header">
                    <span class="replyText">댓글</span>&nbsp;
                    <span class="replyCount"><%Response.Write(replyCount);%></span>
                </div>
                <div class="reply-contents">
                    <%
                        for (int k = 0; k < CommentList.Count; k++)
                        {
                            Member member = new Member();
                            MemberDao memberDao = new MemberDao();

                            member.Mem_id = CommentList[k].Mem_id;
                            member = memberDao.selectMemberByMem_id(member); // 메인 이미지 찾기 작업

                            string memMainImg = member.Mem_img_url;
                            if (memMainImg == "noImage")
                                memMainImg = "./img/noImage.png";

                            double d_replyStarCount = double.Parse(CommentList[k].Cmt_rate.ToString()); // 소수 출력
                            int i_replyStarCount = (int)d_replyStarCount; // 별 갯수
                            string s_replyStarCount = "";

                            for (int l = 0; l < i_replyStarCount; l++)
                                s_replyStarCount += "⭐";

                            Response.Write("" +
                                               "<div class = \"replyItem\">\n" +
                                                    "<div class = \"reply-writer\">\n" +
                                                        "<div class=\"writer-Image\">\n" +
                                                            "<a href=\"#\">\n" +
                                                                "<img src=\"" + memMainImg + "\" alt=\"" + CommentList[k].Mem_id + "\" class=\"writer-ImageItem\" />\n" +
                                                            "</a>\n" +
                                                        "</div>\n" +
                                                        "<div class=\"writer-Text\">\n" +
                                                            "<div class=\"writerID\">\n" +
                                                                "<a href=\"#\">\n" +
                                                                    CommentList[k].Mem_id + "\n" +
                                                                "</a>\n" +
                                                            "</div>\n" +
                                                            "<div class=\"writerTime\">" + CommentList[k].Cmt_timestamp + "</div>\n" +
                                                        "</div>\n" +
                                                    "</div>\n" +
                                                    "<div class = \"reply-content\">\n" +
                                                        CommentList[k].Cmt_content + "\n" +
                                                    "</div>\n" +
                                                    "<div class = \"reply-score\">\n" +
                                                        "<span class=\"star\">" + s_replyStarCount + "</span>\n" +
                                                        "<span class=\"score\">(" + d_replyStarCount + ")</span>\n" +
                                                    "</div>\n" +
                                                "</div>\n");
                        }
                    %>
                </div>
                <div class="reply-write">
                    <div class="reply-write-input">
                        <asp:TextBox ID="replyWriteText" runat="server" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
                    </div>
                    <div class="reply-write-item">
                        <span class="star" style="font-size: 18px; padding-right: 3px; padding-bottom: 3px;">⭐</span>
                        <div class="reply-star-input">
                            <asp:DropDownList ID="replyStarList" runat="server" class="reply-star">
                                <asp:ListItem Value="0" Selected="True">평점</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="1">1</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="reply-write-limit">
                            <asp:Label ID="limitText" runat="server" Text="Label">(0 / 200)</asp:Label>
                        </div>
                        <div class="reply-write-btn"></div>
                        <asp:Button ID="Button1" class="replyButton" runat="server" Text="등록" OnClick="Button1_Click" />
                    </div>
                </div>
            </div>

        </div>
        <div id="footer">
        </div>
        <asp:PlaceHolder ID="PlaceHolder_hidden" runat="server"></asp:PlaceHolder>
    </form>

    <script>




        // Drawing Manager에서 데이터를 가져와 도형을 표시할 아래쪽 지도 div
        var mapContainer = document.getElementById('total_map'),
            mapOptions = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도 div와 지도 옵션으로 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOptions),
            overlays = []; // 지도에 그려진 도형을 담을 배열

        function getDataFromDrawingMap(mapDataId, instrokeColor, infillColor) {
            // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 

            var data = JSON.parse(document.getElementById(mapDataId).value);
            console.info(data);


            // 지도에 가져온 데이터로 도형들을 그립니다
            // 지도에 가져온 데이터로 도형들을 그립니다
            //drawMarker(data[kakao.maps.drawing.OverlayType.MARKER]);
            //drawPolyline(data[kakao.maps.drawing.OverlayType.POLYLINE]);
            //drawRectangle(data[kakao.maps.drawing.OverlayType.RECTANGLE]);
            //drawCircle(data[kakao.maps.drawing.OverlayType.CIRCLE]);
            //drawPolygon(data[kakao.maps.drawing.OverlayType.POLYGON]);
            //    drawArrow(data[kakao.maps.drawing.OverlayType.POLYLINE]);
            //    drawEllipse(data[kakao.maps.drawing.OverlayType.ELLIPSE]);

            drawMarker(data["marker"], instrokeColor, infillColor);
            drawPolyline(data["polyline"], instrokeColor, infillColor);
            drawRectangle(data["rectangle"], instrokeColor, infillColor);
            drawCircle(data["circle"], instrokeColor, infillColor);
            drawPolygon(data["polygon"], instrokeColor, infillColor);
            drawEllipse(data["ellipse"], instrokeColor, infillColor);
            drawArrow(data["arrow"], instrokeColor, infillColor);

        }

        // 아래 지도에 그려진 도형이 있다면 모두 지웁니다
        function removeOverlays() {
            var len = overlays.length, i = 0;

            for (; i < len; i++) {
                overlays[i].setMap(null);
            }

            overlays = [];
        }


        function drawArrow(arrow, instrokeColor, infillColor) {
            if (arrow != [] || arrow != "" || arrow != null) {
                var len = arrow.length, i = 0;

                for (; i < len; i++) {
                    var path = pointsToPath(arrow[i].points);
                    var style = arrow[i].options;
                    var polyline = new kakao.maps.Polyline({
                        map: map,
                        endArrow: true,
                        path: path,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight
                    });

                    overlays.push(polyline);
                }


            }
        }

        function drawEllipse(ellipse, instrokeColor, infillColor) {
            if (ellipse != [] || ellipse != "" || ellipse != null) {
                var len = ellipse.length,
                    i = 0;

                for (; i < len; i++) {


                    var ellipse = new kakao.maps.Ellipse({
                        map: map,
                        center: new daum.maps.LatLng(ellipse[i].center.y, ellipse[i].center.x),
                        rx: ellipse[i].rx,
                        ry: ellipse[i].ry,
                        strokeWeight: 2,
                        strokeColor: instrokeColor,
                        strokeOpacity: 0.8,
                        strokeStyle: 'solid',
                        fillColor: infillColor,
                        fillOpacity: 0.3

                    });
                    overlays.push(ellipse);


                }
            }
        }


        // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
        function drawMarker(markers, instrokeColor, infillColor) {
            if (markers != [] || markers != "" || markers != null) {
                var len = markers.length, i = 0;

                for (; i < len; i++) {
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: new kakao.maps.LatLng(markers[i].y, markers[i].x),
                        zIndex: markers[i].zIndex
                    });

                    overlays.push(marker);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
        function drawPolyline(lines, instrokeColor, infillColor) {
            if (lines != [] || lines != "" || lines != null) {
                var len = lines.length, i = 0;

                for (; i < len; i++) {
                    var path = pointsToPath(lines[i].points);
                    var style = lines[i].options;
                    var polyline = new kakao.maps.Polyline({
                        map: map,
                        path: path,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight
                    });

                    overlays.push(polyline);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
        function drawRectangle(rects, instrokeColor, infillColor) {
            if (rects != [] || rects != "" || rects != null) {
                var len = rects.length, i = 0;

                for (; i < len; i++) {
                    var style = rects[i].options;
                    var rect = new kakao.maps.Rectangle({
                        map: map,
                        bounds: new kakao.maps.LatLngBounds(
                            new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                            new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
                        ),
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight,
                        fillColor: infillColor,
                        fillOpacity: style.fillOpacity
                    });

                    overlays.push(rect);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
        function drawCircle(circles, instrokeColor, infillColor) {
            if (circles != [] || circles != "" || circles != null) {
                var len = circles.length, i = 0;

                for (; i < len; i++) {
                    var style = circles[i].options;
                    var circle = new kakao.maps.Circle({
                        map: map,
                        center: new kakao.maps.LatLng(circles[i].center.y, circles[i].center.x),
                        radius: circles[i].radius,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight,
                        fillColor: infillColor,
                        fillOpacity: style.fillOpacity
                    });

                    overlays.push(circle);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 다각형을 아래 지도에 표시하는 함수입니다
        function drawPolygon(polygons, instrokeColor, infillColor) {
            if (polygons != [] || polygons != "" || polygons != null) {
                var len = polygons.length, i = 0;

                for (; i < len; i++) {
                    var path = pointsToPath(polygons[i].points);
                    var style = polygons[i].options;
                    var polygon = new kakao.maps.Polygon({
                        map: map,
                        path: path,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight,
                        fillColor: infillColor,
                        fillOpacity: style.fillOpacity
                    });

                    overlays.push(polygon);
                }
            }
        }





        // input (맵객체id, 중심좌표, 지도 데이터를 포함한 hiddenfiled , inStrokeColor,inFillColor)
        // return -> {생성한 지도객체, 생성한 manager, }
        function makeMapOption(mapId, mapCenter, mapLevel, mapDataInputId, inStrokeColor, inFillColor) {

            var drawingMapContainer = document.getElementById(mapId),
                drawingMap = {
                    center: mapCenter, // 지도의 중심좌표
                    level: mapLevel // 지도의 확대 레벨
                };

            var drawingMap = new daum.maps.Map(drawingMapContainer, drawingMap);

            var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
                map: drawingMap, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
                drawingMode: [ // Drawing Manager로 제공할 그리기 요소 모드입니다
                    daum.maps.drawing.OverlayType.ARROW,
                    daum.maps.drawing.OverlayType.CIRCLE,
                    daum.maps.drawing.OverlayType.ELLIPSE,
                    daum.maps.drawing.OverlayType.MARKER,
                    daum.maps.drawing.OverlayType.POLYLINE,
                    daum.maps.drawing.OverlayType.POLYGON,
                    daum.maps.drawing.OverlayType.RECTANGLE
                ],

                arrowOptions: {
                    draggable: false,
                    removable: false,
                    editable: false,
                    strokeWeight: 3,
                    strokeOpacity: 0.8,
                    strokeColor: inStrokeColor,
                    strokeStyle: 'solid',
                    hintStrokeStyle: 'dashdot',
                    hintStrokeOpacity: 0.3,
                    startArrow: false
                },
                circleOptions: {
                    draggable: false,
                    removable: false,
                    editable: true,
                    strokeColor: inStrokeColor,
                    fillColor: inFillColor,
                    fillOpacity: 0.5
                },
                ellipseOptions: {
                    draggable: false,
                    removable: false,
                    editable: false,
                    strokeWeight: 2,
                    strokeOpacity: 0.8,
                    strokeColor: inStrokeColor,
                    strokeStyle: 'solid',
                    fillColor: inFillColor,
                    fillOpacity: 0.3
                },
                markerOptions: { // 마커 옵션입니다
                    draggable: false, // 마커를 그리고 나서 드래그 가능하게 합니다
                    removable: false, // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다
                    markerImages: [
                        null, // API에서 제공하는 기본 마커 이미지
                        {
                            src: 'http://t1.daumcdn.net/localimg/localimages/07/2009/map/icon/ico_mn_13.png',
                            width: 31,
                            height: 35,
                            shape: 'rect',
                            coords: '0,0,31,35',
                            hoverImage: {
                                src: 'http://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_normal.png',
                                width: 33,
                                height: 36,
                                offsetX: 12,
                                offsetY: 36,
                                spriteWidth: 644,
                                spriteHeight: 946,
                                spriteOriginX: 10,
                                spriteOriginY: 10
                            },
                            dragImage: {
                                src: 'http://t1.daumcdn.net/localimg/localimages/07/2012/attach/pc_img/ico_comm.png',
                                width: 20, // 마커 크기
                                height: 20, // 마커 크기
                                offsetX: 10, // 지도에 고정시킬 이미지 내 위치 좌표
                                offsetY: 20, // 지도에 고정시킬 이미지 내 위치 좌표
                                spriteWidth: 118, // 이미지 전체 크기
                                spriteHeight: 111, // 이미지 전체 크기
                                spriteOriginX: 0, // 이미지 중 마커로 사용할 위치
                                spriteOriginY: 90 // 이미지 중 마커로 사용할 위치
                            }
                        }
                    ]
                },
                polylineOptions: { // 선 옵션입니다
                    draggable: false, // 그린 후 드래그가 가능하도록 설정합니다
                    removable: false, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
                    editable: false, // 그린 후 수정할 수 있도록 설정합니다
                    strokeColor: inStrokeColor, // 선 색
                    hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
                    hintStrokeOpacity: 0.5 // 그리중 마우스를 따라다니는 보조선의 투명도
                },
                polygonOptions: {
                    draggable: false,
                    removable: false,
                    editable: false,
                    strokeColor: inStrokeColor,
                    fillColor: inFillColor,
                    fillOpacity: 0.5,
                    hintStrokeStyle: 'dash',
                    hintStrokeOpacity: 0.5
                },
                rectangleOptions: {
                    draggable: false,
                    removable: false,
                    editable: false,
                    strokeColor: inStrokeColor, // 외곽선 색
                    fillColor: inFillColor, // 채우기 색
                    fillOpacity: 0.5 // 채우기색 투명도
                }

            };
            var resultManager = new daum.maps.drawing.DrawingManager(options);

            return { map: drawingMap, manager: resultManager };

        }
        //------------------------------------
        //----------drawingMap DataBind Start Not Map
        //-------------------------------








        function setDrawingMapDataByManagerMapId(inManager, mapId) {
            // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
            var data = JSON.parse(document.getElementById(mapId).value);
            console.info(data);

            // 아래 지도에 그려진 도형이 있다면 모두 지웁니다


            console.info(data["marker"]);
            console.info(data["polyline"]);
            console.info(data["rectangle"]);
            console.info(data["circle"]);
            console.info(data["polygon"]);
            console.info(data["ellipse"]);
            console.info(data["arrow"]);
            // 지도에 가져온 데이터로 도형들을 그립니다
            setMarker(inManager, data["marker"]);
            setPolyline(inManager, data["polyline"]);
            setRectangle(inManager, data["rectangle"]);
            setCircle(inManager, data["circle"]);
            setPolygon(inManager, data["polygon"]);
            setEllipse(inManager, data["ellipse"]);
            setArrow(inManager, data["arrow"]);




        }


        function setArrow(inManager, arrow) {
            var len = arrow.length,
                i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(arrow[i].points);
                inManager.put(kakao.maps.drawing.OverlayType.ARROW, path);
            }
        }

        function setEllipse(inManager, ellipse) {
            var len = ellipse.length,
                i = 0;

            for (; i < len; i++) {
                var style = ellipse[i].options;
                bounds = new kakao.maps.LatLngBounds(
                    new kakao.maps.LatLng(ellipse[i].sPoint.y, ellipse[i].sPoint.x),
                    new kakao.maps.LatLng(ellipse[i].ePoint.y, ellipse[i].ePoint.x)
                );
                inManager.put(kakao.maps.drawing.OverlayType.ELLIPSE, bounds);
            }
        } // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
        function setMarker(inManager, markers) {

            var len = markers.length,
                i = 0;

            for (; i < len; i++) {
                inManager.put(kakao.maps.drawing.OverlayType.MARKER, new kakao.maps.LatLng(markers[i].y, markers[i].x), 2);
            }
        }

        // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
        function setPolyline(inManager, lines) {
            var len = lines.length,
                i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(lines[i].points);
                inManager.put(kakao.maps.drawing.OverlayType.POLYLINE, path);


            }
        }

        // Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
        function setRectangle(inManager, rects) {
            var len = rects.length,
                i = 0;

            for (; i < len; i++) {
                var style = rects[i].options;
                bounds = new kakao.maps.LatLngBounds(
                    new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                    new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
                );
                inManager.put(kakao.maps.drawing.OverlayType.RECTANGLE, bounds);



            }
        }

        // Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
        function setCircle(inManager, circles) {
            var len = circles.length,
                i = 0;

            for (; i < len; i++) {

                inManager.put(kakao.maps.drawing.OverlayType.CIRCLE, new kakao.maps.LatLng(circles[i].center.y, circles[i].center.x), circles[i].radius);

            }
        }

        // Drawing Manager에서 가져온 데이터 중 다각형을 아래 지도에 표시하는 함수입니다
        function setPolygon(inManager, polygons) {
            var len = polygons.length,
                i = 0;

            for (; i < len; i++) {

                var path = pointsToPath(polygons[i].points);
                inManager.put(kakao.maps.drawing.OverlayType.POLYGON, path);

            }
        }

        // Drawing Manager에서 가져온 데이터 중 
        // 선과 다각형의 꼭지점 정보를 kakao.maps.LatLng객체로 생성하고 배열로 반환하는 함수입니다 
        function pointsToPath(points) {
            var len = points.length,
                path = [],
                i = 0;

            for (; i < len; i++) {
                var latlng = new kakao.maps.LatLng(points[i].y, points[i].x);
                path.push(latlng);
            }

            return path;
        }
    //------------------------------------
    //----------DrawingMap DataBind  END  Not Map
    //------------------------------------


        // c
        <%
        List<Map> mapList = getMapByTrvDayNo();
<<<<<<< HEAD
        string [] color= { "#E53A40", "#F68657", "#EFDC05", "#58C9B9", "#a3daff", "#0080ff" , "#A593E0", "#C5C6B6", "#D09E88", "#FADAD8", "#fab1ce", "#fffff5", "#c8c8a9", "#3a5134" };
=======
        string[] color = { "#007bff", "#dc3545", "#fd7e14", "#28a745", "#17a2b8", "#ffc107", "#fff", "#20c997", "#6610f2" };
>>>>>>> 8451cd397e6e51e1676f374e17130bcebf3bb693
        int colorIndex = 0;
        int index = 0;
        JObject mapCenter;
        foreach (var map in mapList)
        {
            mapCenter = JObject.Parse(map.Map_center);

            Response.Write("var map_" + index + " = makeMapOption('map_" + index + "', new daum.maps.LatLng("+mapCenter["Ha"]+", "+mapCenter["Ga"]+"), 3, 'mapData_" + index + "', '"+color[colorIndex]+"', '"+color[colorIndex]+"') ;");
            Response.Write("setDrawingMapDataByManagerMapId(map_" + index + ".manager, 'mapData_" + index + "');");
            Response.Write("getDataFromDrawingMap('mapData_" + index + "', '" + color[colorIndex] + "', '" + color[colorIndex] + "');");
            if (colorIndex < color.Length)
            {
                colorIndex++;
            }
            else
            {
                colorIndex = 0;
            }
            index++;
        }


        %>

       

    

    </script>
</body>
</html>
