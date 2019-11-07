<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button_selecttag_Click(object sender, EventArgs e)
    {

        List<Travel> travelList;
        Travel travel = new Travel();

        TravelDao tra = new TravelDao();

        travel.Trv_tag = txtTag.Text;
        string like = "'%" + txtTag.Text + "%'";





    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if(RadioButton1.Checked == true)
        //{
        //    List<Travel> travelList;
        //    Travel travel = new Travel();

        //    TravelDao tra = new TravelDao();


        //    travelList = tra.test(travel);

        //    txt1.Text = travelList[1].Trv_no;
        //    txt2.Text = travelList[1].Trv_title;
        //    txt3.Text = travelList[1].Trv_timestamp;
        //}
        //else if(RadioButton2.Checked == true)
        //{
        //    txt1.Text = "";
        //    txt2.Text = "";
        //    txt3.Text = "";
        //}



    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<Travel> travelList;
        Travel travel = new Travel();

        TravelDao tra = new TravelDao();

        travel.Loc_name = txtSearch.Text;
        travel.Trv_title = txtSearch.Text;
        travel.Trv_tag = txtSearch.Text;

        string loc = "'%" + travel.Loc_name + "%'";
        string title = "'%" + travel.Trv_title + "%'";
        string tag = "'%" + travel.Trv_tag + "%'";
        string date = "";
        string orderBy = "";

        if (rdbRecent.Checked == true)
        {
            orderBy = " order by trv_create_time desc ";
        }
        else if (rdbBest.Checked == true)
        {
            orderBy = " order by trv_tot_rate desc ";
        }
        else if (rdbFollower.Checked == true)
        {

        }
        else if (rdbHot.Checked == true)
        {
            date = " trv_create_time between trv_create_time -14 and trv_create_time and";
            orderBy = " order by trv_create_time desc ";
        }

        travelList = tra.selectAll(travel,date, loc, title, tag, orderBy);


        Literal1.Text = "";
        for (int i = 0; i < travelList.Count; i++)
        {
            int j = int.Parse(travelList[i].Trv_tot_rate);
            int count = travelList.Count;
            string star = "";
            if(j >= 5)
            {
                star = "★★★★★";
            }
            else if(j>=4 && j<5)
            {
                star = "★★★★☆";
            }
            else if(j>=3 && j<4)
            {
                star = "★★★☆☆";
            }
            else if(j>=2 && j<3)
            {
                star = "★★☆☆☆";
            }
            else if(j>=1 && j<2)
            {
                star = "★☆☆☆☆";
            }
            else if(j>=0 && j<1)
            {
                star = "☆☆☆☆☆";
            }


            Literal1.Text +=
                  "      <div class=\"boardArea\">                                                                                          " +
                  "          <div class=\"boardAlign\">                                                                                     " +
                  "              <div class=\"boardItem\">                                                                                  " +
                  "                  <div class=\"article1\">                                                                               " +
                  "                      <div class=\"boardImage\">                                                                         " +
                  "                          <a href=\"#\" data-toggle=\"modal\" data-target=\"#myModal\">                                  " +
                  "                              <img src = \"" + travelList[i].Trv_main_img + "\" alt=\"ㅁㄴㅇㅇㅁㅁㄴ \" class=\"boardImageItem\">         " +
                  "                          </a>                                                                                           " +
                  "                      </div>                                                                                             " +
                  "                      <div class=\"boardContent\">                                                                       " +
                  "                          <a href=\"#\" data-toggle=\"modal\" data-target=\"#myModal\">                                  " +
                  "                              <div class=\"boardTitle\">                                                                 " +
                  "                                  <span>"+ travelList[i].Trv_title +"</span>                                             " +
                  "                              </div>                                                                                     " +
                  "                          </a>                                                                                           " +
                  "                      </div>                                                                                             " +
                  "                  </div>                                                                                                 " +
                  "                  <div class=\"article2\">                                                                               " +
                  "                      <div class=\"boardUser\">                                                                          " +
                  "                          <div class=\"boardUserImage\">                                                                 " +
                  "                              <a href=\"#\">                                                                             " +
                  "                                  <img src=\"./img/UserNoneImage.png\" alt=\"userImage\" class=\"userImageItem\">        " +
                  "                              </a>                                                                                       " +
                  "                          </div>                                                                                         " +
                  "                          <div class=\"boardUserId\">                                                                    " +
                  "                              <a href=\"#\">                                                                             " +
                  "                                  <span>"+ travelList[i].Mem_id +"</span>                                                " +
                  "                              </a>                                                                                       " +
                  "                              <div class=\"boardUserTime\">                                                              " +
                  "                                  <span style=\"cursor: default;\">"+ travelList[i].Trv_create_time +"</span>            " +
                  "                              </div>                                                                                     " +
                  "                          </div>                                                                                         " +
                  "                          <div class=\"boardScore\" style=\"cursor: default;\">                                          " +
                  "                              <span class=\"Score1\">"+star+"</span>                                                       " +
                  "                              <span class=\"Score3\">("+ travelList[i].Trv_tot_rate +")</span>                           " +
                  "                          </div>                                                                                         " +
                  "                      </div>                                                                                             " +
                  "                  </div>                                                                                                 " +
                  "              </div>                                                                                                     " +
                  "          </div>                                                                                                         " +
                  "      </div>";


            int pageNo = 1;
            int countList = 5; // 한 화면에 출력될 게시글 수
            int countPage = 10; // 한 화면에 출력될 페이지 수
            int totalCount = travelList.Count; // 전체 count수
            int totalPage = totalCount / countList; // 전체 페이지 수

            int startPage = (totalPage / 10) * 10 + 1;
            if (totalPage % 10 == 0) startPage -= 10;
            int targetPage = totalPage;
            if(startPage != 1)
            {
                Response.Write($"<a href = \"test2.aspx?totalPage={startPage - 1}\">[이전]</a>");
            }
            else
            {

            }
            for(int z = startPage; z < totalPage; z++)
            {
                Response.Write($"<a href = \"test2.aspx?totalPage={z}\">{z}</a>");
            }


        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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

    <!-- kakodev -->
      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>

    <style>
        html,
        body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
        }

        .main {
            width: 100%;
            height: 100%;

            overflow: hidden;
            position: absolute;
        }

        .searchBar {
            /*width: 100%;
            height: 100%;*/
            display: flex;
            flex-direction: row;

            z-index: 1;
            position: absolute;
        }

        #mapArea {
            width: 100%;
            height: 100%;

            
            background-size: cover;
            background-repeat: no-repeat;
            z-index: 0;
        }

        .sideBar {
            width: 360px;
            height: 850px;
            margin: 15px 0 15px 15px;

            display: flex;
            flex-direction: column;

            border: 1px solid rgba(0, 0, 0, 0.1);
            border-top-left-radius: 4px;
            border-bottom-left-radius: 4px;
            border-bottom-right-radius: 4px;
            background-color: #fff;
            background-clip: padding-box;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            transition-duration: .5s;
        }

        .sideBarBtn {
            width: auto;
            height: 100%;
            margin-top: 15px;
            margin-left: -1px;

            display: flex;
        }

        .sideBarBtn input[type="button"] {
            width: 50px;
            height: 50px;

            color: white;
            font-size: 15px;
            font-weight: bold;

            outline: none;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
            background-color: rgba(0, 185, 241, 0.8);
            transition-duration: .5s;
        }

        .sideBarBtn input[type="button"]:hover {
            transition-duration: .5s;
            background-color: rgba(0, 185, 241, 1);
        }

        .sideBarHome {
            width: auto;
            height: 100%;
            margin-top: 15px;
            margin-left: 15px;

            display: flex;
        }

        .sideBarHome button {
            width: auto;
            height: 50px;

            font-size: 18px;
            padding: 0 10px;
            font-family: 'Mansalva', cursive;

            outline: none;
            border-radius: 4px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            color: white;
            background-color: rgba(0, 185, 241, 0.8);
            transition-duration: .5s;
        }

        .sideBarHome button:hover {
            transition-duration: .5s;
            background-color: rgba(0, 185, 241, 1);
        }

        .sideBarHome .homeBtn {
            width: auto;
            height: 50px;

            font-size: 18px;
            padding: 0 10px;
            font-family: 'Mansalva', cursive;

            outline: none;
            border-radius: 4px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            color: white;
            background-color: rgba(0, 185, 241, 0.8);
            transition-duration: .5s;
        }

        .sideBarHome .homeBtn:hover {
            transition-duration: .5s;
            background-color: rgba(0, 185, 241, 1);
        }

        .header {
            width: 100%;
            height: 50px;

            border-top-left-radius: 4px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);

            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            transition-duration: .5s;
        }

        .iconBtnArea {
            width: 15%;
        }

        .iconBtnArea button {
            width: 100%;
            height: 100%;
            font-size: 13px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
            cursor: pointer;
            background-color: transparent;
        }

        .inputArea {
            width: 85%;
        }

        .inputArea input {
            width: 100%;
            height: 100%;
            padding: 10px;
            color: rgba(0, 0, 0, 0.7);
            border: none;
            outline: none;
        }

        .contents {
            transition-duration: .5s;
            width: 100%;
            height: 85%;
            display: flex;
            flex-direction: column;
        }

        .contentsArea {
            width: 100%;
            height: 100%;

            display: flex;
            flex-direction: column;
        }

        .orderArea {
            transition-duration: .5s;
            width: 100%;
            height: auto;
            padding: 15px 10px 0px;
        }

        .orderRadio {
            width: 100%;
            padding-bottom: 25px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .orderRadioItem {
            width: auto;
            height: auto;
            padding: 0 10px;

            font-size: 15px;
            font-weight: 300;
        }

        .orderRadioItem input[type="radio"] {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            border: 0;
        }

        .orderRadioItem input[type="radio"]+label {
            display: inline-block;
            position: relative;
            padding-left: 23px;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
        }

        .orderRadioItem input[type="radio"]+label:before {
            content: '';
            position: absolute;
            left: 0;
            top: 2px;
            width: 17px;
            height: 17px;
            text-align: center;
            background: #fff;
            border: 1px solid #cacece;
            border-radius: 100%;
        }

        .orderRadioItem input[type="radio"]:checked+label:before {
            background: #fff;
            border-color: #adb8c0;
        }

        .orderRadioItem input[type="radio"]:checked+label:after {
            content: '';
            position: absolute;
            top: 2px;
            left: 0px;
            width: 17px;
            height: 17px;
            border: 5px solid deepskyblue;
            background-color: transparent;
            border-radius: 100%;
        }

        .orTxt {
            font-size: 15px;
            font-weight: bold;
            padding: 8px 10px;
            color: rgba(0, 0, 0, 0.7);
        }

        .boardArea {
            width: 100%;
            height: 100%;
            padding: 0 10px;
            word-spacing: -2px;
        }

        .boardAlign {
            width: 100%;
            height: 100%;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            overflow: auto;
        }

        .boardItem {
            display: flex;
            flex-direction: column;
            padding: 10px 0px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .article1 {
            width: 100%;
            height: auto;
            display: flex;
            flex-direction: column;
        }

        .boardImage {
            width: 100%;
            height: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .boardImageItem {
            width: 300px;
            height: 190px;
            border-radius: 5px;
        }

        .boardContent {
            width: 100%;
            height: 100%;
            padding: 5px 10px 0;
        }

        .boardContent>a {
            transition-duration: .5s;
            text-decoration: none;
        }

        .boardTitle {
            transition-duration: .2s;
            color: black;
            width: 100%;
            font-size: 15px;
            font-weight: 700;
        }

        .boardBody {
            width: 100%;
            height: 30px;

            overflow: auto;
            color: rgba(0, 0, 0, 0.5);
            font-size: 13px;
        }

        .article2 {
            width: 100%;
            height: 20%;

            display: flex;
            flex-direction: row;
        }

        .boardUser {
            width: 100%;
            height: 100%;
            padding: 10px;
            display: flex;
            flex-direction: row;
            align-items: center;
        }

        .userImageItem {
            width: 40px;
            height: 40px;
            border-radius: 100%;
        }

        .boardUserId {
            font-size: 15px;
            font-weight: 300;
            padding: 0px 10px;
        }

        .boardUserId>a {
            color: black;
            text-decoration: none;
        }

        .boardUserTime {
            font-size: 13px;
        }

        .boardScore {
            width: 50%;
            height: 100%;

            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;

            font-size: 14.5px;
        }

        .boardScore>.Score1 {
            font-size: 18px;
            color: darkorange;
        }

        .boardScore>.Score2 {
            font-size: 16px;
            color: orange;
        }

        .boardScore>.Score3 {
            display: inline-block;
            padding-top: 3px;
            font-size: 15px;
        }

        .footer {
            width: 100%;
            padding: 15px 0;
            transition-duration: .5s;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .pagination>a {
            width: auto;
            height: auto;

            color: black;
            font-size: 18px;
            font-weight: 300;
            text-decoration: none;
        }

        .pagination>a>li {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 40px;
            height: 40px;
            padding: 0 10px;
        }

        .pagination>a>li:hover {
            background-color: rgba(0, 0, 0, 0.08);
        }

        .modal {
            border: 2px solid red;
        }

        .modal-dialog {
            width: 100%;
            display: flex;
            flex-direction: row;
            z-index: 9999;
        }

        .modal-header {
            width: 100%;
            display: flex;
            flex-direction: column;
            background-color: #eee;
        }

        .modal-data {
            display: flex;
            flex-direction: column;
        }

        .modal-title-align {
            width: 100%;
            display: flex;
            flex-direction: row;
        }

        .modal-title-align2 {
            width: 100%;
            display: flex;
            flex-direction: row;
        }

        .modal-title {
            width: 740px;
            cursor: default;
            font-size: 28px;
            font-weight: 700;
        }

        .modal-close {
            display: inline-block;
            margin-top: -10px;
            outline: none;
        }

        .modal-time {
            height: auto;
            font-size: 17px;
            cursor: default;
            color: rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: row;
            align-items: center;
        }

        .modal-report {
            padding-left: 7px;
        }

        .modal-report a {
            font-size: 13px;
            color: firebrick;
            text-decoration: none;
            transition-duration: .5s;
        }

        .modal-report a:hover {
            color: red;
            transition-duration: .5s;
        }

        .modal-user {
            width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
        }

        .modal-user-image a>img {
            width: 35px;
            height: 35px;
            border-radius: 100%;
        }

        .modal-user-id {
            height: 100%;
            display: flex;
            padding-right: 10px;
        }

        .modal-user-id>a>span {
            display: inline-block;
            color: rgba(0, 0, 0, 0.8);
            padding-left: 5px;
            font-size: 20px;
            font-weight: 400;
        }

        .modal-score {
            width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
        }

        .modal-score .star {
            cursor: default;
            font-size: 19px;
            color: darkorange;
        }

        .modal-score .score {
            cursor: default;
            font-size: 15px;
            font-weight: 400;
            display: inline-block;
            padding-left: 5px;
            padding-top: 5px;
        }

        .modal-body {
            height: 500px;
            overflow: auto;
        }

        .modal-footer {
            padding: 0;
            height: 600px;
        }

        .footerContents {
            width: 100%;
            height: 100%;
        }

        .footerReadReply {
            width: 100%;
            height: 300px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            overflow: auto;
        }

        .replyHeader {
            width: 100%;
            height: 15%;
            background-color: #eee;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            padding-left: 15px;
            display: flex;
            flex-direction: row;
            align-items: center;
        }

        .replyTxt {
            display: inline-block;
            padding-right: 5px;
            font-weight: 500;
        }

        .replyAmt {
            display: inline-block;
            font-size: 20px;
            color: darkorange;
        }

        .replyContent {
            width: 100%;
            padding-right: 15px;
        }

        .replyItem {
            height: 140px;
            padding: 15px;
            display: flex;
            flex-direction: column;
            overflow: auto;
            border-bottom: 1px solid rgba(0, 0, 0, .1);
        }

        .replyAlign {
            width: 100%;
            height: 100%;
        }

        .replyUser {
            display: flex;
            flex-direction: row;
            align-items: center;
            
        }

        .replyImage {
            width: auto;
            height: auto;
            padding-right: 5px;
        }

        .replyImageItem {
            width: 30px;
            height: 30px;
            border-radius: 100%;
        }

        .replyId {
            width: auto;
            height: auto;
            padding-right: 5px;
        }

        .replyId a {
            font-size: 18px;
            font-weight: 400;
            color: rgba(0, 0, 0, 0.85);
            text-decoration: none;
        }

        .replyTime {
            cursor: default;
            display: inline-block;
            padding-top: 1px;
            padding-right: 15px;
        }

        .replyTime span {
            font-size: 13px;
        }

        .replyScore {
            width: auto;
            height: auto;
            cursor: default;
            display: inline-block;
            padding-bottom: 1px;
            padding-right: 15px;
        }

        .replyBody {
            padding: 10px 5px;
            font-size: 14px;
            font-weight: 350;
        }

        .replyScore .replyStar {
            font-size: 15px;
            color: darkorange;
        }

        .replyScore .replyText {
            font-size: 15px;
        }

        .replyCancle {
            width: 40px;
            height: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .replyCancle button {
            width: auto;
            height: auto;
            font-size: 11px;
            display: inline-block;
            margin-top: 3px;
        }

        .footerWriteReply {
            height: 300px;
            padding: 10px;
            border-bottom-left-radius: 4px;
            border-bottom-right-radius: 4px;
        }

        .footerWriteArea {
            width: 100%;
            height: 100%;
        }

        .footerInputArea {
            padding: 5px 5px 0;
        }

        .footerInputArea>textarea {
            width: 100%;
            height: 130px;
            outline: none;
            resize: none;
            color: rgba(0, 0, 0, 0.7);
            font-size: 18px;
            padding: 10px;
        }

        .inputScore {
            width: 100%;
            padding: 5px;
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
        }

        .scoreText {
            font-weight: 300;
            padding: 0 10px;
        }

        .scoreSelect select {
            width: 100px;
            height: 30px;
            outline: none;
            cursor: pointer;
            font-size: 13px;
        }

        .inputBtn {
            width: 100%;
            height: 80px;

            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 0 5px;
        }

        .inputBtnItem {
            width: 100px;
            height: 50px;
            outline: none;
            border: 1px solid rgba(0, 0, 0, 0.1);
            color: rgba(0, 0, 0, 0.5);
            background-color: rgba(255, 140, 0, 0.8);
            font-size: 13px;
            transition-duration: .5s;
        }

        .inputBtnItem:hover {
            transition-duration: .5s;
            color: rgba(0, 0, 0, 1);
            background-color: rgba(255, 140, 0, 1);
        }

        .modal-cost {
            top: 0;
            margin-top: 28px;
            padding-right: 127px;
            display: flex;
            justify-content: flex-end;
            width: 100%;
            position: fixed;
        }

        .modal-cost-area {
            width: 300px;
            height: 700px;
            border: 1px solid rgba(0, 0, 0, 0.6);
            background-color: #eee;
            border-radius: 4px;
            display: flex;
            flex-direction: column;
        }

        .cost-header {
            cursor: default;
            width: 100%;
            height: 80px;
            padding: 10px;
            background-color: #e2e2e2;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;

        }

        .cost-header .chTitle {
            font-size: 23px;
            font-weight: 700;
        }

        .cost-header .chBody {
            font-size: 15px;
        }

        .cost-body {
            width: 100%;
            height: 100%px;
            padding: 0px 10px 10px;
            overflow: auto;
        }

        .costItem {
            cursor: default;
            padding: 10px 0 5px;
            border-bottom: 1px dashed rgba(0, 0, 0, 0.2);
        }

        .costItem-header span {
            font-size: 40px;
            font-family: 'East Sea Dokdo', cursive;
        }

        .costItem-body ul {
            padding: 0 5px 0 20px;
            list-style-type: circle;
        }

        .costItem-body li {
            font-size: 12px;
        }

        #reportContent {
            width: 300px;
            margin-top: 200px;
            background-color: #eee;
            border: 1px solid rgba(0, 0, 0, 0.2);
        }

        .reportHeader {
            width: 100%;
            height: 50px;
            display: flex;
            cursor: default;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            color: white;
            background-color: #282c37;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }

        .reportHeader span {
            font-size: 15px;
            font-weight: 300;
        }

        .reportBody {
            width: 100%;
            height: 200px;
            background-color: #9baec8;
        }

        .reportBodyItem1 {
            width: 100%;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px 0;
        }

        .reportBodyItem1 span {
            font-size: 13px;
        }

        .reportBodyItem2 {
            width: 100%;
            height: 150px;
            display: flex;
            flex-direction: row;
            justify-content: center;
        }

        .reportBodyItem2 textarea {
            width: 250px;
            height: 130px;
            font-size: 13px;
            padding: 10px;
            outline: none;
            resize: none;
            color: rgba(0, 0, 0, 0.7);
            border: 1px solid rgba(0, 0, 0, 0.1);
            background-color: #d9e1e8;
        }

        .reportFooter {
            width: 100%;
            height: 50px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        .reportFooterItem1 {
            padding: 10px 5px 10px 10px;
        }

        .reportFooterItem2 {
            padding: 10px 10px 10px 5px;
        }

        .reportFooterItem1 button {
            width: 70px;
            height: 30px;
            color: #fff;
            outline: none;
            font-size: 12px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 3px;
            background-color: #2b90d9;
        }

        .reportFooterItem2 button {
            width: 70px;
            height: 30px;
            color: #fff;
            outline: none;
            font-size: 12px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 3px;
            background-color: #ff5f2e;
        }

    </style>

    <script>
            function sidebarSwitch() {
            var chk = document.getElementById("contents");

            if (chk.style.display != 'none') {
                document.getElementById("contents").style.display = "none";
            document.getElementById("footer").style.display = "none";
            $('.orderArea').height("0px");
            $('.boardArea').height("0px");
            $('.footer').height("0px");
            $('#sideBar').height("48px");
            $('#sideBarBtnItem').val("▼");
            } else {
                document.getElementById("contents").style.display = "flex";
                document.getElementById("footer").style.display = "flex";
            $('.orderArea').height("auto");
            $('.boardArea').height("100%");
            $('.footer').height("50px");
            $('#sideBar').height("850px");
            $('#sideBarBtnItem').val("▲");
        }
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            태그로 검색하기
            <asp:TextBox ID="txtTag" runat="server"></asp:TextBox><br />
            <asp:Button ID="Button_selecttag" runat="server" Text="Button" OnClick="Button_selecttag_Click" />
            <br />
            결과
            <asp:TextBox ID="txt1" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt2" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt3" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt4" runat="server"></asp:TextBox>
            <br />
           
            

            <div class="searchBar">

            <div class="sideBar" id="sideBar">
                <div class="header" id="header">
                    <div class="iconBtnArea">
                        <asp:Button ID="btnSearch" runat="server" Text="검색" OnClick="btnSearch_Click" />
                    </div>
                    <div class="inputArea">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="리뷰를 볼 지역을 입력하세요"></asp:TextBox>
                    </div>
                </div>
                <div class="contents" id="contents">
                    <div class="contentsArea">
                        <div class="orderArea">
                            <div class="orderRadio">
                                <p class="orTxt"><i class="far fa-window-restore"></i> 검색 기준</p>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="rdbRecent" runat="server" GroupName="select"  Checked="true"/> 최신순
                                        </td>
                                        <td>
                                            <asp:RadioButton ID="rdbBest" runat="server" GroupName="select" /> 인기순
                                        </td>
                                        <td>
                                            <asp:RadioButton ID="rdbFollower" runat="server" GroupName="select" /> 팔로워
                                        </td>
                                        <td>
                                            <asp:RadioButton ID="rdbHot" runat="server" GroupName="select" /> HOT
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="boardAlign">
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>
                <div class="footer" id="footer">
                    <div class="footerArea">
                        <div class="footerItem">
                            <ul class="pagination">
                                <a href="#">
                                    <li>
                                        <</li> </a> <a href="#">
                                    <li class="pageActive">1</li>
                                </a>
                                <a href="#">
                                    <li>2</li>
                                </a>
                                <a href="#">
                                    <li>3</li>
                                </a>
                                <a href="#">
                                    <li>4</li>
                                </a>
                                <a href="#">
                                    <li>5</li>
                                </a>
                                <a href="#">
                                    <li>></li>
                                </a>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
                <div class="sideBarBtn" id="sideBarBtn">
                <input type="button" id="sideBarBtnItem" onClick="sidebarSwitch()" value="▲" />

            </div>
        </div>
    </form>
</body>
</html>
