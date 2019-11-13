<%@ Page Language="C#" %>

<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["name"] != null)
        {
            string result = Session["userID"].ToString();
            txtResult.Text = result;
        }
        if(Request.QueryString["id"] != null)
        {
            string result = Session["userPW"].ToString();
            txtResult.Text = result;
        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("./index.aspx");
    }

    protected void btnMypage_Click(object sender, EventArgs e)
    {
        Response.Redirect("./MyPage.aspx");
    }

    protected void btnJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("./join.aspx");
    }

    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("./find_idpw.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>TO OUR SHARED : 여행일수 작성</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|Jua&display=swap" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <!-- 아이콘 유니코드 설정-->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>

    <style>
        body {
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
            height: 100%;
            padding-top: 100px;
            padding-bottom: 150px;
        }

        .title {
            padding: 150px 0px 0px;
            text-align: center;
        }

        .titleItem {
            cursor: default;
            color: #eee;
            font-size: 50px;
            font-family: 'Mansalva', cursive;
        }

        .body {
            width: 100%;
            height: 600px;

            display: flex;
            justify-content: center;
        }

        .contents {
            width: 1100px;
            height: 500px;
            margin-top: 100px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 15px;
            border-top-left-radius: 15px;
            border-bottom-right-radius: 15px;
            background-color: #eee;
        }

        .contentTitle {
            padding: 10px 0;
        }

        .contentTitle h3 {
            font-size: 25px;
            font-weight: 700;
            border-bottom: 5px solid orange;
        }

        .contentResult1 {
            width: auto;
            height: 100px;
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .result1Item{
            display: flex;
            flex-direction: row;
        }

        .user {
            font-size: 15px;
            font-weight: 700;
        }

        .normal {
            font-size: 13px;
            padding-right: 5px;
        }

        .type {
            font-size: 15px;
            font-weight: 700;
            padding-right: 1px;
        }
        
        .control input{
            width: 400px;
            height: 60px;
            padding: 10px;
            outline: none;
            font-size: 15px;
            font-weight: 400;
            text-align-last: center;
            color: rgba(0, 0, 0, 0.7);
            border-radius: 4px;
            border: 1px solid rgba(0, 0, 0, .1);
            background-color: rgb(25, 25, 25);
            transition-duration: .5s;
            cursor: default;
        }
        
        .control input:hover{
            transition-duration: .5s;
            background-image: none;
            background-color: #eee;
            font-size: 15px;
        }
        
        .contentBtn{
            padding: 70px 50px 50px;
        }
        
        .contentBtn .go{
            margin-bottom: 30px;
        }
        
        .go input{
            width: 250px;
            height: 40px;
            border: none;
            outline: none;
            font-size: 12px;
            border-radius: 4px;
            transition-duration: .5s;
        }
        
        .go.Back input{
            background-color: orange;
        }
        
        .go.Home input{
            background-color: orange;
        }
        
        .go input:hover{
            transition-duration: .5s;
            background-color: darkorange;
        }
        
        .footer {
            width: 100%;
            height: 250px;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
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
                            <asp:Button ID="btnLogin" runat="server" Text="로그인" class="nav-log-item" PostBackUrl="./login.aspx"/>
                        </div>
                    </a>
                </div>
                <ul>
                    <br />
                    <li><asp:Button ID="btnJoin" runat="server" Text="회원가입" OnClick="btnJoin_Click" class="navJoinBtn"/></li>
                    <li><asp:Button ID="btnFindIDPW" runat="server" Text="계정찾기" OnClick="btnFindIDPW_Click" class="navFindBtn"/></li>
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

        <!-- title -->
        <div class="title">
            <div class="titleItem">
                To Our Shared
            </div>
        </div>

        <!-- body -->
        <div class="body">
            <div class="contents">
                <div class="contentTitle">
                    <h3>조회결과</h3>
                </div>
                <div class="contentResult1">
                   <div class = "result1Item">
                    <div class="user">
                        <% 
                            if (Request.QueryString["name"] != null)
                            {
                                Response.Write(Request.QueryString["name"]);
                        %>
                    </div>
                    <div class="normal">님의</div>
                    <div class="type">아이디</div>
                    <div class="normal">조회 결과입니다.</div>
                    </div>
                        <%
                            }
                        %>
                        <%
                            if(Request.QueryString["id"] != null)
                            {
                                Response.Write(Request.QueryString["id"]);
                        %>
                    </div>
                    <div class="normal">님의</div>
                    <div class="type">비밀번호</div>
                    <div class="normal">조회 결과입니다.</div>
                    </div>
                        <%
                            }
                        %>
                    <div class = "result1Item">
                       <div class="normal" style="padding-top: 10px;">아래 영역에 마우스를 대면 조회 결과를 확인할 수 있습니다.</div>
                    </div>
                </div>
                <div class="contentResult2">
                    <div class="control">
                        <asp:TextBox ID="txtResult" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
                <div class = "contentBtn">
                    <div class = "go Back">
                        <asp:Button ID="btnBack" runat="server" Text="이전으로" PostBackUrl="./find_idpw.aspx"/>
                    </div>
                    <div class = "go Home">
                        <asp:Button ID="btnHome" runat="server" Text="메인으로" PostBackUrl="./index.aspx"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        바닥글
    </div>
</form>
</body>
</html>