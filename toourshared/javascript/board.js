
// input (맵객체id, 중심좌표, 지도 데이터를 포함한 hiddenfiled , inStrokeColor,inFillColor)
// return -> {생성한 지도객체, 생성한 manager, }
function makeMapOption(mapId, mapCenter, mapLevel, mapDataInputId, inStrokeColor, inFillColor) {
    
    var drawingMapContainer = document.getElementById(mapId),
    drawingMap = {
        center: mapCenter, // 지도의 중심좌표
        level: mapLevel // 지도의 확대 레벨
    };
    
    var drawingMap = new daum.maps.Map(drawingMapContainer, drawingMap);
    
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

        arrowOptions: {
            draggable: false,
            removable: false,
            editable: false,
            strokeWeight: 3,
            strokeOpacity: 0.8,
            strokeColor: inStrokeColor,
            strokeStyle: 'solid',
            hintStrokeStyle: 'dashdot',
            hintStrokeOpacity: 0.3,
            startArrow: false
        },
        circleOptions: {
            draggable: false,
            removable: false,
            editable: true,
            strokeColor: inStrokeColor,
            fillColor: inFillColor,
            fillOpacity: 0.5
        },
        ellipseOptions: {
            draggable: false,
            removable: false,
            editable: false,
            strokeWeight: 2,
            strokeOpacity: 0.8,
            strokeColor: inStrokeColor,
            strokeStyle: 'solid',
            fillColor: inFillColor,
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
            draggable: false, // 그린 후 드래그가 가능하도록 설정합니다
            removable: false, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
            editable: false, // 그린 후 수정할 수 있도록 설정합니다
            strokeColor: inStrokeColor, // 선 색
            hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
            hintStrokeOpacity: 0.5 // 그리중 마우스를 따라다니는 보조선의 투명도
        },
        polygonOptions: {
            draggable: false,
            removable: false,
            editable: false,
            strokeColor: inStrokeColor,
            fillColor: inFillColor,
            fillOpacity: 0.5,
            hintStrokeStyle: 'dash',
            hintStrokeOpacity: 0.5
        },
        rectangleOptions: {
            draggable: false,
            removable: false,
            editable: false,
            strokeColor: inStrokeColor, // 외곽선 색
            fillColor: inFillColor, // 채우기 색
            fillOpacity: 0.5 // 채우기색 투명도
        }

    };
    var resultManager = new daum.maps.drawing.DrawingManager(options);
    
    return {map: drawingMap, manager: resultManager};

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
    drawMarker(data["marker"]);
    drawPolyline(data["polyline"]);
    drawRectangle(data["rectangle"]);
    drawCircle(data["circle"]);
    drawPolygon(data["polygon"]);
    drawEllipse(data["ellipse"]);
    //drawPolygon(data["arrow"]);




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

function drawArrow(arrow) {
    var len = arrow.length,
        i = 0;

    for (; i < len; i++) {
        var path = pointsToPath(arrow[i].points);
        var style = arrow[i].options;
        var polyline = new kakao.maps.Arrow({
            map: drawingMap,
            endArrow: style.endArrow,
            path: path,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight
        });

        overlays.push(polyline);
    }
}

function drawEllipse(ellipse) {
    var len = ellipse.length,
        i = 0;

    for (; i < len; i++) {
        var style = ellipse[i].options;
        var circle = new kakao.maps.Ellipse({
            map: drawingMap,
            center: new kakao.maps.LatLng(ellipse[i].center.x, ellipse[i].center.y),
            ePoint: new kakao.maps.LatLng(ellipse[i].ePoint.x, ellipse[i].ePoint.y),
            strokeWeight: style.strokeWeight,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            fillColor: style.fillColor,
            fillOpacity: style.fillOpacity
        });
        overlays.push(ellipse);
    }
} // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
function drawMarker(markers) {
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
function drawPolyline(lines) {
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
function drawRectangle(rects) {
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
function drawCircle(circles) {
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
function drawPolygon(polygons) {
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
