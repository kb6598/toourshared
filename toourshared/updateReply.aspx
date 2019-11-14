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
            else
            {
                string MemID = Session["mem_id"].ToString(); // 현재 세션 아이디 불러오고
                string cmtNo = Request.QueryString["cmt_no"].ToString(); // comment No 불러오고

                Comment comment = new Comment();
                CommentDao commentDao = new CommentDao();

                comment.Cmt_no = cmtNo.ToString();
                comment = commentDao.selectCommentByCmt_no(comment); // DTO 받고

                DropDownList1.SelectedIndex = 0; // 가장 첫 번째 항목(평점) 으로 선택시킨다.
                TextBox1.Text = comment.Cmt_content.ToString(); // 댓글 내용 TextBox에 뿌려주고
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

                string inputText = TextBox1.Text;
                System.Diagnostics.Debug.WriteLine(DropDownList1.Items[DropDownList1.SelectedIndex].Text);

                if (string.IsNullOrEmpty(inputText) || DropDownList1.Items[DropDownList1.SelectedIndex].Text == "평점")
                {
                    Response.Write("<script language='javascript'>alert('평점을 선택하지 않으셨거나 혹은 댓글을 입력하지 않았습니다.');</script language='javascript'>");
                }
                else
                {
                    Comment setComment = new Comment();
                    Comment getComment = new Comment();
                    CommentDao commentDao = new CommentDao();

                    getComment.Cmt_no = cmtNo;
                    getComment = commentDao.selectCommentByCmt_no(getComment);

                    setComment.Mem_id = MemID; // mem_id
                    setComment.Cmt_no = cmtNo; // cmt_no
                    setComment.Cmt_content = inputText; // cmt_content
                    setComment.Cmt_timestamp = getComment.Cmt_timestamp.ToString(); // 기존 시간값으로 설정
                    setComment.Cmt_rate = DropDownList1.Items[DropDownList1.SelectedIndex].Text.ToString(); // cmt_rate  DTO 설정

                    commentDao.UpdateComment(setComment); // 댓글 업데이트

                    TravelDao travelDao = new TravelDao();
                    travelDao.setTotRateByTrvNo(int.Parse(trvNo)); // 게시글 평점 업데이트

                    Response.Write("<script language='javascript'>alert('댓글이 수정되었습니다.'); this.close(); opener.location.reload(); </script language='javascript'>");
                }
            }
        }
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset = "utf-8">
        <meta name = "viewport" content= "width=device-width, initial-scale=1">
        <title>댓글 수정하기</title>

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
            
            .header{
                width: 100%;
                height: 50px;
                flex-direction: row;
                justify-content: center;
                align-items: center;
                padding-top: 40px;
                padding-right: 50px;
            }
            
            .header_LEFT{
                padding: 10px;
            }
            .header_LEFT > span{
                font-size: 17px;
                cursor: default;
            }
            
            .score{
                width: 100px;
                height: 30px;
                
                border: none;
                outline: none;
                text-align-last: center;
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
            
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class = "header">
                <div class = "header_LEFT">
                    <span>⭐</span>
                </div>
                <div class = "header_RIGHT">
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass = "score">
                        <asp:ListItem Value="0">평점</asp:ListItem>
                        <asp:ListItem Value ="5">5</asp:ListItem>
                        <asp:ListItem Value ="4">4</asp:ListItem>
                        <asp:ListItem Value ="3">3</asp:ListItem>
                        <asp:ListItem Value ="2">2</asp:ListItem>
                        <asp:ListItem Value ="1">1</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class = "contents">
                <div class ="contents_UP">
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="contentsText" MaxLength="200" TextMode="MultiLine"/>
                </div>
                <div class = "contents_DOWN">
                    <asp:Button ID="Button1" runat="server" Text="수정" CssClass="contentsBtn" OnClick="Button1_Click" />
                </div>
            </div>
        </form>
    </body>

</html>