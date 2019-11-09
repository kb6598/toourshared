<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void FindID_Click(object sender, EventArgs e)
    {
        Member member = new Member();
        MemberDao findID = new MemberDao();

        member.Mem_name = find_id_mem_name.Text;
        member.Mem_birth = find_id_mem_birth.Text;
        member.Mem_phone = find_id_mem_phone.Text;
        member.Mem_ques = find_id_QnAList.SelectedItem.Text;
        member.Mem_answer = find_id_mem_answer.Text;

        if (find_id_mem_name.Text.Equals("") || find_id_mem_birth.Text.Equals("") || find_id_mem_phone.Text.Equals("") || find_id_mem_answer.Text.Equals(""))
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('입력되지 않은 사항이 있습니다.');", true);
        }
        else
        {
            Member id = findID.FindMemberID(member);

            string str = id.Mem_id;

            if (str == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('정확한 정보를 입력해 주세요.');", true);
            }
            else
            {
                Session["userID"] = str;
                Response.Redirect("find_idpw2.aspx?name=" + member.Mem_name);
            }
        }
    }

    protected void FindPW_Click(object sender, EventArgs e)
    {
        Member member = new Member();
        MemberDao findPW = new MemberDao();

        member.Mem_id = find_pw_mem_id.Text;
        member.Mem_birth = find_pw_mem_birth.Text;
        member.Mem_phone = find_pw_mem_phone.Text;
        member.Mem_ques = find_pw_QnAList.SelectedItem.Text;
        member.Mem_answer = find_pw_mem_answer.Text;

        if (find_pw_mem_id.Text.Equals("") || find_pw_mem_birth.Text.Equals("") || find_pw_mem_phone.Text.Equals("") || find_pw_mem_answer.Text.Equals(""))
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('입력되지 않은 사항이 있습니다.');", true);
        }
        else
        {
            Member pw = findPW.FindMemberPW(member);

            string str = pw.Mem_pw;

            if (str == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('정확한 정보를 입력해 주세요.');", true);
            }
            else
            {
                Session["userPW"] = str;
                Response.Redirect("find_idpw2.aspx?id=" + member.Mem_id);
            }
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

    protected void btnJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("/join.aspx");
    }

    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("/find_idpw.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            width: 100%;
            height: 1300px;
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
            height: 900px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        .find {
            width: 700px;
            height: 650px;
            margin: 0px 10px;
            border: 2px solid #fff;
            transition-duration: .9s;
        }
        
        .find.fid:hover{
            background-color: #fff;
            transition-duration9: .5s;
        }
        
        .find.fpw:hover{
            background-color: #fff;
            transition-duration: .9s;
        }
        
        .fid{
            border-top-left-radius: 20px;
        }
        
        .fpw{
            border-bottom-right-radius: 20px;
        }

        .findTitle {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .findTitle h4 {
            color: #353866;
            font-size: 23px;
            font-weight: 700;
            padding: 20px 0 40px;
        }

        .findContents {
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .findContent {
            padding: 15px 0;
        }

        .findContentTitle {
            padding-bottom: 5px;
            padding-left: 1px;
        }

        .findContentTitle span {
            color: black;
            font-size: 13px;
        }

        .findContentItem > input{
            width: 300px;
            height: 45px;
            padding: 10px;
            font-size: 13px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
            border-radius: 4px;
            background-color: #eee;
        }
        
        .Question select{
            width: 300px;
            height: 45px;
            padding: 10px;
            font-size: 13px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            border-bottom: 0.5px solid rgba(0, 0, 0, 0.1);
            background-color: #eee;
        }
        
        .Answer input{
            width: 300px;
            height: 45px;
            padding: 10px;
            font-size: 13px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
            border-bottom-left-radius: 4px;
            border-bottom-right-radius: 4px;
            background-color: #eee;
        }
        
        .findContentBtn{
            margin: 20px 0;
            width: 150px;
            height: 40px;
            outline: none;
            border: none;
            border-radius: 4px;
            font-size: 13px;
            color: #eee;
            background-color: #e97f02;
            transition-duration: .5s;
        }
        
        .findContentBtn:hover{
            background-color: #bd1550;
            transition-duration: .5s;
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
            <div class="find fid">
                <div class="findTitle">
                    <h4>아이디 찾기</h4>
                </div>
                <div class="findContents">
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>이름</span>
                        </div>
                        <div class="findContentItem">
                            <asp:TextBox ID="find_id_mem_name" runat="server" placeholder="이름" maxlength="10" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>생년월일</span>
                        </div>
                        <div class="findContentItem">
                            <asp:TextBox ID="find_id_mem_birth" runat="server" placeholder="생년월일 (yy/mm/dd)" maxlength="6" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>연락처</span>
                        </div>
                        <div class="findContentItem">
                            <asp:TextBox ID="find_id_mem_phone" runat="server" placeholder="연락처 (- 제외)" maxlength="13" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>본인확인질문</span>
                        </div>
                        <div class="findContentItem">
                            <div class="Question">
                                <asp:DropDownList ID="find_id_QnAList" runat="server">
                                    <asp:ListItem Value="question1">본인이 태어난 출생지는?</asp:ListItem>
                                    <asp:ListItem Value="question2">본인의 출신 초등학교 이름은?</asp:ListItem>
                                    <asp:ListItem Value="question3">본인의 반려견 이름은?</asp:ListItem>
                                    <asp:ListItem Value="question4">본인의 어머니 성함은?</asp:ListItem>
                                    <asp:ListItem Value="question5">본인의 소중한 보물 1호는?</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="Answer">
                                <asp:TextBox ID="find_id_mem_answer" runat="server" placeholder="질문에 대한 답변" ></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="findContent">
                        <a href = "#">
                            <asp:Button ID="FindID" runat="server" Text="아이디찾기" class = "findContentBtn" OnClick="FindID_Click"/>
                        </a>
                    </div>
                </div>
            </div>
            <div class="find fpw">
                <div class="findTitle">
                    <h4>비밀번호 찾기</h4>
                </div>
                <div class="findContents">
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>아이디</span>
                        </div>
                        <div class="findContentItem">
                            <asp:TextBox ID="find_pw_mem_id" runat="server" placeholder="아이디" maxlength="15"></asp:TextBox>
                        </div>
                    </div>
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>생년월일</span>
                        </div>
                        <div class="findContentItem">
                            <asp:TextBox ID="find_pw_mem_birth" runat="server" placeholder="생년월일 (yy/mm/dd)" maxlength="6" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" ></asp:TextBox>

                        </div>
                    </div>
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>연락처</span>
                        </div>
                        <div class="findContentItem">
                            <asp:TextBox ID="find_pw_mem_phone" runat="server" placeholder="연락처 (- 제외)" maxlength="13" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="findContent">
                        <div class="findContentTitle">
                            <span>본인확인질문</span>
                        </div>
                        <div class="findContentItem">
                            <div class="Question">
                                <asp:DropDownList ID="find_pw_QnAList" runat="server">
                                    <asp:ListItem Value="question1">본인이 태어난 출생지는?</asp:ListItem>
                                    <asp:ListItem Value="question2">본인의 출신 초등학교 이름은?</asp:ListItem>
                                    <asp:ListItem Value="question3">본인의 반려견 이름은?</asp:ListItem>
                                    <asp:ListItem Value="question4">본인의 어머니 성함은?</asp:ListItem>
                                    <asp:ListItem Value="question5">본인의 소중한 보물 1호는?</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="Answer">
                                <asp:TextBox ID="find_pw_mem_answer" runat="server" placeholder="질문에 대한 답변" ></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="findContent">
                        <a href = "#">
                            <asp:Button ID="FindPW" runat="server" Text="비밀번호찾기" class = "findContentBtn" OnClick="FindPW_Click" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- footer 영역 -->
    <div class ="footer">바닥글</div>
</form>
</body>
</html>
