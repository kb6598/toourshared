<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server"></script>
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

        .IDItem2 button {
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

        .GENDERitem2 .radio {
            padding: 3px 25px 0;
            font-size: 15px;
        }


        .radio input[type="radio"] {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            border: 0;
        }

        .radio input[type="radio"]+label {
            display: inline-block;
            position: relative;
            padding-left: 20px;
            padding-top: 3px;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
        }

        .radio input[type="radio"]+label:before {
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

        .radio input[type="radio"]:checked+label:before {
            background: #fff;
            border-color: #adb8c0;
        }

        .radio input[type="radio"]:checked+label:after {
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
            document.getElementById("chkBtn").onclick = function () {
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

    </script>
</head>

<body>
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
                <div class="nav-log">
                    <a href="#">
                        <div class="nav-log-area">
                            <input type="button" value="로그인" class="nav-log-item">
                        </div>
                    </a>
                </div>
            </li>
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
                    <input type="text" id="getID" placeholder="아이디" class="inputArea sht" maxlength="15" id="idArea" />
                    <button id="idCheckBtn" data-toggle="modal" data-target="#checkID">중복확인</button>
                </div>
            </div>
            <div class="Item" id="PW">
                <div class="PWitem1">
                    <span class="inforStar">*</span><span class="inforText">비밀번호</span>
                </div>
                <div class="PWitem2">
                    <input type="password" placeholder="비밀번호" class="inputArea lng" maxlength="20" />
                </div>
            </div>
            <div class="Item" id="NAME">
                <div class="NAMEitem1">
                    <span class="inforStar">*</span><span class="inforText">이름</span>
                </div>
                <div class="NAMEitem2">
                    <input type="text" placeholder="이름" class="inputArea lng" maxlength="10" />
                </div>
            </div>
            <div class="Item" id="GENDER">
                <div class="GENDERitem1">
                    <span class="inforStar">*</span><span class="inforText">성별</span>
                </div>
                <div class="GENDERitem2">
                    <div class="radio">
                        <input type="radio" name="gender" id="man" checked>
                        <label for="man">남자</label>
                    </div>
                    <div class="radio">
                        <input type="radio" name="gender" id="girl">
                        <label for="girl">여자</label>
                    </div>
                </div>
            </div>
            <div class="Item" id="BIRTH">
                <div class="BIRTHitem1">
                    <span class="inforStar">*</span><span class="inforText">생년월일</span>
                </div>
                <div class="BIRTHitem2">
                    <input type="text" placeholder="생년월일 (yy/mm/dd)" class="inputArea lng" maxlength="20" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
                </div>
            </div>
            <div class="Item" id="TEL">
                <div class="TELitem1">
                    <span class="inforStar">*</span><span class="inforText">연락처</span>
                </div>
                <div class="TELitem2">
                    <input type="text" placeholder="연락처 (- 제외)" class="inputArea lng" maxlength="13" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" />
                </div>
            </div>
            <div class="Item" id="EMAIL">
                <div class="EMAILitem1">
                    <span class="inforStar">*</span><span class="inforText">이메일</span>
                </div>
                <div class="EMAILitem2">
                    <input type="text" placeholder="이메일 (@포함)" class="inputArea lng" />
                </div>
            </div>
            <div class="Item" id="QNA">
                <div class="QNAitem1">
                    <span class="inforStar">*</span><span class="inforText">본인확인질문</span>
                </div>
                <div class="QNAitem2">
                    <select>
                        <option value="1">질문1</option>
                        <option value="2">질문2</option>
                        <option value="3">질문3</option>
                        <option value="4">질문4</option>
                        <option value="5">질문5</option>
                    </select>
                </div>
                <div class="QNAitem3">
                    <input type="text" placeholder="질문에 대한 답변" class="inputArea lng" />
                </div>
            </div>
            <div class="Item" id="REG">
                <div class="REGitem1">
                    <a href="#">
                        <button class="REGbtn">회원가입</button>
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
                            <input type="text" id="setID" />
                        </div>
                        <div class="checkBtn">
                            <button id="chkBtn">중복확인</button>
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

</body>

</html>
