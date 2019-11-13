<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">

    //====== ( temp Init Area ) ==========
    string myID; // session(로그인 한 사람)의 아이디를 저장할 변수
    string memberID; // QueryString(페이지의 주인)의 아이디를 저장할 변수
    bool pageOwner = false; // MyPage의 주인인지 아닌지 여부를 나타낼 변수
    string memberName; // MyPage 주인의 이름을 저장할 변수
    string memberImageUrl; // MyPage 주인의 이미지가 나타날 변수
    int travelCount = 0; // MyPage 주인이 작성한 게시글의 총 수를 저장할 변수
    int followCount = 0; // MyPage 주인의 팔로우 카운트를 저장할 변수
    int followerCount = 0; // MyPage 주인의 팔로워 카운트를 저장할 변수
    string pageType = ""; // MyPage 게시글 타입을 저장할 변수
    //============================

    // 로그아웃 눌렀을 때 발생할 이벤트
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("./index.aspx");
    }

    // 회원가입 눌렀을 때 발생할 이벤트
    protected void btnJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("./join.aspx");
    }

    // 계정찾기 눌렀을 때 발생할 이벤트
    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("./find_idpw.aspx");
    }

    //My Travels에 뿌려줄 양식
    protected string MyTravels()
    {
        if (Request.QueryString["mem_id"] == null)
        {
            return "";
        }
        else
        {
            string returnStr = "";
            string memberID = Request.QueryString["mem_id"].ToString(); // 현재 QueryString(mem_id)을 불러 변수에 담는다.
            Travel travel = new Travel();
            TravelDao travelDao = new TravelDao();

            travel.Mem_id = memberID;
            List<Travel> travelList = new List<Travel>();
            travelList = travelDao.selectTravelListByMem_id(travel, 0, 15); // 해당 아이디의 Travel들을 List형식으로 반환하는 함수를 통해 모든 게시글들을 긁어온다.

            Like Like = new Like();
            LikeDao likeDao = new LikeDao();

            Comment comment = new Comment();
            CommentDao commentDao = new CommentDao();

            returnStr += "" +
                "<table>\n" +
                "   <tr>\n";

            int trCount = 0;

            for (int i = 0; i < travelList.Count; i++)
            {
                string trvNo = travelList[i].Trv_no.ToString(); // index에 해당하는 Travel의 trv_no를 trvNo에 담고,
                string trvTotalRate = travelList[i].Trv_tot_rate.ToString(); // index에 해당하는 Travel의 trv_tot_rate를 trvTotalRate에 담고,

                Like.Trv_no = trvNo;
                string LikeCount = likeDao.selectLikeCountByTrvNo(Like).ToString(); // index에 해당하는 Travel의 like Count를 LikeCount에 담고,

                travel = travelList[i];
                string CommentCount = commentDao.selectCommentCountByTrvNo(travel).ToString(); // index에 해당하는 Travel의 comment Count를 CommentCount에 담고

                string travelImage = travel.Trv_main_img.ToString();
                if (string.IsNullOrEmpty(travelImage) || travelImage == "noImage")
                    travelImage = "./img/noImage.png";

                returnStr += "" +
                "		<td>\n" +
                "			<a href = \"./board.aspx?trv_no=" + trvNo.ToString() + "\">\n" +
                "				<div class = \"tableContainer\" >\n" +
                "				<img src = \"" + travelImage + "\" alt= \"NoImage\" />\n" +
                "					<div class = \"tableOverlay\">\n" +
                "						<div class = \"tableText\">\n" +
                "							<div class = \"tableAlign\">\n" +
                "								<div class = \"star\">\n" +
                "									<span>⭐</span>" + trvTotalRate.ToString() + "\n" +
                "								</div>\n" +
                "								<div class = \"good\">\n" +
                "									<span>👍</span>" + LikeCount.ToString() + "\n" +
                "								</div>\n" +
                "								<div class = \"reply\">\n" +
                "									<span>💬</span>" + CommentCount.ToString() + "\n" +
                "								</div>\n" +
                "							</div>\n" +
                "						</div>\n" +
                "					</div>\n" +
                "				</div>\n" +
                "			</a>\n" +
                "		</td>\n";

                trCount++;
                if (trCount >= 3)
                {
                    trCount = 0;
                    returnStr += "    </tr>\n <tr>\n";
                }
            }

            returnStr += "    </tr>\n</table>";
            return returnStr;
        }
    }

    //My Reviews에 뿌려줄 양식
    protected string MyReviews()
    {
        if (Request.QueryString["mem_id"] == null)
        {
            return "";
        }
        else
        {
            string returnStr = "";
            string memberID = Request.QueryString["mem_id"].ToString(); // 현재 QueryString(mem_id)을 불러 변수에 담는다.
            Travel travel = new Travel();
            TravelDao travelDao = new TravelDao();

            Comment comment = new Comment();
            CommentDao commentDao = new CommentDao();

            List<Travel> travelList = new List<Travel>();
            List<Comment> commentList = new List<Comment>();

            comment.Mem_id = memberID;
            commentList = commentDao.selectCommentListByMem_id(comment, 0, 15); // 해당 아이디의 Travel들을 List형식으로 반환하는 함수를 통해 모든 게시글들을 긁어온다.

            Like Like = new Like();
            LikeDao likeDao = new LikeDao();

            returnStr += "" +
                "<table>\n" +
                "   <tr>\n";

            int trCount = 0;

            for (int i = 0; i < commentList.Count; i++)
            {
                string trvNo = commentList[i].Trv_no.ToString(); // index에 해당하는 comment의 trv_no를 trvNo에 담고,

                string cmtContent = commentList[i].Cmt_content.ToString(); // 댓글 불러오고

                travel.Trv_no = trvNo.ToString();
                travel = travelDao.selectTravelBytrv_no(travel);
                string trvTotRate = travel.Trv_tot_rate.ToString(); // 평점을 불러오고,

                string CommentCount = commentDao.selectCommentCountByTrvNo(travel).ToString(); // 댓글 수 불러오고

                Like.Trv_no = trvNo;
                string LikeCount = likeDao.selectLikeCountByTrvNo(Like).ToString(); // 추천 수 불러오고


                string travelImage = travel.Trv_main_img.ToString();
                if (string.IsNullOrEmpty(travelImage) || travelImage == "noImage")
                    travelImage = "./img/noImage.png";

                returnStr += "" +
                "		<td>\n" +
                "			<a href = \"./board.aspx?trv_no=" + trvNo.ToString() + "\">\n" +
                "				<div class = \"tableContainer\" >\n" +
                "				<img src = \"" + travelImage + "\" alt= \"NoImage\" />\n" +
                "					<div class = \"tableOverlay\">\n" +
                "						<div class = \"tableText\">\n" +
                "							<div class = \"tableAlign\">\n" +
                "								<div class = \"star\">\n" +
                "									<span>⭐</span>" + trvTotRate.ToString() + " <span>👍</span>" + LikeCount.ToString() + " <span>💬</span>" + CommentCount.ToString() + "\n" +
                "								</div>\n" +
                "								<div class = \"cmtContent\">\n" +
                "                                   <span style=\"font-size: 13px; display: flex; justify-content: center;\">" + cmtContent.ToString() + "</span>\n" +
                "								</div>\n" +
                "							</div>\n" +
                "						</div>\n" +
                "					</div>\n" +
                "				</div>\n" +
                "			</a>\n" +
                "		</td>\n";

                trCount++;
                if (trCount >= 3)
                {
                    trCount = 0;
                    returnStr += "    </tr>\n <tr>\n";
                }
            }

            returnStr += "    </tr>\n</table>";
            return returnStr;
        }
    }

    //Following Touple에 뿌려줄 양식
    protected string FollowingTouples()
    {
        if (Request.QueryString["mem_id"] == null)
        {
            return "";
        }
        else
        {
            string returnStr = "";
            string memberID = Request.QueryString["mem_id"].ToString(); // 현재 QueryString(mem_id)을 불러 변수에 담는다.

            Follower follower = new Follower();
            FollowerDao followerDao = new FollowerDao();
            List<Follower> lists = new List<Follower>();

            follower.Mem_id = memberID;
            lists = followerDao.selectFollowListByMemID(follower, 1);

            Travel travel = new Travel();
            Like like = new Like();
            Comment comment = new Comment();
            TravelDao travelDao = new TravelDao();
            LikeDao likeDao = new LikeDao();
            CommentDao commentDao = new CommentDao();

            returnStr += "" +
                "<table>\n" +
                "   <tr>\n";

            int trCount = 0;

            for (int i = 0; i < lists.Count; i++)
            {
                string memID = lists[i].Mem_id.ToString(); // index에 해당하는 Follower의 Mem_id를 memID 변수에 담고,
                travel.Mem_id = memID;
                travel = travelDao.selectTravelByMemID(travel); // memID를 travel DTO에 담고 이를 파라미터로 넘겨 새로운 travel 객체를 반환받고

                string totRate = travel.Trv_tot_rate.ToString(); // travel 객체의 평점을 받고,

                like.Trv_no = travel.Trv_no; // trv_no를 like DTO에 담고
                string likeCount = likeDao.selectLikeCountByTrvNo(like).ToString(); // like DTO를 파라미터로 넘겨 likeCount 값을 받고

                string commentCount = commentDao.selectCommentCountByTrvNo(travel).ToString(); // travel DTO를 파라미터로 넘겨 commentCount 값을 받고

                string travelImage = travel.Trv_main_img.ToString(); // travel 객체의 메인 사진을 변수에 담고,
                if (string.IsNullOrEmpty(travelImage) || travelImage == "noImage") // null OR empty OR noImage인 경우
                    travelImage = "./img/noImage.png"; // 기본 noImage로 대체.

                returnStr += "" +
                "		<td>\n" +
                "			<a href = \"./board.aspx?trv_no=" + travel.Trv_no + "\">\n" +
                "				<div class = \"tableContainer\" >\n" +
                "				<img src = \"" + travelImage + "\" alt= \"NoImage\" />\n" +
                "					<div class = \"tableOverlay\">\n" +
                "						<div class = \"tableText\">\n" +
                "							<div class = \"tableAlign\">\n" +
                "								<div class = \"star\">\n" +
                "									<span>⭐</span>" + totRate.ToString() + "\n" +
                "								</div>\n" +
                "								<div class = \"good\">\n" +
                "									<span>👍</span>" + likeCount.ToString() + "\n" +
                "								</div>\n" +
                "								<div class = \"reply\">\n" +
                "									<span>💬</span>" + commentCount.ToString() + "\n" +
                "								</div>\n" +
                "							</div>\n" +
                "						</div>\n" +
                "					</div>\n" +
                "				</div>\n" +
                "			</a>\n" +
                "		</td>\n";

                trCount++;
                if (trCount >= 3)
                {
                    trCount = 0;
                    returnStr += "    </tr>\n <tr>\n";
                }
            }

            returnStr += "    </tr>\n</table>";
            return returnStr;
        }
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

    protected void Page_Load(object sender, EventArgs e)
    {
        // 테스트 코드 이미지 업로드가 session["mem_id"]에 종속됨

        if (Request.QueryString["mem_id"] == null || String.IsNullOrEmpty(Request.QueryString["mem_id"].ToString())) // mem_id 쿼리스트링이 존재하는지 체크
        {
            // null OR empty 인 경우 index로 redirect.
            Response.Write("<script language='javascript'>alert('접근 방법이 잘못되었습니다.');</script language='javascript'>");
            Response.Redirect("/index.aspx");
        }
        else
        {
            Member member = new Member();
            MemberDao memberDao = new MemberDao();

            memberID = Request.QueryString["mem_id"].ToString(); // 쿼리스트링 값 memberID 변수에 담고
            member.Mem_id = memberID;

            if (memberDao.IsExistByMemberID(member) == false) // 적절하지 않은 데이터의 아이디로 들어올 경우 index로 redirect 시키는 작업
            {
                Response.Write("<script language='javascript'>alert('" + member.Mem_id + "님의 페이지는 존재하지 않습니다.');</script language='javascript'>");
                Response.Redirect("/index.aspx");
            }

            if (HttpContext.Current.Session["mem_id"] == null) // 세션이 존재하지 않는 경우 (로그인 하지 않은 경우)
            {
                myID = "";
                pageOwner = false;
            }
            else // 로그인 한 경우 ( 세션이 존재하는 경우 )
            {
                myID = HttpContext.Current.Session["mem_id"].ToString();

                if (HttpContext.Current.Session["mem_id"].ToString() != Request.QueryString["mem_id"].ToString()) // 로그인 한 아이디(session)와 현재 MyPage Owner(mem_id)가 다른 경우
                {
                    pageOwner = false;
                }
                else // 같은 경우 자신의 페이지에 본인이 들어온 것임을 알 수 있다.
                {
                    pageOwner = true;
                }
            }

            mem_id.Text = memberID; // 페이지에 주인의 아이디를 출력시키고
            hdf_MemberID.Value = memberID; // 페이지의 히든필드에 주인의 아이디를 저장시키고 (나중에 프로필사진 편집을 위해서)
            member.Mem_id = memberID; // 페이지 주인의 아이디를 DTO에 넣고
            member = memberDao.selectMemberByMem_id(member); // DTO를 바꾼다.

            memberName = member.Mem_name.ToString(); // 그리고 DTO 내의 사용자 이름을 구해온다.
            main_img.Value = member.Mem_img_url; // HiddenField에 회원의 메인 이미지를 넣는다.

            TravelDao travelDao = new TravelDao();
            travelCount = travelDao.getTravelCountByMemId(memberID); // 페이지 주인이 작성한 게시글의 총 수를 구해온다.

            FollowerDao followerDao = new FollowerDao(); // follower DAO 객체를 생성하고
            followerCount = followerDao.getFollowerCountByMemId(memberID); // 팔로워 카운트를 구한 뒤
            followCount = followerDao.getFollowCountByMemId(memberID); // 팔로우 카운트를 구해온다.

            if(Request.QueryString["type"] == null)
            {
                pageType = "1";
            }
            else
            {
                pageType = Request.QueryString["type"].ToString();
            }

            MyPageViews.ActiveViewIndex = (int.Parse(pageType) - 1); // MultiView는 인덱스가 0부터 시작하기 때문에..
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
        object-fit: cover;
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
        width: 160px;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        background-color: transparent;
        transition-duration: .2s;
    }

        /* get → border-top */
        .boardTapOpen:hover {
            margin-top: -3px;
            border-top: 5px solid rgba(255, 91, 0, 1);
            text-decoration: none;
        }

        .active{
            margin-top: -3px;
            border-top: 5px solid rgba(255, 69, 0, 1);
            font-weight: 700;
        }

    .boardTapTxt {
        color: white;
        font-size: 13px;
        font-family: 'Noto Sans KR', sans-serif;
    }

    .boardContents {
        width: 100%;
        height: 500px;
    }

    .boardItem {
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
        transition-duration: .5s;
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
                            <asp:Button ID="btnLogin" runat="server" Text="로그인" CssClass="nav-log-item" PostBackUrl="./login.aspx" />
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
				<a><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                <ul>
                    <li><asp:Button ID="btnLogout" runat="server" Text="로그아웃" OnClick="btnLogout_Click" class="navFindBtn"/></li>
                </ul>
            </li>
        <% 
            }
        %>
        </ul>
    </div>

        <asp:HiddenField ID="hdf_MemberID" runat="server" />

        <div class="section">
            <!-- UserProfile -->
            <div class="section01">
                <div class="userImage">
                    <div class="userImageAlign">
                        <div class="userImageItem">
                            <a href="#">
                                <!-- 이미지 업로드 -->
                                <input type="file" class="upload"  id="FileUpload_main_img" accept="image/*" multiple="false" style="display:none;"/>
                                <asp:HiddenField ID="main_img" runat="server" Value=""/>

                                <!-- 이미지 미리보기 부분-->
<%
    if (pageOwner == true)
    {
        Response.Write("<img src=\"" + main_img.Value + "\" ID=\"mainImgItem\" alt=\"프로필 사진\" class=\"userImageStyle\" onclick=\"document.getElementById('FileUpload_main_img').click();\" />");
    }
    else
    {
        Response.Write("<img src=\"" + main_img.Value+ "\" ID=\"mainImgItem\" alt=\"프로필 사진\" class=\"userImageStyle\" />");
    }
%>
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
<%
    if (pageOwner == true)
        Response.Write("                                <input type=\"button\" value=\"프로필 편집\" class=\"settingButton\" onclick=\"location.href = '/edit.aspx'\"/>");
%>
                            </div>
                        </div>
                        <div class="data">
                            <div class="dataItem">
                                게시물 <span><%Response.Write(travelCount);%></span>
                            </div>
                            <div class="dataItem">
                                팔로워 <span><%Response.Write(followerCount);%></span>
                            </div>
                            <div class="dataItem">
                                팔로우 <span><%Response.Write(followCount);%></span>
                            </div>
                        </div>
                        <div class="name">
                            <span>
                                <asp:Label ID="mem_name" runat="server" Text="Label">
                                    <%Response.Write(memberName);%>
                                </asp:Label>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Board -->
            <div class="section02">

                <!-- boardTap -->
                <div class="boardTap">
<%
    string active1State = "";
    string active2State = "";
    string active3State = "";

    if (pageType == "1") active1State = " active";
    else if (pageType == "2") active2State = " active";
    else if (pageType == "3") active3State = " active";

%>
                        <a href = "./MyPage.aspx?mem_id=<%Response.Write(Request.QueryString["mem_id"].ToString());%>&type=1" class="boardTapOpen<%Response.Write(active1State);%>">
                            <span class="boardTapTxt">▦ My Travels</span>
                        </a>
                        <a href = "./MyPage.aspx?mem_id=<%Response.Write(Request.QueryString["mem_id"].ToString());%>&type=2" class="boardTapOpen<%Response.Write(active2State);%>">
                            <span class="boardTapTxt">▦ My Reviews</span>
                        </a>
                        <a href = "./MyPage.aspx?mem_id=<%Response.Write(Request.QueryString["mem_id"].ToString());%>&type=3" class="boardTapOpen<%Response.Write(active3State);%>">
                            <span class="boardTapTxt">▦ Following Touple</span>
                        </a>
                </div>

            </div>

            <!-- boardContents -->
            <div class="boardContents">
                <asp:MultiView ID="MyPageViews" runat="server" ActiveViewIndex="0">

                    <asp:View ID="MyTravelsView" runat="server">
                        <!-- My Travels -->
                        <div id="MyTravels" class="boardItem">
                            <%Response.Write(MyTravels());%>
                        </div>
                    </asp:View>

                    <asp:View ID="MyReviewsView" runat="server">
                        <!-- My ReViews -->
                        <div id="MyReviews" class="boardItem">
                            <%Response.Write(MyReviews());%>
                        </div>
                    </asp:View>

                    <asp:View ID="MyFollowersView" runat="server">
                        <!-- Following Touple -->
                        <div id="FollowingTouple" class="boardItem">
                            <%Response.Write(FollowingTouples());%>
                        </div>
                    </asp:View>

                </asp:MultiView>
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
                    url: 'memImageUploader.ashx',
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
