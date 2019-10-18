<%@ Page Language="C#" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="MySql.Data" %>
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

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        CommentDao com = new CommentDao();

        Comment comment = new Comment();

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

            <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />

            <asp:Button ID="Button3" runat="server" Text="Button" OnClick="Button3_Click" />

            <asp:Button ID="Button4" runat="server" Text="Button" OnClick="Button4_Click" />

        </div>

    </form>
</body>
</html>
