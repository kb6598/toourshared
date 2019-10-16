<%@ Page Language="C#" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>


<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {

        string date = DateTime.Now.ToString("yyyy-MM-dd");

        //CommentDao com = new CommentDao();

        Comment comment = new Comment();

        comment.Cmt_content = TextBox1.Text;
        comment.Trv_no = "1";
        comment.Cmt_rate = TextBox2.Text;
        comment.Cmt_timestamp = date;

        //com.InsertComment(comment);

        MyDB myDB = new MyDB();
            MySqlConnection con = myDB.GetCon();



            string Sql = "INSERT INTO toourshared.comment (trv_no, cmt_content, cmt_rate, cmt_timestamp) VALUES(@trv_no, @cmt_content, @cmt_rate, @cmt_timestamp)";
            MySqlCommand cmd = new MySqlCommand(Sql, con);


            cmd.Parameters.AddWithValue("@trv_no", comment.Trv_no);
            cmd.Parameters.AddWithValue("@cmt_content", comment.Cmt_content);
            cmd.Parameters.AddWithValue("@cmt_rate", comment.Cmt_rate);
            cmd.Parameters.AddWithValue("@cmt_timestamp", comment.Cmt_timestamp);



            con.Open();


            con.Close();

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
