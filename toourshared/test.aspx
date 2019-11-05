<%@ Page Language="C#" %>



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


        List<Question> resultList;
        Question question = new Question();
        QuestionDao qus = new QuestionDao();

        resultList = qus.selectAllQuestion(question);

        for(int i=0; i < resultList.Count; i++)
        {

            Literal1.Text+=                                                            
            "        <div class=\"FAQ_QUE_BOARD\" data-toggle=\"collapse\" data-target=\"#board"+i +"\">"+
            "            <div class=\"BOARDITEM1\">                                            "+
            "                <div class=\"BDNUMBER\">                                          "+
                                resultList[i].Qus_no+"</div>"                                  +
            "                <div class=\"BDTITLE\">                                           "+
                                resultList[i].Qus__title+"</div>"                              +
            "            </div>                                                              "+
            "            <div class=\"BOARDITEM2\">                                            "+
            "                <div id=\"board"+i+"\" class=\"collapse\">                              "+
            "                    <div class=\"ANSWER\">                                        " +
                                    resultList[i].Qus_ask                                    +
            "                                                                                " +
            "                    </div>                                                      " +
            "                </div>                                                          " +
            "            </div>                                                              " +
            "        </div>                                                                  ";
        }


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

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|East+Sea+Dokdo|Jua&display=swap" rel="stylesheet">

    <!-- ICON -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <style>

         .FAQ_QUE_CATEGORY {
            width: 900px;
            margin-left: 12px;
            padding-top: 20px;
            display: flex;
            flex-direction: row;
        }

        .FAQ_QUE_CATEGORY>div {
            margin: 0 2px;
        }

        .QUENUMBER {
            width: 10%;
            text-align: center;
            padding: 10px 0 5px;
            border-bottom: 3px solid orange;
            font-size: 18px;
            font-weight: 500;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .QUETITLE {
            width: 90%;
            text-align: center;
            padding: 10px 0 5px;
            border-bottom: 3px solid orange;
            font-size: 18px;
            font-weight: 500;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .FAQ_QUE_BOARD {
            width: 900px;
            display: flex;
            margin-left: 12px;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .FAQ_QUE_BOARD {
            width: 900px;
            margin-left: 12px;
            display: flex;
            flex-direction: column;
            cursor: pointer;
        }

        .BOARDITEM1 {
            width: 100%;
            display: flex;
            flex-direction: row;
        }

        .BOARDITEM1>div {
            margin: 0 2px;
            padding: 20px 0;
            text-align: center;
        }

        .BDNUMBER {
            width: 10%;
            font-size: 15px;
            border-bottom: .5px solid rgba(0, 0, 0, .5);
        }

        .BDTITLE {
            width: 90%;
            font-size: 15px;
            border-bottom: .5px solid rgba(0, 0, 0, .5);
        }

        .ANSWER {
            padding: 20px 5px;
            background-color: #eee;
            color: rgba(0, 0, 0, .5);
            margin: 0 1px;
        }
        
        .FAQ_INQUIRE{
            width: 100%;
            height: 150px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .FAQ_INQUIRE > span{
            padding: 0 3px;
        }
        
        .nm{
            font-size: 15px;
        }
        
        .em{
            width: 142px;
            height: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: default;
            color: #fff;
            font-size: 13px;
            font-weight: 300;
            border-radius: .4rem;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: rgba(0, 0, 0, .9);
            transition-duration: .5s;
        }
        
        .em:hover{
            font-size: 15px;
        }
        
        .footer {
            width: 100%;
            height: 250px;
            background-color: #272625;
        }
    </style>


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
            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>'
            
            <div class="FAQ_QUE_CATEGORY">
            <div class="QUENUMBER">번호</div>
            <div class="QUETITLE">제목</div> 
            </div>      
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            
 
        </div>

    </form>
</body>
</html>
