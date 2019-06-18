<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1"/>
    <head runat="server">
        <title>TO OUR SHARED</title>
        
        <!-- 웹 폰트 경로 -->
        <link href="https://fonts.googleapis.com/css?family=Libre+Baskerville|Merriweather|Nanum+Gothic+Coding|Noto+Serif+KR|Playfair+Display" rel="stylesheet"/>
        <link rel="stylesheet" href="main.css"/>
        
        <!-- 슬라이드를 위한 경로 설정 -->
        
        <link rel="stylesheet" type="text/css" href="./demo.css" />
        <link rel="stylesheet" type="text/css" href="./backgroundTransition.css" />
        
        <!-- 스크립트 경로 설정 -->
        <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="./backgroundTransition.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
	           $('.backgroundTransition').backgroundTransition({
		              backgrounds:[
			             { src: './imgs/Background.jpg' },
			             { src: './imgs/Background2.jpg' },
			             { src: './imgs/Background3.jpg' },
			             { src: './imgs/Background4.jpg' },
			             { src: './imgs/Background5.jpg' },
		              ],
		              transitionDelay: 10,
		              animationSpeed: 800
	           });
            });
        </script>
    </head>
    <body>
        <form>
        <div class = "backgroundTransition">
            <div class="div_sty0">
                <ul>
                    <li><a href ="">Sign up</a></li>
                    <li><a href ="http://itbuddy.iptime.org/project/toourshared/src/main/webapp/login_form.html">Log in</a></li>
                    <li class ="team">
                        <a href="javascript:void(0)" class="teambtn">Team</a>
                        <div class ="team-drop">
                            <a href="">나평근</a>
                            <a href="">이빌립</a>
                            <a href="">이나진</a>
                            <a href="">김윤성</a>
                            <a href="">이민혁</a>
                        </div>
                    </li>
                    <li class = "ToOurShared">
                        <a href = "">To Our Shared</a>
                    </li>
                </ul>
            </div>
                
            <div class="div_sty2">
                <span class="TOS">To<br>Our<br>Shared</span>
            </div>
                
            <div class = "div_sty3">
                <span class ="MS">share memorable memories while you travel.</span>
            </div>
                
            <div class="div_sty">
                <span>
                    <input type = "text" placeholder = " Search here" class = "text_sty"/>
                </span>
            </div>
                
            <div class="div_sty4">
                <input type = "button" class="src_sty"/>
            </div>
            
            <div class="div_sty5">관심있는 지역을 입력하세요.&nbsp;&nbsp;서울, 부산… </div>
            
            <div class="area"></div>
                
            <div style="overflow: hidden;">
                <center>
                    <table>
                        <tr>
                            <td>
                                <div class="container"><img src="./imgs/서울.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">서울<br/>SEOUL</div></a>
                                </div>
                            </td>
                            
                            <td>
                                <div class="container"><img src="./imgs/경기도.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">경기도<br/>GYEONGGIDO</div></a>
                                </div>
                            </td>
                            
                            <td>
                                <div class="container"><img src="./imgs/인천.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">인천<br/>INCHEON</div></a>
                                </div>
                            </td>
                            
                            <td>
                                <div class="container"><img src="./imgs/충청도.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">충청도<br/>CHUNGCHEONGDO</div></a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="container"><img src="./imgs/강원도.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">강원도<br/>GANGWONDO</div></a>
                                </div>
                            </td>
                            
                            <td>
                                <div class="container"><img src="./imgs/전라도.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">전라도<br/>JEOLLADO</div></a>
                                </div>
                            </td>
                            
                            <td>
                                <div class="container"><img src="./imgs/경상도.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">경상도<br/>GYEONGSANGDO</div></a>
                                </div>
                            </td>
                            
                            <td>
                                <div class="container"><img src="./imgs/제주도.jpg" class="imgstyle">
                                    <a href="#"><div class="overlay">제주도<br/>JEJUDO</div></a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </center>
            </div>
        </div>
        </form>
    </body>
</html>
