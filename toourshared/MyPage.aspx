<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">
    // 내가 작성한글, 내가 팔로일하는 사람의 글, 나를 팔로우 하는 사람의 글

    protected List<Travel> getArticleList(string mem_id)
    {
        List<Travel> resultList;
        Travel travelIn = new Travel();
        TravelDao travelDao = new TravelDao();

        travelIn.Mem_id = "billip";
        resultList = travelDao.selectTravelListByMem_id(travelIn);
        //resultDataset = travelDao.SelectTravel();


        return resultList;

    }

    protected void Bind_Table_Travel()
    {
        List<Travel> resultList = getArticleList("billip");

        TableRow tmpTableRow_article;
        TableCell tmpTableCell_article1;
        TableCell tmpTableCell_article2;
        TableCell tmpTableCell_article3;


        for (int i = 0; i < resultList.Count - 1; i++)
        {


            tmpTableCell_article1 = new TableCell();
            tmpTableCell_article1.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + resultList[i].Trv_main_img + "\" alt= \"milk9503\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Trv_tot_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span> x3" +
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> x5" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article2 = new TableCell();
            tmpTableCell_article2.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + resultList[i].Trv_main_img + "\" alt= \"milk9503\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Trv_tot_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span> x3" +
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> x5" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);
                tmpTableRow_article.Cells.Add(tmpTableCell_article2);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article3 = new TableCell();
            tmpTableCell_article3.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + resultList[i].Trv_main_img + "\" alt= \"milk9503\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Trv_tot_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span> x3" +
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> x5" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";


            tmpTableRow_article = new TableRow();
            tmpTableRow_article.Cells.Add(tmpTableCell_article1);
            tmpTableRow_article.Cells.Add(tmpTableCell_article2);
            tmpTableRow_article.Cells.Add(tmpTableCell_article3);
            Table_travel.Rows.Add(tmpTableRow_article);
        }
    }
    protected List<Comment> getReviewsList(string mem_id)
    {
        List<Comment> resultList;
        Comment Input = new Comment();
        CommentDao dao = new CommentDao();

        Input.Mem_id = "billip";
        resultList = dao.selectCommentListByMem_id(Input);
        //resultDataset = travelDao.SelectTravel();


        return resultList;
    }
    protected string getTrv_Main_Img(string trv_no)
    {
        string result;
        Travel Input = new Travel();
        Travel output = new Travel();
        TravelDao dao = new TravelDao();

        Input.Trv_no = trv_no;
        output = dao.selectTravelBytrv_no(Input);

        result = output.Trv_main_img;

        return result;
    }
    protected void Bind_Table_MyReviews()
    {
        List<Comment> resultList = getReviewsList("billip");

        TableRow tmpTableRow_article;
        TableCell tmpTableCell_article1;
        TableCell tmpTableCell_article2;
        TableCell tmpTableCell_article3;


        for (int i = 0; i < resultList.Count - 1; i++)
        {


            tmpTableCell_article1 = new TableCell();
            tmpTableCell_article1.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + getTrv_Main_Img(resultList[i].Trv_no) + "\" alt= \"milk9503\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Cmt_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span>" +resultList[i].Cmt_content+
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> " + resultList[i].Cmt_timestamp+
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article2 = new TableCell();
            tmpTableCell_article2.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + getTrv_Main_Img(resultList[i].Trv_no) + "\" alt= \"milk9503\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Cmt_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span>" +resultList[i].Cmt_content+
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> " + resultList[i].Cmt_timestamp+
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);
                tmpTableRow_article.Cells.Add(tmpTableCell_article2);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article3 = new TableCell();
            tmpTableCell_article3.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + getTrv_Main_Img(resultList[i].Trv_no) + "\" alt= \"milk9503\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Cmt_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span>" +resultList[i].Cmt_content+
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> " + resultList[i].Cmt_timestamp+
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";


            tmpTableRow_article = new TableRow();
            tmpTableRow_article.Cells.Add(tmpTableCell_article1);
            tmpTableRow_article.Cells.Add(tmpTableCell_article2);
            tmpTableRow_article.Cells.Add(tmpTableCell_article3);
            Table_MyReviews.Rows.Add(tmpTableRow_article);
        }






    }

    protected List<Follower> getFollowerList(string mem_id)
    {
         List<Follower> resultList;
        Follower Input = new Follower();
        FollowerDao dao = new FollowerDao();

        Input.Mem_id = "billip";
        resultList = dao.selectFollwerListByMem_id(Input);

        //resultDataset = travelDao.SelectTravel();


        return resultList;
    }


    protected void BInd_Table_FollowingTouple()
    {

    }


    protected void Page_Load(object sender, EventArgs e)
    {

        Bind_Table_Travel();
        Bind_Table_MyReviews();



    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED : MYPAGE</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|Jua&display=swap" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- Icon -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


<style>
    html, body {
        margin: 0;
        padding: 0;
        list-style: none;
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

        .topnavLi ul, li {
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
        transition: .5s;
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

    .section {
        max-width: 935px;
        width: 100%;
        height: 75%;
        position: relative;
        margin: 0 auto 30px;
        padding-top: 150px;
    }

    .section01 {
        -webkit-box-flex: 1;
        -webkit-flex-grow: 1;
        -ms-flex-positive: 1;
        flex-grow: 1;
        margin: 0 auto 30px;
        display: flex;
        padding-bottom: 50px;
    }

    .userImage {
        width: 150px;
        height: 150px;
    }

    .userImageItem {
        width: 100%;
        height: 100%;
        position: absolute;
    }

    .userImageAlign {
        width: 150px;
        height: 150px;
        position: absolute;
    }

    .userImageItem .userImageStyle {
        width: 100%;
        height: 100%;
        padding: 0;
        margin: 0;
        border: none;
        cursor: pointer;
        border-radius: 100%;
    }

    .userData {
        color: #262626;
        -webkit-flex-shrink: 1;
        -ms-flex-negative: 1;
        flex-shrink: 1;
        min-width: 0;
    }

    .userDataAlign {
        padding-left: 150px;
        position: absolute;
    }

    .idAndSetting {
        width: 500px;
        display: flex;
        padding: 7px 15px 20px 0px;
    }

    .ID {
        width: 25%;
        display: block;
    }

        .ID h1 {
            font-size: 28px;
            margin: -5px 0px -6px;
            font-weight: 300;
        }

    .Setting {
        width: auto;
    }

    .settingButton {
        width: 115px;
        height: 30px;
        border: 1px solid white;
        border-radius: 5px;
        outline: none;
        color: white;
        background-color: transparent;
    }

    .data {
        width: 100%;
        display: flex;
        position: absolute;
        font-size: 18px;
    }

    .dataItem {
        width: auto;
        padding-right: 30px;
    }

        .dataItem span {
            font-weight: 500;
        }

    .name {
        padding-top: 40px;
        position: relative;
    }

        .name span {
            width: auto;
            height: auto;
            font-size: 20px;
            fotnt-weight: bold;
            font-family: 'Nanum Gothic', sans-serif;
        }

    .section02 {
        width: 935px;
        height: auto;
        padding-bottom: 155px;
    }

    .boardTap {
        width: 935px;
        border-top: 0.5px solid white;
        display: flex;
        flex-direction: row;
        justify-content: center;
    }

    .boardTapOpen {
        float: left;
        border: none;
        outline: none;
        cursor: pointer;
        padding: 14px 16px;
        width: auto;
        background-color: transparent;
    }

        /* get → border-top */
        .boardTapOpen:hover {
            margin-top: -1px;
            border-top: 1px solid black;
        }

    .boardTapTxt {
        color: white;
        font-size: 15px;
    }

    .boardContents {
        width: 100%;
        height: auto;
    }

    .boardItem {
        display: none;
        width: 935px;
        height: auto;
        color: #262626;
        background-color: rgba(255, 255, 255, 0);
    }

    .boardItemContent {
        width: 100%;
        height: 100%;
    }

    #boardItemDefault {
        width: 100%;
        height: 300px;
        display: block;
        background-color: snow;
        text-align: center;
    }

        #boardItemDefault div {
            padding-top: 15%;
            font-size: 18px;
            cursor: default;
        }

    .tableContainer {
        position: relative;
        width: 100%;
        height: auto;
    }

        .tableContainer img {
            display: block;
            width: 293px;
            height: 293px;
            margin-right: 25px;
            margin-bottom: 25px;
        }

    .tableOverlay {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background-color: rgba(0, 0, 0, 0.5);
        overflow: hidden;
        width: 293px;
        height: 0;
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

        .tableText span {
            font-size: 15px;
            cursor: default;
        }

    .tableAlign div {
        padding: 3px 5px;
        text-align: left;
    }

        .tableAlign div span {
            padding-right: 7px;
        }

    .footer {
        width: 100%;
        height: 150px;
        position: relative;
        background-color: #272625;
    }

    .footerText {
        width: 100%;
        height: inherit;
        color: white;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        position: absolute;
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

    /* Tab 이벤트 */
    function openPage(pageName, elmnt) {
        var i, boardItem, boardTapOpens;
        boardItem = document.getElementsByClassName("boardItem");

        for (i = 0; i < boardItem.length; i++) {
            boardItem[i].style.display = "none";
        }

        boardTapOpens = document.getElementsByClassName("boardTapOpen");
        document.getElementById(pageName).style.display = "block";
        document.getElementById("boardItemDefault").style.display = "none";
    }

    document.getElementById("defaultOpen").click();		
</script>
</head>
     <!-- navbar 영역 -->
<div id="nav" class="topnav">
    <ul class="topnavUl">
        <li class="topnavLi">
            <div class="nav-logo">
                <a href="#" class="nav-logo-item">To Our Shared</a>
            </div>
        </li>
        <li class="topnavLi">
            <a href="#">소개</a>
            <ul>
                <li><a href="#">TOUPLE</a></li>
                <li><a href="#">서브메뉴1-2</a></li>
                <li><a href="#">서브메뉴1-3</a></li>
            </ul>
        </li>
        <li class="topnavLi">
            <a href="#">메뉴 2</a>
            <ul>
                <li><a href="#">서브메뉴2-1</a></li>
                <li><a href="#">서브메뉴2-2</a></li>
                <li><a href="#">서브메뉴2-3</a></li>
            </ul>
        </li>
        <li class="topnavLi">
            <a href="#">메뉴 3</a>
            <ul>
                <li><a href="#">서브메뉴3-1</a></li>
                <li><a href="#">서브메뉴3-2</a></li>
                <li><a href="#">서브메뉴3-3</a></li>
            </ul>
        </li>
        <li class="topnavLi">
            <a href="#">커뮤니티</a>
            <ul>
                <li><a href="#">자유게시판</a></li>
                <li><a href="#">리뷰게시판</a></li>
            </ul>
        </li>
        <li class="topnavLi">
            <a href="#">고객센터</a>
            <ul>
                <li><a href="#">도움말</a></li>
                <li><a href="#">건의사항</a></li>
            </ul>
        </li>
        <li class="topnavLi">
            <a href="#">milk9503</a>
            <ul>
                <li><a href="#">마이페이지</a></li>
                <li><a href="#">로그아웃</a></li>
            </ul>
        </li>
    </ul>
</div>
<body>
    <form id="form1" runat="server">
        <div class="section">
            <!-- UserProfile -->
            <div class="section01">
                <div class="userImage">
                    <div class="userImageAlign">
                        <div class="userImageItem">
                            <a href="#">
                                <img class="userImageStyle" src="./img/UserNoneImage.png" alt="프로	필 사진 편집">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="userData">
                    <div class="userDataAlign">
                        <div class="idAndSetting">
                            <div class="ID">
                                <h1>milk9503</h1>
                            </div>
                            <div class="Setting">
                                <input type="button" value="프로필 편집" class="settingButton" />
                            </div>
                        </div>
                        <div class="data">
                            <div class="dataItem">
                                게시물 <span>0</span>
                            </div>
                            <div class="dataItem">
                                팔로워 <span>10</span>
                            </div>
                            <div class="dataItem">
                                팔로우 <span>10</span>
                            </div>
                        </div>
                        <div class="name">
                            <span>홍길동</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Board -->
            <div class="section02">

                <!-- boardTap -->
                <div class="boardTap">
                    <a
                        class="boardTapOpen" onclick="openPage('MyTravels', this)">
                        <span class="boardTapTxt">▦ My Travels</span>
                    </a>
                    <a class="boardTapOpen" onclick="openPage('MyReviews', this)">
                        <span class="boardTapTxt">▦ My Reviews</span>
                    </a>
                    <a class="boardTapOpen" onclick="openPage('FollowingTouple', this)">
                        <span class="boardTapTxt">▦ Following Touple</span>
                    </a>
                </div>
            </div>

            <!-- boardContents -->
            <div class="boardContents">
                <div id="boardItemDefault">
                    <div>작성된 게시글이 없습니다.</div>
                </div>
                <div id="MyTravels" class="boardItem">
                    <div class="boardItemContent">

                        <asp:Table ID="Table_travel" runat="server">
                        </asp:Table>

                    </div>
                </div>
                <div id="MyReviews" class="boardItem">

                        <asp:Table ID="Table_MyReviews" runat="server">
                        </asp:Table>
                </div>
                <div id="FollowingTouple" class="boardItem">
                        <asp:Table ID="Table_FollowingTouple" runat="server">
                        </asp:Table>
                </div>
            </div>
        </div>


        <!-- 바닥글 영역 -->
        <div class="footer">
            <div class="footerText">
                ㅂㄷㄱ
            </div>
        </div>
    </form>
</body>
</html>
