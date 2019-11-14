<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void BtnLogin_Click(object sender, EventArgs e)
    {
        MemberDao member = new MemberDao();
        Member mem = new Member();

        mem.Mem_id = mem_id.Text;
        mem.Mem_pw = mem_pw.Text;

        int check = member.Login(mem);


        if (Session["mem_id"] == null)
        {
            if (mem_id.Text.Equals("") || mem_pw.Text.Equals(""))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('아이디와 비밀번호를 입력해주세요.');", true);
            }
            else
            {

                if (check == 1)
                {
                    Session["mem_id"] = mem.Mem_id;
                    Session.Timeout = 2;
                    Response.Redirect("./index.aspx");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('아이디와, 비밀번호를 다시한번 확인해주세요.');", true);
                    mem_id.Text = "";
                    mem_pw.Text = "";


                }
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["mem_id"]!= null)
        {
            Response.Redirect("./index.aspx");
        }

        this.mem_id.Attributes["onkeyPress"] = "if(event.keyCode == 13) {" + Page.GetPostBackEventReference(this.BtnLogin) + "; return false; }";       // 아이디 입력창에서 ENTER 키 누를 때 BtnLogin이 눌러지도록.
        this.mem_pw.Attributes["onkeyPress"] = "if(event.keyCode == 13) {" + Page.GetPostBackEventReference(this.BtnLogin) + "; return false; }";      // 비밀번호 입력창에서 ENTER 키 누를 때 BtnLogin이 눌러지도록.
    }

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


    protected void FindPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("./find_idpw.aspx");
    }

    protected void FindID_Click(object sender, EventArgs e)
    {
        Response.Redirect("./find_idpw.aspx");
    }

    protected void JoinBtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("./join.aspx");
    }

</script>
 <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED : 로그인</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|Jua&display=swap" rel="stylesheet">

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

            cursor:default;
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

        .body {
            width: 100%;
            height: 620px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .area1 {
            width: 600px;
            height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .area1 .ID input {
            width: 400px;
            height: 50px;
            padding: 10px;
            font-size: 13px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
            border-bottom: 0.5px solid rgba(0, 0, 0, 0.3);
        }

        .area1 .PW input {
            width: 400px;
            height: 50px;
            padding: 10px;
            font-size: 13px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
        }

        .LOGINBTNitem {
            width: 400px;
            height: 50px;
            font-size: 13px;
            border: none;
            outline: none;
            color: white;
            background-color: orange;
            transition-duration: .5s;
        }

        .LOGINBTNitem:hover {
            transition-duration: .5s;
            background-color: darkorange;
        }

        .area2 {
            width: 400px;
            height: 400px;
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
        }

        #FindID
        {
            background-color: #00b9f1;
            color: white;
            font-size: 14px;
            text-decoration: none;
            outline : none;
        }

        #FindPW
        {
            background-color: #00b9f1;
            color: white;
            font-size: 14px;
            text-decoration: none;
            outline : none;

        }

        .findLine {
            width: 0.5px;
            height: 13px;
            border-right: 1px solid black;
            margin-top: 6px;
        }

        .area3 {
            width: 400px;
            height: 400px;
            padding: 50px 0px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .joinText {
            padding-top: 200px;
        }

        .joinText span {
            cursor: default;
            color: white;
            font-size: 13px;
        }

        .joinBtn {
            padding-top: 3px;
        }

        .joinBtnItem {
            width: 400px;
            height: 50px;
            color: #fff;
            font-size: 13px;
            border: none;
            outline: none;
            background-color: orange;
            transition-duration: .5s;
        }

        .joinBtnItem:hover {
            transition-duration: .5s;
            background-color: darkorange;
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
<form id="form1" runat="server">
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
                    <li><a href="./search.aspx">글 쓰기</a></li>
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
                            <asp:Button ID="Button1" runat="server" Text="로그인" class="nav-log-item" PostBackUrl="./login.aspx"/>
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
                    <li><asp:Button ID="btnMypage" runat="server" Text="마이페이지" OnClick="btnMypage_Click"  CssClass="navJoinBtn" /></li>
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
        <div class="body">
            <!-- 아이디 및 패스워드 입력, 로그인 버튼-->
            <div class="area1">
                <div class="ID">
                    <asp:TextBox ID="mem_id" runat="server" placeholder="아이디" maxlength="15"></asp:TextBox>
                </div>
                <div class="PW">
                    <asp:TextBox ID="mem_pw" runat="server" placeholder="비밀번호" maxlength="20" TextMode="Password"></asp:TextBox>
                </div>
                <div class="LOGINBTN">
                    <asp:Button ID="BtnLogin" runat="server" Text="로그인"  CssClass="LOGINBTNitem" OnClick="BtnLogin_Click" />
                </div> 
            </div>

            <!-- 아이디 비밀번호 찾기 -->
            <div class="area2">
                <div class="findID">
                    <asp:Button ID="FindID" runat="server" Text="아이디찾기" BorderStyle="None" onclick="FindID_Click" />
                </div>
                <!-- 구분선 -->
                <div class="findLine"></div>
                <div class="findPW">
                    <asp:Button ID="FindPW" runat="server" Text="비밀번호찾기" BorderStyle="None" OnClick ="FindPW_Click"/>
                </div>
            </div>

            <!-- 회원가입 버튼-->
            <div class="area3">
                <div class="joinText">
                    <span>아직 회원이 아니신가요?</span>
                </div>
                <div class="joinBtn">
                    <asp:Button ID="JoinBtn" runat="server" Text="회원가입" class="joinBtnItem" OnClick="JoinBtn_Click" />
                </div>
            </div>
        </div>
    </div>
        </form>
</body>

</html>

