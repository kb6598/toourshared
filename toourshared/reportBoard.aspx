<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
    }


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset = "utf-8">
        <meta name = "viewport" content= "width=device-width, initial-scale=1">

        <!-- Font -->
        <link href = "https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|Jua&display=swap" rel = "stylesheet" >

        <style>
            body, form{
                padding: 0;
                margin: 0;
                width: 500px;
                height: 300px;
                background-color: #00b9f1;
                position: fixed;
                padding: 10px;
                
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                font-family: 'Noto Sans KR', sans-serif;  
            }
            
            div{
                display: flex;
            }
            
            .contents{
                padding: 10px;
                height: 300px;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            
            .contents_UP{
                width: 100%;
                height: 50px;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 15px;
            }
            
            .UpText{
                cursor: default;
                color: black;
                font-size: 25px;
                font-weight: 700;
            }
            
            .UpText:hover .ico{
                text-shadow: 0px 0px 5px rgb(255, 0, 0);
            }
            
            .contents_DOWN{
                width: 100%;
                height: 250px;
                
                flex-direction: column;
                align-items: center;
            }
            
            .contentsText{
                width: 400px;
                height: 130px;
                font-family: 'Noto Sans KR', sans-serif; 
                border: none;
                outline: none;
                background-color: #e2e2e2;
                font-size: 15px;
                padding: 10px;
                resize: none;
                transition-duration: .5s;
            }
            
            .contentsText:focus{
                border-top: 10px solid #000;
                border-bottom: 10px solid #000;
            }
            
            .contentsBtnArea{
                padding: 30px;
            }
            
            .reportBtn{
                width: 100px;
                height: 30px;
                margin: 0px 10px;
                border: none;
                outline: none;
                color: #fff;
                cursor: pointer;
                background-color: #000;
                font-size: 12px;
                font-family: 'Noto Sans KR', sans-serif;
                transition-duration: .5s;
            }
            
            .reportBtn:hover{
                background-color: firebrick;
            }
            
        </style>

    </head>

    <body>
        <form id="form1" runat="server">
            <div class = "contents">
                <div class ="contents_UP">
                    <div><span class="UpText"><span class="ico">🚨</span> 게시글 신고</span></div>
                    <div>해당 게시글의 신고 사유를 입력해주세요.</div>
                </div>
                <div class = "contents_DOWN">
                    <div class = "contentsTextArea">
                        <asp:TextBox ID="TextBox1" class="contentsText" runat="server" MaxLength="50" autocomplete="off" />
                    </div>
                    <div class = "contentsBtnArea">
                        <asp:Button ID="Button1" runat="server" Text="신고하기" CssClass="reportBtn"/>
                        <asp:Button ID="Button2" runat="server" Text="취소" CssClass="reportBtn"/>
                    </div>
                </div>
            </div>
        </form>
    </body>

</html>