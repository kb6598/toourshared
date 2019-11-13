<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["mem_id"] == null)
        {
            Response.Write("<script language='javascript'>alert('비 정상적인 접근 방법 입니다.'); this.close(); </script language='javascript'>");
        }
        else
        {
            if(Request.QueryString["trv_no"] == null)
            {
                Response.Write("<script language='javascript'>alert('비 정상적인 접근 방법 입니다.'); this.close(); </script language='javascript'>");
            }
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["mem_id"] == null)
        {
            Response.Write("<script language='javascript'>alert('비 정상적인 접근 방법 입니다.'); this.close(); </script language='javascript'>");
        }
        else
        {
            if(Request.QueryString["trv_no"] == null)
            {
                Response.Write("<script language='javascript'>alert('비 정상적인 접근 방법 입니다.'); this.close(); </script language='javascript'>");
            }
            else
            {
                string reportReason = TextBox1.Text.ToString();

                if(string.IsNullOrEmpty(reportReason))
                {
                    Response.Write("<script language='javascript'>alert('신고 사유를 입력해주세요.'); </script language='javascript'>");
                }
                else
                {
                    string MemID = Session["mem_id"].ToString();
                    string trvNo = Request.QueryString["trv_no"].ToString();

                    Report report = new Report();
                    ReportDao reportDao = new ReportDao();

                    report.Trv_no = trvNo;
                    report.Rep_timestap = TimeLib.GetTimeStamp();
                    report.Rep_mem_id = MemID;
                    report.Rep_reason = reportReason;

                    if(reportDao.IsExistReportWhereMemIDByTrvNo(report) == true) // 이미 해당 게시글을 신고한 기록이 있는 경우
                    {
                        Response.Write("<script language='javascript'>alert('이미 신고한 기록이 존재합니다.'); this.close(); </script language='javascript'>");
                    }
                    else
                    {
                        reportDao.InsertReport(report);
                        Response.Write("<script language='javascript'>alert('게시글이 신고되었습니다.\r\n해당 게시글은 운영자의 판단에 따라 조치될 예정입니다.'); this.close(); </script language='javascript'>");
                    }
                }
            }
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Write("<script language='javascript'>this.close(); </script language='javascript'>");
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
                        <asp:Button ID="Button1" runat="server" Text="신고하기" CssClass="reportBtn" OnClick="Button1_Click"/>
                        <asp:Button ID="Button2" runat="server" Text="취소" CssClass="reportBtn" OnClick="Button2_Click"/>
                    </div>
                </div>
            </div>
        </form>
    </body>

</html>