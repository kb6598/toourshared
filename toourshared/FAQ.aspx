<%@ Page Language="C#" %>

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

    protected void Page_Load(object sender, EventArgs e)
    {
         List<Question> resultList;
        Question question = new Question();
        QuestionDao qus = new QuestionDao();

        resultList = qus.selectAllQuestion(question);

        for(int i=0; i < resultList.Count; i++)
        {

            Literal1.Text+=                                                            
            "        <div class=\"FAQ_QUE_BOARD\" data-toggle=\"collapse\" data-target=\"#board"+i +"\">"+
            "            <div class=\"BOARDITEM1\">                                            "+
            "                <div class=\"BDNUMBER\">                                          "+
                                resultList[i].Qus_no+"</div>"                                  +
            "                <div class=\"BDTITLE\">                                           "+
                                resultList[i].Qus__title+"</div>"                              +
            "            </div>                                                              "+
            "            <div class=\"BOARDITEM2\">                                            "+
            "                <div id=\"board"+i+"\" class=\"collapse\">                              "+
            "                    <div class=\"ANSWER\">                                        " +
                                    resultList[i].Qus_ask                                    +
            "                                                                                " +
            "                    </div>                                                      " +
            "                </div>                                                          " +
            "            </div>                                                              " +
            "        </div>                                                                  ";
        }
        



    }
</script>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED : 고객센터</title>

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
        body {
            margin: 0;
            padding: 0;
            list-style: none;


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
            line-height: 1;

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

        .main {
            width: 100%;
            height: auto;
            padding: 100px 0 150px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .title {
            padding: 150px 0px 70px;
            text-align: center;
        }

        .titleItem {
            cursor: default;
            color: #eee;
            font-size: 50px;
            font-family: 'Mansalva', cursive;
        }

        .FAQ {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 1000px;
            height: auto;
            background-color: #fff;
            transition-duration: .5s;
            background-color: #e2e2e2;
        }

        .FAQ_HEADER {
            width: 100%;
            height: auto;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 0 40px;
            border-bottom: 1px solid rgba(0, 0, 0, .19);
        }

        .FAQ_HEADER span {
            font-size: 25px;
            font-weight: 300;
            font-family: 'Noto Sans KR', sans-serif;
            cursor: default;
        }

        .FAQ_MAIN {
            width: 100%;
            height: 100%;
            background-color: #eee;
        }

        .FAQ_ITEM {
            width: 100%;
            height: auto;
            padding: 20px;

            display: flex;
            flex-direction: column;
        }

        .FAQ_SUBTITLE {
            width: 100%;
            height: 50px;
            padding-top: 5px;
            padding-left: 15px;
        }

        .FAQ_SUBTITLE span {
            font-size: 20px;
            font-weight: 600;
            font-family: 'Noto Sans KR', sans-serif;
            border-bottom: 3px solid orangered;
        }

        .FAQ_SUBTEXT {
            width: 100%;
            height: 30px;
            margin-top: -10px;
            padding-left: 15px;
        }

        .FAQ_SUBTEXT span {
            font-size: 13px;
            color: rgba(0, 0, 0, .5);
        }

        .FAQ_QUE_CATEGORY {
            width: 900px;
            margin-left: 12px;
            padding-top: 20px;
            display: flex;
            flex-direction: row;
        }

        .FAQ_QUE_CATEGORY>div {
            margin: 0 2px;
        }

        .QUENUMBER {
            width: 10%;
            text-align: center;
            padding: 10px 0 5px;
            border-bottom: 3px solid orange;
            font-size: 18px;
            font-weight: 500;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .QUETITLE {
            width: 90%;
            text-align: center;
            padding: 10px 0 5px;
            border-bottom: 3px solid orange;
            font-size: 18px;
            font-weight: 500;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .FAQ_QUE_BOARD {
            width: 900px;
            display: flex;
            margin-left: 12px;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .FAQ_QUE_BOARD {
            width: 900px;
            margin-left: 12px;
            display: flex;
            flex-direction: column;
            cursor: pointer;
        }

        .BOARDITEM1 {
            width: 100%;
            display: flex;
            flex-direction: row;
        }

        .BOARDITEM1>div {
            margin: 0 2px;
            padding: 20px 0;
            text-align: center;
        }

        .BDNUMBER {
            width: 10%;
            font-size: 15px;
            border-bottom: .5px solid rgba(0, 0, 0, .5);
        }

        .BDTITLE {
            width: 90%;
            font-size: 15px;
            border-bottom: .5px solid rgba(0, 0, 0, .5);
        }

        .ANSWER {
            padding: 20px 5px;
            background-color: #eee;
            color: rgba(0, 0, 0, .5);
            margin: 0 1px;
        }
        
        .FAQ_INQUIRE{
            width: 100%;
            height: 150px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .FAQ_INQUIRE > span{
            padding: 0 3px;
        }
        
        .nm{
            font-size: 15px;
        }
        
        .em{
            width: 142px;
            height: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: default;
            color: #fff;
            font-size: 13px;
            font-weight: 300;
            border-radius: .4rem;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: rgba(0, 0, 0, .9);
            transition-duration: .5s;
        }
        
        .em:hover{
            font-size: 15px;
        }
        
        .footer {
            width: 100%;
            height: 250px;
            background-color: #272625;
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

    </script>

</head>

<body>
    <form name="form1" runat="server">
    <!-- navbar 영역 -->
    <div id="nav" class="topnav">
        <ul class="topnavUl">
            <li class="topnavLi">
                <div class="nav-logo">
                    <a href="./index.aspx" class="nav-logo-item">To Our Shared</a>
                </div>
            </li>
            <li class="topnavLi">
                <a>Intro</a>
                <ul>
                    <li><a href="./index.aspx#relAndTOU">TOUPLE</a></li>
                </ul>
            </li>
            <li class="topnavLi">
                <a>Shared</a>
                <ul>
                    <li><a href="./search.aspx">검색</a></li>
                    <li><a href="./write.aspx">글 쓰기</a></li>
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
                    <li><a href="./FAQ.aspx">자주 찾는 질문</a></li>
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
                            <asp:Button ID="btnLogin" runat="server" Text="로그인" CssClass="nav-log-item" PostBackUrl="./login.aspx"/>
                        </div>
                    </a>
                </div>
                <ul>
                    <br />
                    <li><asp:Button ID="btnJoin" runat="server" Text="회원가입" OnClick="btnJoin_Click" class="navJoinBtn"/></li>
                    <li><asp:Button ID="btnFindIDPW" runat="server" Text="계정찾기" OnClick="btnFindIDPW_Click" class="navFindBtn" /></li>
                </ul>
            </li>
        <%  
            }
            else
            {
        %>
            <li class = "topnavLi" >
				<a href = "#" ><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                <ul>
                    <li><asp:Button ID="btnMypage" runat="server" Text="마이페이지" OnClick="btnMypage_Click" class="navJoinBtn"/></li>
                    <li><asp:Button ID="btnLogout" runat="server" Text="로그아웃" OnClick="btnLogout_Click" class="navFindBtn"/></li>

                </ul>
            </li>
        <% 
            }
        %>
        </ul>
    </div>

    <!-- main 영역 -->
    <div class="main">
        <div class="title">
            <div class="titleItem">
                To Our Shared
            </div>
        </div>

        <div class="FAQ">
            <div class="FAQ_HEADER">
                <span>고객센터</span>
            </div>
            <div class="FAQ_MAIN">
                <div class="FAQ_ITEM">

                    <div class="FAQ_SUBTITLE">
                        <span>자주찾는질문</span>
                    </div>
                    <div class="FAQ_SUBTEXT">
                        <span>보고싶은 질문을 눌러주세요.</span>
                    </div>
                    <div class="FAQ_QUE_CATEGORY">
                        <div class="QUENUMBER">번호</div>
                        <div class="QUETITLE">제목</div>
                    </div>
                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                </div>
                
                <div class="FAQ_ITEM">
                   
                    <div class="FAQ_SUBTITLE">
                        <span>문의사항</span>
                    </div>
                    <div class ="FAQ_INQUIRE">
                        <span class = "nm">문의사항은</span>
                        <span class = "em">email@naver.com</span>
                        <span class = "nm"> 으로 문의주세요.</span>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    </form>
</body>

</html>
