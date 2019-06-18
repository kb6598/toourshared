<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>To Our Shared - Login</title>
        <link href="https://fonts.googleapis.com/css?family=Libre+Baskerville|Merriweather|Noto+Sans+KR|Nanum+Gothic+Coding|Noto+Serif+KR|Playfair+Display" rel="stylesheet"/>
        <link rel="stylesheet" href="login_form.css"/>
</head>
    <body><center>
        <form>
            <div class ="bg">
                
                <div class ="div1">To Our Shared</div>
                
                <div class ="div2">
                    <div>
                        <input type = "text" placeholder=" 아이디" maxlength="15"class="inp1"/>
                    </div>
                    <div>
                        <input type = "password" placeholder=" 비밀번호" maxlength="18" class="inp2"/>
                    </div>
                    <div>
                        <input type = "button" value = "로그인" class="btn1"/>
                    </div>
                    <div>
                        <hr class = "hr1">
                    </div>
                    <div class = "div3">
                        <span class="spn1"><a href = "#">아이디찾기</a></span>
                        <span class="spn1">|</span>
                        <span class="spn1"><a href = "#">비밀번호찾기</a></span>
                    </div>
                </div>
                
                <div class = "div4">
                    <div>
                        <span class = "spn2">아직 회원이 아니신가요?</span>
                    </div>
                </div>
                <div class = "div5">
                    <div>
                        <input type = "button" value = "회원가입" class = "btn2" />
                    </div>
                </div>
            </div>
        </form>
    </center></body>
</html>
