<%@ Page Language="C#" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>



<script runat="server">

    // boardItem에서 구해야 할 항목 : Member(mainImage) Travel(title, main_img, mem_id, create_time, tot_rate) Trave_Day(content)
    // searchType이 null인 경우 default값은 최신 순(1) 이다.

    int searchType;
    string searchText = "";
    string HashTag = "";

    protected List<Travel> getTravelBySearchType(string searchText, int limit1, int limit2)
    {
        Travel travel = new Travel();
        TravelDao travelDao = new TravelDao();

        if (searchType == 1)
        {
            return travelDao.getTravelOrderByCreateTimeDesc(searchText, limit1, limit2);
        }
        else if(searchType == 2)
        {
            return travelDao.getTravelOrderByTotRateDesc(searchText, limit1, limit2);
        }
        else if (searchType == 3)
        {
            return travelDao.getTravelOrderByFollowerDesc(searchText, limit1, limit2);
        }
        else if (searchType == 4)
        {
            return travelDao.getTravelOrderByHotDesc(searchText, limit1, limit2);
            //return travelDao.getTravelOrderByFollowerDesc();
            return null;
        }
        else if (searchType == 4)
        {
            //return travelDao.getTravelOrderByHotDesc();
            return null;
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["searchType"] == null)
        {
            Response.Redirect("./search.aspx?searchType=1");
        }
        else
        {
            searchType = int.Parse(Request.QueryString["searchType"].ToString());
        }

        if (Request.QueryString["text"] != null)
        {
            searchText = Request.QueryString["text"].ToString();
        }

        if (Request.QueryString["hashtag"] != null) // 해시태그를 통한 search 페이지 접근 시
        {
            HashTag = Request.QueryString["hashtag"].ToString(); // board 페이지에서 search 페이지에 접근하기 위해 눌렀던 해시태그를 구해온다
            inputText.Text = HashTag.ToString();
            search(1); // hashTag로 search 실행 시 
        }

    }

    protected void search(int n = 0)
    {
        if (Request.QueryString["searchType"] == null)
            searchType = 1;
        else
            searchType = int.Parse(Request.QueryString["searchType"].ToString());

        string text = "";
        string page = "";

        text = inputText.Text.ToString();

        if (Request.QueryString["page"] != null)
            page = Request.QueryString["page"].ToString();

        string absolutePath = HttpContext.Current.Request.Url.AbsolutePath + "?searchType=" + searchType;

        if (page != "")
            absolutePath += "&page=" + page;

        if (text != "")
            absolutePath += "&text=" + text;

        Response.Redirect(absolutePath);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        search(0);
    }

    protected void inputText_TextChanged(object sender, EventArgs e)
    {
        //EnterKey 누를 시 Button1_Click 이벤트 발생.
        inputText.Attributes["onkeyPress"] = "if(event.keyCode == 13) { " + Page.GetPostBackEventReference(Button1) + "; return false; }";
    }


</script>

<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TO OUR SHARED : SEARCH</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|Yeon+Sung|East+Sea+Dokdo|Jua&display=swap" rel="stylesheet">

    <!-- ICON -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
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


    <!-- AJAX-->
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>

        function rdoEvent(paramType) {
            var hashtag = "";
           

            <%
          if (Request.QueryString["text"] != null) // 해시태그를 통한 search 페이지 접근 시
        {
            HashTag = Request.QueryString["text"].ToString(); // board 페이지에서 search 페이지에 접근하기 위해 눌렀던 해시태그를 구해온다.
            string encodedHashtag = Server.UrlEncode(HashTag);
            Response.Write("hashtag = '&hashtag="+encodedHashtag+ "'");
            
        }
        %>

            window.location.href = "./search.aspx?searchType=" + paramType + hashtag;
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
                        <asp:Button class="iconBtnAreaItem" ID="Button1" runat="server" Text="🤔" OnClick="Button1_Click" />
                    </div>
                    <div class="inputArea">
                        <asp:TextBox ID="inputText" class="inputAreaItem" placeholder="원하는 리뷰가 있나요?" maxlength="15" runat="server" OnTextChanged="inputText_TextChanged"></asp:TextBox>
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
    List<Travel> travelList;
    Member member;
    Travel travel;
    Travel_Day travelDay;

    MemberDao memberDao = new MemberDao();
    TravelDao travelDao = new TravelDao();
    Travel_DayDao travelDayDao = new Travel_DayDao();

    // 웹 페이징을 위한 변수들
    int CurrentPage = 0;
    if (Request.QueryString["page"] == null) CurrentPage = 1;
    else CurrentPage = int.Parse(Request.QueryString["page"].ToString());

    int totalTravelCount = 0; // searchType(검색 기준)에 따라 구해올 게시글들의 수가 다르다.
    if(searchType == 1)
        totalTravelCount = travelDao.getTravelCountOrderByCreateTimeDesc(searchText);
    else if(searchType == 2)
        totalTravelCount = travelDao.getTravelCountOrderByTotRateDesc(searchText);
    else if(searchType == 3)
        totalTravelCount = travelDao.getTravelCountOrderByFollowerDesc(searchText);
    else if(searchType == 4)
        totalTravelCount = travelDao.getTravelCountOrderByHotDesc(searchText);

    int totalPageCount = totalTravelCount / 5;
    if ((totalTravelCount % 5) > 0) totalPageCount++;

    int pageCount = 5; // 한 페이지에 보여줄 게시글 갯수
    int blockCount = 0;

    blockCount = (int)Math.Floor((double)((CurrentPage - 1) / pageCount));
    int startPage = (pageCount * blockCount) + 1; // 시작 페이지
    int lastPage = startPage + (pageCount - 1); // 마지막 페이지

    int leftArrow = startPage - 1; // 좌측 화살표

    int rightArrow = lastPage + 1; // 우측 화살표
    if (rightArrow > totalPageCount)
        rightArrow = totalPageCount;

    String CurrentUrl = HttpContext.Current.Request.Url.AbsolutePath + "?"; // 도메인, 포트, 그리고 쿼리스트링이 제외된 주소. (ex: /board/Index)
    if (Request.QueryString["searchType"] != null)
        CurrentUrl += "searchType=" + Request.QueryString["searchType"].ToString();

    int limit1 = (CurrentPage - 1) * 5;
    int limit2 = 5;

    // boardItem에서 구해야 할 항목 : Member(mainImage) Travel(title, main_img, mem_id, create_time, tot_rate) Trave_Day(content)
    travelList = getTravelBySearchType(searchText, limit1, limit2);
    // 맵데이터 바인딩


    for (int i = 0; i < travelList.Count; i++)
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

        if (userMainImage == "noImage" || string.IsNullOrEmpty(userMainImage))
            userMainImage = "./img/memberNoImage.png";

        double d_starCount = double.Parse(travelList[i].Trv_tot_rate);
        int i_starCount = (int)d_starCount;
        string starText = "";

        for (int j = 0; j < i_starCount; j++)
            starText += "⭐";

        string content = "";
        if (string.IsNullOrEmpty(travelDay.Trv_day_content) == false)
        {
            if (travelDay.Trv_day_content.Length > 10)
                content = travelDay.Trv_day_content.Substring(0, 10).ToString();
            else
                content = travelDay.Trv_day_content.ToString();
        }

        Response.Write("" +
            "<div class=\"boardItem\">\n" +
                "<div class=\"article1\">\n" +
                    "<div class=\"boardImage\">\n" +
                        "<a href = \"./board.aspx?trv_no=" + travelList[i].Trv_no.ToString() + "\" onmouseover=\"setMapByIndex("+i+")\">\n" +
                            "<img src = \"" + travelMainImage + "\" alt=\"" + member.Mem_id.ToString() + "\" class=\"boardImageItem\">\n" +
                        "</a>\n" +
                    "</div>\n" +
                    "<div class=\"boardContent\">" +
                        "<a href = \"./board.aspx?trv_no=" + travelList[i].Trv_no.ToString() + "\" onmouseover=\"setMapByIndex("+i+")\">\n" +
                            "<div class=\"boardTitle\">" +
                                "<span>" + travelList[i].Trv_title.ToString() + "</span>" +
                            "</div>\n" +
                            "<div class=\"boardBody\">\n" +
                                "<span>\n" +
                                    content + "\n" +
                                "</span>\n" +
                            "</div>\n" +
                        "</a>\n" +
                    "</div>\n" +
                "</div>\n" +
                "<div class=\"article2\">\n" +
                    "<div class=\"boardUser\">\n" +
                        "<div class=\"boardUserImage\">\n" +
                            "<a href = \"./MyPage.aspx?mem_id=" + member.Mem_id.ToString() + "\">\n" +
                                "<img src=\"" + userMainImage + "\" alt=\"" + member.Mem_id.ToString() + "\" class=\"userImageItem\">\n" +
                            "</a>\n" +
                        "</div>\n" +
                        "<div class=\"boardUserId\">\n" +
                            "<a href = \"./MyPage.aspx?mem_id=" + member.Mem_id.ToString() + "\">\n" +
                                "<span>" + member.Mem_id.ToString() + "</span>\n" +
                            "</a>\n" +
                            "<div class=\"boardUserTime\">\n" +
                                "<span style = \"cursor: default;\">" + timestampConvert.TimeStampToString(travelList[i].Trv_create_time.ToString()) + "</span>\n" +
                            "</div>\n" +
                        "</div>\n");

        if (i_starCount > 0)
        {
            Response.Write("<div class=\"boardScore\" style=\"cursor: default;\">\n" +
                                    "<span class=\"Score1\">" + starText + "</span>\n" +
                                    "<span class=\"Score3\">(" + d_starCount + ")</span>\n" +
                                "</div>\n");
        }
        Response.Write("</div>\n" +
                    "</div>\n" +
                "</div>\n"+"<input type=\"hidden\" class=\"hidden_trv_no\" value=\""+travelList[i].Trv_no.ToString()+"\" />");
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
                                
<%
    System.Diagnostics.Debug.WriteLine($"페이징 작업: totalPageCount({totalPageCount}) pageCount({pageCount}) blockCount({blockCount}) startPage({startPage}) lastPage({lastPage}) leftArrow({leftArrow}) rightArrow({rightArrow})");

    if (leftArrow > 0)
        Response.Write("<a href=\"" + CurrentUrl + "&page=" + leftArrow + "\"><li><</li></a>\n");
    else
        Response.Write("<a href=\"javascript:void(0);\"><li>&nbsp;</li></a>\n");

    for (int i = startPage; i <= lastPage; i++)
    {
        string li = "";
        if (CurrentPage == i)
            li = "<li class=\"pageActive\">";
        else
            li = "<li>";

        if (i <= totalPageCount)
        {
            Response.Write("<a href=\"" + CurrentUrl + "&page=" + i + "\">" + li + i + "</li></a>\n");
        }
        else
        {
            Response.Write("<a href=\"javascript:void(0);\"><li>&nbsp;</li></a>\n");
        }
    }

    if (rightArrow < totalPageCount)
        Response.Write("<a href=\"" + CurrentUrl + "&page=" + rightArrow + "\"><li>></li></a>\n");
    else
        Response.Write("<a href=\"javascript:void(0);\"><li>&nbsp;</li></a>\n");
%>
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
        <asp:PlaceHolder ID="PlaceHolder_mapData" runat="server"></asp:PlaceHolder>
</form>
    <script>

        var trvMapDatas = [];
        var trvMapCenters = [];
        $(document).ready(function () {
            var hiddenFileds = document.getElementsByClassName("hidden_trv_no");

            for (var i = 0; i < hiddenFileds.length; i++) {
                console.log(hiddenFileds[i].value); //second console output
                getMapData2Arrs(hiddenFileds[i].value);
            }
            console.info("---------------------------------");
            console.info(trvMapDatas);
            console.info(trvMapCenters);
            
        });


  





        function getMapData2Arrs(travel_no) {
            

                $.ajax({
                    type: "GET",
                    url: "./getMapCenter.ashx?trv_no=" + travel_no,
                    dataType: 'json',
                    success: function (data) {


                        //console.info(data);
                        trvMapCenters.push(data);
                        



                    }

                });


                $.ajax({
                    type: "GET",
                    url: "./getMaps.ashx?trv_no=" + travel_no,
                    dataType: 'json',
                    success: function (data) {     
                        //console.info(travel_no);

                        //console.info(data);
                        trvMapDatas.push(data);



                    }

                });        


            
        }

        var color= [ "#E53A40", "#F68657", "#EFDC05", "#58C9B9", "#a3daff", "#0080ff" , "#A593E0", "#C5C6B6", "#D09E88", "#FADAD8", "#fab1ce", "#fffff5", "#c8c8a9", "#3a5134" ];
        var markerIco = [ "default_01.png", "default_02.png", "default_03.png", "default_04.png", "default_05.png", "default_06.png" , "default_07.png", "default_08.png", "default_09.png", "default_10.png", "default_11.png", "default_12.png", "default_13.png", "default_14.png" ];
        var icoDir = "./img/ico/marker/";

        function setMapByIndex(index) {
            console.info("setMapByIndex called");
            setMapDatasByIndex(index);
            //setMapCenterByIndex(index);
        }

        function setMapDatasByIndex(index) {
            removeOverlays();
            var data = trvMapDatas[index];
            if (data != null && data != "" && data != '""') {
                
                
                //console.info(data);
                data.forEach(function (value, index, array) {
                    if (value != null && value != "" && value != '""') {
                        //console.info(value);
                        getDataFromDrawingMap(value, color[index], color[index], icoDir + markerIco[index]);
                    }
                });
            }
        }

        function setMapCenterByIndex(index) {
            console.info("setMapCenterByIndex called");
            var data = trvMapCenters[index];
            console.info(data);
            if (data != null && data != "" && data != '""') {
                
                var totalGa = 0.0;
                var totalHa = 0.0;
                var cnt = 0;
                var tmpCenter;
                data.forEach(function (value, index, array) {
                    if (value != null && value != "" && value != '""') {
                        tmpCenter = JSON.parse(value);

                        console.info(tmpCenter.Ga);
                        console.info(tmpCenter.Ha);
                        totalGa += tmpCenter.Ga;
                        totalHa += tmpCenter.Ha;
                        cnt++;
                        console.info(totalGa);
                        console.info(totalHa);
                    }
                });
                map.setLevel(4, { animate: true });

                panTo(totalHa / cnt, totalGa / cnt);
                
                
            }
        }

        function panTo( Ha, Ga) {
            // 이동할 위도 경도 위치를 생성합니다 
            var moveLatLon = new kakao.maps.LatLng(Ha, Ga);

            // 지도 중심을 부드럽게 이동시킵니다
            // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
            map.panTo(moveLatLon);
        } 

        
        // Drawing Manager에서 데이터를 가져와 도형을 표시할 아래쪽 지도 div
        //center 좌표 계산 필요
        var mapContainer = document.getElementById('mapArea'),
            mapOptions = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도 div와 지도 옵션으로 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOptions),
            overlays = []; // 지도에 그려진 도형을 담을 배열

        // 지도 타입 변경 컨트롤을 생성한다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	

		// 지도에 확대 축소 컨트롤을 생성한다
		var zoomControl = new kakao.maps.ZoomControl();

		// 지도의 우측에 확대 축소 컨트롤을 추가한다
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);



        function getDataFromDrawingMap(mapData, instrokeColor, infillColor, iconUrl) {
            // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
            //console.info(mapData);
            //var data = mapData;
            var data = JSON.parse(mapData);
            //var data = mapData;
            //console.info(data);
            
            
            // 지도에 가져온 데이터로 도형들을 그립니다
            // 지도에 가져온 데이터로 도형들을 그립니다
            //drawMarker(data[kakao.maps.drawing.OverlayType.MARKER]);
            //drawPolyline(data[kakao.maps.drawing.OverlayType.POLYLINE]);
            //drawRectangle(data[kakao.maps.drawing.OverlayType.RECTANGLE]);
            //drawCircle(data[kakao.maps.drawing.OverlayType.CIRCLE]);
            //drawPolygon(data[kakao.maps.drawing.OverlayType.POLYGON]);
            //    drawArrow(data[kakao.maps.drawing.OverlayType.POLYLINE]);
            //    drawEllipse(data[kakao.maps.drawing.OverlayType.ELLIPSE]);

            drawMarker(data["marker"], iconUrl);
            drawPolyline(data["polyline"], instrokeColor, infillColor);
            drawRectangle(data["rectangle"], instrokeColor, infillColor);
            drawCircle(data["circle"], instrokeColor, infillColor);
            drawPolygon(data["polygon"], instrokeColor, infillColor);
            drawEllipse(data["ellipse"], instrokeColor, infillColor);
            drawArrow(data["arrow"], instrokeColor, infillColor);

        }

        // 아래 지도에 그려진 도형이 있다면 모두 지웁니다
        function removeOverlays() {
            var len = overlays.length, i = 0;

            for (; i < len; i++) {
                overlays[i].setMap(null);
            }

            overlays = [];
        }


        function drawArrow(arrow, instrokeColor, infillColor) {
            if (arrow != [] || arrow != "" || arrow != null) {
                var len = arrow.length, i = 0;

                for (; i < len; i++) {
                    var path = pointsToPath(arrow[i].points);
                    var style = arrow[i].options;
                    var polyline = new kakao.maps.Polyline({
                        map: map,
                        endArrow: true,
                        path: path,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight
                    });

                    overlays.push(polyline);
                }


            }
        }

        function drawEllipse(ellipse, instrokeColor, infillColor) {
            if (ellipse != [] || ellipse != "" || ellipse != null) {
                var len = ellipse.length,
                    i = 0;

                for (; i < len; i++) {


                    var ellipse = new kakao.maps.Ellipse({
                        map: map,
                        center: new daum.maps.LatLng(ellipse[i].center.y, ellipse[i].center.x),
                        rx: ellipse[i].rx,
                        ry: ellipse[i].ry,
                        strokeWeight: 2,
                        strokeColor: instrokeColor,
                        strokeOpacity: 0.8,
                        strokeStyle: 'solid',
                        fillColor: infillColor,
                        fillOpacity: 0.3

                    });
                    overlays.push(ellipse);


                }
            }
        }
        // 숫자 포멧팅
        function pad(n, width) {
            n = n + '';
            return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
        }


        // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
        function drawMarker(markers, iconUrl) {
            if (markers != [] || markers != "" || markers != null) {
                var maxX = markers[0].x;
                var maxY = markers[0].y;
                var minX = markers[0].x;
                var minY = markers[0].y;
                var len = markers.length, i = 0;
             
                var icon =  new kakao.maps.MarkerImage(
                    iconUrl,
                    new kakao.maps.Size(31, 35));

                for (; i < len; i++) {
                    //지도의 중심 좌표를 구하기 위한 코드
                    if (markers[i].x > maxX) {
                        maxX = markers[i].x
                    }
                    if (markers[i].y > maxY) {
                        maxY = markers[i].y
                    }
                    if (markers[i].x <= minX) {
                        minX = markers[i].x
                    }
                    if (markers[i].y <= minY) {
                        minY = markers[i].y
                    }

                    var marker = new kakao.maps.Marker({
                        image: icon,
                        map: map,
                        position: new kakao.maps.LatLng(markers[i].y, markers[i].x),
                        zIndex: markers[i].zIndex
                    });

                    overlays.push(marker);
                    
                }
                if (len == 1) {
                    len = len + 1;
                }
                var centerX = (maxX + maxX) / len;
                var centerY = (minY + minY) / len;
                console.info(centerX);
                console.info(centerY);
                panTo(centerY, centerX);
            }
        }

        // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
        function drawPolyline(lines, instrokeColor, infillColor) {
            if (lines != [] || lines != "" || lines != null) {
                var len = lines.length, i = 0;

                for (; i < len; i++) {
                    var path = pointsToPath(lines[i].points);
                    var style = lines[i].options;
                    var polyline = new kakao.maps.Polyline({
                        map: map,
                        path: path,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight
                    });

                    overlays.push(polyline);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
        function drawRectangle(rects, instrokeColor, infillColor) {
            if (rects != [] || rects != "" || rects != null) {
                var len = rects.length, i = 0;

                for (; i < len; i++) {
                    var style = rects[i].options;
                    var rect = new kakao.maps.Rectangle({
                        map: map,
                        bounds: new kakao.maps.LatLngBounds(
                            new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                            new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
                        ),
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight,
                        fillColor: infillColor,
                        fillOpacity: style.fillOpacity
                    });

                    overlays.push(rect);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
        function drawCircle(circles, instrokeColor, infillColor) {
            if (circles != [] || circles != "" || circles != null) {
                var len = circles.length, i = 0;

                for (; i < len; i++) {
                    var style = circles[i].options;
                    var circle = new kakao.maps.Circle({
                        map: map,
                        center: new kakao.maps.LatLng(circles[i].center.y, circles[i].center.x),
                        radius: circles[i].radius,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight,
                        fillColor: infillColor,
                        fillOpacity: style.fillOpacity
                    });

                    overlays.push(circle);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 다각형을 아래 지도에 표시하는 함수입니다
        function drawPolygon(polygons, instrokeColor, infillColor) {
            if (polygons != [] || polygons != "" || polygons != null) {
                var len = polygons.length, i = 0;

                for (; i < len; i++) {
                    var path = pointsToPath(polygons[i].points);
                    var style = polygons[i].options;
                    var polygon = new kakao.maps.Polygon({
                        map: map,
                        path: path,
                        strokeColor: instrokeColor,
                        strokeOpacity: style.strokeOpacity,
                        strokeStyle: style.strokeStyle,
                        strokeWeight: style.strokeWeight,
                        fillColor: infillColor,
                        fillOpacity: style.fillOpacity
                    });

                    overlays.push(polygon);
                }
            }
        }

        // Drawing Manager에서 가져온 데이터 중 
        // 선과 다각형의 꼭지점 정보를 kakao.maps.LatLng객체로 생성하고 배열로 반환하는 함수입니다 
        function pointsToPath(points) {
            var len = points.length,
                path = [],
                i = 0;

            for (; i < len; i++) {
                var latlng = new kakao.maps.LatLng(points[i].y, points[i].x);
                path.push(latlng);
            }

            return path;
        }




    </script>
</body>

</html>
