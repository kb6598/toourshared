<%@ Page Language="C#"  EnableEventValidation="false" ValidateRequest="false"%>


<!DOCTYPE html>

<script runat="server">


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


    //<div class="mainImg_Input">
    //                        <input type="file" name="main_img" id="main_img">
    //                    </div>

    protected void WriteSessionProcess()
    {
        int SESSION_TIME_OUT_MIN = 60;
        //if (IsLogin.isLogin() == false)
        //{
        //    Response.Redirect("/index.aspx");
        //}
        // 테스트 코드
        if(HttpContext.Current.Session["mem_id"] == null)
        {
            Session["mem_id"] = "billip";
        }


        //status -> 편집 페이지 정보
        //세션 status가 비어있다면 새로운 status 생성
        if (HttpContext.Current.Session["write_status"] == null)
        {


            // 비어있는 travel을 삽입하고 trv_no(pk) 값을 가져옴
            Travel inTravel = new Travel();
            inTravel.Mem_id = HttpContext.Current.Session["mem_id"].ToString();
            inTravel.Trv_create_time = TimeLib.GetTimeStamp();
            inTravel.Trv_secret = 0.ToString();
            inTravel.Trv_timestamp = TimeLib.GetTimeStamp();
            inTravel.Trv_title = Request.Form["title"];
            inTravel.Trv_tot_rate = 0.ToString();
            inTravel.Trv_views = 0.ToString();



            TravelDao travelDao = new TravelDao();
            string trv_no = travelDao.InsertTravel(inTravel);

            //travel_day도 생성
            Travel_Day travel_Day = new Travel_Day();
            travel_Day.Trv_no = trv_no;


            Travel_DayDao travel_DayDao = new Travel_DayDao();
            string trv_day_no = travel_DayDao.InsertTravel_Day(travel_Day);
            // 현재폼 정보를 저장할 딕셔너리 생성 나중에 세션에 넘겨줌
            Dictionary<string, string> newWriteStatus = new Dictionary<string, string>()
            {
                {"status","first" },
                { "trv_no", trv_no},
                { "cur_trv_day_no",trv_day_no},
                { "cur_day","1"},
                {"trv_day_cnt","1" },
                {"1",trv_day_no }

            };
            Session["write_status"] = newWriteStatus;
            Session.Timeout = SESSION_TIME_OUT_MIN;

        }


    }
    protected void BindTables()
    {

        Dictionary<string, string> readWriteStatus = SessionLib.getWriteStatus();
        if (readWriteStatus != null)
        {

            Literal_day.Text = readWriteStatus["cur_day"];

            Travel_Day inputTravel_day = new Travel_Day();
            Travel_Day outputTravel_day = new Travel_Day();
            Travel_DayDao Travel_daydao = new Travel_DayDao();

            inputTravel_day.Trv_day_no = readWriteStatus["cur_day"];
            outputTravel_day = Travel_daydao.selectTrvel_DayBytrv_day_no(inputTravel_day);

            Travel inputTravel = new Travel();
            Travel outputTravel = new Travel();
            TravelDao daoTravel = new TravelDao();
            inputTravel.Trv_no = readWriteStatus["trv_no"];
            outputTravel = daoTravel.selectTravelBytrv_no(inputTravel);

            // 바인드
            title.Text = outputTravel.Trv_title;
            hashtag.Text = outputTravel.Trv_tag;
            article.Text = outputTravel_day.Trv_day_content;




        }

    }

    protected void BindDropDownList()
    {
        Dictionary<string, string> readWriteStatus = SessionLib.getWriteStatus();
        if (readWriteStatus != null)
        {
            int i = 1;
            ListItem lst;
            while (true)
            {
                if (!readWriteStatus.ContainsKey(i.ToString())) break;
                lst = new ListItem(i + "일차", i.ToString());
                goDay.Items.Add(lst);
                i++;
            }
        }
    }


    protected void DropDownList_goDay_SelectedIndexChanged(object sender, EventArgs e)
    {

        if(HttpContext.Current.Session["write_status"] != null)
        {
            Dictionary<string, string> readWriteStatus = new Dictionary<string, string>();
            readWriteStatus = (Dictionary<string, string>)Session["write_status"];


        }

    }
    protected void Bind_otherData()
    {
                if (Request.Form["mapCost"] != null)
        {
            mapCost.Value = Request.Form["mapCost"];

        }

        if (Request.Form["mapData"] != null)
        {
            mapData.Value = Request.Form["mapData"];
        }

        if (Request.Form["mapRoute"] != null)
        {
            mapRoute.Value = Request.Form["mapRoute"];
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        WriteSessionProcess();
        BindDropDownList();
        Bind_otherData();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>TO OUR SHARED : 글 작성 #일차</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|East+Sea+Dokdo|Jua&display=swap" rel="stylesheet">

    <!-- ICON -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- summerNote -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.11/dist/summernote-bs4.min.css" rel="stylesheet" />

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bs4-summernote@0.8.10/dist/summernote-bs4.min.js"></script>

    <link rel="stylesheet" href="/css/write.css">


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

        /* TextArea Summernote */
        $(document).ready(function () {
            $('#article').summernote({
                height: 300, //set editable area's height
            });
        });

        /* FileUpload (경로 없이 무조건 파일명만 뜨게) */
        $(document).ready(function () {
            var fileTarget = $('.fileItem');
            var originalFileName;
            fileTarget.on('change', function () { // 값이 변경되면
                if (window.FileReader) { // modern browser
                    originalFileName = $(this)[0].files[0].name;

                    var filename = $(this)[0].files;
                    var filename = $(this)[0].files[0].name;
                }
                else { // old IE
                    originalFileName = $(this).val();
                    var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
                }

                // 추출한 파일명 삽입
                $(this).siblings('.fileItem').val(filename);

                // modalBody 부분 높이 조절 및 업로드 버튼 나타내기
                document.getElementById("mainImgItem").style.width = "150px";
                document.getElementById("mainImgItem").style.height = "150px";

                var image = document.getElementById("mainImgItem");
                image.alt = filename;
                image.src = originalFileName;
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- navbar 영역 -->
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
                                <asp:Button ID="btnLogin" runat="server" Text="로그인" class="nav-log-item" PostBackUrl="~/login.aspx" />
                            </div>
                        </a>
                    </div>
                    <ul>
                        <br />
                        <li>
                            <asp:Button ID="btnJoin" runat="server" Text="회원가입" OnClick="btnJoin_Click" /></li>
                        <li>
                            <asp:Button ID="btnFindIDPW" runat="server" Text="계정찾기" OnClick="btnFindIDPW_Click" /></li>
                    </ul>
                </li>
                <%  
                    }
                    else
                    {
                %>
                <li class="topnavLi">
                    <a href="#"><% string id = Session["mem_id"].ToString(); Response.Write(id); %></a>
                    <ul>
                        <li>
                            <asp:Button ID="btnMypage" runat="server" Text="마이페이지" OnClick="btnMypage_Click" /></li>
                        <li>
                            <asp:Button ID="btnLogout" runat="server" Text="로그아웃" OnClick="btnLogout_Click" /></li>

                    </ul>
                </li>
                <% 
                    }
                %>
            </ul>
        </div>
        <div id="main" class="main">
            <!-- 메인 상단 영역 -->
            <div class="TitleArea">
                <div class="TitleAlign">
                            <asp:HiddenField ID="mapData" runat="server" />
        <asp:HiddenField ID="mapRoute" runat="server" />
        <asp:HiddenField ID="mapCost" runat="server" />
                    <asp:TextBox ID="title"  runat="server" type="text" placeholder="게시글의 제목을 정해주세요." />
                </div>
                <div class="TitleSub">
                    <div class="SubItem">
                        <span>
                            <asp:Literal ID="Literal_day" runat="server"></asp:Literal>일 차 작성 중...</span>
                    </div>
                    <div class="SubItem">

                        <asp:DropDownList ID="goDay" runat="server" OnSelectedIndexChanged="DropDownList_goDay_SelectedIndexChanged">
                        </asp:DropDownList>

                    </div>
                </div>
            </div>

            <!-- 중앙 영역 1 -->
            <div class="MapArea">
                <div id="travelRoute_wrap">
                    <div class="travelRouteItem-Left">
                        <div class="travelRoute-header">
                            <div class="trTitle1"><span class="trTitle">여행지</span></div>
                            <div class="trTitle2"><span id="trBody">방문 : 0</span></div>
                        </div>
                        <div class="travelRoute-content">
                            <ul id="travelRoute" class="travelRoute"></ul>
                        </div>
                    </div>
                    <div class="travelRouteItem-Center">
                        <div class="travelRoute-header">
                            <button type="button" class="TIFIRST" onclick="selectOverlay('MARKER')">
                                <p>📌</p>
                                <p>마커</p>
                            </button>
                            <button type="button" onclick="selectOverlay('POLYLINE')">
                                <p>🥖</p>
                                <p>선</p>
                            </button>
                            <button type="button" onclick="selectOverlay('CIRCLE')">
                                <p>🍅</p>
                                <p>원</p>
                            </button>
                            <button type="button" onclick="selectOverlay('RECTANGLE')">
                                <p>🍱</p>
                                <p>사각형</p>
                            </button>
                            <button type="button" onclick="selectOverlay('POLYGON')">
                                <p>🍰</p>
                                <p>다각형</p>
                            </button>
                            <button type="button" onclick="selectOverlay('ELLIPSE')">
                                <p>🍪</p>
                                <p>타원</p>
                            </button>
                            <button type="button" onclick="selectOverlay('ARROW')">
                                <p>👉</p>
                                <p>화살표</p>
                            </button>
                            <button type="button" id="undo" onclick="undoAction()" disabled>
                                <p>↺</p>
                                <p>동작취소</p>
                            </button>
                            <button type="button" id="redo" onclick="redoAction()" disabled>
                                <p>↻</p>
                                <p>되돌리기</p>
                            </button>
                            <button type="button" class="TILAST" data-toggle="modal" data-target="#searchPlaceModal">
                                <p>🍳</p>
                                <p>장소검색</p>
                            </button>
                        </div>
                        <div class="map_wrap">
                            <div id="drawingMap"></div>
                        </div>
                    </div>

                    <div class="travelRouteItem-Right">
                        <div id="travelCost_wrap">
                            <div class="modal-cost">
                                <div class="modal-cost-area">
                                    <div class="cost-header" id="costHeader">
                                        <div class="chTitle1"><span class="chTitle">전체 경비</span></div>
                                        <div class="chTitle2"><span class="chBody">💰 0</span></div>
                                    </div>
                                    <div class="cost-body" id="costBody">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 중앙 영역 2 -->
            <div class="taArea">
                <div class="form-group">
                    <asp:TextBox ID="article" runat="server" TextMode="MultiLine" type="text"  name="article"></asp:TextBox>
                </div>
            </div>

            <!-- 메인페이지 영역 -->
            <div class="mainImgArea">
                <div class="mainImg_wrap">
                    <div class="mainImg_AlignLeft">
                        <div class="mainImg_Label">게시글의 메인이미지를 첨부하세요.</div>
                        <div class="mainImg_Input">
                            <asp:FileUpload ID="main_img" runat="server" />
                        </div>
                    </div>
                    <div class="mainImg_AlignRight">
                        <img src="./img/%EC%A0%9C%EC%A3%BC%EB%8F%84.jpg" alt="userMainImage" id="mainImgItem" />
                    </div>
                </div>
            </div>

            <!-- 해쉬태그 영역 -->
            <div class="hashArea">
                <asp:TextBox ID="hashtag" runat="server" type="text" placeholder="해쉬태그를 입력하세요. (ex : #여행 #추억) (스페이스바로 구분지어 주세요.)" class="hashAreaItem" />
            </div>

            <!-- 하단부 영역 -->
            <div class="btnArea">
                <!-- 임시 저장 버튼 -->
                <div class="tempSaveBtn">
                    <div onclick ="tmpSave()" class="btnAreaItem">임시 저장</div>
                </div>
                <!-- 다음 일로 이동 -->
                <div  class="nextPageBtn">
                    <div onclick ="nextDay()" class="btnAreaItem">다음 일 입력</div>
                </div>
                <!-- 글 작성 완료 버튼 -->
                <div class="finishBtn">
                    <div onclick ="endWrite()" class="btnAreaItem">글 작성 완료</div>
                </div>
            </div>
        </div>

        <!-- 장소 검색 Modal 영역 -->
        <div class="modal fade" id="searchPlaceModal" tabindex="-1" role="dialog" aria-labelledby="searchPlaceModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="searchPlaceModalTitle">장소 검색</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="menu_wrap" class="bg_white">
                            <div class="option">
                                <div>
                                    키워드 :
                                <input id="keyword" value="이태원 맛집" type="text" />
                                    <button onclick="searchPlaces();">검색하기</button>
                                </div>
                            </div>
                            <hr />
                            <ul id="placesList"></ul>
                            <div id="pagination"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

   
    </form>

 

       





        <!-- KAKAO -->

 <script src="javascript/write.js"></script>
    
          
<script>




      //------------------------------------
        //----------Post START
        //------------------------------------
    var form = document.createElement("form");


     // 다음페이지로 markers, polyline, rect, circle, polygon 보내는 기능
    function addDataAtForm() {

            var title = document.getElementById("title");
            var article = document.getElementById("article");
            var hashtag = document.getElementById("hashtag");
            title.setAttribute('type', "hidden");
            article.setAttribute('type', "hidden");
            hashtag.setAttribute('type', "hidden");


            
            //// Form submission canceled because the form is not connected 해결
            document.body.appendChild(form);
            form.setAttribute('method', "post");

            form.appendChild(title);
            form.appendChild(article);
            form.appendChild(hashtag);


            var mapData = document.createElement("input"); // input 엘리멘트 생성
            mapData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            mapData.setAttribute("name", "mapData"); // name 속성을 'stadium'으로 설정
            mapData.setAttribute("value", JSON.stringify(getMapData())); // value 속성을 삽입
            form.appendChild(mapData);

            var TravelRouteListData = document.createElement("input"); // input 엘리멘트 생성
            TravelRouteListData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            TravelRouteListData.setAttribute("name", "mapRoute"); // name 속성을 'stadium'으로 설정
            TravelRouteListData.setAttribute("value", JSON.stringify(getTravelRouteData())); // value 속성을 삽입
            form.appendChild(TravelRouteListData);

            var CostItemListData = document.createElement("input"); // input 엘리멘트 생성
            CostItemListData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            CostItemListData.setAttribute("name", "mapCost"); // name 속성을 'stadium'으로 설정
            CostItemListData.setAttribute("value", JSON.stringify(getCostData())); // value 속성을 삽입
            form.appendChild(CostItemListData);


     
            
        }


    
    function tmpSave() {
        addDataAtForm();
        form.setAttribute('action', "Write_tmpSave.aspx");
        form.submit(); // 전송
    }
    function nextDay() {
        addDataAtForm();
        form.setAttribute('action', "Write_nextDay.aspx");
        form.submit(); // 전송
    }
    function endWrite() {
        addDataAtForm();
        form.setAttribute('action', "Write_get_endWrite.aspx");
        form.submit(); // 전송
    }

        //------------------------------------
        //----------Post END
        //------------------------------------




    //------------------------------------
    //----------Post START
    //------------------------------------
    var form = document.createElement("form");


    // 다음페이지로 markers, polyline, rect, circle, polygon 보내는 기능
    function addDataAtForm() {

        var title = document.getElementById("title");
        var article = document.getElementById("article");
        var hashtag = document.getElementById("hashtag");
        title.setAttribute('type', "hidden");
        article.setAttribute('type', "hidden");
        hashtag.setAttribute('type', "hidden");



        //// Form submission canceled because the form is not connected 해결
        document.body.appendChild(form);
        form.setAttribute('method', "post");

        form.appendChild(title);
        form.appendChild(article);
        form.appendChild(hashtag);


        var mapData = document.createElement("input"); // input 엘리멘트 생성
        mapData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
        mapData.setAttribute("name", "mapData"); // name 속성을 'stadium'으로 설정
        mapData.setAttribute("value", JSON.stringify(getMapData())); // value 속성을 삽입
        form.appendChild(mapData);

        var TravelRouteListData = document.createElement("input"); // input 엘리멘트 생성
        TravelRouteListData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
        TravelRouteListData.setAttribute("name", "mapRoute"); // name 속성을 'stadium'으로 설정
        TravelRouteListData.setAttribute("value", JSON.stringify(getTravelRouteData())); // value 속성을 삽입
        form.appendChild(TravelRouteListData);

        var CostItemListData = document.createElement("input"); // input 엘리멘트 생성
        CostItemListData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
        CostItemListData.setAttribute("name", "mapCost"); // name 속성을 'stadium'으로 설정
        CostItemListData.setAttribute("value", JSON.stringify(getCostData())); // value 속성을 삽입
        form.appendChild(CostItemListData);




    }



    function tmpSave() {
        addDataAtForm();
        form.setAttribute('action', "Write_tmpSave.aspx");
        form.submit(); // 전송
    }
    function nextDay() {
        addDataAtForm();
        form.setAttribute('action', "Write_nextDay.aspx");
        form.submit(); // 전송
    }
    function endWrite() {
        addDataAtForm();
        form.setAttribute('action', "Write_get_endWrite.aspx");
        form.submit(); // 전송
    }

    //------------------------------------
    //----------Post END
    //------------------------------------
    //------------------------------------
    //----------drawingMap DataBind Start Not Map
    //-------------------------------








    function setDrawingMapData(mapData) {
        // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
        var data = mapData;
        console.info(data);

        // 아래 지도에 그려진 도형이 있다면 모두 지웁니다
        removeOverlays();

        console.info(data["marker"]);
        console.info(data["polyline"]);
        console.info(data["rectangle"]);
        console.info(data["circle"]);
        console.info(data["polygon"]);
        console.info(data["ellipse"]);
        console.info(data["arrow"]);
        // 지도에 가져온 데이터로 도형들을 그립니다
        drawMarker(data["marker"]);
        //drawPolyline(data["polyline"]);
        //drawRectangle(data["rectangle"]);
        //drawCircle(data["circle"]);
        //drawPolygon(data["polygon"]);
        //drawEllipse(data["ellipse"]);
        //drawArrow(data["arrow"]);




    }


    function drawArrow(arrow) {
        var len = arrow.length,
            i = 0;

        for (; i < len; i++) {
            var path = pointsToPath(arrow[i].points);
            manager.put(kakao.maps.drawing.OverlayType.ARROW, path);
        }
    }

    function drawEllipse(ellipse) {
        var len = ellipse.length,
            i = 0;

        for (; i < len; i++) {
            var style = ellipse[i].options;
            bounds = new kakao.maps.LatLngBounds(
                new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
            );
            manager.put(kakao.maps.drawing.OverlayType.ELLIPSE, bounds);
        }
    } // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
    function drawMarker(markers) {

        var len = markers.length,
            i = 0;

        for (; i < len; i++) {
            manager.put(kakao.maps.drawing.OverlayType.MARKER, new kakao.maps.LatLng(markers[i].y, markers[i].x), 2);
        }
    }

    // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
    function drawPolyline(lines) {
        var len = lines.length,
            i = 0;

        for (; i < len; i++) {
            var path = pointsToPath(lines[i].points);
            manager.put(kakao.maps.drawing.OverlayType.POLYLINE, path);
            

        }
    }

    // Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
    function drawRectangle(rects) {
        var len = rects.length,
            i = 0;

        for (; i < len; i++) {
            var style = rects[i].options;
            bounds = new kakao.maps.LatLngBounds(
                new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
            );
            manager.put(kakao.maps.drawing.OverlayType.RECTANGLE, bounds);

           

        }
    }

    // Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
    function drawCircle(circles) {
        var len = circles.length,
            i = 0;

        for (; i < len; i++) {

            manager.put(kakao.maps.drawing.OverlayType.CIRCLE, new kakao.maps.LatLng(circles[i].center.y, circles[i].center.x), circles[i].radius);
            
        }
    }

    // Drawing Manager에서 가져온 데이터 중 다각형을 아래 지도에 표시하는 함수입니다
    function drawPolygon(polygons) {
        var len = polygons.length,
            i = 0;

        for (; i < len; i++) {
            
            var path = pointsToPath(polygons[i].points);
            manager.put(kakao.maps.drawing.OverlayType.POLYLINE, path);
           
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
    //------------------------------------
    //----------DrawingMap DataBind  END  Not Map
    //------------------------------------


   



        //------------------------------------
        //----------From Post START
        //------------------------------------
    var inputMapData = JSON.parse(document.getElementById("mapData").value);    
    if (inputMapData != "" && inputMapData != [] && inputMapData != null && inputMapData != '""') {
        setDrawingMapData(inputMapData);
        closeCusOverlay();
        refreshOverlayListener();
    }


    TravelRouteList = JSON.parse(document.getElementById("mapRoute").value);
    if (TravelRouteList != "" && TravelRouteList != [] && TravelRouteList != null && TravelRouteList != '""') {
        refreashTravelRoute();
    }

    CostItemList = JSON.parse(document.getElementById("mapCost").value);
    if (CostItemList != "" && CostItemList != [] && CostItemList != null && CostItemList != '""') {
        refreashCostItem();
    }
         //------------------------------------
        //----------From Post END
        //------------------------------------



</script>
        
</body>
</html>
