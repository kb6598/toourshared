<%@ Page Language="C#"  EnableEventValidation="false" ValidateRequest="false" Debug="true"%>

<%@ Import Namespace="System.IO" %>  


<!DOCTYPE html>

<script runat="server">



    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("./index.aspx");
    }
    protected void btnMypage_Click(object sender, EventArgs e)
    {
        Response.Redirect("./MyPage.aspx");
    }
    protected void btnJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("./join.aspx");
    }
    protected void btnFindIDPW_Click(object sender, EventArgs e)
    {
        Response.Redirect("./find_idpw.aspx");
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
            Response.Redirect("./index.aspx");
        }

        //status -> 편집 페이지 정보
        //세션 status가 비어있다면 새로운 status 생성
        if (HttpContext.Current.Session["write_status"] == null)
        {



            // create Travel
            Travel inTravel = new Travel();
            inTravel.Mem_id = HttpContext.Current.Session["mem_id"].ToString();
            inTravel.Trv_create_time = TimeLib.GetTimeStamp();
            inTravel.Trv_secret = 0.ToString();
            inTravel.Trv_timestamp = TimeLib.GetTimeStamp();
            inTravel.Trv_title = Request.Form["title"];
            inTravel.Trv_tot_rate = 0.ToString();
            inTravel.Trv_views = 0.ToString();

            // insert new travel
            TravelDao travelDao = new TravelDao();
            string trv_no = travelDao.InsertTravel(inTravel);



            //create travel_day
            Travel_Day travel_Day = new Travel_Day();

            travel_Day.Trv_no = trv_no;
            Travel_DayDao travel_DayDao = new Travel_DayDao();
            //insert new travel_day
            string trv_day_no = travel_DayDao.InsertTravel_Day(travel_Day);


            //create map
            Map inMap = new Map();
            MapDao mapDao = new MapDao();
            // insert new map
            inMap.Trv_day_no = trv_day_no;
            mapDao.InsertMap(inMap);

            // 현재폼 정보를 저장할 딕셔너리 생성 나중에 세션에 넘겨줌
            Dictionary<string, string> newWriteStatus = new Dictionary<string, string>()
            {
                { "trv_no", trv_no},
                { "cur_trv_day_no",trv_day_no},
                { "cur_day","1"},
                {"1",trv_day_no }

            };
            Session["write_status"] = newWriteStatus;





        }
        Dictionary<string, string> readWriteStatus = SessionLib.getWriteStatus();
        foreach (var item in readWriteStatus)
        {
            Response.Write(item.Key + " : " + item.Value + "<br/>");
        }

    }
    protected void BindTables()
    {


        Dictionary<string, string> readWriteStatus = SessionLib.getWriteStatus();
        if (readWriteStatus != null)
        {
            // 일차수 표시
            Literal_day.Text = readWriteStatus["cur_day"];

            //Travel Day 가져오기
            Travel_Day inputTravel_day = new Travel_Day();
            Travel_Day outputTravel_day = new Travel_Day();
            Travel_DayDao Travel_daydao = new Travel_DayDao();

            inputTravel_day.Trv_day_no = readWriteStatus["cur_trv_day_no"];
            outputTravel_day = Travel_daydao.selectTrvel_DayBytrv_day_no(inputTravel_day);

            article.Text = outputTravel_day.Trv_day_content;

            //Travel 가져오기
            Travel inputTravel = new Travel();
            Travel outputTravel = new Travel();
            TravelDao daoTravel = new TravelDao();
            inputTravel.Trv_no = readWriteStatus["trv_no"];
            outputTravel = daoTravel.selectTravelBytrv_no(inputTravel);

            // 바인드
            title.Text = outputTravel.Trv_title;
            hashtag.Text = outputTravel.Trv_tag;
            if(outputTravel.Trv_main_img != null && outputTravel.Trv_main_img != "")
            {
                mainImgItem.ImageUrl = outputTravel.Trv_main_img;
            }
            else
            {
                mainImgItem.ImageUrl = "./img/noImage.png";
            }

            main_img.Value = outputTravel.Trv_main_img;

            //Map 가져오기
            Map inputMap = new Map();
            Map outputMap = new Map();
            MapDao daoMap = new MapDao();
            inputMap.Trv_day_no = outputTravel_day.Trv_day_no;
            outputMap = daoMap.selectMapByTrv_day_no(inputMap);
            mapData.Value = outputMap.Map_data;
            mapCost.Value = outputMap.Map_cost;
            mapRoute.Value = outputMap.Map_route;
            mapCenter.Value = outputMap.Map_center;







        }

    }




    protected void BindDropDownList()
    {
        Dictionary<string, string> readWriteStatus = SessionLib.getWriteStatus();
        if (readWriteStatus != null)
        {
            int i = 1;
            string option = "";

            while (true)
            {
                if (!readWriteStatus.ContainsKey(i.ToString())) break;
                // 들어가는 값이 현재일과 같을경우 option을 selected 요소로 추가
                if(i.ToString().Equals(readWriteStatus["cur_day"]))
                {
                    Literal_goDay.Text += "<option value='"+i.ToString()+"' selected>"+i.ToString()+" 일차</option>";
                }
                else
                {
                    Literal_goDay.Text += "<option value='"+i.ToString()+"'>"+i.ToString()+" 일차</option>";
                }

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


    protected void Page_Load(object sender, EventArgs e)
    {

        WriteSessionProcess();
        BindDropDownList();

        BindTables();
    }




</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>TO OUR SHARED : 글 작성 #일차</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Mansalva|Nanum+Gothic|Nanum+Myeongjo|Noto+Sans+KR|Lora|East+Sea+Dokdo|Jua&amp;display=swap" rel="stylesheet" />

    <!-- ICON -->
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

    <!-- KaKao -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>
    
    <!--Summer note + Ajax-->
  <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>

   <link rel="stylesheet" href="./css/write.css">
  <style>
        // summer note 이미지 삽입시 뜨는 창 스타일 처리
        .note-modal-content {
            margin-top: 30%;
        }


        .travelRoute-content,
        .cost-body {

            overflow: auto;
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

        /* TextArea Summernote */
        $(document).ready(function () {
            $('#article').summernote({
                height: 600, //set editable area's height
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

                    <asp:TextBox ID="title"  runat="server" type="text" placeholder="게시글의 제목을 정해주세요." autocomplete="off" onkeyup="tmpSaveByEnter()"/>
                </div>
                <div class="TitleSub">
                    <div class="SubItem">
                        <span>
                            <asp:Literal ID="Literal_day" runat="server"></asp:Literal>일 차 작성 중...
                        </span>
                    </div>
                    <div class="SubItem">
                        <select name="goDay" id="goDay" class="goDay" onchange="gotoDay()">
                            <asp:Literal ID="Literal_goDay" runat="server"></asp:Literal>
                        </select>
                    </div>
                    <div class="SubItem">
                        <div  class="nextPageBtn">
                            <div onclick ="addDay()" class="subAddItem">일 추가 (+)</div>
                        </div>
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
                            <button type="button" data-toggle="modal" data-target="#searchPlaceModal">
                                <p>🍳</p>
                                <p>장소검색</p>
                            </button>
                            <div class="dropdown">
                                <button class="dropdown-toggle TILAST" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <p>🍳</p>
                                    <p>주변검색</p>
                                </button>
                                <div id="category" class="dropdown-menu">                                                                     
                                            <a id='MT1' class="dropdown-item" data-order="0">  대형마트</a>
                                            <a id='CS2' class="dropdown-item" data-order="1">  편의점</a>
                                            <a id='PS3' class="dropdown-item" data-order="2">  어린이집, 유치원</a>
                                            <a id='SC4' class="dropdown-item" data-order="3">  학교</a>
                                            <a id='AC5' class="dropdown-item" data-order="4">  학원</a>
                                            <a id='PK6' class="dropdown-item" data-order="5">  주차장</a>
                                            <a id='OL7' class="dropdown-item" data-order="6">  주유소, 충전소</a>
                                            <a id='SW8' class="dropdown-item" data-order="7">  지하철역</a>
                                            <a id='BK9' class="dropdown-item" data-order="8">  은행</a>
                                            <a id='CT1' class="dropdown-item" data-order="9">  문화시설</a>
                                            <a id='AG2' class="dropdown-item" data-order="10"> 중개업소</a>
                                            <a id='PO3' class="dropdown-item" data-order="11"> 공공기관</a>
                                            <a id='AT4' class="dropdown-item" data-order="12"> 관광명소</a>
                                            <a id='AD5' class="dropdown-item" data-order="13"> 숙박</a>
                                            <a id='FD6' class="dropdown-item" data-order="14"> 음식점</a>
                                            <a id='CE7' class="dropdown-item" data-order="15"> 카페</a>
                                            <a id='HP8' class="dropdown-item" data-order="16"> 병원</a>
                                            <a id='PM9' class="dropdown-item" data-order="17"> 약국</a>                                   
                                </div>
                            </div>


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
                    <asp:TextBox ID="article" runat="server" TextMode="MultiLine" type="text"  name="article" onkeyup="tmpSaveByEnter()"></asp:TextBox>
                </div>
            </div>

            <!-- 메인페이지 영역 -->
            <div class="mainImgArea">
                <div class="mainImg_wrap">
                    <div class="mainImg_AlignLeft">
                        <div class="mainImg_Label" >게시글의 메인이미지를 첨부하세요.</div>
                        <div class="mainImg_Input">
                            <!-- 이미지 업로드 -->
                            <input type="file" class="upload"  id="FileUpload_main_img" accept="image/*" multiple="false"/>
                            <asp:HiddenField ID="main_img" runat="server" Value="noImage"/>

                            
                            <!-- 이미지 업로드 -->

                        </div>
                    </div>
                    <div class="mainImg_AlignRight">
                        <!-- 이미지 미리보기 부분-->
                        <asp:Image ID="mainImgItem" runat="server" ImageUrl="~/img/noImage.png" alt="userMainImage" />
                        <!-- 이미지 미리보기 부분-->
                    </div>
                </div>
            </div>

            <!-- 해쉬태그 영역 -->
            <div class="hashArea">
                <asp:TextBox ID="hashtag" runat="server" type="text" placeholder="해쉬태그를 입력하세요. (ex : #여행 #추억) (스페이스바로 구분지어 주세요.)" class="hashAreaItem" onkeyup="tmpSaveByEnter()"/>
            </div>

            <!-- 하단부 영역 -->
            <div class="btnArea">
                <!-- 임시 저장 버튼 -->
                <div class="tempSaveBtn">
                    <div onclick ="tmpSave()" class="btnAreaItem">임시 저장</div>
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
                                    <input id="keyword" value="" type="text" onkeyup="searchPlacesByEnter();" />
                                    <div class="btn btn-secondary" onclick="searchPlaces();">검색하기</div>
                                </div>
                            </div>
                            <hr />
                            <ul id="placesList"></ul>
                            <div id="pagination"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="btn btn-secondary" data-dismiss="modal">Close</div>
                    </div>
                </div>
            </div>
        </div>
                <asp:HiddenField ID="mapData" runat="server" />
        <asp:HiddenField ID="mapRoute" runat="server" />
        <asp:HiddenField ID="mapCost" runat="server" />
        <asp:HiddenField ID="mapCenter" runat="server" />

    </form>

 

       





        <!-- KAKAO 

 <script src="./javascript/write.js"></script>
  
-->  
  
    <script>
        //사용자 편의 기능 

        // 자동 저장 액션 5분마다 / 300초
        setInterval(function() {
            tmpSave(false);
        }, 300000);



        //윈도우에서 엔터 백스페이스 막기
        window.onkeydown = function() {
            var kcode = event.keyCode;
            if (window.event.keyCode == 13 || kcode == 116) event.returnValue = false;
        }






        //엔터키를 통한 임시저장
        function tmpSaveByEnter() {
            var kcode = event.keyCode;
            if (window.event.keyCode == 13) {
                tmpSave(false);
            }

        }



        function searchPlacesByEnter() {
            var kcode = event.keyCode;
            if (window.event.keyCode == 13) {
                searchPlaces();
            }
        }


        function setTravelRouteItemInfoByEnter(index) {

            var kcode = event.keyCode;
            if (window.event.keyCode == 13) {
                setTravelRouteItemInfo(index);
            }

        }


        function setTravelRouteItemNameByEnter(index) {
            var kcode = event.keyCode;
            if (window.event.keyCode == 13) {
                setTravelRouteItemName(index);
            }

        }

    </script>

    <script>
        //이미지 업로드 AJAX
        function sendFile(file) {

            var formData = new FormData();
            formData.append('file', $('#FileUpload_main_img')[0].files[0]);
            $.ajax({
                type: 'post',
                url: './imageUploader.ashx',
                data: formData,
                success: function(status) {
                    if (status != 'error') {
                        var my_path = status;
                        $("#mainImgItem").attr("src", my_path);
                        $("#main_img").attr("value", my_path);
                    }
                },
                processData: false,
                contentType: false,
                error: function() {
                    alert("Whoops something went wrong!");
                }
            });
        }

        var _URL = window.URL || window.webkitURL;
        $("#FileUpload_main_img").on('change', function() {

            var file, img;
            if ((file = this.files[0])) {
                img = new Image();
                img.onload = function() {
                    sendFile(file);
                };
                img.onerror = function() {
                    alert("Not a valid file:" + file.type);
                };
                img.src = _URL.createObjectURL(file);
            }

        });

    </script>


    <script>
        // Drawing Manager로 도형을 그릴 지도 div
        var drawingMapContainer = document.getElementById('drawingMap'),
            drawingMap = {
                center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };
        
        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        //var drawingMap = new daum.maps.Map(drawingMapContainer, mapOption);
        var drawingMap = new daum.maps.Map(drawingMapContainer, drawingMap);


        // 지도 타입 변경 컨트롤을 생성한다
        var mapTypeControl = new kakao.maps.MapTypeControl();

        // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
        drawingMap.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        // 지도에 확대 축소 컨트롤을 생성한다
        var zoomControl = new kakao.maps.ZoomControl();

        // 지도의 우측에 확대 축소 컨트롤을 추가한다
        drawingMap.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);



        var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
            map: drawingMap, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
            drawingMode: [ // Drawing Manager로 제공할 그리기 요소 모드입니다
                daum.maps.drawing.OverlayType.ARROW,
                daum.maps.drawing.OverlayType.CIRCLE,
                daum.maps.drawing.OverlayType.ELLIPSE,
                daum.maps.drawing.OverlayType.MARKER,
                daum.maps.drawing.OverlayType.POLYLINE,
                daum.maps.drawing.OverlayType.POLYGON,
                daum.maps.drawing.OverlayType.RECTANGLE
            ],
            // 사용자에게 제공할 그리기 가이드 툴팁입니다
            // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
            guideTooltip: ['draw', 'drag', 'edit'],
            arrowOptions: {
                draggable: true,
                removable: true,
                editable: true,
                strokeWeight: 3,
                strokeOpacity: 0.8,
                strokeColor: '#39f',
                strokeStyle: 'solid',
                hintStrokeStyle: 'dashdot',
                hintStrokeOpacity: 0.3,
                startArrow: false
            },
            circleOptions: {
                draggable: true,
                removable: true,
                editable: true,
                strokeColor: '#39f',
                fillColor: '#39f',
                fillOpacity: 0.5
            },
            ellipseOptions: {
                draggable: true,
                removable: true,
                editable: true,
                strokeWeight: 2,
                strokeOpacity: 0.8,
                strokeColor: '#39f',
                strokeStyle: 'solid',
                fillColor: '#39f',
                fillOpacity: 0.3
            },
            markerOptions: { // 마커 옵션입니다
                draggable: false, // 마커를 그리고 나서 드래그 가능하게 합니다
                removable: false, // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다
                markerImages: [
                    null, // API에서 제공하는 기본 마커 이미지
                    {
                        src: 'http://t1.daumcdn.net/localimg/localimages/07/2009/map/icon/ico_mn_13.png',
                        width: 31,
                        height: 35,
                        shape: 'rect',
                        coords: '0,0,31,35',
                        hoverImage: {
                            src: 'http://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_normal.png',
                            width: 33,
                            height: 36,
                            offsetX: 12,
                            offsetY: 36,
                            spriteWidth: 644,
                            spriteHeight: 946,
                            spriteOriginX: 10,
                            spriteOriginY: 10
                        },
                        dragImage: {
                            src: 'http://t1.daumcdn.net/localimg/localimages/07/2012/attach/pc_img/ico_comm.png',
                            width: 20, // 마커 크기
                            height: 20, // 마커 크기
                            offsetX: 10, // 지도에 고정시킬 이미지 내 위치 좌표
                            offsetY: 20, // 지도에 고정시킬 이미지 내 위치 좌표
                            spriteWidth: 118, // 이미지 전체 크기
                            spriteHeight: 111, // 이미지 전체 크기
                            spriteOriginX: 0, // 이미지 중 마커로 사용할 위치
                            spriteOriginY: 90 // 이미지 중 마커로 사용할 위치
                        }
                    }
                ]
            },
            polylineOptions: { // 선 옵션입니다
                draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
                removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
                editable: true, // 그린 후 수정할 수 있도록 설정합니다
                strokeColor: '#39f', // 선 색
                hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
                hintStrokeOpacity: 0.5 // 그리중 마우스를 따라다니는 보조선의 투명도
            },
            polygonOptions: {
                draggable: true,
                removable: true,
                editable: true,
                strokeColor: '#39f',
                fillColor: '#39f',
                fillOpacity: 0.5,
                hintStrokeStyle: 'dash',
                hintStrokeOpacity: 0.5
            },
            rectangleOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeColor: '#39f', // 외곽선 색
                fillColor: '#39f', // 채우기 색
                fillOpacity: 0.5 // 채우기색 투명도
            }

        };

        // 위에 작성한 옵션으로 Drawing Manager를 생성합니다
        var manager = new daum.maps.drawing.DrawingManager(options);








        // 버튼 클릭 시 호출되는 핸들러 입니다
        function selectOverlay(type) {
            // 그리기 중이면 그리기를 취소합니다
            manager.cancel();

            // 클릭한 그리기 요소 타입을 선택합니다
            manager.select(daum.maps.drawing.OverlayType[type]);
        }









        // drawManager의 상태가 변경되고
        // travelRoute와 변경
        manager.addListener('state_changed', function() {
            closeCusOverlay();
            //console.info(this._historyStroage);
            refreshOverlayListener();


        });
        // e 는 삭제되는 대상 오버레이가 삭제될때 listener 삭제
        // 대상이 삭제되면 listener 도 같이 삭제됨
        // 애초에 리스너가 ExtenedMarker의 부분 요소로 들어가기 때문에
        // 같이 삭제됨
        manager.addListener('remove', function(e) {

        });
        //http://localhost:49862/


        function refreshOverlayListener() {
            var data = manager.getOverlays();
            //var overlayType = ["circle", "ellipse", "marker", "polygon", "rectangle"];
            var overlayType = ["marker"];
            overlayType.forEach(function(overlay, overlayIndex, overlayArray) {
                // 각 오버레이들은 길이가 0인 배열로 최초부터 존제
                //if (data[overlay] != null) {
                if (data[overlay].length > 0) {
                    //현재 상태와 이전 상태의 오버레이 갯수가 같다면 해당 리스트 전부 새로고침
                    //console.info(overlay + " : " + data[overlay]._index + "를 새로 고침");
                    data[overlay].forEach(function(value, index, array) {
                        try {
                            //removeListener 시도
                            // 리스너를 만드는중에 오버레이를 전달
                            kakao.maps.event.removeListener(value, 'click', onClick_overlay);
                        } catch (exception) {
                            //console.info(exception);
                        } finally {
                            kakao.maps.event.addListener(value, 'click', onClick_overlay);
                        }


                    });

                }
            });
        }


        //주소 - 좌표간 변환 서비스 객체를 생성한다.
        var geocoder = new kakao.maps.services.Geocoder();

        var customOverlay = new kakao.maps.CustomOverlay({
            xAnchor: 0.5,
            yAnchor: 1.25,
            zIndex: 3
        });

        function closeCusOverlay() {
            customOverlay.setMap(null);
        }

        manager.addListener('drawend', function(data) {
            console.log('drawend', data);
            if (data.overlayType == 'marker') {



                pushTravelRouteItem("", "", "", "", "", "", "");
            }
        });







        //-----------------------------------------------
        // 클릭시 발생하는 이벤트
        //----------------------------------------------
        var onClick_overlay = function() {

            //console.info(overlay.constructor.name + '_' + overlay._index);

            //console.info("onClick_overlay");
            //alert(this._index + "번째 마커" + "\nk : " + this.k + "\nGa : " + this.k.Ga + "\nHa : " + this.k.Ha + '\nMARKER click!');
            //console.info(this);
            //console.info(overlay);
            //---- 오버레이 타입마다 좌표가 존재하는 위치가 다름

            var coord_WCONGNAMUL = getWCONGNAMULFromOverlay(this);
            console.info("-------------------------------------------- 현재 마커는");
            console.info(this);
            var curMkrOrder = this._order;
            var trvRoute = getTravelRouteByOrder(curMkrOrder);

            //----좌표값으로 주소를 가져옴
            geocoder.coord2Address(coord_WCONGNAMUL.wcongnamulX, coord_WCONGNAMUL.wcongnamulY, function(result, status) {


                if (status === kakao.maps.services.Status.OK) {
                    //console.info(result);

                    var content = "<div>ok</div>";
                    var keyword = document.getElementById('keyword');



                    //주소가 있다면 검색
                    if (result[0].address != null) {
                        if (result[0].address.address_name != null) {
                            //                                keyword.value = result[0].address.address_name;
                            //                                //
                            //                                ps.keywordSearch(keyword.value, placesSearchByStateChange);
                            //                                $('#searchPlaceModal').modal('show');



                            content =


                                '<div class="card card-cus" style="width:300px;">' +
                                '<div class="card-header">' +
                                '<div class="card-title">' +
                                '<input id="cuov-name" class="form-control card-input" type="text" placeholder="장소 이름" value="' + trvRoute.place_name + '" />' +
                                '</div>' +
                                '<div class="card-close">' +
                                '<div class="closeBtn" onclick="closeCusOverlay()">' +
                                '<span>×</span>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '<div class="card-body">' +
                                '<blockquote class="blockquote mb-0">';

                            if (result[0].address.address_name != null) {
                                content += '<li class="card-body-li">' + result[0].address.address_name + '</li>';
                            }
                            content +=
                                '<li class="card-body-li"> </li>' +
                                '<li class="card-body-li"> </li>' +
                                '</blockquote>' +
                                '<table style="margin-top: 10px;"><tr>' +
                                '<td>';
                            if (result[0].address.address_name != null) {
                                content += '<div class="card-addBtn" onclick=\'searchPlacesByAddress("' + result[0].address.address_name + '")\'>주소로 검색</div>'
                            } else {
                                content += '<div class="card-addBtn" onclick=\'searchPlacesByAddress("' + result[0].address.road_address_name + '")\'>주소로 검색</div>'
                            }
                            content += '<div class="btn btn-danger btn-sm" onclick="removeMarkNTrvRouteByOrder(' + curMkrOrder + ')">삭제</div>' +
                                '</td>' +
                                '</tr></table>' +
                                '</div>';


                        }
                    }




                    geocoder.transCoord(coord_WCONGNAMUL.wcongnamulX, coord_WCONGNAMUL.wcongnamulY,
                        function(result, status) {

                            // 정상적으로 검색이 완료됐으면
                            if (status === kakao.maps.services.Status.OK) {
                                customOverlay.setPosition(new kakao.maps.LatLng(result[0].y, result[0].x));
                                customOverlay.setContent(content);
                                customOverlay.setMap(drawingMap);
                            }
                        }, {
                            input_coord: kakao.maps.services.Coords.WCONGNAMUL, // 변환을 위해 입력한 좌표계 입니다
                            output_coord: kakao.maps.services.Coords.WGS84 // 변환 결과로 받을 좌표계 입니다
                        });

                }
            }, {
                input_coord: kakao.maps.services.Coords.WCONGNAMUL
            });


        }




        function getWCONGNAMULFromOverlay(overlay) {
            var wcongnamulX;
            var wcongnamulY;
            if (overlay.constructor.name == "ExtendsMarker") {
                wcongnamulX = overlay.k.Ga;
                wcongnamulY = overlay.k.Ha;
            } else if (overlay.constructor.name == "ExtendsCircle") {
                wcongnamulX = overlay.k.Ga;
                wcongnamulY = overlay.k.Ha;
            } else if (overlay.constructor.name == "ExtendsRectangle") {
                //ExtendedRectangle has za{ea,ja,ka,la} as coords
                wcongnamulY = (overlay.za.ka + overlay.za.la) / 2;
                wcongnamulX = (overlay.za.ea + overlay.za.ja) / 2;
            } else if (overlay.constructor.name == "ExtendsPolygon") {
                //ExtendedPolygon has ig{0: {ga: ha:}, }
                var gaTotal = 0;
                var haTotal = 0;
                overlay.Ig.forEach(function(value, index, array) {
                    gaTotal += value.Ga;
                    haTotal += value.Ha;
                });
                wcongnamulX = gaTotal / overlay.Ig.length;
                wcongnamulY = haTotal / overlay.Ig.length;
            } else if (overlay.constructor.name == "ExtendsEllipse") {
                wcongnamulX = overlay.k.Ga;
                wcongnamulY = overlay.k.Ha;
            }
            return {
                "wcongnamulX": wcongnamulX,
                "wcongnamulY": wcongnamulY
            };
        }



        // 검색 시스템
        function openCatego() {

            $('.dropdown-toggle').dropdown('show');
        }


        var find_AroundMarkers = [];

        //카테고리 검색시 지도의 중심 좌표를 가져오기 위해 사용
        var ps = new kakao.maps.services.Places(drawingMap);

        // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            zIndex: 1
        });



        // 키워드 검색을 요청하는 함수입니다
        function searchPlaces() {

            var keyword = document.getElementById('keyword').value;

            if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }

            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword, placesSearchCB);
        }
        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {

                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);

                // 페이지 번호를 표출합니다
                displayPagination(pagination);

            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                alert('검색 결과가 존재하지 않습니다.');
                return;

            } else if (status === kakao.maps.services.Status.ERROR) {

                alert('검색 결과 중 오류가 발생했습니다.');
                return;

            }
        }


        // 키워드(주소를 통해서 ) 주변 검색을 요청하는 함수입니다
        function searchPlacesByAddress(address) {
            //주변검색을 하며 해당 마커는 삭제합니다.
            //console.info(curOverlay[0]);
            //manager.remove(curOverlay[0]);


            var keyword = document.getElementById('keyword');
            keyword.value = address;

            if (!keyword.value.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }

            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword.value, placesSearchByAddressCB);
        }

        // 키워드(주소를 통해서 ) 주변 검색이 완료되었을때 호출되는 콜백함수 입니다
        function placesSearchByAddressCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {


                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);

                // 페이지 번호를 표출합니다
                displayPagination(pagination);
                $('#searchPlaceModal').modal('show');
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                //                alert('검색 결과가 존재하지 않아 더 넓은 주소로 찾습니다.');
                //                var keyword = document.getElementById('keyword');
                //                var keywordArr = keyword.value.split(' ');
                //
                //                console.info(keywordArr);
                //                var str = "";
                //
                //                for (var i = 0; i < keywordArr.length - 1; i++) {
                //                    str += keywordArr[i] + " ";
                //                }
                //
                //
                //
                //                //console.info(str);
                //                keyword.value = str;
                //                ps.keywordSearch(keyword.value, placesSearchByAddressCB);
                return;

            } else if (status === kakao.maps.services.Status.ERROR) {

                alert('검색 결과 중 오류가 발생했습니다.');
                return;

            }
        }








        // 검색 결과 목록과 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            var listEl = document.getElementById('placesList'),
                menuEl = document.getElementById('menu_wrap'),
                fragment = document.createDocumentFragment(),
                bounds = new kakao.maps.LatLngBounds(),
                listStr = '';


            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(listEl);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();

            for (var i = 0; i < places.length; i++) {

                // 마커를 생성하고 지도에 표시합니다
                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                    marker = addMarker(placePosition, i),
                    itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                // LatLngBounds 객체에 좌표를 추가합니다
                bounds.extend(placePosition);

                // 마커와 검색결과 항목에 mouseover 했을때
                // 해당 장소에 인포윈도우에 장소명을 표시합니다
                // mouseout 했을 때는 인포윈도우를 닫습니다
                (function(marker, place) {
                    kakao.maps.event.addListener(marker, 'click', function() {
                        displayInfowindow(marker, place);
                    });

                    itemEl.onmouseover = function() {
                        displayInfowindow(marker, place);
                    };

                    itemEl.onmouseclick = function() {
                        displayInfowindow(marker, place);
                        $('#searchPlaceModal').modal('hide');

                    };

                })(marker, places[i]);

                fragment.appendChild(itemEl);
            }

            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            //map.setBounds(bounds);
            drawingMap.setBounds(bounds);
        }

        class Place {
            constructor(place_name, road_address_name, address_name, phone, place_url, x, y) {
                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;
            }
            setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;
            }
        }

        var CurPlaceList = Array();



        // 검색결과 항목을 Element로 반환하는 함수입니다
        function getListItem(index, places) {

            var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                '<div class="info">' +
                '   <h5 data-dismiss="modal">' + places.place_name + '</h5>';

            if (places.road_address_name) {
                itemStr += '    <span data-dismiss="modal">' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray" data-dismiss="modal">' + places.address_name + '</span>';
            } else {
                itemStr += '    <span data-dismiss="modal">' + places.address_name + '</span>';
            }

            itemStr += '  <span class="tel">' + places.phone + '</span>' +
                '</div>';

            el.innerHTML = itemStr;
            el.className = 'item';

            return el;
        }

        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarker(position, idx, title) {
            var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
                imgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                });

            marker.setMap(drawingMap); // 지도 위에 마커를 표출합니다
            find_AroundMarkers.push(marker); // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
            for (var i = 0; i < find_AroundMarkers.length; i++) {
                find_AroundMarkers[i].setMap(null);
            }
            find_AroundMarkers = [];
        }

        // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
        function displayPagination(pagination) {
            var paginationEl = document.getElementById('pagination'),
                fragment = document.createDocumentFragment(),
                i;

            // 기존에 추가된 페이지번호를 삭제합니다
            while (paginationEl.hasChildNodes()) {
                paginationEl.removeChild(paginationEl.lastChild);
            }

            for (i = 1; i <= pagination.last; i++) {
                var el = document.createElement('a');
                el.href = "#";
                el.innerHTML = i;

                if (i === pagination.current) {
                    el.className = 'on';
                } else {
                    el.onclick = (function(i) {
                        return function() {
                            pagination.gotoPage(i);
                        }
                    })(i);
                }

                fragment.appendChild(el);
            }
            paginationEl.appendChild(fragment);
        }

        // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
        // 인포윈도우에 장소명을 표시합니다
        function displayInfowindow(marker, place) {

            var content =
                '<div class="card card-cus" style="width:300px;">' +
                '<div class="card-header">' +
                '<div class="card-title">' +
                place.place_name +
                '</div>' +
                '<div class="card-close">' +
                '<div class="closeBtn" onclick="closeOverlay()">' +
                '<span >×</span>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="card-body">' +
                '<blockquote class="blockquote mb-0">';
            if (place.road_address_name != null) {
                content += '<li class="card-body-li">' + place.road_address_name + '</li>';
            }
            if (place.address_name != null) {
                content += '<li class="card-body-li">' + place.address_name + '</li>';
            }
            if (place.phone != null) {
                content += '<li class="card-body-li">' + place.phone + '</li>';
            }
            if (place.place_url != null) {
                content += '<li class="card-body-li" style="padding: 15px 0;"><a href="' + place.place_url + '" target="_blank" style="text-decoration: none;">상세페이지</a></li>';
            }
            content +=
                '</blockquote>' +
                '<div class="card-addBtn" onclick=\'AddMarkerWithTravelRouteItem("' + place.place_name + '","' + place.road_address_name + '","' + place.address_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>추가</div>' +
                '</div>' +
                '</div>';



            infowindow.setContent(content);
            infowindow.open(drawingMap, marker);
        }
        // 모든 인포윈도우 닫음
        function closeOverlay() {
            infowindow.close();
        }


        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }

        //------------------------------------
        //----------TravelRouteItem and travelRouteList Start
        //------------------------------------
        var TravelOrder = 0;
        class TravelRouteItem {
            constructor(place_name, road_address_name, address_name, phone, place_url, x, y) {
                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;
                this.info = "";
                this.order = TravelOrder;
                TravelOrder++;
            }
            setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

                this.place_name = place_name;
                this.road_address_name = road_address_name;
                this.address_name = address_name;
                this.phone = phone;
                this.place_url = place_url;
                this.x = x;
                this.y = y;

            }
            setName(place_name) {
                this.place_name = place_name;
            }
            setInfo(info) {
                this.info = info;
            }

        }

        var TravelRouteList = Array();

        function refreashTravelRoute() {

            var travelRouteUl = document.getElementById('travelRoute'),
                trBody = document.getElementById('trBody'),
                fragment = document.createDocumentFragment(),
                itemList = '',
                el;

            ;

            // costBody 모든 자식 노드 삭제
            while (travelRouteUl.hasChildNodes()) {
                travelRouteUl.removeChild(travelRouteUl.firstChild);
            }
            TravelRouteList.forEach(function(currentValue, index) {

                ////console.info(index);
                ////console.info(currentValue);
                el = document.createElement('li'),
                    itemStr =

                    '<div class="travelRouteItem-header">' +
                    ' <div class="form-group">' +
                    ' <table>' +
                    ' <tr>' +
                    ' <td>' +
                    ' <input id="addTravelRoute_place_name_' + index + '" class="form-control" type="text" placeholder="장소 이름" value="' + currentValue.place_name + '" />' +
                    ' </td>' +
                    ' <td>' +
                    ' <div class="btn btn-danger btn-sm" onclick="removeTravelRouteItem(' + index + ')"> x </div>' +
                    ' </td>' +
                    ' </tr>' +
                    '</table>' +
                    ' </div>' +
                    '</div>' +
                    ' <div>' +
                    '<table>' +
                    '<tr>' +
                    '<td>' +
                    ' <textarea id="addTravelRoute_info_' + index + '" class="form-control" type="text" placeholder="설명" rows="3" style="resize: none;overflow: auto;">' + currentValue.info + '</textarea>' +
                    '</td>' +
                    '</tr>' +
                    '</table>';

                if (currentValue.address_name != "" && currentValue.address_name != "undefined") {
                    itemStr += currentValue.address_name + '<br/>';

                }
                if (currentValue.road_address_name != "" && currentValue.road_address_name != "undefined") {
                    itemStr += currentValue.road_address_name + '<br/>';

                }
                if (currentValue.phone != "" && currentValue.phone != "undefined") {
                    itemStr += currentValue.phone + '<br/>';

                }
                itemStr += '<a class="btn btn-primary btn-sm" href="' + currentValue.place_url + '" target="_blank">상세페이지</a>';




                itemStr += '</div>';
                el.innerHTML = itemStr;
                el.setAttribute("draggable", 'true');
                el.setAttribute("class", "travelPoint");
                el.setAttribute("id", "travelPoint_" + index);



                var itemEl = el;

                fragment.appendChild(itemEl);

                travelRouteUl.appendChild(fragment);



            });

            var trBodyStr = '방문 : ' + TravelRouteList.length;
            ////console.info(trBody);
            trBody.innerHTML = trBodyStr;


            dragAndDropAction();

        }







        function AddMarkerWithTravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y) {
            pushTravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y);

            var position = new kakao.maps.LatLng(y, x);
            manager.put(kakao.maps.drawing.OverlayType.MARKER, position, 0);

            ///글작성 
            closeAllOverlay();
            closeAllSearchedMarkers();


        }








        function pushTravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y) {

            TravelRouteList.push(new TravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y));
            addCostItemParent(place_name);
            refreashTravelRoute();
            closeOverlay();
            closeCusOverlay();

        }

        // TravelROute 삭제시 마커도 같이 삭제되도록 하는 함수
        function removeTravelRouteItem(index) {
            var removingOrder = TravelRouteList[index].order;
            checkMarkerNRemove(removingOrder);
            TravelRouteList.splice(index, 1);
            removeCostItemParent(index);
            refreashTravelRoute();

        }



        // TravelROute 삭제함수
        function removeTravelRouteItem(index) {
            var removingOrder = TravelRouteList[index].order;
            checkMarkerNRemove(removingOrder);
            TravelRouteList.splice(index, 1);
            removeCostItemParent(index);
            refreashTravelRoute();

        }

        // manger의 마커의 order의 값을 비교하여 삭제 

        function checkMarkerNRemove(order) {
            var markers = manager.getOverlays([kakao.maps.drawing.OverlayType.MARKER]);
            markers.marker.forEach(function(value, idx, arr) {
                if (value._order == order) {
                    manager.remove(value);
                }
            });
        }



        // order를 입력받아 travelRoute와 marker 삭제
        function removeMarkNTrvRouteByOrder(order) {
            TravelRouteList.forEach(function(val, idx, arr) {
                if (val.order == order) {
                    TravelRouteList.splice(idx, 1);
                    removeCostItemParent(idx);
                    refreashTravelRoute();
                }

            });




            var markers = manager.getOverlays([kakao.maps.drawing.OverlayType.MARKER]);
            markers.marker.forEach(function(value, idx, arr) {
                if (value._order == order) {
                    manager.remove(value);
                }
            });
        }


        function getTravelRouteByOrder(order) {
            TravelRouteList.forEach(function(val, idx, arr) {
                if (val.order == order) {
                    return TravelRouteList[idx];

                }

            });
            return {};
        }

        function setTravelRouteNameByOrder(order, name) {
            TravelRouteList.forEach(function(val, idx, arr) {
                if (val.order == order) {
                    TravelRouteList[idx].setName(name);

                }

            });
            return [];
        }



        function setTravelRouteItem(index, place_name, road_address_name, address_name, phone, place_url, x, y) {


            TravelRouteList[index].setRoute(place_name, road_address_name, address_name, phone, place_url, x, y);
            refreashTravelRoute();
        }

        function setTravelRouteItemName(index) {

            var addTravelRoute_place_nameId = "addTravelRoute_place_name_" + index;
            var place_name = document.getElementById(addTravelRoute_place_nameId).value;
            TravelRouteList[index].setName(place_name);
            refreashTravelRoute();

            setCostItemParentName(index);
        }

        function setTravelRouteItemInfo(index) {

            var addTravelRoute_infoId = "addTravelRoute_info_" + index;
            var info = document.getElementById(addTravelRoute_infoId).value;
            TravelRouteList[index].setInfo(info);
            refreashTravelRoute();

            setCostItemParentName(index);
        }




        function swapTravelRouteItem(fIndex, sIndex) {
            var tmp = TravelRouteList[fIndex];
            TravelRouteList[fIndex] = TravelRouteList[sIndex];
            TravelRouteList[sIndex] = tmp;
            refreashTravelRoute();
        }



        //------------------------------------
        //----------TravelRouteItem and travelRouteList END
        //------------------------------------

        //------------------------------------
        //----------CostItems and CostItemList Start
        //------------------------------------
        class CostItem {
            constructor(place_name) {
                this.itemList = Array();
                this.place_name = place_name;
            }
            setPlace_name(place_name) {
                this.place_name = place_name;
            }
            pushItem(costType, cost, info) {
                this.itemList.push({
                    costType,
                    cost,
                    info
                });
            }
            popItem() {
                this.itemList.pop();
            }
        }

        var CostItemList = Array();



        function button() {

        }


        function refreashCostItem() {

            var costBody = document.getElementById('costBody'),
                costHeader = document.getElementById('costHeader'),
                fragment = document.createDocumentFragment(),
                headerFragment = document.createDocumentFragment(),
                itemList = '',
                el, headerEl, totalCost = 0,
                pindexTmp;

            ;

            // costBody 모든 자식 노드 삭제
            while (costBody.hasChildNodes()) {
                costBody.removeChild(costBody.firstChild);
            }
            CostItemList.forEach(function(currentValue, pindex) {
                pindexTmp = pindex;
                ////console.info(pindex);
                ////console.info(currentValue);
                el = document.createElement('div'),
                    itemStr =

                    '<div class="costItem-header">' +
                    '         <span># ' + currentValue.place_name + '</span>' +
                    '</div>' +
                    '   <div class="costItem-body">' +
                    '       <ul>';

                currentValue.itemList.forEach(function(currentValue, index) {
                    itemStr += '<li>' + currentValue.costType +
                        '               <div class="btn btn-sm btn-warning" onclick="removeCostItemChild(' + pindex + ',' + index + ')">x</div>' +
                        '<br/>' +
                        setComa(currentValue.cost) + ' (' + currentValue.info + ')' + '</li>';
                    totalCost += parseInt(currentValue.cost);
                });

                itemStr +=
                    '<li>' +
                    '   <div class="btn btn-secondary btn-sm" data-toggle="collapse" data-target="#collapseAddCost_' + pindex + '" aria-expanded="false" aria-controls="collapseAddCost_' + pindex + '">경비추가</div>' +
                    '   <div class="collapse" id="collapseAddCost_' + pindex + '">' +
                    '       <select id="addCost_costType_' + pindex + '" class="form-control form-control-sm">' +
                    '           <option value="식비">식비</option>' +
                    '           <option value="교통비">교통비</option>' +
                    '           <option value="숙박비">숙박비</option>' +
                    '           <option value="기타">기타</option>' +
                    '       </select>' +
                    '       <input id="addCost_cost_' + pindex + '" class="form-control form-control-sm" type="number" placeholder="비용">' +
                    '       <input id="addCost_info_' + pindex + '" class="form-control form-control-sm" type="text" placeholder="비용 설명">' +
                    '       <div class="btn btn-secondary btn-sm" onclick="pushCostItemChild(' + pindex + ')">+</div>' +
                    //'       <div class="btn btn-secondary btn-sm" onclick="popCostItemChild(' + pindex + ')">-</div>' +

                    '</div>' +
                    '</li>' +
                    '   </ul>' +
                    '</div>' +
                    '</div>';
                el.innerHTML = itemStr;
                //            el.setAttribute("draggable", 'true');
                //            el.setAttribute("id", "travelPoint");
                el.setAttribute("class", "costItem");


                var itemEl = el;

                fragment.appendChild(itemEl);

                costBody.appendChild(fragment);



            });

            // 나중에 지도의 travelroute에서 추가할 버튼
            //el = document.createElement('div'),
            //    itemStr =

            //    '<div class="btn btn-secondary btn-sm" onclick="addCostItemParent(' + pindexTmp + ')">+</div>';

            //el.innerHTML = itemStr;
            ////            el.setAttribute("draggable", 'true');
            ////            el.setAttribute("id", "travelPoint");
            //el.setAttribute("class", "costItem");


            //var itemEl = el;

            //fragment.appendChild(itemEl);

            //costBody.appendChild(fragment);

            ////--------------------



            var headerStr =
                '<span class="chTitle">전체 경비</span>' +
                '<span class="chBody">💰 ' + setComa(totalCost) + '</span>';
            costHeader.innerHTML = headerStr;




        }

        function pushCostItemChild(index) {

            var costTypeId = "addCost_costType_" + index,
                costId = "addCost_cost_" + index,
                infoId = "addCost_info_" + index;

            var costType = document.getElementById(costTypeId);
            cost = document.getElementById(costId),
                info = document.getElementById(infoId);

            if (cost.value == "") {

                alert("비용을 입력하세요");
            } else {

                CostItemList[index].pushItem(costType.options[costType.selectedIndex].value, cost.value, info.value);
                refreashCostItem();
            }



        }


        function popCostItemChild(index) {

            var costTypeId = "addCost_costType_" + index,
                costId = "addCost_cost_" + index,
                infoId = "addCost_info_" + index;

            var costType = document.getElementById(costTypeId);
            cost = document.getElementById(costId),
                info = document.getElementById(infoId);

            CostItemList[index].popItem();
            refreashCostItem();

        }




        function addCostItemParent(place_name) {
            CostItemList.push(new CostItem(place_name));
            refreashCostItem();

        }

        function setCostItemParentName(pindex) {

            //var addCost_place_nameId = "addCost_place_name_" + pindex;
            //var addCost_place_name = document.getElementById(addCost_place_nameId);
            var addTravelRoute_place_nameId = "addTravelRoute_place_name_" + pindex;
            var place_name = document.getElementById(addTravelRoute_place_nameId).value;

            CostItemList[pindex].setPlace_name(place_name);
            refreashCostItem();
        }

        function removeCostItemChild(pindex, index) {
            CostItemList[pindex].itemList.splice(index, 1);
            refreashCostItem();
        }


        function removeCostItemParent(pindex) {
            CostItemList.splice(pindex, 1);
            refreashCostItem();
        }

        function swapCostItemParent(fIndex, sIndex) {
            var tmp = CostItemList[fIndex];
            CostItemList[fIndex] = CostItemList[sIndex];
            CostItemList[sIndex] = tmp;
            refreashCostItem();
        }

        function setComa(number) {
            var resultStr = "";
            var strNumber = String(number);
            ////console.info(strNumber);
            ////console.info(strNumber.length);
            for (var i = strNumber.length - 1; i >= 0; i--) {
                ////console.info(i);

                if ((strNumber.length - i - 1) % 3 == 0 && i != strNumber.length - 1) {
                    resultStr = ',' + resultStr;
                }
                resultStr = strNumber[i] + resultStr;
            }


            return resultStr;

        }

        //------------------------------------
        //----------CostItems and CostItemList End
        //------------------------------------




        //------------------------------------
        //----------DragManager Start
        //------------------------------------





        //여행경로 드래그 앤 드롭
        var DragManager;

        function dragAndDropAction() {
            //DragManger에 요소 추가 (추후 드래그 앤드롭 액션 실행)
            DragManager = {
                travelRoutes: [],
                currentContainer: null,

                add: function(travelRoute) {
                    this.travelRoutes.push(travelRoute);
                },

                handleEvent: function(event) {
                    ////console.info(event.target);
                    if (event.type == 'dragstart') {
                        //console.info("dragstart");
                        var containers = this.travelRoutes.filter(function(container) {

                            return container.contains(event.target);
                        });

                        if (containers.length > 0) {
                            this.currentContainer = containers[0];
                            this.currentContainer.activate();
                        }
                    }

                    if (this.currentContainer !== null) {
                        this.currentContainer.handleEvent(event);
                        if (event.type == 'dragend') {
                            this.currentContainer.deactivate();
                            this.currentContainer = null;
                        }
                    }
                }

            };

            window.addEventListener('dragstart', DragManager);
            window.addEventListener('dragend', DragManager);

            function travelRoute(container, type) {
                this.element = container;
                this.type = type || 'swap';
                this.items = $('> li', this.element);
                this.draggingItem = null;

                DragManager.add(this);
            }

            travelRoute.prototype.contains = function(target) {
                ////console.info(target);
                return $(this.element).find(target).length;
            }

            travelRoute.prototype.handleEvent = function(event) {
                // NOTE: We've bound `this` to the travelRoute object, not
                // the element the event was fired on.
                var $t = $(event.target);

                if (event.type == 'dragstart') {
                    this.draggingItem = event.target;
                    //console.info(event.target);
                    //setdata에 최상위 LIdml HTML을 데이터로 보낸다
                    ////console.info("this.draggingItem");
                    ////console.info(this.draggingItem);
                    var tgtItem = this.draggingItem;
                    while (1) {
                        //if(data.id == "travelPoint")
                        ////console.info("tgtItem.tagName");
                        ////console.info(tgtItem.tagName);
                        //if (tgtItem.tagName == "LI")
                        if (tgtItem.className == "travelPoint")
                            break;
                        tgtItem = tgtItem.parentNode;
                    }


                    event.dataTransfer.setData('text/html', tgtItem.innerHTML);
                }

                if (event.type == 'dragover' && this.draggingItem != event.target) {

                    $t.addClass('js-active');
                    // Preventing the default action _enables_ drop. Because JS APIs.
                    if (event.preventDefault) {
                        event.preventDefault();
                    }
                    event.dataTransfer.dropEffect = 'move';
                }

                if (event.type == 'dragleave') {
                    $t.removeClass('js-active');
                }

                if (event.type == 'drop' && this.draggingItem != null) {
                    if (this.type == 'swap') {


                        // 최상단 LI태그를 탐색
                        var tgtItem = event.target;
                        while (1) {
                            //if(data.id == "travelPoint")
                            //if (tgtItem.tagName == "LI")
                            if (tgtItem.className == "travelPoint")
                                break;
                            tgtItem = tgtItem.parentNode;
                        }
                        var fIndex, sIndex;
                        //travelPoint_0
                        fIndex = tgtItem.id.slice(12);
                        sIndex = this.draggingItem.id.slice(12);

                        //console.info(fIndex);
                        //console.info(sIndex);
                        swapTravelRouteItem(parseInt(fIndex), parseInt(sIndex));
                        swapCostItemParent(parseInt(fIndex), parseInt(sIndex));
                        //최상단  travelPoint로만 옮김.
                        //this.draggingItem.innerHTML = tgtItem.innerHTML;
                        //tgtItem.innerHTML = event.dataTransfer.getData('text/html');
                    } else if (this.type == 'reorder') {
                        //console.info('reorder');
                        //console.info(this.items.index(event.target));
                    }
                }

                if (event.type == 'dragend' || event.type == 'drop') {
                    this.items.removeClass('js-active');
                    this.draggingItem = null;
                }
            }

            travelRoute.prototype.activate = function() {
                for (var i = 0, j = this.items.length; i < j; i++) {
                    // Make sure `this` is always a travelRoute instead of the element the
                    // event was activated on.
                    this.items[i].addEventListener('dragenter', this.handleEvent.bind(this));
                    this.items[i].addEventListener('dragover', this.handleEvent.bind(this));
                    this.items[i].addEventListener('dragleave', this.handleEvent.bind(this));
                    this.items[i].addEventListener('drop', this.handleEvent.bind(this));
                }
            }

            travelRoute.prototype.deactivate = function() {
                this.draggingItem = null;
                for (var i = 0, j = this.items.length; i < j; i++) {
                    //this.items[i].removeEventListener('dragenter', this.handleEvent);
                    //this.items[i].removeEventListener('dragover', this.handleEvent);
                    //this.items[i].removeEventListener('dragleave', this.handleEvent);
                    //this.items[i].removeEventListener('drop', this.handleEvent);
                }
            }

            var travelRoutes = document.getElementsByClassName('travelRoute');

            for (var i = 0, j = travelRoutes.length; i < j; i++) {
                new travelRoute(travelRoutes[i], (i % 2 == 0) ? 'swap' : 'reorder');
            }

        }
        //------------------------------------
        //----------DragManager END
        //------------------------------------



        //------------------------------------
        //----------Map DataBind Start Not DrawingMap
        //-------------------------------



        function getMapData() {
            return manager.getData();
        }

        function getTravelRouteData() {
            return TravelRouteList;
        }

        function getCostData() {
            return CostItemList;
        }

        function setTravelRouteData(data) {
            TravelRouteList = data;
        }

        function setCostData(data) {
            CostItemList = data;
        }


        overlays = [];

        function setMapData(mapData) {
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
            setMapMarker(data["marker"]);
            setMapPolyline(data["polyline"]);
            setMapRectangle(data["rectangle"]);
            setMapCircle(data["circle"]);
            setMapPolygon(data["polygon"]);
            setMapEllipse(data["ellipse"]);
            setMapArrow(data["arrow"]);




        }

        // 아래 지도에 그려진 도형이 있다면 모두 지웁니다
        function removeOverlays() {
            var len = overlays.length,
                i = 0;

            for (; i < len; i++) {
                overlays[i].setMap(null);
            }

            overlays = [];
        }

        function setMapArrow(arrow) {
            var len = arrow.length,
                i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(arrow[i].points);
                var style = arrow[i].options;
                var polyline = new kakao.maps.Polyline({
                    map: drawingMap,
                    endArrow: true,
                    path: path,
                    strokeColor: style.strokeColor,
                    strokeOpacity: style.strokeOpacity,
                    strokeStyle: style.strokeStyle,
                    strokeWeight: style.strokeWeight
                });

                overlays.push(polyline);
            }
        }

        function setMapEllipse(ellipse) {
            var len = ellipse.length,
                i = 0;

            for (; i < len; i++) {
                var style = ellipse[i].options;
                var ellipse = new kakao.maps.Ellipse({
                    map: drawingMap,
                    center: new kakao.maps.LatLng(ellipse[i].center.x, ellipse[i].center.y),
                    rx: ellipse[i].rx,
                    ry: ellipse[i].ry,
                    strokeWeight: style.strokeWeight,
                    strokeColor: style.strokeColor,
                    strokeOpacity: style.strokeOpacity,
                    strokeStyle: style.strokeStyle,
                    fillColor: style.fillColor,
                    fillOpacity: style.fillOpacity




                });
                console.info(ellipse);
                overlays.push(ellipse);
            }
        } // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
        function setMapMarker(markers) {
            var len = markers.length,
                i = 0;

            for (; i < len; i++) {
                var marker = new kakao.maps.Marker({
                    map: drawingMap,
                    position: new kakao.maps.LatLng(markers[i].y, markers[i].x),
                    zIndex: markers[i].zIndex
                });

                overlays.push(marker);
            }
        }

        // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
        function setMapPolyline(lines) {
            var len = lines.length,
                i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(lines[i].points);
                var style = lines[i].options;
                var polyline = new kakao.maps.Polyline({
                    map: drawingMap,
                    path: path,
                    strokeColor: style.strokeColor,
                    strokeOpacity: style.strokeOpacity,
                    strokeStyle: style.strokeStyle,
                    strokeWeight: style.strokeWeight
                });

                overlays.push(polyline);
            }
        }

        // Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
        function setMapRectangle(rects) {
            var len = rects.length,
                i = 0;

            for (; i < len; i++) {
                var style = rects[i].options;
                var rect = new kakao.maps.Rectangle({
                    map: drawingMap,
                    bounds: new kakao.maps.LatLngBounds(
                        new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                        new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
                    ),
                    strokeColor: style.strokeColor,
                    strokeOpacity: style.strokeOpacity,
                    strokeStyle: style.strokeStyle,
                    strokeWeight: style.strokeWeight,
                    fillColor: style.fillColor,
                    fillOpacity: style.fillOpacity
                });

                overlays.push(rect);
            }
        }

        // Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
        function setMapCircle(circles) {
            var len = circles.length,
                i = 0;

            for (; i < len; i++) {
                var style = circles[i].options;
                var circle = new kakao.maps.Circle({
                    map: drawingMap,
                    center: new kakao.maps.LatLng(circles[i].center.y, circles[i].center.x),
                    radius: circles[i].radius,
                    strokeColor: style.strokeColor,
                    strokeOpacity: style.strokeOpacity,
                    strokeStyle: style.strokeStyle,
                    strokeWeight: style.strokeWeight,
                    fillColor: style.fillColor,
                    fillOpacity: style.fillOpacity
                });

                overlays.push(circle);
            }
        }

        // Drawing Manager에서 가져온 데이터 중 다각형을 아래 지도에 표시하는 함수입니다
        function setMapPolygon(polygons) {
            var len = polygons.length,
                i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(polygons[i].points);
                var style = polygons[i].options;
                var polygon = new kakao.maps.Polygon({
                    map: drawingMap,
                    path: path,
                    strokeColor: style.strokeColor,
                    strokeOpacity: style.strokeOpacity,
                    strokeStyle: style.strokeStyle,
                    strokeWeight: style.strokeWeight,
                    fillColor: style.fillColor,
                    fillOpacity: style.fillOpacity
                });

                overlays.push(polygon);
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
        //----------DataBind  END  Not DrawingMap
        //------------------------------------


        function HashTagCheck() {
            var str = document.getElementById('hashtag').value;
            var falseStr = "";
            var pattern_num = /[0-9]/; // 숫자 
            var pattern_eng = /[a-zA-Z]/; // 문자 
            var pattern_spc = /[# }]/; // 특수문자
            var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크

            // 한글, 영문, 숫자, #, 스페이스바는 입력이 가능하지만 나머지는 입력할 수 없고,
            // 입력된 글자가 있는 경우 #은 무조건 하나 이상 들어가 있어야 함.

            if (str != "") {
                if (!str.includes("#")) {
                    // 입력 문자열에 #이 존재하지 않는 경우
                    alert('해쉬태그는 #으로 시작해야 합니다. 1');
                    return;
                } else {
                    for (var i = 0; i < str.length; i++) {
                        var chr = str.charAt(i);

                        if (pattern_num.test(chr) || pattern_eng.test(chr) || pattern_spc.test(chr) || pattern_kor.test(chr))
                            continue;
                        else
                            falseStr += chr + ', ';
                    }

                    if (falseStr != "") {
                        alert('해시태그 조건에 맞춰 입력해주세요. 2\n오류 원인: ' + falseStr);
                        return;
                    } else {
                        var strArray;
                        var strSplit = str.split(' ');
                        var hashTagArray = "";

                        for (var i in strSplit) {
                            if (strSplit[i].startsWith("#") == false) {
                                alert('해시태그 조건에 맞춰 입력해주세요. 3');
                                return;
                            } else {
                                hashTagArray += strSplit[i] + " ";
                            }
                        }

                        alert(hashTagArray + "이다!"); // 정상적으로 불러온 경우 hashTagArray를 불러오면 그 태그들을 불러옴.
                        // ex) '#가나 #다라 #마바 #사아자 #파하하하하'
                    }
                }
            }
        }


        function gotoDay() {
            
            
            
            var form = document.createElement("form");
            addDataAtForm(form);

            var targetDay = document.getElementById("goDay").value;
            var targetDayData = document.createElement("input"); // input 엘리멘트 생성
            targetDayData.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            targetDayData.setAttribute("name", "targetDay"); // name 속성을 'stadium'으로 설정
            targetDayData.setAttribute("value", targetDay); // value 속성을 삽입
            form.appendChild(targetDayData);


            form.setAttribute('action', "Write_goDay.aspx");
            form.submit(); // 전송
        }


        function tmpSave(alFlg) {
            

            var form = document.createElement("form");
            addDataAtForm(form);
            form.setAttribute('action', "Write_tmpSave.aspx");
            //form.submit(); // 전송
            var data = new FormData(form);

            $.ajax({
                type: 'post',
                url: 'Write_tmpSave.aspx',
                data: data,
                success: function(status) {
                    if (alFlg) {
                        if (status != 'error') {
                            alert("저장되었습니다.");
                        }
                    }

                },
                processData: false,
                contentType: false,
                error: function() {
                    if (alFlg) {
                        alert("Whoops something went wrong!");
                    }
                }
            });
        }

        function addDay() {
            
            var form = document.createElement("form");
            addDataAtForm(form);
            form.setAttribute('action', "Write_addDay.aspx");
            form.submit(); // 전송
        }

        function endWrite() {
            if(HashTagCheck() == false) return;
            var form = document.createElement("form");
            addDataAtForm(form);
            form.setAttribute('action', "Write_endWrite.aspx");
            form.submit(); // 전송
        }

        //------------------------------------
        //----------Post END
        //------------------------------------




        //------------------------------------
        //----------Post START
        //------------------------------------


        // 다음페이지로 markers, polyline, rect, circle, polygon 보내는 기능
        function addDataAtForm(form) {

            //var title = document.getElementById("title").value;
            //var article = document.getElementById("article").value;
            //var hashtag = document.getElementById("hashtag").value;
            //var main_img = document.getElementById("main_img").value;
            form.setAttribute("style", "display: none;");
            var title = document.getElementById("title").cloneNode();
            var article = document.getElementById("article").cloneNode();
            var hashtag = document.getElementById("hashtag").cloneNode();
            var main_img = document.getElementById("main_img").cloneNode();







            title.setAttribute('type', "hidden");
            article.setAttribute('type', "hidden");
            hashtag.setAttribute('type', "hidden");
            main_img.setAttribute('type', "hidden");


            //// Form submission canceled because the form is not connected 해결
            document.body.appendChild(form);
            form.setAttribute('method', "post");

            form.appendChild(title);
            form.appendChild(article);
            form.appendChild(hashtag);
            form.appendChild(main_img);


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


            // -- TravelRouteList중 중간 노드의 주소를 가져와 파싱하여 가장 앞 주소(시/도)ㄴ만 가져온다.

            var firstAddress = "";

            var items = getTravelRouteData();
            if (items != null && items != [] && items.length != 0) {

                var itemsMiddle = Math.floor(items.length / 2);
                var address = "";

                if (items[itemsMiddle].address_name != null) {
                    address = items[itemsMiddle].address_name;
                } else {
                    address = items[itemsMiddle].road_address_name;
                }

                var addresstokens = address.split(' ');
                firstAddress = addresstokens[0];
            } else {

                //현재 지도의 중앙부분의 주소를 가져와 가장 앞 주소(시/도)만 사용
                var coord = drawingMap.getCenter();
                geocoder.coord2Address(coord.Ga, coord.Ha, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        //주소가 있다면 검색
                        if (result[0] != null) {

                            LocName.setAttribute("value", result[0].address.region_1depth_name);
                        }
                    }
                });
            }



            var LocName = document.createElement("input"); // input 엘리멘트 생성
            LocName.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            LocName.setAttribute("name", "loc_name"); // name 속성을 'stadium'으로 설정
            //LocName.setAttribute("value", tmpLocName); // value 속성을 삽입
            form.appendChild(LocName);

            var map_center = drawingMap.getCenter();
            var mapCenter = document.createElement("input"); // input 엘리멘트 생성
            mapCenter.setAttribute("type", "hidden"); // type 속성을 hidden으로 설정
            mapCenter.setAttribute("name", "map_center"); // name 속성을 'stadium'으로 설정
            mapCenter.setAttribute("value", JSON.stringify(map_center)); // value 속성을 삽입
            form.appendChild(mapCenter);









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
            drawPolyline(data["polyline"]);
            drawRectangle(data["rectangle"]);
            drawCircle(data["circle"]);
            drawPolygon(data["polygon"]);
            drawEllipse(data["ellipse"]);
            drawArrow(data["arrow"]);




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
                    new kakao.maps.LatLng(ellipse[i].sPoint.y, ellipse[i].sPoint.x),
                    new kakao.maps.LatLng(ellipse[i].ePoint.y, ellipse[i].ePoint.x)
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
                manager.put(kakao.maps.drawing.OverlayType.POLYGON, path);

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
        if (document.getElementById("mapData").value != "" &&
            document.getElementById("mapData").value != [] &&
            document.getElementById("mapData").value != null &&
            document.getElementById("mapData").value != '""') {
            var inputMapData = JSON.parse(document.getElementById("mapData").value);

            setDrawingMapData(inputMapData);
            closeCusOverlay();
            refreshOverlayListener();

        }

        if (document.getElementById("mapRoute").value != "" &&
            document.getElementById("mapRoute").value != [] &&
            document.getElementById("mapRoute").value != null &&
            document.getElementById("mapRoute").value != '""') {
            TravelRouteList = JSON.parse(document.getElementById("mapRoute").value);
            refreashTravelRoute();

        }
        if (document.getElementById("mapCost").value != "" &&
            document.getElementById("mapCost").value != [] &&
            document.getElementById("mapCost").value != null &&
            document.getElementById("mapCost").value != '""') {
            CostItemList = JSON.parse(document.getElementById("mapCost").value);

            refreashCostItem();

        }

        if (document.getElementById("mapCenter").value != "" &&
            document.getElementById("mapCenter").value != [] &&
            document.getElementById("mapCenter").value != null &&
            document.getElementById("mapCenter").value != '""') {
            var mapCenter = JSON.parse(document.getElementById("mapCenter").value);

            drawingMap.setCenter(new kakao.maps.LatLng(mapCenter.Ha, mapCenter.Ga));



        }


        //------------------------------------
        //----------From Post END
        //------------------------------------

        //------------------------------------
        //----------From around category search START
        //------------------------------------


        // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
        var placeOverlay = new kakao.maps.CustomOverlay({
                xAnchor: 0.5,
                yAnchor: 1.25,
                zIndex: 3

            }),
            contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
            markersAround = [], // 마커를 담을 배열입니다
            currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다




        // 지도에 idle 이벤트를 등록합니다
        kakao.maps.event.addListener(drawingMap, 'idle', searchPlacesAround);

        // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
        contentNode.className = 'placeinfo_wrap';

        // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
        // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
        addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
        addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

        // 커스텀 오버레이 컨텐츠를 설정합니다
        placeOverlay.setContent(contentNode);

        // 각 카테고리에 클릭 이벤트를 등록합니다
        addCategoryClickEvent();

        function closePlaceOverlay() {
            placeOverlay.setMap(null);
        }

        // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
        function addEventHandle(target, type, callback) {
            if (target.addEventListener) {
                target.addEventListener(type, callback);
            } else {
                target.attachEvent('on' + type, callback);
            }
        }

        // 카테고리 검색을 요청하는 함수입니다
        function searchPlacesAround() {
            if (!currCategory) {
                return;
            }

            // 커스텀 오버레이를 숨깁니다 
            placeOverlay.setMap(null);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarkerAround();

            ps.categorySearch(currCategory, placesSearchCBArround, {
                useMapBounds: true,

            });
        }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCBArround(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {

                // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                displayPlacesArround(data);
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

            } else if (status === kakao.maps.services.Status.ERROR) {
                // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

            }
        }

        // 지도에 마커를 표출하는 함수입니다
        function displayPlacesArround(places) {
            console.info(places);

            // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
            // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
            var order = document.getElementById(currCategory).getAttribute('data-order');



            for (var i = 0; i < places.length; i++) {

                // 마커를 생성하고 지도에 표시합니다
                var marker = addMarkerArround(new kakao.maps.LatLng(places[i].y, places[i].x), order);

                // 마커와 검색결과 항목을 클릭 했을 때
                // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
                (function(marker, place) {
                    kakao.maps.event.addListener(marker, 'click', function() {
                        displayPlaceInfo(place);
                    });
                })(marker, places[i]);
            }
        }

        //        <li id='MT1' data-order="0"> <span class="category_bg mart"> 대형마트</span></li>
        //        <li id='CS2' data-order="1"> <span class="category_bg store"> 편의점</span></li>
        //        <li id='PS3' data-order="2"> <span class="category_bg elemantry"> 어린이집, 유치원</span></li>
        //        <li id='SC4' data-order="3"> <span class="category_bg"> 학교</span></li>
        //        <li id='AC5' data-order="4"> <span class="category_bg"> 학원</span></li>
        //        <li id='PK6' data-order="5"> <span class="category_bg"> 주차장</span></li>
        //        <li id='OL7' data-order="6"> <span class="category_bg oil"> 주유소, 충전소</span></li>
        //        <li id='SW8' data-order="7"> <span class="category_bg"> 지하철역</span></li>
        //        <li id='BK9' data-order="8"> <span class="category_bg bank"> 은행</span></li>
        //        <li id='CT1' data-order="9"><span class="category_bg"> 문화시설</span></li>
        //        <li id='AG2' data-order="10"><span class="category_bg"> 중개업소</span></li>
        //        <li id='PO3' data-order="11"><span class="category_bg"> 공공기관</span></li>
        //        <li id='AT4' data-order="12"><span class="category_bg"> 관광명소</span></li>
        //        <li id='AD5' data-order="13"><span class="category_bg"> 숙박</span></li>
        //        <li id='FD6' data-order="14"><span class="category_bg"> 음식점</span></li>
        //        <li id='CE7' data-order="15"><span class="category_bg cafe"> 카페</span></li>
        //        <li id='HP8' data-order="16"><span class="category_bg"> 병원</span></li>
        //        <li id='PM9' data-order="17"><span class="category_bg pharmacy"> 약국</span></li>     


        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarkerArround(position, order) {
            var imageSize = new kakao.maps.Size(33, 44); // 마커이미지의 크기입니다
            var imageOption = {
                offset: new kakao.maps.Point(19, 45)
            };
            var iconUrl = [
                "./img/ico/marker/shopping.png", //대형마트
                "./img/ico/marker/retail-stores.png", //편의점
                "./img/ico/marker/play-schools.png", //어린이집, 유치원
                "./img/ico/marker/schools.png", //학교
                "./img/ico/marker/education.png", //학원
                "./img/ico/marker/automotive.png", //주차장
                "./img/ico/marker/gas-station.png", //주유소, 충전소
                "./img/ico/marker/transport.png", //지하철역
                "./img/ico/marker/financial-services.png", //은행
                "./img/ico/marker/tickets.png", //문화시설
                "./img/ico/marker/business.png", //중개업소
                "./img/ico/marker/government.png", //공공기관
                "./img/ico/marker/travel.png", //관광명소
                "./img/ico/marker/residential-places.png", //숙박
                "./img/ico/marker/restaurants.png", //음식점
                "./img/ico/marker/coffee-n-tea.png", //카페
                "./img/ico/marker/medical.png", //병원
                "./img/ico/marker/health-medical.png" //약국
            ];

            var marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: new kakao.maps.MarkerImage(iconUrl[order], imageSize, imageOption)
            });

            marker.setMap(drawingMap); // 지도 위에 마커를 표출합니다
            markersAround.push(marker); // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarkerAround() {
            for (var i = 0; i < markersAround.length; i++) {
                markersAround[i].setMap(null);
            }
            markersAround = [];
        }

        // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
        function displayPlaceInfo(place) {
            console.info(place);

            var content =
                '<div class="card card-cus" style="width:300px;">' +
                '<div class="card-header">' +
                '<div class="card-title">' +
                place.place_name +
                '</div>' +
                '<div class="card-close">' +
                '<div class="closeBtn" onclick="closePlaceOverlay()">' +
                '<span >×</span>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="card-body">' +
                '<blockquote class="blockquote mb-0">';
            if (place.road_address_name != null) {
                content += '<li class="card-body-li">' + place.road_address_name + '</li>';
            }
            if (place.address_name != null) {
                content += '<li class="card-body-li">' + place.address_name + '</li>';
            }
            if (place.phone != null) {
                content += '<li class="card-body-li">' + place.phone + '</li>';
            }
            if (place.place_url != null) {
                content += '<li class="card-body-li" style="padding: 15px 0;"><a href="' + place.place_url + '" target="_blank" style="text-decoration: none;">상세페이지</a></li>';
            }


            content +=
                '</blockquote>' +
                '<div class="card-addBtn" onclick=\'AddMarkerWithTravelRouteItem("' + place.place_name + '","' + place.road_address_name + '","' + place.address_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>추가</div>' +
                '</div>' +
                '</div>';


            contentNode.innerHTML = content;
            placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
            placeOverlay.setMap(drawingMap);
        }


        // 각 카테고리에 클릭 이벤트를 등록합니다
        function addCategoryClickEvent() {
            var category = document.getElementById('category'),
                children = category.children;

            for (var i = 0; i < children.length; i++) {
                children[i].onclick = onClickCategory;
            }
        }

        // 카테고리를 클릭했을 때 호출되는 함수입니다
        function onClickCategory() {
            var id = this.id,
                className = this.className;

            placeOverlay.setMap(null);

            if (className === 'dropdown-item active') {
                currCategory = '';
                changeCategoryClass();
                removeMarkerAround();
            } else {
                currCategory = id;
                changeCategoryClass(this);
                searchPlacesAround();
            }
        }

        // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
        function changeCategoryClass(el) {
            var category = document.getElementById('category'),
                children = category.children,
                i;

            for (i = 0; i < children.length; i++) {
                children[i].className = 'dropdown-item';
            }

            if (el) {
                el.className = 'dropdown-item active';
            }
        }

        //------------------------------------
        //----------From around category search END
        //------------------------------------


        //-----------------------------------
        //----------- CommonFUnction START
        //-----------------------------------


        function closeAllOverlay() {
            //IN Drwaingmanger
            closeCusOverlay();
            //키워드 검색

            closeOverlay();
            //주변 카테고리 검색
            closePlaceOverlay();
        }

        function closeAllSearchedMarkers() {
            //키워드 검색

            removeMarker();
            //주변 카테고리 검색
            removeMarkerAround();
        }
        //-----------------------------------
        //----------- CommonFUnction End
        //-----------------------------------

    </script>
</body>
</html>
