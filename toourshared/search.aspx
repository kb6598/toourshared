<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    // boardItem에서 구해야 할 항목 : Member(mainImage) Travel(title, main_img, mem_id, create_time, tot_rate) Trave_Day(content)
    // searchType이 null인 경우 default값은 최신 순(1) 이다.

    int searchType;
    protected List<Travel> getTravelBySearchType()
    {
        Travel travel = new Travel();
        TravelDao travelDao = new TravelDao();
        // travel 및 travelDao 객체 생성

        if (searchType == 1)
        {
            return travelDao.getTravelOrderByCreateTimeDesc();
        }
        else
        {
            return new List<Travel>(); // 빈 List 반환. 여기 올 일이 없어야 함. 무조건..
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("index.aspx");
    }

    protected void test()
    {
        System.Diagnostics.Debug.WriteLine("radioButtonCheckEvent ON");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["searchType"] == null)
        {
            searchType = 1;
        }
        else
        {
            searchType = int.Parse(Request.QueryString["searchType"].ToString());
        }
    }
</script>

<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED : SEARCH</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|East+Sea+Dokdo|Jua&display=swap" rel="stylesheet">

    <!-- ICON -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="./css/search.css">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <!-- kakodev -->
      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>

    <script>

        function rdoEvent(paramType){
            window.location.href = "search.aspx?searchType=" + paramType;
        }

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

        $(function() {
            $('#inputAreaItem').keyup(function(e) {
                var content = $(this).val();
                $('#textCnt').html("(" + content.length + " / 200)");

                if (content.length > 200) {
                    $(this).val(content.substring(0, 200));
                    $('#textCnt').html("(200 / 200)");
                }
            });
            $('#inputAreaItem').keyup();
        });

    </script>
</head>

<body>
    <form name ="form1" runat="server">
    <div class="main">
        <div class="searchBar">

            <div class="sideBar" id="sideBar">
                <div class="header" id="header">
                    <div class="iconBtnArea">
                        <button><i class="fas fa-search"></i></button>
                    </div>
                    <div class="inputArea">
                        <input type="text" placeholder="리뷰를 볼 지역을 입력하세요" />
                    </div>
                </div>
                <div class="contents" id="contents">
                    <div class="contentsArea">
                        <div class="orderArea">
                            <div class="orderRadio">
                                <p class="orTxt"><i class="far fa-window-restore"></i> 검색 기준</p>
                                <table>
                                    <tr>
<%
    // get방식으로 searchType을 받아와서 radiobutton의 상태를 변경한다. searchType이 null일때는 최신을 default로 잡는다.
    // Request.QueryString["trv_no"].

    string[] str_searchType = new string[] { "최신", "인기", "팔로워", "HOT" };
    string inputCheck = "";
    int searchType = 0;
    if (Request.QueryString["searchType"] == null)
    {
        searchType = 1;
    }
    else
    {
        searchType = int.Parse(Request.QueryString["searchType"].ToString());
    }

    for (int i = 1; i <= 4; i++)
    {
        if (i == searchType) inputCheck = "checked";
        else inputCheck = "";

        Response.Write("" +
                        "<td>\n" +
                            "<div class=\"orderRadioItem\">\n" +
                                "<input type = \"radio\" id=\"rdo" + i + "\" name=\"orderStd\" runat=\"server\" onchange=\"rdoEvent(" + i + ")\"" + inputCheck + "/><label for=\"rdo" + i + "\">" + str_searchType[(i - 1)] + "</label>\n" +
                            "</div>\n" +
                        "</td>\n");
    }
%>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <div class="boardArea">
                            <div class="boardAlign">
<% 
    // boardItem에서 구해야 할 항목 : Member(mainImage) Travel(title, main_img, mem_id, create_time, tot_rate) Trave_Day(content)
    List<Travel> travelList = getTravelBySearchType();

    Travel travel;
    Travel_Day travelDay;
    Member member;

    TravelDao travelDao = new TravelDao();
    Travel_DayDao travelDayDao = new Travel_DayDao();
    MemberDao memberDao = new MemberDao();

    for (int i = 1; i <= 5; i++)
    {
        member = new Member();
        member.Mem_id = travelList[i].Mem_id;
        member = memberDao.selectMemberByMem_id(member); // i번 째 게시글에 해당하는 유저 데이터 가져오는 작업

        travelDay = new Travel_Day();
        travelDay.Trv_no = travelList[i].Trv_no;
        travelDay = travelDayDao.selectTravelDayByTrvNo(travelDay); // i번 째 게시글의 내용을 구해오는 작업

        string travelMainImage = travelList[i].Trv_main_img;
        string userMainImage = member.Mem_img_url;

        if (travelMainImage == "noImage")
            travelMainImage = "./img/noImage.png";

        if (userMainImage == "noImage")
            userMainImage = "./img/UserNoneImage.png";

        double d_starCount = double.Parse(travelList[i].Trv_tot_rate);
        int i_starCount = (int)d_starCount;
        string starText = "";

        for (int j = 0; j < i_starCount; j++)
            starText += "⭐";

        Response.Write("" +
            "<div class=\"boardItem\">\n" +
                "<div class=\"article1\">\n" +
                    "<div class=\"boardImage\">\n" +
                        "<a href = \"board.aspx?trv_no=" + travelList[i].Trv_no.ToString() + "\">\n" +
                            "<img src = \"" + travelMainImage + "\" alt=\"" + member.Mem_id.ToString() + "\" class=\"boardImageItem\">\n" +
                        "</a>\n" +
                    "</div>\n" +
                    "<div class=\"boardContent\">" +
                        "<a href = \"board.aspx?trv_no=\"" + travelList[i].Trv_no.ToString() + "\">\n" +
                            "<div class=\"boardTitle\">" +
                                "<span>" + travelList[i].Trv_title.ToString() + "</span>" +
                            "</div>\n" +
                            "<div class=\"boardBody\">\n" +
                                "<span>\n" +
                                    travelDay.Trv_day_content.ToString() + "\n" +
                                "</span>\n" +
                            "</div>\n" +
                        "</a>\n" +
                    "</div>\n" +
                "</div>\n" +
                "<div class=\"article2\">\n" +
                    "<div class=\"boardUser\">\n" +
                        "<div class=\"boardUserImage\">\n" +
                            "<a href = \"MyPage.aspx?mem_id=" + member.Mem_id.ToString() + "\">\n" +
                                "<img src=\"" + userMainImage + "\" alt=\"" + member.Mem_id.ToString() + "\" class=\"userImageItem\">\n" +
                            "</a>\n" +
                        "</div>\n" +
                        "<div class=\"boardUserId\">\n" +
                            "<a href = \"MyPage.aspx?mem_id=" + member.Mem_id.ToString() + "\">\n" +
                                "<span>" + member.Mem_id.ToString() + "</span>\n" +
                            "</a>\n" +
                            "<div class=\"boardUserTime\">\n" +
                                "<span style = \"cursor: default;\">" + travelList[i].Trv_create_time.ToString() + "</span>\n" +
                            "</div>\n" +
                        "</div>\n" +
                        "<div class=\"boardScore\" style=\"cursor: default;\">" +
                            "<span class=\"Score1\">starText</span>\n" +
                            "<span class=\"Score3\">(" + d_starCount + ")</span>\n" +
                        "</div>\n" +
                    "</div>\n" +
                "</div>\n" +
            "</div>\n");
    }
    %>
                            </div>
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

            <!-- sideBar open & close switch -->
            <div class="sideBarBtn" id="sideBarBtn">
                <input type="button" id="sideBarBtnItem" onClick="sidebarSwitch()" value="▲" />
            </div>

            <!-- To Our Shared Home Button -->
            <div class="sideBarHome" id="sideBarhome">
                <div class="btnArea">
                    <asp:Button ID="btnHome" runat="server" Text="To Our Shared" class="homeBtn" OnClick="btnHome_Click" />
                </div>
            </div>
        </div>

        <!-- Kakao Map Area -->
        <div class="map" id="mapArea"></div>
    </div>
</form>
    <script>
        var drawingMapContainer = document.getElementById('mapArea'),
            drawingMap = {
                center: new kakao.maps.LatLng(37.56671, 126.98298), // 지도의 중심좌표
                level: 4, // 지도의 확대 레벨
                mapTypeId: kakao.maps.MapTypeId.ROADMAP // 지도종류
            };

        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        //var drawingMap = new daum.maps.Map(drawingMapContainer, mapOption);
        var drawingMap = new daum.maps.Map(drawingMapContainer, drawingMap);

    </script>
</body>

</html>
