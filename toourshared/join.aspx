<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <link href="https://fonts.googleapis.com/css?family=Libre+Baskerville|Merriweather|Noto+Sans+KR|Nanum+Gothic+Coding|Noto+Serif+KR|Playfair+Display" rel="stylesheet"/>
    <title>To Our Shared - Join</title>
    <style>
        .bg{
            top: 0;
            left: 0;
            position: absolute;
                
            min-width: 100%;
            min-height: 100%;
                
            background-color: rgb(244, 244, 244);
        }
            
        .div1{
            margin-top: 100px;
            font-size: 60px;
            font-family: 'Libre Baskerville', serif;
        }
            
        .div2{
            margin-top: 80px;
        }
            
        .div3{
            margin-left: 280px;
        }
            
        .div4{
            margin-top: 150px;
        }
            
        .div5{
            margin-top: 10px;
        }
            
        .inp1{
            width: 450px;
            height: 60px;
            padding-left: 10px;
            padding-right: 30px;
                
            font-size: 17px;
            font-family: 'Merriweather';
                
            border-bottom: none;
                
            border-left-style: solid;
            border-right-style: solid;
            border-top-style: solid;
                
            border-left-width: thin;
            border-right-width: thin;
            border-top-width: thin;
                
            border-left-color: gainsboro;
            border-right-color: gainsboro;
            border-top-color: gainsboro;
        }
            
        .inp1:focus{
            outline: none;
            border: 0.5px solid dimgrey;
        }
            
        .inp2{
            width: 450px;
            height: 60px;
            padding-left: 10px;
            padding-right: 30px;
                
            font-size: 17px;
                
            border: solid;
            border-width: thin;
            border-color: gainsboro;
        }
            
        .inp2:focus{
            outline: none;
            border: 0.5px solid dimgrey;
        }
            
        .btn1{
            width: 450px;
            height: 60px;
        
            font-size: 17px;
                
            outline: none;
            cursor: pointer;
                
            border: none;
            color: white;
            background-color: #333;
        }
            
        .btn2{
            width: 450px;
            height: 60px;
                
            font-size: 17px;
                
            outline: none;
            cursor: pointer;
                
            border: 0.5px solid gainsboro;
            background-color: white;
        }
            
        .btn2:hover{
            color: white;
            background-color: #333;
        }
            
        .hr1{
            width: 450px;
            margin-top: 60px;
                
            border: 0.5px solid gray;
        }
            
        .spn1{
            opacity: 0.5;
            color: black;
            
            font-size: 15px;
            font-family: 'Noto Sans KR', sans-serif;
        }
            
        .spn1 a{
            color: black;
            text-decoration: none; 
        }
            
        .spn1 a:hover{
            color: firebrick;
        }
            
        .spn2{
            opacity: 0.5;
            color: black;
                
            font-size: 15px;
            font-family: 'Noto Sans KR', sans-serif;
        }
    </style>
</head>
    <body>
    <form id="form1" runat="server">
        <center>    
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
                        <input type = "text" placeholder=" 이름" maxlength="18" class="inp1"/>
                    </div>
                       <div>
                           <asp:RadioButton runat="server" text ="남자"></asp:RadioButton>
                           <asp:RadioButton runat="server" text ="여자"></asp:RadioButton>
                       </div>
                       <div>
                           <asp:TextBox ID="TextBox1" runat="server" placeholder="연락처 (-제외)" MaxLength="11" class ="inp1"/>
                       </div>
                    <div>
                        <asp:DropDownList runat="server" AutoPostBack="True" Height="55px" Width="492px"  >
                            <asp:ListItem Value="1">본인이 태어난 곳은?</asp:ListItem>
                            <asp:ListItem Value="2">처음 키운 반려견은?</asp:ListItem>
                            <asp:ListItem Value="3">본인 출신 초등학교는?</asp:ListItem>
                            <asp:ListItem Value="4">내 부모님의 고향은?</asp:ListItem>
                            <asp:ListItem Value="5">학생시절 나의 별명은?</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div>
                         <input type = "text" placeholder="본인확인 답변" maxlength="15"class="inp1"/>
                    </div>

                        <hr class = "hr1"/>

                </div>
                
             
                <div class = "div5">
                    <div>
                        <input type = "button" value = "회원가입" class = "btn2" />
                        </div>
                    </div>
                 </div>
            </center>
             </form>
        </body>
    </html>
        