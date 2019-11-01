<%@ Page Language="C#" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>



<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Data" %>


<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {

        string date = TimeLib.GetTimeStamp();

        CommentDao com = new CommentDao();

        Comment comment = new Comment();

        comment.Cmt_content = TextBox1.Text;
        comment.Trv_no = "1";
        comment.Cmt_rate = TextBox2.Text;
        comment.Cmt_timestamp = date;

        string d = com.InsertComment(comment);

        Label1.Text = d;

        //if(i == 1)
        //{
        //    Label1.Text = i.ToString();

        //    string j = com.Select_last(comment);


        //    Label2.Text = j;



        //}
        //else
        //{
        //    Label1.Text = "값이 제대로 안넘어갔으니 알아서 확인하셈";
        //}

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        CommentDao com = new CommentDao();

        DataSet ds = com.SelectComment();

        GridView1.DataSource = ds;
        GridView1.DataBind();

        //Label3.Text = Session["userPW"].ToString();
        //Label4.Text = Request.QueryString["id"].ToString();





    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Comment comment = new Comment();
        CommentDao com = new CommentDao();

        comment.Cmt_no = TextBox3.Text;

        Comment resultComment =  com.selectCommentByCmt_no(comment);

        TextBox4.Text = resultComment.Cmt_content;
        TextBox5.Text = resultComment.Cmt_rate;
        TextBox6.Text = resultComment.Cmt_timestamp;
        TextBox7.Text = resultComment.Mem_id;


    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        CommentDao com = new CommentDao();

        Comment comment = new Comment();

        comment.Cmt_no = TextBox3.Text;

        int i =  com.DeleteComment(comment);
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        CommentDao com = new CommentDao();

        Comment comment = new Comment();

        comment.Cmt_no = TextBox3.Text;
        comment.Cmt_content = TextBox4.Text;
        comment.Cmt_rate = TextBox5.Text;
        comment.Cmt_timestamp = TimeLib.GetTimeStamp();
        comment.Mem_id = TextBox7.Text;



        int i =  com.UpdateComment(comment);
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        MemberDao member = new MemberDao();

        Member mem = new Member();

        mem.Mem_id = TextBox8.Text;
        mem.Mem_pw = TextBox9.Text;

        int check = member.Login(mem);



        if (Request.Cookies["mem_id"] == null)
        {
            if (TextBox8.Text.Equals("") || TextBox9.Text.Equals(""))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('아이디와 비밀번호를 입력해주세요.');", true);
            }
            else
            {

                if (check == 1)
                {
                    Response.Cookies["mem_id"].Value = mem.Mem_id;
                    //Response.Cookies["mem_id"].Expires = DateTime.Now.AddHours(0);
                    Response.Redirect("/test02.aspx");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "displayalertmessage", "alert('아이디와, 비밀번호를 다시한번 확인해주세요.');", true);
                    TextBox1.Text = "";
                    TextBox2.Text = "";


                }
            }
        }
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        Label5.Text = TextBox10.Text;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>

            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>

            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />


            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"> 
                                <Columns>
                    <asp:BoundField HeaderText="댓글번호" DataField="cmt_no" />
                    <asp:BoundField HeaderText="내용" DataField="cmt_content" />
                    <asp:BoundField HeaderText="작성자" DataField="mem_id" />
                    <asp:BoundField HeaderText="날짜" DataField="cmt_timestamp" />
                    <asp:BoundField HeaderText="평점" DataField="cmt_rate" />
                </Columns>
            </asp:GridView>

            검색 :<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox><br />

            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox><br />
            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox><br />
            <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox><br />
            <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox><br />

            <asp:Button ID="Button2" runat="server" Text="불러오기" OnClick="Button2_Click" />

            <asp:Button ID="Button3" runat="server" Text="삭제" OnClick="Button3_Click" />

            <asp:Button ID="Button4" runat="server" Text="수정" OnClick="Button4_Click" /><br />
            로그인 테스트<br />

            <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox><br />
            <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
            <asp:Button ID="Button5" runat="server" Text="로그인" OnClick="Button5_Click" />

            <br />

            <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>님이
            찾은 아이디는 : 
            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
        </div>



        <asp:Button ID="Button6" runat="server" Text="Button" />
        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Panel ID="Panel1" runat="server" BackColor="#6600FF">
            모달 테스트
            <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button7" runat="server" Text="넘겨" OnClick="Button7_Click" />
            <asp:Button ID="Button8" runat="server" Text="꺼버려" />
        </asp:Panel>
        
        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" CancelControlID="Button8" PopupControlID="Panel1" TargetControlID="Button6"></ajaxToolkit:ModalPopupExtender>
    </form>
</body>
</html>
