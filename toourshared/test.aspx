<%@ Page Language="C#" %>
<%@ Import Namespace ="toourshared.Lib" %>
<%@ Import Namespace ="toourshared.Dao" %>
<%@ Import Namespace ="toourshared.Dto" %>
<%@ Import Namespace ="MySql.Data.MySqlClient" %>


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

            string Sql = "INSERT INTO toourshared.travel (trv_secret, trv_views, trv_tot_rate, trv_main_img, trv_title, trv_tag, trv_timestamp, trv_create_time, loc_name, mem_id)" +
                "VALUES (@trv_secret, @trv_views, @trv_tot_rate, @trv_main_img, @trv_title, @trv_tag, @trv_timestamp, @trv_create_time, @loc_name,@mem_id)";

            MySqlCommand cmd = new MySqlCommand(Sql, con);

            cmd.Parameters.AddWithValue("@trv_secret", travel.Trv_secret);
            cmd.Parameters.AddWithValue("@trv_views", travel.Trv_views);
            cmd.Parameters.AddWithValue("@trv_tot_rate", travel.Trv_tot_rate);
            cmd.Parameters.AddWithValue("@trv_main_img", travel.Trv_main_img);
            cmd.Parameters.AddWithValue("@trv_title", travel.Trv_title);
            cmd.Parameters.AddWithValue("@trv_tag", travel.Trv_tag);



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
