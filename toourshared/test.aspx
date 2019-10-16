<%@ Page Language="C#" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>


<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {

        string date = DateTime.Now.ToString("yyyy-MM-dd");

        CommentDao com = new CommentDao();

        Comment comment = new Comment();

        comment.Cmt_content = TextBox1.Text;
        comment.Trv_no = "1";
        comment.Cmt_rate = TextBox2.Text;
        comment.Cmt_timestamp = date;

        com.InsertComment(comment);





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



            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
