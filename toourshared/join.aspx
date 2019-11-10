<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">



    protected void btnJoin_Click(object sender, EventArgs e)
    {
        MemberDao member = new MemberDao();
        Member mem = new Member();
        mem.Mem_id = getID.Text;
        mem.Mem_pw = mem_pw.Text;
        mem.Mem_name = mem_name.Text;
        mem.Mem_birth = mem_birth.Text;
        mem.Mem_phone = mem_phone.Text;
        mem.Mem_email = mem_email.Text;
        if(mem_sex_m.Checked == true)
        {
            mem.Mem_sex = man.Text;
        }
        else if(mem_sex_f.Checked == true)
        {
            mem.Mem_sex = girl.Text;
        }
        mem.Mem_ques = QnAList.SelectedItem.Text;
        mem.Mem_answer = mem_answer.Text;

        mem.Mem_reg_datetime = TimeLib.GetToday();
        mem.Mem_timestmap = TimeLib.GetTimeStamp();

        int check = member.SelectMem_ID(mem);

        if (getID.Text.Equals("") || mem_pw.Text.Equals("") || mem_name.Text.Equals("") || mem_birth.Text.Equals("") || mem_answer.Text.Equals("") ||
        mem_email.Text.Equals("") || mem_phone.Text.Equals(""))
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('입력되지 않은 항목이 있습니다.');", true);
        }
        else if (mem_pw.Text.Length < 6)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('비밀번호는 6자 이상으로 입력해주세요.');", true);
        }
        else
        {
            if (check == 1)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('이미 존재하는 아이디입니다.');", true);
            }
            else
            {
                member.InsertMember(mem);
                Response.Redirect("/index.aspx");
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == true)
        {
            return;
            // Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('IsPostBack is True.');", true);

        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("/index.aspx");
    }

    protected void btnMypage_Click(object sender, EventArgs e)
    {
        Response.Redirect("/MyPage.aspx");
    }

    protected void btnJoinForm_Click(object sender, EventArgs e)
    {
        Response.Redirect("/join.aspx");
    }

    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("/find_idpw.aspx");
    }
</script>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED : 회원가입</title>

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
        @media only screen and (max-width: 1000px) {
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
            padding: 100px 0px 50px;
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
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        span {
            display: inline-block;
            padding-bottom: 5px;
        }

        .Item {
            padding: 10px 0px;
        }

        .inforStar {
            cursor: default;
            color: #ff0000;
            font-size: 13px;
        }

        .inforText {
            cursor: default;
            font-size: 13px;
            font-weight: 300;
        }

        .inputArea {
            font-size: 14px;
            color: rgba(0, 0, 0, 0.7);
            height: 50px;
            border: none;
            outline: none;
            padding: 10px;
            border-radius: 4px;
        }

        .sht {
            width: 245px;
            border-top-right-radius: 0px;
            border-bottom-right-radius: 0px;
        }

        .lng {
            width: 350px;
        }

        .IDCheck {
            width: 105px;
            padding-top: 20px;
            padding-bottom: 18px;
            border: none;
            outline: none;
            color: white;
            margin-left: -4.4px;
            font-size: 12px;
            background-color: orange;
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
            transition-duration: .5s;
        }

        .IDItem2 button:hover {
            transition-duration: .5s;
            background-color: darkorange;
        }

        .GENDERitem2 {
            width: 350px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            background-color: #fff;
            height: 50px;
            border-radius: 4px;
        }


        .GENDERitem2 .radio_a {
            padding: 3px 25px 0;
            font-size: 15px;
        }

            .GENDERitem2 .radio {
                http: //localhost:6118/draganddropEx.html padding: 3px 25px 0;
                font-size: 15px;
            }



        .radio_a input[type="radio_a"] {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            border: 0;
        }

        .radio_a input[type="radio_a"]+label {
            display: inline-block;
            position: relative;
            padding-left: 20px;
            padding-top: 3px;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
        }

        .radio_a input[type="radio_a"]+label:before {
            content: '';
            position: absolute;
            left: 0;
            top: 2px;
            width: 17px;
            height: 17px;
            text-align: center;
            background: #fff;
            border: 1px solid #cacece;
            border-radius: 100%;
        }

        .radio_a input[type="radio_a"]:checked+label:before {
            background: #fff;
            border-color: #adb8c0;
        }

        .radio_a input[type="radio_a"]:checked+label:after {
            content: '';
            position: absolute;
            top: 2px;
            left: 0px;
            width: 17px;
            height: 17px;
            border: 4px solid orange;
            background-color: transparent;
            border-radius: 100%;
        }

        .QNAitem2 select {
            width: 350px;
            height: 50px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
            padding: 5px;
            font-size: 13px;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }

        .QNAitem3 input {
            border-top: 0.5px solid rgba(0, 0, 0, 0.1);
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

        .REGitem1 {
            padding: 70px 0px 150px;
        }

        .REGbtn {
            width: 300px;
            height: 50px;
            outline: none;
            border: none;
            color: white;
            font-size: 13px;
            border-radius: 4px;
            background-color: orange;
            transition-duration: .5s;
        }

        .REGbtn:hover {
            transition-duration: .5s;
            background-color: darkorange;
        }

        .footer {
            width: 100%;
            height: 250px;
            background-color: #272625;
        }

        .modal-dialog {
            margin-top: 15%;
        }

        .modal-content {
            border-radius: 0;
            border: none;
            width: 500px;
            height: 300px;
            transition-duration: .5s;
        }

        .modal-header {
            border: none;
        }

        .bodyItem1 {
            width: 100%;
            height: auto;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        .bodyItem1 .inputArea input {
            width: 300px;
            height: 40px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            padding: 10px;
            outline: none;
        }

        .bodyItem1 .checkBtn button {
            width: 100px;
            height: 40px;
            margin-top: 9.5px;
            margin-left: -9.8px;
            font-size: 13px;
            border: .5px solid rgba(0, 0, 0, 0.1);
            outline: none;
            color: white;
            background-color: rgba(0, 191, 255, .7);
            transition-duration: .5s;
        }

        .bodyItem1 .checkBtn button:hover {
            transition-duration: .5s;
            background-color: deepskyblue;
        }

        .bodyItem2 {
            padding-top: 40px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        #result {
            font-size: 13px;
        }

        .modal-footer {
            width: 100%;
            height: 70px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            transition-duration: .9s;
        }

        .modal-footer a {
            width: 150px;
            font-size: 13px;
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

    <script type="text/javascript">
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

        /* 중복확인 버튼 누를경우 Modal에 데이터 넘기기 */
        $(document).ready(function () {
            document.getElementById("idCheckBtn").onclick = function () {
                $('#setID').val($('#getID').val());
            };
        });

        /* Modal 내 사용하기 버튼 누를경우 페이지 내 아이디 입력란에 데이터 넘기기 */
        $(document).ready(function () {
            document.getElementById("useID").onclick = function () {
                $('#getID').val($('#setID').val());
                $('#result').html("😢 사용할 수 없는 아이디 입니다.");
            };
        });

        /* Modal 내 사용하기 버튼 누를경우 페이지 내 아이디 입력란에 데이터 넘기기 */
        $(document).ready(function () {
            document.getElementById("chkID").onclick = function () {
                var footer = document.getElementById("modalFooter");
                
                if (footer.style.display != 'none') {
                    $('.modal-content').height("230px");
                    $('modalFooter').height("0px");
                    $('#result').html("😢 사용할 수 없는 아이디 입니다.");
                    document.getElementById("modalFooter").style.display = "none";
                } else {
                    $('.modal-content').height("300px");
                    $('modalFooter').height("70px");
                    $('#result').html("😊 사용할 수 있는 아이디 입니다.");
                    document.getElementById("modalFooter").style.display = "flex";
                }


                
            };
        });

        function ValidNum() {
            var x = document.getElementById('setID').value;
            if (x > 10) {
                alert("Please Enter a valid number");
                return false;
            }
            else {
                return true;
            }
        }

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
                            <asp:Button ID="btnLogin" runat="server" Text="로그인" class="nav-log-item" PostBackUrl="~/login.aspx"/>
                        </div>
                    </a>
                </div>
                <ul>
                    <p></p>
                    <li><asp:Button ID="btnJoinForm" runat="server" Text="회원가입" OnClick="btnJoinForm_Click" class="navJoinBtn"/></li>
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
        <div class="title">
            <div class="titleItem">
                To Our Shared
            </div>
        </div>
        <div class="body">
            <div class="Item" id="ID">
                <div class="IDItem1">
                    <span class="inforStar">*</span><span class="inforText">아이디</span>
                </div>
                <div class="IDItem2">
                    <asp:TextBox ID="getID" placeholder="아이디" class="inputArea lng" maxlength="15" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="Item" id="PW">
                <div class="PWitem1">
                    <span class="inforStar">*</span><span class="inforText">비밀번호</span>
                </div>
                <div class="PWitem2">
                    <asp:TextBox ID="mem_pw" runat="server" TextMode="Password" placeholder="비밀번호" class="inputArea lng" maxlength="20"></asp:TextBox>
                </div>
            </div>
            <div class="Item" id="NAME">
                <div class="NAMEitem1">
                    <span class="inforStar">*</span><span class="inforText">이름</span>
                </div>
                <div class="NAMEitem2">
                    <asp:TextBox ID="mem_name" placeholder="이름" class="inputArea lng" maxlength="10" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="Item" id="GENDER">
                <div class="GENDERitem1">
                    <span class="inforStar">*</span><span class="inforText">성별</span>
                </div>
                <div class="GENDERitem2">
                    <div class="radio_a">
                        <asp:RadioButton ID="mem_sex_m" runat="server" GroupName="mem_sex" Checked="true" />
                        <asp:Label ID="man" runat="server" Text="남자"></asp:Label>
                    </div>
                    <div class="radio_a">
                        <asp:RadioButton ID="mem_sex_f" runat="server" GroupName="mem_sex" />
                        <asp:Label ID="girl" runat="server" Text="여자"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="Item" id="BIRTH">
                <div class="BIRTHitem1">
                    <span class="inforStar">*</span><span class="inforText">생년월일</span>
                </div>
                <div class="BIRTHitem2">
                    <asp:TextBox ID="mem_birth" runat="server" placeholder="생년월일 (yy/mm/dd)" class="inputArea lng" maxlength="6" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;"></asp:TextBox>
                </div>
            </div>
            <div class="Item" id="TEL">
                <div class="TELitem1">
                    <span class="inforStar">*</span><span class="inforText">연락처</span>
                </div>
                <div class="TELitem2">
                    <asp:TextBox ID="mem_phone" runat="server" placeholder="연락처 (- 제외)" class="inputArea lng" maxlength="13" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" ></asp:TextBox>
                </div>
            </div>
            <div class="Item" id="EMAIL">
                <div class="EMAILitem1">
                    <span class="inforStar">*</span><span class="inforText">이메일</span>
                </div>
                <div class="EMAILitem2">
                    <asp:TextBox ID="mem_email" runat="server" placeholder="이메일 (@포함)" class="inputArea lng"></asp:TextBox>
                </div>
            </div>
            <div class="Item" id="QNA">
                <div class="QNAitem1">
                    <span class="inforStar">*</span><span class="inforText">본인확인질문</span>
                </div>
                <div class="QNAitem2">
                    <asp:DropDownList ID="QnAList" runat="server">
                        <asp:ListItem Value="question1">본인이 태어난 출생지는?</asp:ListItem>
                        <asp:ListItem Value="question2">본인의 출신 초등학교 이름은?</asp:ListItem>
                        <asp:ListItem Value="question3">본인의 반려견 이름은?</asp:ListItem>
                        <asp:ListItem Value="question4">본인의 어머니 성함은?</asp:ListItem>
                        <asp:ListItem Value="question5">본인의 소중한 보물 1호는?</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="QNAitem3">
                    <asp:TextBox ID="mem_answer" runat="server" placeholder="질문에 대한 답변" class="inputArea lng"></asp:TextBox>
                </div>
            </div>
            <div class="Item" id="REG">
                <div class="REGitem1">
                    <a href="#">
                        <asp:Button ID="btnJoin" runat="server" Text="회원가입" class="REGbtn" OnClick="btnJoin_Click" />
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- footer 영역 -->
    <div class="footer">
        바닥글
    </div>

    <!-- The Modal -->
    <div class="modal fade" id="checkID">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="bodyItem1">
                        <div class="inputArea">
                            <asp:TextBox ID="setID" runat="server"></asp:TextBox>
                        </div>
                        <div class="checkBtn">
                            <!--<button id="chkID" class="btn btn-warning">중복확인</button>-->
                            <asp:Button ID="chkID" runat="server" Text="중복확인" CssClass="btn btn-warning"  OnClientClick="return ValidNum();"  />
                        </div>
                    </div>
                    <div class="bodyItem2">
                        <div class="result">
                            <span id="result">😊 사용할 수 있는 아이디 입니다.</span>
                        </div>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer" id="modalFooter">
                    <a href="#" id="useID" class="btn btn-danger" data-dismiss="modal">사용하기</a>
                </div>

            </div>
        </div>
    </div>
    </form>
</body>

</html>
