<%@ Page Language="C#" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>


<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {

        string date = DateTime.Now.ToString("yyyy-MM-dd-HH-MM");

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
        </div>
    </form>
</body>
</html>
