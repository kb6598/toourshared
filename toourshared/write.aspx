<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">


    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("/index.aspx");
    }
    protected void btnMypage_Click(object sender, EventArgs e)
    {
        Response.Redirect("/MyPage.aspx");
    }
    protected void btnJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("/join.aspx");
    }
    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("/find_idpw.aspx");
    }


    //<div class="mainImg_Input">
    //                        <input type="file" name="main_img" id="main_img">
    //                    </div>

    protected void WriteSessionProcess()
    {
        int SESSION_TIME_OUT_MIN = 60;
        //if (IsLogin.isLogin() == false)
        //{
        //    Response.Redirect("/index.aspx");
        //}
        // 테스트 코드
        if(HttpContext.Current.Session["mem_id"] == null)
        {
            Session["mem_id"] = "billip";
        }


        //status -> 편집 페이지 정보
        //세션 status가 비어있다면 새로운 status 생성
        if (HttpContext.Current.Session["write_status"] == null)
        {


            // 비어있는 travel을 삽입하고 trv_no(pk) 값을 가져옴
            Travel inTravel = new Travel();
            inTravel.Mem_id = HttpContext.Current.Session["mem_id"].ToString();
            inTravel.Trv_create_time = TimeLib.GetTimeStamp();
            inTravel.Trv_secret = 0.ToString();
            inTravel.Trv_timestamp = TimeLib.GetTimeStamp();
            inTravel.Trv_title = Request.Form["title"];
            inTravel.Trv_tot_rate = 0.ToString();
            inTravel.Trv_views = 0.ToString();



            TravelDao travelDao = new TravelDao();
            string trv_no = travelDao.InsertTravel(inTravel);

            //travel_day도 생성
            Travel_Day travel_Day = new Travel_Day();
            travel_Day.Trv_no = trv_no;


            Travel_DayDao travel_DayDao = new Travel_DayDao();
            string trv_day_no = travel_DayDao.InsertTravel_Day(travel_Day);
            // 현재폼 정보를 저장할 딕셔너리 생성 나중에 세션에 넘겨줌
            Dictionary<string, string> newWriteStatus = new Dictionary<string, string>()
            {
                {"status","first" },
                { "trv_no", trv_no},
                { "cur_trv_day_no",trv_day_no},
                { "cur_day","1"},
                {"trv_day_cnt","1" },
                {"1",trv_day_no }

            };
            Session["write_status"] = newWriteStatus;
            Session.Timeout = SESSION_TIME_OUT_MIN;

        }










    }
    protected void BindTables()
    {

        Dictionary<string, string> readWriteStatus = SessionLib.getWriteStatus();
        if (readWriteStatus != null)
        {

            Literal_day.Text = readWriteStatus["cur_day"];

            Travel_Day input = new Travel_Day();
            Travel_Day output = new Travel_Day();
            Travel_DayDao dao = new Travel_DayDao();

            input.Trv_day_no = readWriteStatus["cur_day"];
            output = dao.selectTrvel_DayBytrv_day_no(input);





        }

    }

    protected void BindDropDownList()
    {


        Dictionary<string, string> readWriteStatus = SessionLib.getWriteStatus();
        if (readWriteStatus != null)
        {
            int i = 1;
            ListItem lst;
            while (true)
            {
                if (!readWriteStatus.ContainsKey(i.ToString())) break;
                lst = new ListItem(i + "일차", i.ToString());
                goDay.Items.Add(lst);
                i++;
            }
        }

        //세션에서 편집 정보를 가져옴




    }


    protected void DropDownList_goDay_SelectedIndexChanged(object sender, EventArgs e)
    {

        if(HttpContext.Current.Session["write_status"] != null)
        {
            Dictionary<string, string> readWriteStatus = new Dictionary<string, string>();
            readWriteStatus = (Dictionary<string, string>)Session["write_status"];


        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        WriteSessionProcess();
        BindDropDownList();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>TO OUR SHARED : 글 작성 #일차</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|East+Sea+Dokdo|Jua&display=swap" rel="stylesheet">

    <!-- ICON -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- summerNote -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.11/dist/summernote-bs4.min.css" rel="stylesheet" />

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bs4-summernote@0.8.10/dist/summernote-bs4.min.js"></script>


    <style>
        body, form {
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

        .main {
            margin-top: 250px;
            width: 100%;
            height: 1500px;
            padding: 10px;
        }

        .TitleArea {
            width: 100%;
            height: 130px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .TitleAlign {
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

            .TitleAlign > input {
                width: 800px;
                height: 60px;
                padding: 0 auto;
                text-align-last: center;
                color: rgba(0, 0, 0, 0.7);
                font-size: 15px;
                border: none;
                outline: none;
                border-radius: 4px;
                transition-duration: .9s;
            }

                .TitleAlign > input:focus {
                    font-size: 28px;
                }

        .TitleSub {
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        .SubItem {
            padding: 0 30px;
        }

            .SubItem span {
                font-size: 13px;
                width: 130px;
                height: 40px;
                color: #eee;
                border-radius: 5px;
                background-color: #2e2e2e;
                display: flex;
                cursor: default;
                justify-content: center;
                align-items: center;
            }

            .SubItem .goDay {
                width: 130px;
                height: 40px;
                border: none;
                outline: none;
                color: #eee;
                text-align-last: center;
                background-color: #2e2e2e;
                font-size: 13px;
                padding: 10px;
                border-radius: 5px;
            }

        /* 글 작성 영역 外 */
        .MapArea {
            width: 100%;
            height: 850px;
            margin-top: 100px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        /* 글 작성 영역 內 */
        #travelRoute_wrap {
            width: 1530px;
            height: 100%;
            display: flex;
            flex-direction: row;
        }

        /* 글 작성 좌측 사이드 영역 */
        .travelRouteItem-Left {
            width: 20%;
            height: 100%;
            padding: 10px;
        }

        /* 글 작성 센터 영역 */
        .travelRouteItem-Center {
            width: 60%;
            height: 100%;
            padding: 10px;
        }

        /* 글 작성 우측 사이드 영역 */
        .travelRouteItem-Right {
            width: 20%;
            height: 100%;
            padding: 10px;
        }

        /* 여행 방문 헤더 영역 */
        .travelRoute-header {
            width: 100%;
            height: 100px;
        }

        /* 여행 방문 내용 영역 */
        .travelRoute-content {
            width: 100%;
            height: 730px;
        }

        .travelRouteItem-Left .travelRoute-header {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            border: none;
            border-bottom: 0.5px solid rgba(0, 0, 0, .2);
            background-color: darkorange;
        }

        .travelRouteItem-Left .travelRoute-content {
            display: flex;
            flex-direction: column;
            background-color: #FFEEE4;
        }

        .travelRoute-header .trTitle1 {
            font-size: 14px;
            font-weight: 700;
        }

        .travelRoute-header .trTitle2 {
            padding-top: 5px;
            font-size: 12px;
            font-weight: 300;
        }

        .travelRouteItem-Center .travelRoute-header {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            border: none;
            border-bottom: 0.5px solid rgba(0, 0, 0, .2);
            background-color: darkorange;
        }

            .travelRouteItem-Center .travelRoute-header button {
                margin: 0 8px;
                width: 80px;
                height: 80px;
                font-size: 11px;
                border: none;
                outline: none;
                background-color: transparent;
                transition-duration: .3s;
            }

                .travelRouteItem-Center .travelRoute-header button:hover {
                    font-weight: 700;
                    margin-bottom: 5px;
                }

        .travelRoute-header button p {
            margin: 5px;
        }

        .travelRouteItem-Center .map_wrap {
            width: 100%;
            height: 730px;
            padding: 10px;
            background-color: #FFEEE4;
        }

        .travelRouteItem-Right .modal-cost {
        }

        .travelRouteItem-Right .cost-header {
            width: 100%;
            height: 100px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            border: none;
            border-bottom: 0.5px solid rgba(0, 0, 0, .2);
            background-color: darkorange;
        }

            .travelRouteItem-Right .cost-header .chTitle1 {
                font-size: 14px;
                font-weight: 700;
            }

            .travelRouteItem-Right .cost-header .chTitle2 {
                padding-top: 5px;
                font-size: 12px;
                font-weight: 300;
                padding-right: 35px;
            }

        .travelRouteItem-Right .cost-body {
            width: 100%;
            height: 730px;
            background-color: #FFEEE4;
        }

        .hashArea {
            width: 100%;
            height: 100px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 50px;
        }

        .hashAreaItem {
            width: 1200px;
            height: 50px;
            padding: 10px;
            font-size: 13px;
            border-radius: 5px;
            border: none;
            outline: none;
        }

        .taArea {
            width: 100%;
            height: 600px;
            margin-top: 20px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

            .taArea .form-group {
                width: 1510px;
                height: 100%;
            }

        .note-editing-area {
            height: 600px;
            resize: none;
        }

        .note-statusbar {
            display: none;
        }

        .btnArea {
            width: 100%;
            height: 150px;
            padding: 10px;
            margin-top: 50px;
            display: flex;
            flex-direction: row;
            justify-content: center;
        }

            .btnArea > div {
                padding: 0 30px;
            }

        .btnAreaItem {
            width: 200px;
            height: 40px;
            outline: none;
            border: none;
            font-size: 13px;
            color: white;
            background-color: #D81159;
            transition-duration: .5s;
        }



        .mainImgArea {
            width: 100%;
            height: 200px;
            margin-top: 100px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .mainImg_wrap {
            width: 1200px;
            height: 200px;
            border-radius: 5px;
            background-color: #eee;
            border: 1px solid white;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        .mainImg_label {
            font-size: 13px;
            font-weight: 700;
            padding: 10px 0;
        }

        .mainImg_Input {
            background-color: white;
            font-size: 13px;
            padding: 10px;
        }

        .mainImg_AlignRight {
            padding: 100px;
        }

        #mainImgItem {
            width: 0;
            height: 0;
            transition-duration: .5s;
        }

        .mapWrap {
            padding: 10px;
        }

        #drawingMap {
            z-index: 3;
            height: 100%;
            border: 1px solid black;
        }
        <!-- 원본 style-- >
        .modes {
            top: 10px;
            left: 10px;
            z-index: 1;
        }

        .map_wrap a,
        .map_wrap a:hover,
        .map_wrap a:active {
            color: #000;
            text-decoration: none;
        }

        #menu_wrap {
            margin: 10px 0 30px 10px;
            padding: 5px;
            overflow-y: auto;
            background: rgba(255, 255, 255, 0.7);
            z-index: 1;
            font-size: 12px;
            border-radius: 10px;
        }

        .bg_white {
            background: #fff;
        }

        #menu_wrap hr {
            display: block;
            height: 1px;
            border: 0;
            border-top: 2px solid #5F5F5F;
            margin: 3px 0;
        }

        #menu_wrap .option {
            text-align: center;
        }

            #menu_wrap .option p {
                margin: 10px 0;
            }

            #menu_wrap .option button {
                margin-left: 5px;
            }

        #placesList li {
            list-style: none;
        }

        #placesList .item {
            position: relative;
            border-bottom: 1px solid #888;
            overflow: hidden;
            cursor: pointer;
            min-height: 65px;
        }

            #placesList .item span {
                display: block;
                margin-top: 4px;
            }

            #placesList .item h5,
            #placesList .item .info {
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            #placesList .item .info {
                padding: 10px 0 10px 55px;
            }

        #placesList .info .gray {
            color: #8a8a8a;
        }

        #placesList .info .jibun {
            padding-left: 26px;
            background: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
        }

        #placesList .info .tel {
            color: #009900;
        }

        #placesList .item .markerbg {
            float: left;
            position: absolute;
            width: 36px;
            height: 37px;
            margin: 10px 0 0 10px;
            background: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
        }

        #placesList .item .marker_1 {
            background-position: 0 -10px;
        }

        #placesList .item .marker_2 {
            background-position: 0 -56px;
        }

        #placesList .item .marker_3 {
            background-position: 0 -102px
        }

        #placesList .item .marker_4 {
            background-position: 0 -148px;
        }

        #placesList .item .marker_5 {
            background-position: 0 -194px;
        }

        #placesList .item .marker_6 {
            background-position: 0 -240px;
        }

        #placesList .item .marker_7 {
            background-position: 0 -286px;
        }

        #placesList .item .marker_8 {
            background-position: 0 -332px;
        }

        #placesList .item .marker_9 {
            background-position: 0 -378px;
        }

        #placesList .item .marker_10 {
            background-position: 0 -423px;
        }

        #placesList .item .marker_11 {
            background-position: 0 -470px;
        }

        #placesList .item .marker_12 {
            background-position: 0 -516px;
        }

        #placesList .item .marker_13 {
            background-position: 0 -562px;
        }

        #placesList .item .marker_14 {
            background-position: 0 -608px;
        }

        #placesList .item .marker_15 {
            background-position: 0 -654px;
        }

        #pagination {
            margin: 10px auto;
            text-align: center;
        }

            #pagination a {
                display: inline-block;
                margin-right: 10px;
            }

            #pagination .on {
                font-weight: bold;
                cursor: default;
                color: #777;
            }


        < !-- 커스텀 오버레이 스타일-- >
        .card-cus {
            border: 1px outset rgba(0, 0, 0, .19);
            width: 300px;
            word-spacing: -1px;
        }

        .card-header {
            width: 100%;
            height: 50px;
            display: flex;
            flex-direction: row;
            background-color: #eee;
            font-family: 'Noto Sans KR', sans-serif;
            padding: 0px;
        }

        .card-title {
            width: 100%;
            height: 100%;
            display: flex;
            font-size: 18px;
            justify-content: center;
            align-items: center;
            padding-left: 10px;
            color: #000;
        }

        .card-input {
            width: 95%;
            height: 80%;
            padding: 10px;
            outline: none;
        }

        .card-close {
            width: 10%;
            height: 100%;
            display: flex;
            justify-content: center;
            padding-top: 3px;
            margin-right: 8px;
        }

            .card-close .closeBtn {
                color: #000;
                font-size: 25px;
            }

        .closeBtn span {
            cursor: pointer;
            color: black;
        }

        .card-body {
            width: 100%;
            height: 100%;
            padding: 20px 0px;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
            text-align: center;
            font-size: 18px;
            overflow: auto;
        }

        .card-body-li {
            font-size: 15px;
            list-style: none;
        }

        .card-addBtn {
            width: 80px;
            height: 27px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: .2rem;
            font-size: .875rem;
            cursor: pointer;
            background-color: orange;
            transition-duration: .9s;
        }

            .card-addBtn:hover {
                transition-duration: .9s;
                background-color: darkorange;
            }

        < !-- modal-cost and TravelRoute-- > < !-- modal-cost and TravelRoute-- >
        .modal-cost {
            display: flex;
            flex-direction: row-reverse;
            width: 100%;
        }

        #travelRoute {
            list-style: none;
        }

        .costItem,
        .travelPoint {
            width: 100%;
            cursor: default;
            padding: 10px 0 5px;
            border-bottom: 1px dashed rgba(0, 0, 0, 0.2);
        }

        .costItem-header span {
            font-size: 30px;
            font-family: 'East Sea Dokdo', cursive;
        }

        .costItem-body ul {
            padding: 0 5px 0 20px;
            list-style-type: circle;
        }

        .costItem-body li {
            font-size: 12px;
        }

        < !--bootstrap customize-- >
        .row {
            width: 100%;
        }

        .btn-group-sm > .btn, .btn-sm {
            font-size: 8px;
        }

        .form-control-sm {
            font-size: 10px;
        }

        .btn-warning {
            box-sizing: content-box;
            font-size: 2px;
            padding-top: 0px;
            padding-bottom: 0px;
            padding-left: 0px;
            padding-right: 0px;
            width: 10px;
            height: 10px;
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

        /* TextArea Summernote */
        $(document).ready(function () {
            $('textarea').summernote({
                height: 300, //set editable area's height
            });
        });

        /* FileUpload (경로 없이 무조건 파일명만 뜨게) */
        $(document).ready(function () {
            var fileTarget = $('.fileItem');
            var originalFileName;
            fileTarget.on('change', function () { // 값이 변경되면
                if (window.FileReader) { // modern browser
                    originalFileName = $(this)[0].files[0].name;

                    var filename = $(this)[0].files;
                    var filename = $(this)[0].files[0].name;
                }
                else { // old IE
                    originalFileName = $(this).val();
                    var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
                }

                // 추출한 파일명 삽입
                $(this).siblings('.fileItem').val(filename);

                // modalBody 부분 높이 조절 및 업로드 버튼 나타내기
                document.getElementById("mainImgItem").style.width = "150px";
                document.getElementById("mainImgItem").style.height = "150px";

                var image = document.getElementById("mainImgItem");
                image.alt = filename;
                image.src = originalFileName;
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
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
                        <li><a href="#">TOUPLE</a></li>
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
                                <asp:Button ID="btnLogin" runat="server" Text="로그인" class="nav-log-item" PostBackUrl="~/login.aspx" />
                            </div>
                        </a>
                    </div>
                    <ul>
                        <br />
                        <li>
                            <asp:Button ID="btnJoin" runat="server" Text="회원가입" OnClick="btnJoin_Click" /></li>
                        <li>
                            <asp:Button ID="btnFindIDPW" runat="server" Text="계정찾기" OnClick="btnFindIDPW_Click" /></li>
                    </ul>
                </li>
                <%  
                    }
                    else
                    {
                %>
                <li class="topnavLi">
                    <a href="#"><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                    <ul>
                        <li>
                            <asp:Button ID="btnMypage" runat="server" Text="마이페이지" OnClick="btnMypage_Click" /></li>
                        <li>
                            <asp:Button ID="btnLogout" runat="server" Text="로그아웃" OnClick="btnLogout_Click" /></li>

                    </ul>
                </li>
                <% 
                    }
                %>
            </ul>
        </div>
        <div id="main" class="main">
            <!-- 메인 상단 영역 -->
            <div class="TitleArea">
                <div class="TitleAlign">
                    <input type="text" placeholder="게시글의 제목을 정해주세요." />
                </div>
                <div class="TitleSub">
                    <div class="SubItem">
                        <span>
                            <asp:Literal ID="Literal_day" runat="server"></asp:Literal>일 차 작성 중...</span>
                    </div>
                    <div class="SubItem">

                        <asp:DropDownList ID="goDay" runat="server" OnSelectedIndexChanged="DropDownList_goDay_SelectedIndexChanged">
                        </asp:DropDownList>

                    </div>
                </div>
            </div>

            <!-- 중앙 영역 1 -->
            <div class="MapArea">
                <div id="travelRoute_wrap">
                    <div class="travelRouteItem-Left">
                        <div class="travelRoute-header">
                            <div class="trTitle1"><span class="trTitle">여행지</span></div>
                            <div class="trTitle2"><span id="trBody">방문 : 0</span></div>
                        </div>
                        <div class="travelRoute-content">
                            <ul id="travelRoute" class="travelRoute"></ul>
                        </div>
                    </div>
                    <div class="travelRouteItem-Center">
                        <div class="travelRoute-header">
                            <button type="button" class="TIFIRST" onclick="selectOverlay('MARKER')">
                                <p>📌</p>
                                <p>마커</p>
                            </button>
                            <button type="button" onclick="selectOverlay('POLYLINE')">
                                <p>🥖</p>
                                <p>선</p>
                            </button>
                            <button type="button" onclick="selectOverlay('CIRCLE')">
                                <p>🍅</p>
                                <p>원</p>
                            </button>
                            <button type="button" onclick="selectOverlay('RECTANGLE')">
                                <p>🍱</p>
                                <p>사각형</p>
                            </button>
                            <button type="button" onclick="selectOverlay('POLYGON')">
                                <p>🍰</p>
                                <p>다각형</p>
                            </button>
                            <button type="button" onclick="selectOverlay('ELLIPSE')">
                                <p>🍪</p>
                                <p>타원</p>
                            </button>
                            <button type="button" onclick="selectOverlay('ARROW')">
                                <p>👉</p>
                                <p>화살표</p>
                            </button>
                            <button type="button" id="undo" onclick="undoAction()" disabled>
                                <p>↺</p>
                                <p>동작취소</p>
                            </button>
                            <button type="button" id="redo" onclick="redoAction()" disabled>
                                <p>↻</p>
                                <p>되돌리기</p>
                            </button>
                            <button type="button" class="TILAST" data-toggle="modal" data-target="#searchPlaceModal">
                                <p>🍳</p>
                                <p>장소검색</p>
                            </button>
                        </div>
                        <div class="map_wrap">
                            <div id="drawingMap"></div>
                        </div>
                    </div>

                    <div class="travelRouteItem-Right">
                        <div id="travelCost_wrap">
                            <div class="modal-cost">
                                <div class="modal-cost-area">
                                    <div class="cost-header" id="costHeader">
                                        <div class="chTitle1"><span class="chTitle">전체 경비</span></div>
                                        <div class="chTitle2"><span class="chBody">💰 0</span></div>
                                    </div>
                                    <div class="cost-body" id="costBody">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 중앙 영역 2 -->
            <div class="taArea">
                <div class="form-group">
                    <textarea type="text" id="article" name="article"></textarea>
                </div>
            </div>

            <!-- 메인페이지 영역 -->
            <div class="mainImgArea">
                <div class="mainImg_wrap">
                    <div class="mainImg_AlignLeft">
                        <div class="mainImg_Label">게시글의 메인이미지를 첨부하세요.</div>
                        <div class="mainImg_Input">
                            <asp:FileUpload ID="main_img" runat="server" />
                        </div>
                    </div>
                    <div class="mainImg_AlignRight">
                        <img src="./img/%EC%A0%9C%EC%A3%BC%EB%8F%84.jpg" alt="userMainImage" id="mainImgItem" />
                    </div>
                </div>
            </div>

            <!-- 해쉬태그 영역 -->
            <div class="hashArea">
                <input type="text" placeholder="해쉬태그를 입력하세요. (ex : #여행 #추억) (스페이스바로 구분지어 주세요.)" class="hashAreaItem" />
            </div>

            <!-- 하단부 영역 -->
            <div class="btnArea">
                <!-- 임시 저장 버튼 -->
                <div class="tempSaveBtn">
                    <div onclick ="tmpSave()" class="btnAreaItem">임시 저장"</div>
                </div>
                <!-- 다음 일로 이동 -->
                <div onclick ="nextDay()" class="nextPageBtn">
                    <div class="btnAreaItem">다음 일 입력</div>
                </div>
                <!-- 글 작성 완료 버튼 -->
                <div class="finishBtn">
                    <div onclick ="endWrite`
                        ()" class="btnAreaItem">글 작성 완료</div>
                </div>
            </div>
        </div>

        <!-- 장소 검색 Modal 영역 -->
        <div class="modal fade" id="searchPlaceModal" tabindex="-1" role="dialog" aria-labelledby="searchPlaceModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="searchPlaceModalTitle">장소 검색</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="menu_wrap" class="bg_white">
                            <div class="option">
                                <div>
                                    키워드 :
                                <input id="keyword" value="이태원 맛집" type="text" />
                                    <button onclick="searchPlaces();">검색하기</button>
                                </div>
                            </div>
                            <hr />
                            <ul id="placesList"></ul>
                            <div id="pagination"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>



    </form>
    <!-- KAKAO -->
    <script type="text/javascript" >
        // Drawing Manager로 도형을 그릴 지도 div
        var drawingMapContainer = document.getElementById('drawingMap'),
            drawingMap = {
                center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        //var drawingMap = new daum.maps.Map(drawingMapContainer, mapOption);
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
            // 사용자에게 제공할 그리기 가이드 툴팁입니다
            // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
            guideTooltip: ['draw', 'drag', 'edit'],
            arrowOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeWeight: 3,
                strokeOpacity: 0.8,
                strokeColor: '#39f',
                strokeStyle: 'solid',
                hintStrokeStyle: 'dashdot',
                hintStrokeOpacity: 0.3,
                startArrow: false
            },
            circleOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeColor: '#39f',
                fillColor: '#39f',
                fillOpacity: 0.5
            },
            ellipseOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeWeight: 2,
                strokeOpacity: 0.8,
                strokeColor: '#39f',
                strokeStyle: 'solid',
                fillColor: '#39f',
                fillOpacity: 0.3
            },
            markerOptions: { // 마커 옵션입니다
                draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다
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
                draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
                removable: false, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
                editable: true, // 그린 후 수정할 수 있도록 설정합니다
                strokeColor: '#39f', // 선 색
                hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
                hintStrokeOpacity: 0.5 // 그리중 마우스를 따라다니는 보조선의 투명도
            },
            polygonOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeColor: '#39f',
                fillColor: '#39f',
                fillOpacity: 0.5,
                hintStrokeStyle: 'dash',
                hintStrokeOpacity: 0.5
            },
            rectangleOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeColor: '#39f', // 외곽선 색
                fillColor: '#39f', // 채우기 색
                fillOpacity: 0.5 // 채우기색 투명도
            }

        };

        // 위에 작성한 옵션으로 Drawing Manager를 생성합니다
        var manager = new daum.maps.drawing.DrawingManager(options);

        // undo, redo 버튼의 disabled 속성을 설정하기 위해 엘리먼트를 변수에 설정합니다
        var undoBtn = document.getElementById('undo');
        var redoBtn = document.getElementById('redo');

        // Drawing Manager 객체에 state_changed 이벤트를 등록합니다
        // state_changed 이벤트는 그리기 요소의 생성/수정/이동/삭제 동작
        // 또는 Drawing Manager의 undo, redo 메소드가 실행됐을 때 발생합니다
        manager.addListener('state_changed', function () {

            // 되돌릴 수 있다면 undo 버튼을 활성화 시킵니다
            if (manager.undoable()) {
                undoBtn.disabled = false;

            } else { // 아니면 undo 버튼을 비활성화 시킵니다
                undoBtn.disabled = true;
            }

            // 취소할 수 있다면 redo 버튼을 활성화 시킵니다
            if (manager.redoable()) {
                redoBtn.disabled = false;
            } else { // 아니면 redo 버튼을 비활성화 시킵니다
                redoBtn.disabled = true;
            }

        });


        class History {
            constructor() {
                this._cursor = 0;
                this.cur_overlay
                this.history = Array();
                this.history.push({
                    PlaceList: Array(),
                    TravelRouteItemList: Array(),
                    CostItemList: Array()
                });
            }
            setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;
            }
            push
        }



        // 버튼 클릭 시 호출되는 핸들러 입니다
        function selectOverlay(type) {
            // 그리기 중이면 그리기를 취소합니다
            manager.cancel();

            // 클릭한 그리기 요소 타입을 선택합니다
            manager.select(daum.maps.drawing.OverlayType[type]);
        }



        // undo 버튼 클릭시 호출되는 함수입니다.
        function undoAction() {
            // 그리기 요소를 이전 상태로 되돌립니다
            manager.undo();
        }

        // redo 버튼 클릭시 호출되는 함수입니다.
        function redoAction() {
            // 이전 상태로 되돌린 상태를 취소합니다
            manager.redo();
        }


        ////////////////////////////////////////////



        manager.addListener('drawend', function (data) {
            // data.target 에 그려진 오버레이 객체가 넘어온다.
            console.info(data.target);
        });




        // drawManager의 상태가 변경되고
        // travelRoute와 변경
        manager.addListener('state_changed', function () {
            closeCusOverlay();
            //console.info(this._historyStroage);
            refreshOverlayListener();


        });
        // e 는 삭제되는 대상 오버레이가 삭제될때 listener 삭제
        // 대상이 삭제되면 listener 도 같이 삭제됨
        // 애초에 리스너가 ExtenedMarker의 부분 요소로 들어가기 때문에
        // 같이 삭제됨
        manager.addListener('remove', function (e) {

        });
        //http://localhost:49862/


        function refreshOverlayListener() {
            var data = manager.getOverlays();
            var overlayType = ["circle", "ellipse", "marker", "polygon", "rectangle"];
            overlayType.forEach(function (overlay, overlayIndex, overlayArray) {
                // 각 오버레이들은 길이가 0인 배열로 최초부터 존제
                //if (data[overlay] != null) {
                if (data[overlay].length > 0) {
                    //현재 상태와 이전 상태의 오버레이 갯수가 같다면 해당 리스트 전부 새로고침
                    //console.info(overlay + " : " + data[overlay]._index + "를 새로 고침");
                    data[overlay].forEach(function (value, index, array) {
                        try {
                            //removeListener 시도
                            // 리스너를 만드는중에 오버레이를 전달
                            kakao.maps.event.removeListener(value, 'click', onClick_overlay);
                        } catch (exception) {
                            //console.info(exception);
                        } finally {
                            kakao.maps.event.addListener(value, 'click', onClick_overlay);
                        }


                    });

                }
            });
        }


        //주소 - 좌표간 변환 서비스 객체를 생성한다.
        var geocoder = new kakao.maps.services.Geocoder();

        var customOverlay = new kakao.maps.CustomOverlay({
            xAnchor: 0.5,
            yAnchor: 1.25,
            zIndex: 3
        });

        function closeCusOverlay() {
            customOverlay.setMap(null);
        }




        var curOverlay = Array(1);

        //-----------------------------------------------
        // 클릭시 발생하는 이벤트
        //----------------------------------------------
        var onClick_overlay = function () {

            //console.info(overlay.constructor.name + '_' + overlay._index);

            //console.info("onClick_overlay");
            //alert(this._index + "번째 마커" + "\nk : " + this.k + "\nGa : " + this.k.Ga + "\nHa : " + this.k.Ha + '\nMARKER click!');
            //console.info(this);
            //console.info(overlay);
            //---- 오버레이 타입마다 좌표가 존재하는 위치가 다름

            var coord_WCONGNAMUL = getWCONGNAMULFromOverlay(this);
            curOverlay[0] = this;


            //----좌표값으로 주소를 가져옴
            geocoder.coord2Address(coord_WCONGNAMUL.wcongnamulX, coord_WCONGNAMUL.wcongnamulY, function (result, status) {


                if (status === kakao.maps.services.Status.OK) {
                    //console.info(result);

                    var content = "<div>ok</div>";
                    var keyword = document.getElementById('keyword');



                    //주소가 있다면 검색
                    if (result[0].address != null) {
                        if (result[0].address.address_name != null) {
                            //                                keyword.value = result[0].address.address_name;
                            //                                //
                            //                                ps.keywordSearch(keyword.value, placesSearchByStateChange);
                            //                                $('#searchPlaceModal').modal('show');

                            content =


                                '<div class="card card-cus" style="width:300px;">' +
                                '<div class="card-header">' +
                                '<div class="card-title">' +
                                '<input class="form-control card-input" type="text" placeholder="장소 이름" value="" />' +
                                '</div>' +
                                '<div class="card-close">' +
                                '<div class="closeBtn" onclick="closeCusOverlay()">' +
                                '<span>×</span>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '<div class="card-body">' +
                                '<blockquote class="blockquote mb-0">';

                            if (result[0].address.address_name != null) {
                                content += '<li class="card-body-li">' + result[0].address.address_name + '</li>';
                            }
                            content +=
                                '<li class="card-body-li"> </li>' +
                                '<li class="card-body-li"> </li>' +
                                '</blockquote>' +
                                '<table style="margin-top: 10px;"><tr>' +
                                '<td>' +
                                '<div class="card-addBtn" onclick=\'pushTravelRouteItem("","","","","","' + coord_WCONGNAMUL.wcongnamulX + '","' + coord_WCONGNAMUL.wcongnamulY + '")\'>추가</div>' +
                                '</td>' +
                                '<td>' +
                                '<div class="card-addBtn" onclick=\'searchPlacesByAddress("' + result[0].address.address_name + '")\'>주소로 검색</div>' +
                                '</td>' +
                                '</tr></table>' +
                                '</div>';


                        }
                    }




                    geocoder.transCoord(coord_WCONGNAMUL.wcongnamulX, coord_WCONGNAMUL.wcongnamulY,
                        function (result, status) {

                            // 정상적으로 검색이 완료됐으면
                            if (status === kakao.maps.services.Status.OK) {
                                customOverlay.setPosition(new kakao.maps.LatLng(result[0].y, result[0].x));
                                customOverlay.setContent(content);
                                customOverlay.setMap(drawingMap);
                            }
                        }, {
                            input_coord: kakao.maps.services.Coords.WCONGNAMUL, // 변환을 위해 입력한 좌표계 입니다
                            output_coord: kakao.maps.services.Coords.WGS84 // 변환 결과로 받을 좌표계 입니다
                        });

                }
            }, {
                    input_coord: kakao.maps.services.Coords.WCONGNAMUL
                });


        }


        function getWCONGNAMULFromOverlay(overlay) {
            var wcongnamulX;
            var wcongnamulY;
            if (overlay.constructor.name == "ExtendsMarker") {
                wcongnamulX = overlay.k.Ga;
                wcongnamulY = overlay.k.Ha;
            } else if (overlay.constructor.name == "ExtendsCircle") {
                wcongnamulX = overlay.k.Ga;
                wcongnamulY = overlay.k.Ha;
            } else if (overlay.constructor.name == "ExtendsRectangle") {
                //ExtendedRectangle has za{ea,ja,ka,la} as coords
                wcongnamulY = (overlay.za.ka + overlay.za.la) / 2;
                wcongnamulX = (overlay.za.ea + overlay.za.ja) / 2;
            } else if (overlay.constructor.name == "ExtendsPolygon") {
                //ExtendedPolygon has ig{0: {ga: ha:}, }
                var gaTotal = 0;
                var haTotal = 0;
                overlay.Ig.forEach(function (value, index, array) {
                    gaTotal += value.Ga;
                    haTotal += value.Ha;
                });
                wcongnamulX = gaTotal / overlay.Ig.length;
                wcongnamulY = haTotal / overlay.Ig.length;
            } else if (overlay.constructor.name == "ExtendsEllipse") {
                wcongnamulX = overlay.k.Ga;
                wcongnamulY = overlay.k.Ha;
            }
            return { "wcongnamulX": wcongnamulX, "wcongnamulY": wcongnamulY };
        }



        // 검색 시스템



        var find_markers = [];


        var ps = new kakao.maps.services.Places();

        // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            zIndex: 1
        });

        // 키워드로 장소를 검색합니다
        searchPlaces();

        // 키워드 검색을 요청하는 함수입니다
        function searchPlaces() {

            var keyword = document.getElementById('keyword').value;

            if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }

            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword, placesSearchCB);
        }
        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {

                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);

                // 페이지 번호를 표출합니다
                displayPagination(pagination);

            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                alert('검색 결과가 존재하지 않습니다.');
                return;

            } else if (status === kakao.maps.services.Status.ERROR) {

                alert('검색 결과 중 오류가 발생했습니다.');
                return;

            }
        }


        // 키워드(주소를 통해서 ) 주변 검색을 요청하는 함수입니다
        function searchPlacesByAddress(address) {
            //주변검색을 하며 해당 마커는 삭제합니다.
            //console.info(curOverlay[0]);
            //manager.remove(curOverlay[0]);


            var keyword = document.getElementById('keyword');
            keyword.value = address;

            if (!keyword.value.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }

            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword.value, placesSearchByAddressCB);
        }

        // 키워드(주소를 통해서 ) 주변 검색이 완료되었을때 호출되는 콜백함수 입니다
        function placesSearchByAddressCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {

                manager.remove(curOverlay[0]);
                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);

                // 페이지 번호를 표출합니다
                displayPagination(pagination);
                $('#searchPlaceModal').modal('show');
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                alert('검색 결과가 존재하지 않아 더 넓은 주소로 찾습니다.');
                var keyword = document.getElementById('keyword');
                keyword.value = keyword.value.split('-')[0];
                ps.keywordSearch(keyword.value, placesSearchByAddressCB);
                return;

            } else if (status === kakao.maps.services.Status.ERROR) {

                alert('검색 결과 중 오류가 발생했습니다.');
                return;

            }
        }








        // 검색 결과 목록과 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            var listEl = document.getElementById('placesList'),
                menuEl = document.getElementById('menu_wrap'),
                fragment = document.createDocumentFragment(),
                bounds = new kakao.maps.LatLngBounds(),
                listStr = '';


            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(listEl);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();

            for (var i = 0; i < places.length; i++) {

                // 마커를 생성하고 지도에 표시합니다
                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                    marker = addMarker(placePosition, i),
                    itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                // LatLngBounds 객체에 좌표를 추가합니다
                bounds.extend(placePosition);

                // 마커와 검색결과 항목에 mouseover 했을때
                // 해당 장소에 인포윈도우에 장소명을 표시합니다
                // mouseout 했을 때는 인포윈도우를 닫습니다
                (function (marker, place) {
                    kakao.maps.event.addListener(marker, 'click', function () {
                        displayInfowindow(marker, place);
                    });

                    itemEl.onmouseover = function () {
                        displayInfowindow(marker, place);
                    };

                    itemEl.onmouseclick = function () {
                        displayInfowindow(marker, place);
                        $('#searchPlaceModal').modal('hide');

                    };

                })(marker, places[i]);

                fragment.appendChild(itemEl);
            }

            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            //map.setBounds(bounds);
            drawingMap.setBounds(bounds);
        }

        class Place {
            constructor(place_name, road_address_name, address_name, phone, place_url, x, y) {
                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;
            }
            setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;
            }
        }

        var CurPlaceList = Array();



        // 검색결과 항목을 Element로 반환하는 함수입니다
        function getListItem(index, places) {

            var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5 data-dismiss="modal">' + places.place_name + '</h5>';

            if (places.road_address_name) {
                itemStr += '    <span data-dismiss="modal">' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray" data-dismiss="modal">' + places.address_name + '</span>';
            } else {
                itemStr += '    <span data-dismiss="modal">' + places.address_name + '</span>';
            }

            itemStr += '  <span class="tel">' + places.phone + '</span>' +
                '</div>';

            el.innerHTML = itemStr;
            el.className = 'item';

            return el;
        }

        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarker(position, idx, title) {
            var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
                imgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                });

            marker.setMap(drawingMap); // 지도 위에 마커를 표출합니다
            find_markers.push(marker); // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
            for (var i = 0; i < find_markers.length; i++) {
                find_markers[i].setMap(null);
            }
            find_markers = [];
        }

        // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
        function displayPagination(pagination) {
            var paginationEl = document.getElementById('pagination'),
                fragment = document.createDocumentFragment(),
                i;

            // 기존에 추가된 페이지번호를 삭제합니다
            while (paginationEl.hasChildNodes()) {
                paginationEl.removeChild(paginationEl.lastChild);
            }

            for (i = 1; i <= pagination.last; i++) {
                var el = document.createElement('a');
                el.href = "#";
                el.innerHTML = i;

                if (i === pagination.current) {
                    el.className = 'on';
                } else {
                    el.onclick = (function (i) {
                        return function () {
                            pagination.gotoPage(i);
                        }
                    })(i);
                }

                fragment.appendChild(el);
            }
            paginationEl.appendChild(fragment);
        }

        // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
        // 인포윈도우에 장소명을 표시합니다
        function displayInfowindow(marker, place) {

            var content =
                '<div class="card card-cus" style="width:300px;">' +
                '<div class="card-header">' +
                '<div class="card-title">' +
                place.place_name +
                '</div>' +
                '<div class="card-close">' +
                '<div class="closeBtn" onclick="closeOverlay()">' +
                '<span >×</span>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="card-body">' +
                '<blockquote class="blockquote mb-0">';
            if (place.road_address_name != null) {
                content += '<li class="card-body-li">' + place.road_address_name + '</li>';
            }
            if (place.address_name != null) {
                content += '<li class="card-body-li">' + place.address_name + '</li>';
            }
            if (place.phone != null) {
                content += '<li class="card-body-li">' + place.phone + '</li>';
            }
            if (place.place_url != null) {
                content += '<li class="card-body-li" style="padding: 15px 0;"><a href="' + place.place_url + '" target="_blank" style="text-decoration: none;">상세페이지</a></li>';
            }
            content +=
                '</blockquote>' +
                '<div class="card-addBtn" onclick=\'pushTravelRouteItem("' + place.place_name + '","' + place.road_address_name + '","' + place.ddress_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>추가</div>' +
                '</div>' +
                '</div>';




            //            var content =
            //                '<div class="card">' +
            //                '<div class="card-header">' +
            //                place.place_name +
            //                '<div class="btn btn-link" onclick="closeOverlay()" title="닫기" style="float: right">X</div>' +
            //                '</div>' +
            //                '<blockquote class="blockquote mb-0">';
            //
            //            if (place.road_address_name != null) {
            //                content += '<li class="card-body-li">' + place.road_address_name + '</li>';
            //            }
            //            if (place.address_name != null) {
            //                content += '<li class="card-body-li">' + place.address_name + '</li>';
            //            }
            //            if (place.phone != null) {
            //                content += '<li class="card-body-li">' + place.phone + '</li>';
            //            }
            //            if (place.place_url != null) {
            //                content += '<li class="card-body-li"><a href="' + place.place_url + '" target="_blank" class="link">상세페이지</a></li>';
            //            }
            //            content +=
            //                '<div class="btn btn-secondary" onclick=\'pushTravelRouteItem("' + place.place_name + '","' + place.road_address_name + '","' + place.ddress_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>여행경로에 추가</div>' +
            //                '</blockquote>' +
            //                '</div>';

            infowindow.setContent(content);
            infowindow.open(drawingMap, marker);
        }
        // 모든 인포윈도우 닫음
        function closeOverlay() {
            infowindow.close();
        }


        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }

        //------------------------------------
        //----------TravelRouteItem and travelRouteList Start
        //------------------------------------

        class TravelRouteItem {
            constructor(place_name, road_address_name, address_name, phone, place_url, x, y) {
                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;
                this.info = "";

            }
            setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;

            }
            setName(place_name) {
                this.place_name = place_name;
            }
            setInfo(info) {
                this.info = info;
            }

        }

        var TravelRouteList = Array();

        function refreashTravelRoute() {

            var travelRouteUl = document.getElementById('travelRoute'),
                trBody = document.getElementById('trBody'),
                fragment = document.createDocumentFragment(),
                itemList = '',
                el;

            ;

            // costBody 모든 자식 노드 삭제
            while (travelRouteUl.hasChildNodes()) {
                travelRouteUl.removeChild(travelRouteUl.firstChild);
            }
            TravelRouteList.forEach(function (currentValue, index) {

                ////console.info(index);
                ////console.info(currentValue);
                el = document.createElement('li'),
                    itemStr =

                    '<div class="travelRouteItem-header">' +
                    ' <div class="form-group">' +
                    ' <table>' +
                    ' <tr>' +
                    ' <td>' +
                    ' <input id="addTravelRoute_place_name_' + index + '" class="form-control form-control-sm" type="text" placeholder="장소 이름" value="' + currentValue.place_name + '" style="width:130px;" />' +
                    ' </td>' +
                    ' <td>' +
                    ' <div class="btn btn-secondary btn-sm" onclick="setTravelRouteItemName(' + index + ')">이름변경</div>' +
                    ' </td>' +
                    ' <td>' +
                    ' <div class="btn btn-danger btn-sm" onclick="removeTravelRouteItem(' + index + ')"> x </div>' +
                    ' </td>' +
                    ' </tr>' +
                    '</table>' +
                    ' </div>' +
                    '</div>' +
                    ' <div>' +
                    '<table>' +
                    '<tr>' +
                    '<td>' +
                    ' <textarea id="addTravelRoute_info_' + index + '" class="form-control form-control-sm" type="text" placeholder="설명" rows="3" >' + currentValue.info + '</textarea>' +
                    '</td>' +
                    '<td style="vertical-align:top">' +
                    ' <div class="btn btn-secondary btn-sm" onclick="setTravelRouteItemInfo(' + index + ')" >설명저장</div>' +
                    '</td>' +
                    '</tr>' +
                    '</table>';

                if (currentValue.address_name != "" && currentValue.address_name != "undefined") {
                    itemStr += currentValue.address_name + '<br/>';

                }
                if (currentValue.road_address_name != "" && currentValue.road_address_name != "undefined") {
                    itemStr += currentValue.road_address_name + '<br/>';

                }
                if (currentValue.phone != "" && currentValue.phone != "undefined") {
                    itemStr += currentValue.phone + '<br/>';

                }
                itemStr += '<a class="btn btn-primary btn-sm" href="' + currentValue.place_url + '" target="_blank">상세페이지</a>';




                itemStr += '</div>';
                el.innerHTML = itemStr;
                el.setAttribute("draggable", 'true');
                el.setAttribute("class", "travelPoint");
                el.setAttribute("id", "travelPoint_" + index);



                var itemEl = el;

                fragment.appendChild(itemEl);

                travelRouteUl.appendChild(fragment);



            });

            var trBodyStr = '방문 : ' + TravelRouteList.length;
            ////console.info(trBody);
            trBody.innerHTML = trBodyStr;


            dragAndDropAction();

        }

        function pushTravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y) {

            TravelRouteList.push(new TravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y));
            addCostItemParent(place_name);
            refreashTravelRoute();
            closeOverlay();
            closeCusOverlay();

        }


        function removeTravelRouteItem(index) {
            TravelRouteList.splice(index, 1);
            removeCostItemParent(index);
            refreashTravelRoute();



        }




        function setTravelRouteItem(index, place_name, road_address_name, address_name, phone, place_url, x, y) {


            TravelRouteList[index].setRoute(place_name, road_address_name, address_name, phone, place_url, x, y);
            refreashTravelRoute();
        }

        function setTravelRouteItemName(index) {

            var addTravelRoute_place_nameId = "addTravelRoute_place_name_" + index;
            var place_name = document.getElementById(addTravelRoute_place_nameId).value;
            TravelRouteList[index].setName(place_name);
            refreashTravelRoute();

            setCostItemParentName(index);
        }

        function setTravelRouteItemInfo(index) {

            var addTravelRoute_infoId = "addTravelRoute_info_" + index;
            var info = document.getElementById(addTravelRoute_infoId).value;
            TravelRouteList[index].setInfo(info);
            refreashTravelRoute();

            setCostItemParentName(index);
        }




        function swapTravelRouteItem(fIndex, sIndex) {
            var tmp = TravelRouteList[fIndex];
            TravelRouteList[fIndex] = TravelRouteList[sIndex];
            TravelRouteList[sIndex] = tmp;
            refreashTravelRoute();
        }



        //------------------------------------
        //----------TravelRouteItem and travelRouteList END
        //------------------------------------

        //------------------------------------
        //----------CostItems and CostItemList Start
        //------------------------------------
        class CostItem {
            constructor(place_name) {
                this.itemList = Array();
                this.place_name = place_name;
            }
            setPlace_name(place_name) {
                this.place_name = place_name;
            }
            pushItem(costType, cost, info) {
                this.itemList.push({
                    costType,
                    cost,
                    info
                });
            }
            popItem() {
                this.itemList.pop();
            }
        }

        var CostItemList = Array();



        function button() {

        }


        function refreashCostItem() {

            var costBody = document.getElementById('costBody'),
                costHeader = document.getElementById('costHeader'),
                fragment = document.createDocumentFragment(),
                headerFragment = document.createDocumentFragment(),
                itemList = '',
                el, headerEl, totalCost = 0,
                pindexTmp;

            ;

            // costBody 모든 자식 노드 삭제
            while (costBody.hasChildNodes()) {
                costBody.removeChild(costBody.firstChild);
            }
            CostItemList.forEach(function (currentValue, pindex) {
                pindexTmp = pindex;
                ////console.info(pindex);
                ////console.info(currentValue);
                el = document.createElement('div'),
                    itemStr =

                    '<div class="costItem-header">' +
                    '         <span># ' + currentValue.place_name + '</span>' +
                    '</div>' +
                    '   <div class="costItem-body">' +
                    '       <ul>';

                currentValue.itemList.forEach(function (currentValue, index) {
                    itemStr += '<li>' + currentValue.costType +
                        '               <div class="btn btn-sm btn-warning" onclick="removeCostItemChild(' + pindex + ',' + index + ')">x</div>' +
                        '<br/>' +
                        setComa(currentValue.cost) + ' (' + currentValue.info + ')' + '</li>';
                    totalCost += parseInt(currentValue.cost);
                });

                itemStr +=
                    '<li>' +
                    '   <div class="btn btn-secondary btn-sm" data-toggle="collapse" data-target="#collapseAddCost_' + pindex + '" aria-expanded="false" aria-controls="collapseAddCost_' + pindex + '">경비추가</div>' +
                    '   <div class="collapse" id="collapseAddCost_' + pindex + '">' +
                    '       <select id="addCost_costType_' + pindex + '" class="form-control form-control-sm">' +
                    '           <option value="식비">식비</option>' +
                    '           <option value="교통비">교통비</option>' +
                    '           <option value="숙박비">숙박비</option>' +
                    '           <option value="기타">기타</option>' +
                    '       </select>' +
                    '       <input id="addCost_cost_' + pindex + '" class="form-control form-control-sm" type="number" placeholder="비용">' +
                    '       <input id="addCost_info_' + pindex + '" class="form-control form-control-sm" type="text" placeholder="비용 설명">' +
                    '       <div class="btn btn-secondary btn-sm" onclick="pushCostItemChild(' + pindex + ')">+</div>' +
                    //'       <div class="btn btn-secondary btn-sm" onclick="popCostItemChild(' + pindex + ')">-</div>' +

                    '</div>' +
                    '</li>' +
                    '   </ul>' +
                    '</div>' +
                    '</div>';
                el.innerHTML = itemStr;
                //            el.setAttribute("draggable", 'true');
                //            el.setAttribute("id", "travelPoint");
                el.setAttribute("class", "costItem");


                var itemEl = el;

                fragment.appendChild(itemEl);

                costBody.appendChild(fragment);



            });

            // 나중에 지도의 travelroute에서 추가할 버튼
            //el = document.createElement('div'),
            //    itemStr =

            //    '<div class="btn btn-secondary btn-sm" onclick="addCostItemParent(' + pindexTmp + ')">+</div>';

            //el.innerHTML = itemStr;
            ////            el.setAttribute("draggable", 'true');
            ////            el.setAttribute("id", "travelPoint");
            //el.setAttribute("class", "costItem");


            //var itemEl = el;

            //fragment.appendChild(itemEl);

            //costBody.appendChild(fragment);

            ////--------------------



            var headerStr =
                '<span class="chTitle">전체 경비</span>' +
                '<span class="chBody">💰 ' + setComa(totalCost) + '</span>';
            costHeader.innerHTML = headerStr;




        }

        function pushCostItemChild(index) {

            var costTypeId = "addCost_costType_" + index,
                costId = "addCost_cost_" + index,
                infoId = "addCost_info_" + index;

            var costType = document.getElementById(costTypeId);
            cost = document.getElementById(costId),
                info = document.getElementById(infoId);

            if (cost.value == "") {

                alert("비용을 입력하세요");
            } else {

                CostItemList[index].pushItem(costType.options[costType.selectedIndex].value, cost.value, info.value);
                refreashCostItem();
            }



        }


        function popCostItemChild(index) {

            var costTypeId = "addCost_costType_" + index,
                costId = "addCost_cost_" + index,
                infoId = "addCost_info_" + index;

            var costType = document.getElementById(costTypeId);
            cost = document.getElementById(costId),
                info = document.getElementById(infoId);

            CostItemList[index].popItem();
            refreashCostItem();

        }




        function addCostItemParent(place_name) {
            CostItemList.push(new CostItem(place_name));
            refreashCostItem();

        }

        function setCostItemParentName(pindex) {

            //var addCost_place_nameId = "addCost_place_name_" + pindex;
            //var addCost_place_name = document.getElementById(addCost_place_nameId);
            var addTravelRoute_place_nameId = "addTravelRoute_place_name_" + pindex;
            var place_name = document.getElementById(addTravelRoute_place_nameId).value;

            CostItemList[pindex].setPlace_name(place_name);
            refreashCostItem();
        }

        function removeCostItemChild(pindex, index) {
            CostItemList[pindex].itemList.splice(index, 1);
            refreashCostItem();
        }


        function removeCostItemParent(pindex) {
            CostItemList.splice(pindex, 1);
            refreashCostItem();
        }

        function swapCostItemParent(fIndex, sIndex) {
            var tmp = CostItemList[fIndex];
            CostItemList[fIndex] = CostItemList[sIndex];
            CostItemList[sIndex] = tmp;
            refreashCostItem();
        }

        function setComa(number) {
            var resultStr = "";
            var strNumber = String(number);
            ////console.info(strNumber);
            ////console.info(strNumber.length);
            for (var i = strNumber.length - 1; i >= 0; i--) {
                ////console.info(i);

                if ((strNumber.length - i - 1) % 3 == 0 && i != strNumber.length - 1) {
                    resultStr = ',' + resultStr;
                }
                resultStr = strNumber[i] + resultStr;
            }


            return resultStr;

        }

        //------------------------------------
        //----------CostItems and CostItemList End
        //------------------------------------




        //------------------------------------
        //----------DragManager Start
        //------------------------------------

        



        //여행경로 드래그 앤 드롭
        var DragManager;

        function dragAndDropAction() {
            //DragManger에 요소 추가 (추후 드래그 앤드롭 액션 실행)
            DragManager = {
                travelRoutes: [],
                currentContainer: null,

                add: function (travelRoute) {
                    this.travelRoutes.push(travelRoute);
                },

                handleEvent: function (event) {
                    ////console.info(event.target);
                    if (event.type == 'dragstart') {
                        //console.info("dragstart");
                        var containers = this.travelRoutes.filter(function (container) {

                            return container.contains(event.target);
                        });

                        if (containers.length > 0) {
                            this.currentContainer = containers[0];
                            this.currentContainer.activate();
                        }
                    }

                    if (this.currentContainer !== null) {
                        this.currentContainer.handleEvent(event);
                        if (event.type == 'dragend') {
                            this.currentContainer.deactivate();
                            this.currentContainer = null;
                        }
                    }
                }

            };

            window.addEventListener('dragstart', DragManager);
            window.addEventListener('dragend', DragManager);

            function travelRoute(container, type) {
                this.element = container;
                this.type = type || 'swap';
                this.items = $('> li', this.element);
                this.draggingItem = null;

                DragManager.add(this);
            }

            travelRoute.prototype.contains = function (target) {
                ////console.info(target);
                return $(this.element).find(target).length;
            }

            travelRoute.prototype.handleEvent = function (event) {
                // NOTE: We've bound `this` to the travelRoute object, not
                // the element the event was fired on.
                var $t = $(event.target);

                if (event.type == 'dragstart') {
                    this.draggingItem = event.target;
                    //console.info(event.target);
                    //setdata에 최상위 LIdml HTML을 데이터로 보낸다
                    ////console.info("this.draggingItem");
                    ////console.info(this.draggingItem);
                    var tgtItem = this.draggingItem;
                    while (1) {
                        //if(data.id == "travelPoint")
                        ////console.info("tgtItem.tagName");
                        ////console.info(tgtItem.tagName);
                        //if (tgtItem.tagName == "LI")
                        if (tgtItem.className == "travelPoint")
                            break;
                        tgtItem = tgtItem.parentNode;
                    }


                    event.dataTransfer.setData('text/html', tgtItem.innerHTML);
                }

                if (event.type == 'dragover' && this.draggingItem != event.target) {

                    $t.addClass('js-active');
                    // Preventing the default action _enables_ drop. Because JS APIs.
                    if (event.preventDefault) {
                        event.preventDefault();
                    }
                    event.dataTransfer.dropEffect = 'move';
                }

                if (event.type == 'dragleave') {
                    $t.removeClass('js-active');
                }

                if (event.type == 'drop' && this.draggingItem != null) {
                    if (this.type == 'swap') {


                        // 최상단 LI태그를 탐색
                        var tgtItem = event.target;
                        while (1) {
                            //if(data.id == "travelPoint")
                            //if (tgtItem.tagName == "LI")
                            if (tgtItem.className == "travelPoint")
                                break;
                            tgtItem = tgtItem.parentNode;
                        }
                        var fIndex, sIndex;
                        //travelPoint_0
                        fIndex = tgtItem.id.slice(12);
                        sIndex = this.draggingItem.id.slice(12);

                        //console.info(fIndex);
                        //console.info(sIndex);
                        swapTravelRouteItem(parseInt(fIndex), parseInt(sIndex));
                        swapCostItemParent(parseInt(fIndex), parseInt(sIndex));
                        //최상단  travelPoint로만 옮김.
                        //this.draggingItem.innerHTML = tgtItem.innerHTML;
                        //tgtItem.innerHTML = event.dataTransfer.getData('text/html');
                    } else if (this.type == 'reorder') {
                        //console.info('reorder');
                        //console.info(this.items.index(event.target));
                    }
                }

                if (event.type == 'dragend' || event.type == 'drop') {
                    this.items.removeClass('js-active');
                    this.draggingItem = null;
                }
            }

            travelRoute.prototype.activate = function () {
                for (var i = 0, j = this.items.length; i < j; i++) {
                    // Make sure `this` is always a travelRoute instead of the element the
                    // event was activated on.
                    this.items[i].addEventListener('dragenter', this.handleEvent.bind(this));
                    this.items[i].addEventListener('dragover', this.handleEvent.bind(this));
                    this.items[i].addEventListener('dragleave', this.handleEvent.bind(this));
                    this.items[i].addEventListener('drop', this.handleEvent.bind(this));
                }
            }

            travelRoute.prototype.deactivate = function () {
                this.draggingItem = null;
                for (var i = 0, j = this.items.length; i < j; i++) {
                    //this.items[i].removeEventListener('dragenter', this.handleEvent);
                    //this.items[i].removeEventListener('dragover', this.handleEvent);
                    //this.items[i].removeEventListener('dragleave', this.handleEvent);
                    //this.items[i].removeEventListener('drop', this.handleEvent);
                }
            }

            var travelRoutes = document.getElementsByClassName('travelRoute');

            for (var i = 0, j = travelRoutes.length; i < j; i++) {
                new travelRoute(travelRoutes[i], (i % 2 == 0) ? 'swap' : 'reorder');
            }

        }
        //------------------------------------
        //----------DragManager END
        //------------------------------------

         //-----placeList 데이터 가져오기
         
        <%
        if(Request["placeList"] != null)
        {
            Response.Write("TravelRouteList ="+Request["placeList"]+";");

        }
        else
        {
            Response.Write("{}");
        }
        %>
        //-----costList 가져오기
        <%
        if(Request["costList"] != null)
        {
            Response.Write(Request["costList"]);

        }
        else
        {
            Response.Write("{}");
        }
        %>

        //------MapDato 가져오기
        <%
        if(Request["mapData"] != null)
        {
            Response.Write(Request["mapData"]);

        }
        else
        {
            Response.Write("{}");
        }
        %>




        //------------------------------------
        //----------Post START
        //------------------------------------





        overlays = []; // 지도에 그려진 도형을 담을 배열




        // 다음페이지로 markers, polyline, rect, circle, polygon 보내는 기능
        function postToNext() {
            var data = manager.getData();
            //rects  circles   polygons
            markers = data[daum.maps.drawing.OverlayType.MARKER];
            polylines = data[daum.maps.drawing.OverlayType.POLYLINE];
            rects = data[daum.maps.drawing.OverlayType.RECTANGLE];
            circles = data[daum.maps.drawing.OverlayType.CIRCLE];
            polygons = data[daum.maps.drawing.OverlayType.POLYGON];
            //
            //            markersPath = [];
            //            polylinesPath = [];
            //            rectsPath = [];
            //            circlesPath = [];
            //            polygonsPath = [];
            //
            //            for (var i = 0; i < markers.length; i++) {
            //
            //                var latlng = new daum.maps.LatLng(markers[i].y, markers[i].x);
            //                markersPath.push(i + ":");
            //                markersPath.push(latlng);
            //
            //
            //            }
            //
            //
            //
            //
            //            var len = polylines.length,
            //                i = 0;
            //
            //            for (; i < len; i++) {
            //                var path = pointsToPath(polylines[i].points);
            //                polylinesPath.push(i + ":");
            //                polylinesPath.push(path);
            //
            //            }
            //
            //
            //            var len = circles.length,
            //                i = 0;
            //
            //            for (; i < len; i++) {
            //                circlesPath.push(i + ":");
            //                circlesPath.push(new daum.maps.LatLng(circles[i].center.y, circles[i].center.x));
            //                circlesPath.push(circles[i].radius);
            //
            //            }
            //
            //            var len = rects.length,
            //                i = 0;
            //
            //            for (; i < len; i++) {
            //
            //
            //                rectsPath.push(i + ":");
            //                rectsPath.push(rects[i].sPoint.y, rects[i].sPoint.x, rects[i].ePoint.y, rects[i].ePoint.x);
            //
            //
            //            }
            //
            //            var len = polygons.length,
            //                i = 0;
            //
            //            for (; i < len; i++) {
            //                var path = pointsToPath(polygons[i].points);
            //                polygonsPath.push(i + ":");
            //                polygonsPath.push(path);
            //
            //            }




            //document.getElementById("marker").value = markersPath;
            //document.getElementById("polygon").value = polylinesPath;
            var title = document.getElementById("title");
            var article = document.getElementById("article");
            var hashtag = document.getElementById("hashtag");


            var form = document.createElement("form");
            // Form submission canceled because the form is not connected 해결
            document.body.appendChild(form);
            form.setAttribute('method', "post");
            form.setAttribute('action', "Write_get.aspx");
            form.appendChild(title);
            form.appendChild(article);
            form.appendChild(hashtag);

            //JSON.stringify(obj)



            //            var marker = document.createElement("input"); // input 엘리멘트 생성
            //            insert1.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            //            insert1.setAttribute("name", "marker"); // name 속성을 'stadium'으로 설정
            //            insert1.setAttribute("value", markersPath); // value 속성을 삽입
            //            form.appendChild(insert1); // form 엘리멘트에 input 엘리멘트 추가
            //
            //            var polyline = document.createElement("input"); // input 엘리멘트 생성
            //            insert2.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            //            insert2.setAttribute("name", "polyline"); // name 속성을 'stadium'으로 설정
            //            insert2.setAttribute("value", polylinesPath); // value 속성을 삽입
            //            form.appendChild(insert2);
            //            //rects  circles   polygons
            //            var rects = document.createElement("input"); // input 엘리멘트 생성
            //            insert3.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            //            insert3.setAttribute("name", "rects"); // name 속성을 'stadium'으로 설정
            //            insert3.setAttribute("value", rectsPath); // value 속성을 삽입
            //            form.appendChild(insert3);
            //
            //            var circles = document.createElement("input"); // input 엘리멘트 생성
            //            insert4.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            //            insert4.setAttribute("name", "circles"); // name 속성을 'stadium'으로 설정
            //            insert4.setAttribute("value", circlesPath); // value 속성을 삽입
            //            form.appendChild(insert4);
            //
            //            var polygons = document.createElement("input"); // input 엘리멘트 생성
            //            insert5.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            //            insert5.setAttribute("name", "polygons"); // name 속성을 'stadium'으로 설정
            //            insert5.setAttribute("value", polygonsPath); // value 속성을 삽입
            //            form.appendChild(insert5);



            var mapData = document.createElement("input"); // input 엘리멘트 생성
            mapData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            mapData.setAttribute("name", "mapData"); // name 속성을 'stadium'으로 설정
            mapData.setAttribute("value", JSON.stringify(data)); // value 속성을 삽입
            form.appendChild(mapData);

            var TravelRouteListData = document.createElement("input"); // input 엘리멘트 생성
            TravelRouteListData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            TravelRouteListData.setAttribute("name", "TravelRouteListData"); // name 속성을 'stadium'으로 설정
            TravelRouteListData.setAttribute("value", JSON.stringify(TravelRouteList)); // value 속성을 삽입
            form.appendChild(TravelRouteListData);

            var CostItemListData = document.createElement("input"); // input 엘리멘트 생성
            CostItemListData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            CostItemListData.setAttribute("name", "CostItemListData"); // name 속성을 'stadium'으로 설정
            CostItemListData.setAttribute("value", JSON.stringify(CostItemList)); // value 속성을 삽입
            form.appendChild(CostItemListData);


            console.info(form.innerHTML);
            form.submit(); // 전송
        }


        //------------------------------------
        //----------Post END
        //------------------------------------

    </script>
</body>
</html>
