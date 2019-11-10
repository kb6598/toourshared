<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">
    // 내가 작성한글, 내가 팔로일하는 사람의 글, 나를 팔로우 하는 사람의 글
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("/index.aspx");
    }

    protected void btnMypage_Click(object sender, EventArgs e)
    {
        Response.Redirect("/MyPage.aspx");
    }

    protected void btnJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("/join.aspx");
    }

    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("/find_idpw.aspx");
    }

    protected List<Travel> getArticleList(string mem_id)
    {
        List<Travel> resultList;
        Travel travelIn = new Travel();
        TravelDao travelDao = new TravelDao();

        travelIn.Mem_id = mem_id;
        resultList = travelDao.selectTravelListByMem_id(travelIn);
        //resultDataset = travelDao.SelectTravel();


        return resultList;

    }

    protected void Bind_Table_Travel()
    {
        List<Travel> resultList = getArticleList("billip");

        TableRow tmpTableRow_article;
        TableCell tmpTableCell_article1;
        TableCell tmpTableCell_article2;
        TableCell tmpTableCell_article3;


        for (int i = 0; i < resultList.Count - 1; i++)
        {


            tmpTableCell_article1 = new TableCell();
            tmpTableCell_article1.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + resultList[i].Trv_main_img + "\" alt= \""+ resultList[i].Trv_title + "\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Trv_tot_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span> x3" +
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> x5" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article2 = new TableCell();
            tmpTableCell_article2.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + resultList[i].Trv_main_img + "\" alt= \""+ resultList[i].Trv_title + "\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Trv_tot_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span> x3" +
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> x5" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);
                tmpTableRow_article.Cells.Add(tmpTableCell_article2);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article3 = new TableCell();
            tmpTableCell_article3.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + resultList[i].Trv_main_img + "\" alt= \""+ resultList[i].Trv_title + "\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Trv_tot_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span> x3" +
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> x5" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";


            tmpTableRow_article = new TableRow();
            tmpTableRow_article.Cells.Add(tmpTableCell_article1);
            tmpTableRow_article.Cells.Add(tmpTableCell_article2);
            tmpTableRow_article.Cells.Add(tmpTableCell_article3);
            Table_travel.Rows.Add(tmpTableRow_article);
        }
    }
    protected List<Comment> getReviewsList(string mem_id)
    {
        List<Comment> resultList;
        Comment Input = new Comment();
        CommentDao dao = new CommentDao();

        Input.Mem_id = mem_id;
        resultList = dao.selectCommentListByMem_id(Input);
        //resultDataset = travelDao.SelectTravel();


        return resultList;
    }

    protected string getTrv_Main_Img(string trv_no)
    {
        string result;
        Travel Input = new Travel();
        Travel output = new Travel();
        TravelDao dao = new TravelDao();

        Input.Trv_no = trv_no;
        output = dao.selectTravelBytrv_no(Input);

        result = output.Trv_main_img;

        return result;
    }

    protected void Bind_Table_MyReviews()
    {
        List<Comment> resultList = getReviewsList("billip");

        TableRow tmpTableRow_article;
        TableCell tmpTableCell_article1;
        TableCell tmpTableCell_article2;
        TableCell tmpTableCell_article3;


        for (int i = 0; i < resultList.Count - 1; i++)
        {
            tmpTableCell_article1 = new TableCell();
            tmpTableCell_article1.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + getTrv_Main_Img(resultList[i].Trv_no) + "\" alt= \""+ resultList[i].Cmt_no + "\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Cmt_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span>" +resultList[i].Cmt_content+
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> " + resultList[i].Cmt_timestamp+
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article2 = new TableCell();
            tmpTableCell_article2.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + getTrv_Main_Img(resultList[i].Trv_no) + "\" alt= \""+ resultList[i].Cmt_no + "\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Cmt_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span>" +resultList[i].Cmt_content+
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> " + resultList[i].Cmt_timestamp+
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";
            i++;
            if (i == resultList.Count)
            {
                tmpTableRow_article = new TableRow();
                tmpTableRow_article.Cells.Add(tmpTableCell_article1);
                tmpTableRow_article.Cells.Add(tmpTableCell_article2);

                Table_travel.Rows.Add(tmpTableRow_article);
                break;
            }
            tmpTableCell_article3 = new TableCell();
            tmpTableCell_article3.Text = "<a href = \"#\" alt = \"bg2\">" +
                                            "<div class = \"tableContainer\" >" +
                                            "<img src = \"" + getTrv_Main_Img(resultList[i].Trv_no) + "\" alt= \""+ resultList[i].Cmt_no + "\" >" +
                                                "<div class = \"tableOverlay\" >" +
                                                    "<div class = \"tableText\" >" +
                                                        "<div class = \"tableAlign\">" +
                                                            "<div class = \"star\">" +
                                                                "<span>☆</span>" + resultList[i].Cmt_rate +
                                                            "</div>" +
                                                            "<div class = \"good\">" +
                                                                "<span><i class= \"far fa-thumbs-up\" ></i></span>" +resultList[i].Cmt_content+
                                                            "</div>" +
                                                            "<div class = \"reply\">" +
                                                                "<span><i class= \"fa fa-comment-o\" ></i></span> " + resultList[i].Cmt_timestamp+
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</a>";


            tmpTableRow_article = new TableRow();
            tmpTableRow_article.Cells.Add(tmpTableCell_article1);
            tmpTableRow_article.Cells.Add(tmpTableCell_article2);
            tmpTableRow_article.Cells.Add(tmpTableCell_article3);
            Table_MyReviews.Rows.Add(tmpTableRow_article);
        }
    }

    protected List<Travel> getFollowersTravelList(string mem_id ,int start, int count)
    {
        Member input = new Member();
        List<Travel> resultList= new List<Travel>();
        MyPageDao dao = new MyPageDao();
        input.Mem_id = mem_id;

        resultList = dao.Test();

        return resultList;
    }

    protected string testing()
    {
        int start = 0, count = 7;
        List < Travel >  resultList = getFollowersTravelList("milk9503",start, count);

        int indexCount = 0;
        int trCount = 0;
        String returnStr = "<table>\n   <tr>\n";

        Boolean debugTest = false;

        for (int i = 0; i < resultList.Count; i++)
        {
            returnStr += "      <td>\n" +
                    "           <a href = \"#\" alt = \"bg2\">\n" +
            "           <div class = \"tableContainer\" >\n";

            if(resultList[indexCount].Trv_main_img == "noImage")
            {
                returnStr += "               " + resultList[indexCount].Trv_main_img.ToString() + " " + System.IO.File.Exists(resultList[indexCount].Trv_main_img) + " <br/><img src = \"./img/memerNoImage.png\" alt= \"" + resultList[indexCount].Trv_title + "\" >\n";
            }
            else
            {
                returnStr += "               " + resultList[indexCount].Trv_main_img.ToString() + "<br/><img src = \"" + resultList[indexCount].Trv_main_img + "\" alt= \"" + resultList[indexCount].Trv_title + "\" >\n";
            }

            returnStr += "                   <div class = \"tableOverlay\" >\n" +
            "                       <div class = \"tableText\" >\n" +
            "                           <div class = \"tableAlign\">\n" +
            "                               <div class = \"star\">\n" +
            "                                   <span>☆</span>" + resultList[indexCount++].Trv_tot_rate + "\n" +
            "                               </div>\n" +
            "                               <div class = \"good\">\n" +
            "                                   <span><i class= \"far fa-thumbs-up\" ></i></span> x3\n" +
            "                               </div>\n" +
            "                               <div class = \"reply\">\n" +
            "                                   <span><i class= \"fa fa-comment-o\" ></i></span> x5\n" +
            "                               </div>\n" +
            "                       </div>\n" +
            "                   </div>\n" +
            "                   </div>\n" +
            "               </div>\n" +
            "           </a>\n" +
            "       </td>\n";

            trCount++;
            if (trCount == 3)
            {
                trCount = 0;
                returnStr += "  </tr>\n <tr>\n";
            }
        }

        returnStr += "  </tr>\n</table>";
        return returnStr;

    }

    protected void Page_Load(object sender, EventArgs e)
    {
         // 테스트 코드 이미지 업로드가 session["mem_id"]에 종속됨
        if(HttpContext.Current.Session["mem_id"] == null)
        {
            Session["mem_id"] = "billip";
        }

        Bind_Table_Travel();
        Bind_Table_MyReviews();
        selectMyInfo();


    }

    protected void selectMyInfo()
    {
        Member member = new Member();
        MemberDao mem = new MemberDao();
        if(Session["mem_id"] != null)
        {
            member.Mem_id = Session["mem_id"].ToString();
            member = mem.selectMemberByMem_id(member);

            string id = member.Mem_id.ToString();
            string name = member.Mem_name.ToString();

            mem_id.Text = id;
            mem_name.Text = name;
        }
        else
        {

        }

    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED : MYPAGE</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|Jua&display=swap" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- Icon -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

       <!--파일 업로드-->   
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<style>
    html, body {
        margin: 0;
        padding: 0;
        list-style: none;
        line-height: 1;
        /* 전체 배경색 */
        background-color: #00b9f1;
        background-repeat: no-repeat;
    }

    .topnavUl {
        margin: 0;
        padding: 0;
        list-style: none;
        text-decoration: none;
        font-size: 20px;
        font-family: '맑은고딕';
    }

    .topnavLi {
        margin: 0;
        padding: 0;
        list-style: none;
        text-decoration: none;
        font-size: 20px;
        font-family: '맑은고딕';
    }

        .topnavLi ul, li {
            list-style: none;
            text-decoration: none;
            padding: 0;
            margin: 0;
        }

    a {
        color: white;
        text-decoration: none;
    }

    #nav {
        z-index: 99999;
        position: absolute;
        width: 100%;
        /* absolute는 부피를 못잡으니까 width 100% */
        overflow: hidden;
        font-size: 25px;
        transition-duration: 0.5s;
        position: fixed;
    }

        #nav:hover {
            height: 250px;
            transition: background .5s;
            background-color: rgba(249, 192, 12, 0.95);
        }

        #nav > ul {
            text-align: center;
            font-family: 'Mansalva', cursive;
            font-size: 25px;
        }

            #nav > ul > li {
                display: inline-block;
                position: relative;
                padding: 0px 50px;
            }

                #nav > ul > li > a {
                    display: block;
                    padding: 30px 15px 20px;
                    line-height: 30px;
                    transition: color 0.9s;
                    transition: background 0.4s;
                    /* 부트스트랩 적용 후 nav 효과 적용이 되는걸 방지하기 위해 */
                    text-decoration: none;
                    /* 상단 메뉴 글씨 색 */
                    color: white;
                }

                #nav > ul > li:hover > a {
                    /* 메뉴에 마우스 올렸을 때 발생할 스타일(1Depth) */
                    transition: border .5s;
                    border-bottom: 3px solid #ff7473;
                }

        #nav ul ul {
            /*display: none;*/
            position: absolute;
            width: 100%;
            /* absolute는 부피를 가질 수 없다 */
            margin: 0px -50px;
        }

            #nav ul ul a {
                /* 2Depth li Style */
                display: block;
                line-height: 40px;
                font-size: 14px;
                color: white;
            }

                #nav ul ul a:hover {
                    /* SubMenu 마우스 올렸을 때 발생할 스타일 */
                    font-weight: bold;
                    /* 부트스트랩 적용 후 nav 효과 적용이 되는걸 방지하기 위해 */
                    text-decoration: none;
                }

        #nav li:hover ul {
            display: block;
        }

        #nav li:nth-child(1) ul {
            left: 0;
            width: 100%;
        }

    .nav-logo {
        /* 웹 사이트 좌측 상단에 위치한 로고 div style */
    }

    .nav-logo-item {
        font-family: 'Mansalva', cursive;
        font-size: 25px;
        transition: .5s;
    }

        .nav-logo-item:hover {
            transition: font .5s;
            font-size: 27.5px;
            color: white;
            /* 부트스트랩 적용 후 텍스트에 적용되는 효과 방지를 위해 */
            text-decoration: none;
        }

    .nav-log-area {
        /* 로그인, 로그아웃 영역 */
        width: 150px;
        height: 40px;
        padding-bottom: 5px;
        border: 2px solid white;
        border-radius: 15px;
        transition: .5s;
    }

    .nav-log-item {
        font-size: 20px;
        border: none;
        outline: none;
        cursor: pointer;
        margin-top: 8px;
        color: white;
        background-color: transparent;
    }

    /* 창 크기 조절 시 nav display none 설정 */
    @media only screen and (max-width: 1600px) {
        .topnav {
            display: none;
        }

            .topnav > ul > li > .nav-logo > .nav-logo-item {
                float: left;
                display: block;
            }
    }

    .section {
        max-width: 935px;
        width: 100%;
        height: 75%;
        position: relative;
        margin: 0 auto 30px;
        padding-top: 150px;
    }

    .section01 {
        -webkit-box-flex: 1;
        -webkit-flex-grow: 1;
        -ms-flex-positive: 1;
        flex-grow: 1;
        margin: 0 auto 30px;
        display: flex;
        padding-bottom: 50px;
    }

    .userImage {
        width: 150px;
        height: 150px;
    }

    .userImageItem {
        width: 100%;
        height: 100%;
        position: absolute;
    }

    .userImageAlign {
        width: 150px;
        height: 150px;
        position: absolute;
    }

    .userImageItem .userImageStyle {
        width: 100%;
        height: 100%;
        padding: 0;
        margin: 0;
        border: none;
        cursor: pointer;
        border-radius: 100%;
    }

    .userData {
        color: #262626;
        -webkit-flex-shrink: 1;
        -ms-flex-negative: 1;
        flex-shrink: 1;
        min-width: 0;
    }

    .userDataAlign {
        padding-left: 150px;
        position: absolute;
    }

    .idAndSetting {
        width: 500px;
        display: flex;
        padding: 7px 15px 20px 0px;
    }

    .ID {
        width: 25%;
        display: block;
    }

        .ID h1 {
            font-size: 28px;
            margin: -5px 0px -6px;
            font-weight: 300;
        }

    .Setting {
        width: auto;
    }

    .settingButton {
        width: 115px;
        height: 30px;
        border: 1px solid white;
        border-radius: 5px;
        outline: none;
        color: white;
        background-color: transparent;
    }

    .data {
        width: 100%;
        display: flex;
        position: absolute;
        font-size: 18px;
    }

    .dataItem {
        width: auto;
        padding-right: 30px;
    }

        .dataItem span {
            font-weight: 500;
        }

    .name {
        padding-top: 40px;
        position: relative;
    }

        .name span {
            width: auto;
            height: auto;
            font-size: 20px;
            fotnt-weight: bold;
            font-family: 'Nanum Gothic', sans-serif;
        }

    .section02 {
        width: 935px;
        height: auto;
        padding-bottom: 155px;
    }

    .boardTap {
        width: 935px;
        border-top: 0.5px solid white;
        display: flex;
        flex-direction: row;
        justify-content: center;
    }

    .boardTapOpen {
        float: left;
        border: none;
        outline: none;
        cursor: pointer;
        padding: 14px 16px;
        width: auto;
        background-color: transparent;
    }

        /* get → border-top */
        .boardTapOpen:hover {
            margin-top: -1px;
            border-top: 1px solid black;
        }

    .boardTapTxt {
        color: white;
        font-size: 15px;
    }

    .boardContents {
        width: 100%;
        height: auto;
    }

    .boardItem {
        display: none;
        width: 935px;
        height: auto;
        color: #262626;
        background-color: rgba(255, 255, 255, 0);
    }

    .boardItemContent {
        width: 100%;
        height: 100%;
    }

    #boardItemDefault {
        width: 100%;
        height: 300px;
        display: block;
        background-color: snow;
        text-align: center;
    }

        #boardItemDefault div {
            padding-top: 15%;
            font-size: 18px;
            cursor: default;
        }

    .tableContainer {
        position: relative;
        width: 100%;
        height: auto;
    }

        .tableContainer img {
            display: block;
            width: 293px;
            height: 293px;
            margin-right: 25px;
            margin-bottom: 25px;
        }

    .tableOverlay {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background-color: rgba(0, 0, 0, 0.5);
        overflow: hidden;
        width: 293px;
        height: 0;
    }

    .tableContainer:hover .tableOverlay {
        height: 100%;
    }

    .tableText {
        color: white;
        font-size: 14px;
        position: absolute;
        top: 50%;
        left: 50%;
        -webkit-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
        text-align: center;
    }

        .tableText span {
            font-size: 15px;
            cursor: default;
        }

    .tableAlign div {
        padding: 3px 5px;
        text-align: left;
    }

        .tableAlign div span {
            padding-right: 7px;
        }

    .footer {
        width: 100%;
        height: 150px;
        position: relative;
        background-color: #272625;
    }

    .footerText {
        width: 100%;
        height: inherit;
        color: white;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        position: absolute;
    }
    .navJoinBtn{
            border: none;
            outline: none;
            background-color: transparent;
            color: white;
            font-size: 14px;
            padding-bottom: 20px;
        }

        .navFindBtn:hover, .navJoinBtn:hover{
            font-weight: bold;
        }

        .navFindBtn{
            border: none;
            outline: none;
            background-color: transparent;
            color: white;
            font-size: 14px;
        }
</style>
<script>
    /* scroll할 때 발생할 이벤트 */
    window.onscroll = function () {
        scrollFunction();
    }

    function scrollFunction() {
        var nav = $("nav");
        var v_scroll = $(window).scrollTop();

        if (v_scroll >= 20) {
            document.getElementById("nav").style.background = "rgba(249, 192, 12, 0.95)";
        } else if (v_scroll <= 0) {
            document.getElementById("nav").style.background = "";
        }
    }

    /* Tab 이벤트 */
    function openPage(pageName, elmnt) {
        var i, boardItem, boardTapOpens;
        boardItem = document.getElementsByClassName("boardItem");

        for (i = 0; i < boardItem.length; i++) {
            boardItem[i].style.display = "none";
        }

        boardTapOpens = document.getElementsByClassName("boardTapOpen");
        document.getElementById(pageName).style.display = "block";
        document.getElementById("boardItemDefault").style.display = "none";
    }

    document.getElementById("defaultOpen").click();		
</script>
</head>
     <!-- navbar 영역 -->
    <body>
    <form name="form1" runat="server">
 <div id="nav" class="topnav">
        <ul class="topnavUl">
            <li class="topnavLi">
                <div class="nav-logo">
                    <a href="index.aspx" class="nav-logo-item">To Our Shared</a>
                </div>
            </li>
            <li class="topnavLi">
                <a>Intro</a>
                <ul>
                    <li><a href="#">TOUPLE</a></li>
                </ul>
            </li>
            <li class="topnavLi">
                <a>Shared</a>
                <ul>
                    <li><a href="search.aspx">검색</a></li>
                </ul>
            </li>
            <li class="topnavLi">
                <a>Event</a>
                <ul>
                    <li><a>진행중인 이벤트</a></li>
                    <li><a>종료된 이벤트</a></li>
                </ul>
            </li>
            <li class="topnavLi">
                <a>Help</a>
                <ul>
                    <li><a href="FAQ.aspx">자주 찾는 질문</a></li>
                </ul>
            </li>
        <% 
            if (IsLogin.isLogin() == false)
            {
        %>
            <li class="topnavLi">
                <div class="nav-log">
                    <a>
                        <div class="nav-log-area">
                            <asp:Button ID="btnLogin" runat="server" Text="로그인" CssClass="nav-log-item" PostBackUrl="~/login.aspx"/>
                        </div>
                    </a>
                </div>
                <ul>
                    <br />
                    <li><asp:Button ID="btnJoin" runat="server" Text="회원가입" OnClick="btnJoin_Click" /></li>
                    <li><asp:Button ID="btnFindIDPW" runat="server" Text="계정찾기" OnClick="btnFindIDPW_Click" /></li>
                </ul>
            </li>
        <%  
            }
            else
            {
        %>
            <li class = "topnavLi" >
				<a href = "#" ><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                <ul>
                    <li><asp:Button ID="btnMypage" runat="server" Text="마이페이지" OnClick="btnMypage_Click" class="navJoinBtn"/></li>
                    <li><asp:Button ID="btnLogout" runat="server" Text="로그아웃" OnClick="btnLogout_Click" class="navFindBtn"/></li>

                </ul>
            </li>
        <% 
            }
        %>
        </ul>
    </div>
      

   
        <div class="section">
            <!-- UserProfile -->
            <div class="section01">
                <div class="userImage">
                    <div class="userImageAlign">
                        <div class="userImageItem">
                            <a href="#">
                             <!-- 이미지 업로드 -->
                            <input type="file" class="upload"  id="FileUpload_main_img" accept="image/*" multiple="false" style="display:none;"/>
                            <asp:HiddenField ID="main_img" runat="server" Value="noImage"/>
                                 <!-- 이미지 미리보기 부분-->
                                <!-- 이미지 미리보기 부분-->
                        <asp:Image ID="mainImgItem" runat="server" ImageUrl="./img/UserNoneImage.png" alt="프로	필 사진 편집" CssClass="userImageStyle" onclick="document.getElementById('FileUpload_main_img').click();"/>
                        

                 
                            </a>
                        </div>
                    </div>
                </div>
                <div class="userData">
                    <div class="userDataAlign">
                        <div class="idAndSetting">
                            <div class="ID">
                                <h1>
                                    <asp:Label ID="mem_id" runat="server" Text="Label"></asp:Label></h1>
                            </div>
                            <div class="Setting">
                                <input type="button" value="프로필 편집" class="settingButton" onclick="location.href = '/edit.aspx' "/>
                            </div>
                        </div>
                        <div class="data">
                            <div class="dataItem">
                                게시물 <span>0</span>
                            </div>
                            <div class="dataItem">
                                팔로워 <span>10</span>
                            </div>
                            <div class="dataItem">
                                팔로우 <span>10</span>
                            </div>
                        </div>
                        <div class="name">
                            <span>
                                <asp:Label ID="mem_name" runat="server" Text="Label"></asp:Label></span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Board -->
            <div class="section02">

                <!-- boardTap -->
                <div class="boardTap">
                    <a
                        class="boardTapOpen" onclick="openPage('MyTravels', this)">
                        <span class="boardTapTxt">▦ My Travels</span>
                    </a>
                    <a class="boardTapOpen" onclick="openPage('MyReviews', this)">
                        <span class="boardTapTxt">▦ My Reviews</span>
                    </a>
                    <a class="boardTapOpen" onclick="openPage('FollowingTouple', this)">
                        <span class="boardTapTxt">▦ Following Touple</span>
                    </a>
                </div>
            </div>

            <!-- boardContents -->
            <div class="boardContents">
                <div id="boardItemDefault">
                    <div>작성된 게시글이 없습니다.</div>
                </div>
                <div id="MyTravels" class="boardItem">
                    <div class="boardItemContent">

                        <asp:Table ID="Table_travel" runat="server">
                        </asp:Table>

                    </div>
                </div>
                <div id="MyReviews" class="boardItem">

                        <asp:Table ID="Table_MyReviews" runat="server">
                        </asp:Table>
                </div>
                <div id="FollowingTouple" class="boardItem">
                    <% Response.Write(testing()); %>
                </div>
            </div>
        </div>


        <!-- 바닥글 영역 -->
        <div class="footer">
            <div class="footerText">
                ㅂㄷㄱ
            </div>
        </div>
    </form>


        <script>
            //이미지 업로드 AJAX
             // 이미지 업로드가 session["mem_id"]에 종속됨 없으면 업로드 불가
            function sendFile(file) {

                var formData = new FormData();
                formData.append('file', $('#FileUpload_main_img')[0].files[0]);
                $.ajax({
                    type: 'post',
                    url: 'imageUploader.ashx',
                    data: formData,
                    success: function (status) {
                        if (status != 'error') {
                            var my_path = status;
                            $("#mainImgItem").attr("src", my_path);
                            $("#main_img").attr("value", my_path);
                        }
                    },
                    processData: false,
                    contentType: false,
                    error: function () {
                        alert("Whoops something went wrong!");
                    }
                });
            }

            var _URL = window.URL || window.webkitURL;
            $("#FileUpload_main_img").on('change', function () {

                var file, img;
                if ((file = this.files[0])) {
                    img = new Image();
                    img.onload = function () {
                        sendFile(file);
                    };
                    img.onerror = function () {
                        alert("Not a valid file:" + file.type);
                    };
                    img.src = _URL.createObjectURL(file);
                }

            });


        </script>

</body>
</html>
