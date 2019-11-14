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
            if(Request.QueryString["cmt_no"] == null || Request.QueryString["trv_no"] == null)
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
            if (Request.QueryString["cmt_no"] == null || Request.QueryString["trv_no"] == null)
            {
                Response.Write("<script language='javascript'>alert('비 정상적인 접근 방법 입니다.'); this.close(); </script language='javascript'>");
            }
            else
            {
                string MemID = Session["mem_id"].ToString(); // 현재 세션 아이디 불러오고
                string cmtNo = Request.QueryString["cmt_no"].ToString(); // comment No 불러오고
                string trvNo = Request.QueryString["trv_no"].ToString(); // travel No 불러오고

                TravelDao travelDao = new TravelDao();

                Comment comment = new Comment();
                CommentDao commentDao = new CommentDao();

                comment.Cmt_no = cmtNo.ToString();
                commentDao.DeleteComment(comment); // 해당 Comment(cmt_no 기준) 삭제하고

                travelDao.setTotRateByTrvNo(int.Parse(trvNo)); // 해당 게시글 번호(trvNo) 평점 업데이트

                Response.Write("<script language='javascript'>alert('댓글이 삭제 되었습니다.'); this.close(); opener.location.reload(); </script language='javascript'>");
            }
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Write("<script language='javascript'>this.close();</script language='javascript'>");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset = "utf-8">
        <meta name = "viewport" content= "width=device-width, initial-scale=1">
        <title>댓글 삭제하기</title>

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
            }
            
            div{
                display: flex;
            }
            
            .contents{
                padding: 10px;
                height: 250px;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            
            .contents_UP{
                width: 100%;
                height: 150px;
                justify-content: center;
                align-items: center;
            }
            
            .UpText{
                color: black;
                font-size: 22px;
                font-weight: 700;
                font-family: 'Noto Sans KR', sans-serif;  
            }
            
            .contents_DOWN{
                width: 100%;
                height: 100px;
                
                display: flex;
                justify-content: center;
                align-items: center;
            }
            
            .contentsText{
                width: 450px;
                height: 100px;
                resize: none;
                border: none;
                outline: none;
                padding: 10px;
                font-family: 'Noto Sans KR', sans-serif;
            }
            
            .contentsBtn{
                width: 100px;
                height: 30px;
                border: none;
                outline: none;
                color: #fff;
                cursor: pointer;
                font-size: 12px;
                background-color: orange;
                transition-duration: .5s;
                font-family: 'Noto Sans KR', sans-serif;
            }
            
            .contentsBtn:hover{
                background-color: orangered;
            }
            
            .contentsCancel{
                width: 100px;
                height: 30px;
                border: none;
                outline: none;
                color: #fff;
                cursor: pointer;
                font-size: 12px;
                background-color: orangered;
                transition-duration: .5s;
                margin-left: 10px;
                font-family: 'Noto Sans KR', sans-serif;
            }
            
            .contentsCancel:hover{
                background-color: #2e2e2e;
            }
            
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class = "contents">
                <div class ="contents_UP">
                    <span class="UpText">정말 댓글을 삭제하시겠습니까?</span>
                </div>
                <div class = "contents_DOWN">
                    <asp:Button ID="Button1" runat="server" Text="삭제" CssClass="contentsBtn" OnClick="Button1_Click" />
                    <asp:Button ID="Button2" runat="server" Text="취소" CssClass="contentsCancel" OnClick="Button2_Click" />
                </div>
            </div>
        </form>
    </body>

</html>