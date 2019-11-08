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