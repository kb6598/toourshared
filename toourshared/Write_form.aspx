<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">



</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.11/dist/summernote-bs4.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <title></title>
    <style>
        .map_wrap {
            width: 100%;
            vertical-align: middle;
            margin-bottom: 30px;
        }

        .modes {
            top: 10px;
            left: 10px;
            z-index: 1;
        }

        #drawingMap {
            top: 0px;
            width: auto;
            height: 500px;
            text-align: center;
        }
        #travelRoute_wrap {
            position: absolute;
            text-align: center;
            z-index:3;
            background-color: whitesmoke;
        }

        .map_wrap, .map_wrap * {
            margin: 10;
            padding: 0;
            font-family: 'Malgun Gothic',dotum,'돋움',sans-serif;
            font-size: 12px;
        }

            .map_wrap a, .map_wrap a:hover, .map_wrap a:active {
                color: #000;
                text-decoration: none;
            }

        .map_wrap {
            position: relative;
            width: 100%;
            height: 500px;
        }



        #menu_wrap {
            margin: 10px 0 30px 10px;
            padding: 5px;
            overflow-y: auto;
            background: rgba(255, 255, 255, 0.7);
            z-index: 1;
            font-size: 12px;
            border-radius: 10px;
        }

        .bg_white {
            background: #fff;
        }

        #menu_wrap hr {
            display: block;
            height: 1px;
            border: 0;
            border-top: 2px solid #5F5F5F;
            margin: 3px 0;
        }

        #menu_wrap .option {
            text-align: center;
        }

            #menu_wrap .option p {
                margin: 10px 0;
            }

            #menu_wrap .option button {
                margin-left: 5px;
            }

        #placesList li {
            list-style: none;
        }

        #placesList .item {
            position: relative;
            border-bottom: 1px solid #888;
            overflow: hidden;
            cursor: pointer;
            min-height: 65px;
        }

            #placesList .item span {
                display: block;
                margin-top: 4px;
            }

            #placesList .item h5, #placesList .item .info {
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            #placesList .item .info {
                padding: 10px 0 10px 55px;
            }

        #placesList .info .gray {
            color: #8a8a8a;
        }

        #placesList .info .jibun {
            padding-left: 26px;
            background: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
        }

        #placesList .info .tel {
            color: #009900;
        }

        #placesList .item .markerbg {
            float: left;
            position: absolute;
            width: 36px;
            height: 37px;
            margin: 10px 0 0 10px;
            background: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
        }

        #placesList .item .marker_1 {
            background-position: 0 -10px;
        }

        #placesList .item .marker_2 {
            background-position: 0 -56px;
        }

        #placesList .item .marker_3 {
            background-position: 0 -102px
        }

        #placesList .item .marker_4 {
            background-position: 0 -148px;
        }

        #placesList .item .marker_5 {
            background-position: 0 -194px;
        }

        #placesList .item .marker_6 {
            background-position: 0 -240px;
        }

        #placesList .item .marker_7 {
            background-position: 0 -286px;
        }

        #placesList .item .marker_8 {
            background-position: 0 -332px;
        }

        #placesList .item .marker_9 {
            background-position: 0 -378px;
        }

        #placesList .item .marker_10 {
            background-position: 0 -423px;
        }

        #placesList .item .marker_11 {
            background-position: 0 -470px;
        }

        #placesList .item .marker_12 {
            background-position: 0 -516px;
        }

        #placesList .item .marker_13 {
            background-position: 0 -562px;
        }

        #placesList .item .marker_14 {
            background-position: 0 -608px;
        }

        #placesList .item .marker_15 {
            background-position: 0 -654px;
        }

        #pagination {
            margin: 10px auto;
            text-align: center;
        }

            #pagination a {
                display: inline-block;
                margin-right: 10px;
            }

            #pagination .on {
                font-weight: bold;
                cursor: default;
                color: #777;
            }


            <!--커스텀 오버레이 스타일-->
    .wrap {position: absolute;left: 0;bottom: 40px;width: 250px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 140px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 0px;height: 120px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}


    </style>
</head>
<body>






    <div class="container">
        <div class="col-sm-12">
            <div id="emailMsg"></div>
            <div id="edit_right">
                <form id="form1" runat="server" action="Write_get.aspx">
                    <input type="hidden" name="sendEmail" value="ok" />
                    <div class="form-group">
                        <asp:TextBox ID="title" runat="server" CssClass="form-control form-control-lg" placeholder="제목을 입력해주세요"></asp:TextBox>
                    </div>
                    
                    <div class="map_wrap">
                        <div id="travelRoute_wrap" class="collapse"><ul id="travelRoute"></ul></div>

                        <div id="drawingMap"></div>
                        

                        <p class="modes">
                            <input type="button" class="btn btn-secondary" onclick="selectOverlay('MARKER')" value="마커" />
                            <input type="button" class="btn btn-secondary" onclick="selectOverlay('POLYLINE')" value="선" />
                            <input type="button" class="btn btn-secondary" onclick="selectOverlay('CIRCLE')" value="원" />
                            <input type="button" class="btn btn-secondary" onclick="selectOverlay('RECTANGLE')" value="사각형" />
                            <input type="button" class="btn btn-secondary" onclick="selectOverlay('POLYGON')" value="다각형" />
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#searchPlaceModal">
                                검색
                            </button>
                            <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#travelRoute_wrap">
                                여행경로
                            </button>
                        </p>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="article" runat="server" TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="hashtag" runat="server" CssClass="form-control form-control-lg" placeholder="#해시태그를 입력해주세요"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <input type="button" onclick="postToNext()" value="넘기기" />
                    </div>

                </form>
            </div>

        </div>






    </div>
    <!-- Modal -->
    <div class="modal fade" id="searchPlaceModal" tabindex="-1" role="dialog" aria-labelledby="searchPlaceModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable" role="document">
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
                        <hr>
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





    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bs4-summernote@0.8.10/dist/summernote-bs4.min.js"></script>
    <script>
        $(document).ready(function () {
            $('textarea').summernote({
                height: 300,   //set editable area's height
            });
        });
    </script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>

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

        var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
            map: drawingMap, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
            drawingMode: [ // Drawing Manager로 제공할 그리기 요소 모드입니다
                daum.maps.drawing.OverlayType.MARKER,
                daum.maps.drawing.OverlayType.POLYLINE,
                daum.maps.drawing.OverlayType.RECTANGLE,
                daum.maps.drawing.OverlayType.CIRCLE,
                daum.maps.drawing.OverlayType.POLYGON
            ],
            // 사용자에게 제공할 그리기 가이드 툴팁입니다
            // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
            guideTooltip: ['draw', 'drag', 'edit'],
            markerOptions: { // 마커 옵션입니다 
                draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
                removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
            },
            polylineOptions: { // 선 옵션입니다
                draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
                removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
                editable: true, // 그린 후 수정할 수 있도록 설정합니다 
                strokeColor: '#39f', // 선 색
                hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
                hintStrokeOpacity: 0.5  // 그리중 마우스를 따라다니는 보조선의 투명도
            },
            rectangleOptions: {
                draggable: true,
                removable: true,
                editable: true,
                strokeColor: '#39f', // 외곽선 색
                fillColor: '#39f', // 채우기 색
                fillOpacity: 0.5 // 채우기색 투명도
            },
            circleOptions: {
                draggable: true,
                removable: true,
                editable: true,
                strokeColor: '#39f',
                fillColor: '#39f',
                fillOpacity: 0.5
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

        // Drawing Manager에서 데이터를 가져와 도형을 표시할 아래쪽 지도 div
        //var mapContainer = document.getElementById('map'),
        //    mapOptions = { 
        //        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        //        level: 3 // 지도의 확대 레벨
        //    };

        // 지도 div와 지도 옵션으로 지도를 생성합니다
        //var map = new daum.maps.Map(mapContainer, mapOptions),
        overlays = []; // 지도에 그려진 도형을 담을 배열

        // 가져오기 버튼을 클릭하면 호출되는 핸들러 함수입니다
        // Drawing Manager로 그려진 객체 데이터를 가져와 아래 지도에 표시합니다
        //function getDataFromDrawingMap() {
        //    // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
        //    var data = manager.getData();

        //    // 아래 지도에 그려진 도형이 있다면 모두 지웁니다
        //    removeOverlays();

        //    // 지도에 가져온 데이터로 도형들을 그립니다
        //    //drawMarker(data[daum.maps.drawing.OverlayType.MARKER]);
        //    //drawPolyline(data[daum.maps.drawing.OverlayType.POLYLINE]);
        //    //drawRectangle(data[daum.maps.drawing.OverlayType.RECTANGLE]);
        //    //drawCircle(data[daum.maps.drawing.OverlayType.CIRCLE]);
        //    //drawPolygon(data[daum.maps.drawing.OverlayType.POLYGON]);

        //}

        // 아래 지도에 그려진 도형이 있다면 모두 지웁니다
        function removeOverlays() {
            var len = overlays.length, i = 0;

            for (; i < len; i++) {
                overlays[i].setMap(null);
            }

            overlays = [];
        }

        // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
        function drawMarker(markers) {
            var len = markers.length, i = 0;

            for (; i < len; i++) {
                var marker = new daum.maps.Marker({
                    map: map,
                    position: new daum.maps.LatLng(markers[i].y, markers[i].x),
                    zIndex: markers[i].zIndex
                });

                overlays.push(marker);

                //alert (new daum.maps.LatLng(markers[0].y, markers[0].x)) ;

            }
        }

        // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
        function drawPolyline(lines) {
            var len = lines.length, i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(lines[i].points);
                var style = lines[i].options;
                var polyline = new daum.maps.Polyline({
                    map: map,
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
        function drawRectangle(rects) {
            var len = rects.length, i = 0;

            for (; i < len; i++) {
                var style = rects[i].options;
                var rect = new daum.maps.Rectangle({
                    map: map,
                    bounds: new daum.maps.LatLngBounds(
                        new daum.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                        new daum.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
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
        function drawCircle(circles) {
            var len = circles.length, i = 0;

            for (; i < len; i++) {
                var style = circles[i].options;
                var circle = new daum.maps.Circle({
                    map: map,
                    center: new daum.maps.LatLng(circles[i].center.y, circles[i].center.x),
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
        function drawPolygon(polygons) {
            var len = polygons.length, i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(polygons[i].points);
                var style = polygons[i].options;
                var polygon = new daum.maps.Polygon({
                    map: map,
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
        // 선과 다각형의 꼭지점 정보를 daum.maps.LatLng객체로 생성하고 배열로 반환하는 함수입니다 
        function pointsToPath(points) {
            var len = points.length,
                path = [],
                i = 0;

            for (; i < len; i++) {
                var latlng = new daum.maps.LatLng(points[i].y, points[i].x);
                //path.push(i+":");
                path.push(latlng);
            }

            return path;

        }


        // 다음페이지로 markers, polyline, rect, circle, polygon 보내는 기능
        function postToNext() {
            var data = manager.getData();
            //rects  circles   polygons 
            markers = data[daum.maps.drawing.OverlayType.MARKER];
            polylines = data[daum.maps.drawing.OverlayType.POLYLINE];
            rects = data[daum.maps.drawing.OverlayType.RECTANGLE];
            circles = data[daum.maps.drawing.OverlayType.CIRCLE];
            polygons = data[daum.maps.drawing.OverlayType.POLYGON];

            markersPath = [];
            polylinesPath = [];
            rectsPath = [];
            circlesPath = [];
            polygonsPath = [];

            for (var i = 0; i < markers.length; i++) {

                var latlng = new daum.maps.LatLng(markers[i].y, markers[i].x);
                markersPath.push(i + ":");
                markersPath.push(latlng);


            }




            var len = polylines.length, i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(polylines[i].points);
                polylinesPath.push(i + ":");
                polylinesPath.push(path);

            }


            var len = circles.length, i = 0;

            for (; i < len; i++) {
                circlesPath.push(i + ":");
                circlesPath.push(new daum.maps.LatLng(circles[i].center.y, circles[i].center.x));
                circlesPath.push(circles[i].radius);

            }

            var len = rects.length, i = 0;

            for (; i < len; i++) {


                rectsPath.push(i + ":");
                rectsPath.push(rects[i].sPoint.y, rects[i].sPoint.x, rects[i].ePoint.y, rects[i].ePoint.x);


            }

            var len = polygons.length, i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(polygons[i].points);
                polygonsPath.push(i + ":");
                polygonsPath.push(path);

            }




            //document.getElementById("marker").value = markersPath;
            //document.getElementById("polygon").value = polylinesPath;
            var title = document.getElementById("title").value;
            var article = document.getElementById("article").value;
            var hashtag = document.getElementById("hashtag").value;


            var form = document.getElementById("form1");




            var insert1 = document.createElement("input");   // input 엘리멘트 생성
            insert1.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert1.setAttribute("name", "marker");               // name 속성을 'stadium'으로 설정
            insert1.setAttribute("value", markersPath);             // value 속성을 삽입
            form.appendChild(insert1);                       // form 엘리멘트에 input 엘리멘트 추가

            var insert2 = document.createElement("input");   // input 엘리멘트 생성
            insert2.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert2.setAttribute("name", "polyline");               // name 속성을 'stadium'으로 설정
            insert2.setAttribute("value", polylinesPath);             // value 속성을 삽입
            form.appendChild(insert2);
            //rects  circles   polygons 
            var insert3 = document.createElement("input");   // input 엘리멘트 생성
            insert3.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert3.setAttribute("name", "rects");               // name 속성을 'stadium'으로 설정
            insert3.setAttribute("value", rectsPath);             // value 속성을 삽입
            form.appendChild(insert3);

            var insert4 = document.createElement("input");   // input 엘리멘트 생성
            insert4.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert4.setAttribute("name", "circles");               // name 속성을 'stadium'으로 설정
            insert4.setAttribute("value", circlesPath);             // value 속성을 삽입
            form.appendChild(insert4);

            var insert5 = document.createElement("input");   // input 엘리멘트 생성
            insert5.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert5.setAttribute("name", "polygons");               // name 속성을 'stadium'으로 설정
            insert5.setAttribute("value", polygonsPath);             // value 속성을 삽입
            form.appendChild(insert5);



            form.submit();                                  // 전송
        }

        // 검색 시스템



        var find_markers = [];

        //var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        //    mapOption = {
        //        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        //        level: 3 // 지도의 확대 레벨
        //    };

        // 지도를 생성합니다    
        //var map = new kakao.maps.Map(mapContainer, mapOption);

        // 장소 검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places();

        // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

        // 키워드로 장소를 검색합니다
        searchPlaces();

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
                (function (marker, place) {
                    kakao.maps.event.addListener(marker, 'click', function () {                        
                        displayInfowindow(marker, place);
                    });


                    itemEl.onmouseover = function () {
                        displayInfowindow(marker, place);
                    };

                    itemEl.onmouseclick = function () {
                        displayInfowindow(marker, place);
                        $('#searchPlaceModal').modal('hide')

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
                imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
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
            find_markers.push(marker);  // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
            for (var i = 0; i < find_markers.length; i++) {
                find_markers[i].setMap(null);
            }
            find_markers = [];
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
                    el.onclick = (function (i) {
                        return function () {
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
            //var content = '<div style="padding:5px;z-index:1;">' + title + ' <button >추가</button></div>';
            var content = '<div class="wrap">' + 
            '    <div class="info">' + 
                '        <div class="title">' +
                place.place_name + 
            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="body">' + 
                '            <div class="desc">' +
                '                <div class="ellipsis">' + place.road_address_name + '</div>' +
                '                <div class="jibun ellipsis">' + place.address_name + '</div>' + 
             '   <div class="jibun ellipsis">' + place.phone + '</div>' + 
                '                <div><a href="' + place.place_url + '" target="_blank" class="link">상세페이지</a></div>' + 
                '<div class="btn btn-secondary" onclick=\'addTravelRoute("' + place.place_name + '","' + place.road_address_name + '","' + place.ddress_name + '","' + place.phone + '","' + place.place_url+'")\'>여행경로에 추가</div>'+
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';
            infowindow.setContent(content);
            infowindow.open(drawingMap, marker);
        }

        function closeOverlay() {
    infowindow.close();   
}


        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }


        //
        function addTravelRoute(place_name, road_address_name, address_name, phone, place_url ) {

             var listEl = document.getElementById('travelRoute'),
                menuEl = document.getElementById('travelRoute_wrap'),
                 fragment = document.createDocumentFragment(),
                 searchBox = document.getElementById('keyword'),
                listStr = '';

            //검색 키워드 삭제
            searchBox.value = '';

            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(document.getElementById('placesList'));
                        // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();
            //지도에 표시되고 있는 인포윈도우 제거
            closeOverlay();
            $('#travelRoute_wrap').collapse('show');

            
            var el = document.createElement('li'),
                itemStr = '<div class="wrap">' +
                    '    <div class="info">' +
                    '        <div class="title">' +
                    place_name +
                    '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                    '        </div>' +
                    '        <div class="body">' +
                    '            <div class="desc">' +
                    '                <div class="ellipsis">' + road_address_name + '</div>' +
                    '                <div class="jibun ellipsis">' + address_name + '</div>' +
                    '   <div class="jibun ellipsis">' + phone + '</div>' +
                    '                <div><a href="' + place_url + '" target="_blank" class="link">상세페이지</a></div>' +
                    '            </div>' +
                    '        </div>' +
                    '    </div>' +
                    '</div>';
            el.innerHTML = itemStr;
            el.className = 'item';

            var itemEl = el; // 검색 결과 항목 Element를 생성합니다
         

                fragment.appendChild(itemEl);


            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;
        }

        //여행 경로 추가
        function displayTravelRoute(place,index) {

            var listEl = document.getElementById('travelRoute'),
                menuEl = document.getElementById('travelRoute_wrap'),
                fragment = document.createDocumentFragment(),
                listStr = '';
            

            // 검색 결과 목록에 추가된 항목들을 제거합니다
            //removeAllChildNods(listEl);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();
            //지도에 표시되고 있는 인포윈도우 제거
            closeOverlay();
            $('#travelRoute_wrap').collapse('show');
            var itemEl = getListItem(index, place); // 검색 결과 항목 Element를 생성합니다
            //for (var i = 0; i < places.length; i++) {

                // 마커를 생성하고 지도에 표시합니다
                //var itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                // LatLngBounds 객체에 좌표를 추가합니다
                //bounds.extend(placePosition);

                // 마커와 검색결과 항목에 mouseover 했을때
                // 해당 장소에 인포윈도우에 장소명을 표시합니다
                // mouseout 했을 때는 인포윈도우를 닫습니다
                //(function (marker, title) {
                //    kakao.maps.event.addListener(marker, 'click', function () {                        
                //        displayInfowindow(marker, title);
                //    });


                //    itemEl.onmouseover = function () {
                //        displayInfowindow(marker, title);
                //    };

                //    itemEl.onmouseclick = function () {
                //        displayInfowindow(marker, title);
                //        $('#searchPlaceModal').modal('hide')

                //    };


                //})(marker, places[i]);

                fragment.appendChild(itemEl);
            //}

            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;


        }
                // 검색결과 항목을 Element로 반환하는 함수입니다
        //function getListItem(index, places) {

        //    var el = document.createElement('li'),
        //        itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
        //            '<div class="info">' +
        //            '   <h5 data-dismiss="modal">' + places.place_name + '</h5>';

        //    if (places.road_address_name) {
        //        itemStr += '    <span data-dismiss="modal">' + places.road_address_name + '</span>' +
        //            '   <span class="jibun gray" data-dismiss="modal">' + places.address_name + '</span>';
        //    } else {
        //        itemStr += '    <span data-dismiss="modal">' + places.address_name + '</span>';
        //    }

        //    itemStr += '  <span class="tel">' + places.phone + '</span>' +
        //        '</div>';

        //    el.innerHTML = itemStr;
        //    el.className = 'item';

        //    return el;
        //}





    </script>
</body>
</html>
