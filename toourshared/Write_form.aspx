<%@ Page Language="C#" EnableEventValidation="false" %>

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
            vertical-align:middle;
        }

        .modes {
            top: 10px;
            left: 10px;
            z-index: 1;
        }

        #drawingMap {
            width: 100%;
            height: 500px;
            text-align: center;
        }
    </style>
</head>
<body>



    <div class="container">
        <div class="col-sm-12">
            <div id="emailMsg"></div>
            <form id="form1" action="Write_get.aspx" runat="server">
                <input type="hidden" name="sendEmail" value="ok" />
                <div class="form-group">
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control form-control-lg" placeholder="제목을 입력해주세요"></asp:TextBox>
                </div>
                <div class="map_wrap">
                    <div id="drawingMap"></div>

                    <p class="modes">
                        <button onclick="selectOverlay('MARKER')">마커</button>
                        <button onclick="selectOverlay('POLYLINE')">선</button>
                        <button onclick="selectOverlay('CIRCLE')">원</button>
                        <button onclick="selectOverlay('RECTANGLE')">사각형</button>
                        <button onclick="selectOverlay('POLYGON')">다각형</button>
                    </p>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control form-control-lg" placeholder="#해시태그를 입력해주세요"></asp:TextBox>
                </div>
                <div class="form-group">
                    <input type="submit" value="넘기기" />
                </div>
            </form>
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
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=drawing"></script>
    <script>
        // Drawing Manager로 도형을 그릴 지도 div
        var drawingMapContainer = document.getElementById('drawingMap'),
            drawingMap = {
                center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
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
        var map = new daum.maps.Map(mapContainer, mapOptions),
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

        function postToNext() {
            var data = manager.getData();

            markers = data[daum.maps.drawing.OverlayType.MARKER];
            polylines = data[daum.maps.drawing.OverlayType.POLYLINE];
            rectangles = data[daum.maps.drawing.OverlayType.RECTANGLE];
            circles = data[daum.maps.drawing.OverlayType.CIRCLE];
            polygons = data[daum.maps.drawing.OverlayType.POLYGON];

            markersPath = [];
            polylinesPath = [];
            rectanglesPath = [];
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
                polygonsPath.push(i + ":");
                polygonsPath.push(path);

            }


            document.getElementById("marker").value = markersPath;
            document.getElementById("polygon").value = polygonsPath;


            //     var form = document.createElement("form");      // form 엘리멘트 생성
            //     form.setAttribute("method","post");             // method 속성 설정
            //     form.setAttribute("action","marker.php");       // action 속성 설정
            //     document.body.appendChild(form);                // 현재 페이지에 form 엘리멘트 추가

            //     var insert1 = document.createElement("input");   // input 엘리멘트 생성
            //     insert1.setAttribute("type","hidden");           // type 속성을 hidden으로 설정
            //     insert1.setAttribute("name","marker");               // name 속성을 'stadium'으로 설정
            //     insert1.setAttribute("value",markersPath);             // value 속성을 삽입
            //     form.appendChild(insert1);                       // form 엘리멘트에 input 엘리멘트 추가

            // var insert2 = document.createElement("input");   // input 엘리멘트 생성
            //     insert2.setAttribute("type","hidden");           // type 속성을 hidden으로 설정
            //     insert2.setAttribute("name","polyline");               // name 속성을 'stadium'으로 설정
            //     insert2.setAttribute("value",polylinesPath);             // value 속성을 삽입
            //     form.appendChild(insert2);  


            //     form.submit();                                  // 전송
        }
    </script>
</body>
</html>
