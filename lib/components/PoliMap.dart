import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineMap extends StatefulWidget {
  @override
  _PolylineMapState createState() => _PolylineMapState();
}

class _PolylineMapState extends State<PolylineMap> {
  late GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        polylines: _createPolylines(),
        markers: Set<Marker>.from(markers),
        initialCameraPosition: CameraPosition(
          target: LatLng(14.0583, 108.2772),
          zoom: 6.0,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      polylineCoordinates.add(LatLng(21.532618, 108.056009));
      polylineCoordinates.add(LatLng(20.4017, 108.3792));
      polylineCoordinates.add(LatLng(19.9583, 107.93));
      polylineCoordinates.add(LatLng(19.6583, 107.5283));
      polylineCoordinates.add(LatLng(19.4233, 107.35));
      polylineCoordinates.add(LatLng(19.4233, 107.2117));
      polylineCoordinates.add(LatLng(19.2683, 107.19));
      polylineCoordinates.add(LatLng(19.215, 107.16));
      polylineCoordinates.add(LatLng(18.715, 107.16));
      polylineCoordinates.add(LatLng(18.23, 107.5667));
      polylineCoordinates.add(LatLng(18.1183, 107.6267));
      polylineCoordinates.add(LatLng(18.07, 107.6517));
      polylineCoordinates.add(LatLng(17.7833, 107.9667));
      polylineCoordinates.add(LatLng(17.3317, 108.5572));
      polylineCoordinates.add(LatLng(16.7817, 109.4958));
      polylineCoordinates.add(LatLng(16.4481, 110.9795));
      polylineCoordinates.add(LatLng(17.4598, 111.2896));
      polylineCoordinates.add(LatLng(17.5515, 111.3583));
      polylineCoordinates.add(LatLng(17.6065, 111.4434));
      polylineCoordinates.add(LatLng(17.6274, 111.5286));
      polylineCoordinates.add(LatLng(17.6274, 111.6192));
      polylineCoordinates.add(LatLng(17.5515, 112.1438));
      polylineCoordinates.add(LatLng(17.5017, 112.4322));
      polylineCoordinates.add(LatLng(17.3524, 112.7453));
      polylineCoordinates.add(LatLng(17.2212, 112.9486));
      polylineCoordinates.add(LatLng(17.1517, 112.9843));
      polylineCoordinates.add(LatLng(17.0822, 112.9815));
      polylineCoordinates.add(LatLng(17.4329, 113.5533));
      polylineCoordinates.add(LatLng(18.5129, 114.6131));
      polylineCoordinates.add(LatLng(18.9288, 116.1876));
      polylineCoordinates.add(LatLng(19.743, 117.6259));
      polylineCoordinates.add(LatLng(18.6421, 117.4442));
      polylineCoordinates.add(LatLng(17.8225, 116.99));
      polylineCoordinates.add(LatLng(16.2592, 116.5207));
      polylineCoordinates.add(LatLng(13.8618, 116.8083));
      polylineCoordinates.add(LatLng(13.8471, 116.8235));
      polylineCoordinates.add(LatLng(12.6799, 116.4964));
      polylineCoordinates.add(LatLng(11.93, 115.7554));
      polylineCoordinates.add(LatLng(12.1166, 116.7854));
      polylineCoordinates.add(LatLng(11.118, 117.8153));
      polylineCoordinates.add(LatLng(10.3488, 117.9698));
      polylineCoordinates.add(LatLng(9, 115.9814));
      polylineCoordinates.add(LatLng(7.66, 115.7554));
      polylineCoordinates.add(LatLng(6.74, 113.6954));
      polylineCoordinates.add(LatLng(7.6634, 112.5625));
      polylineCoordinates.add(LatLng(6.262, 111.0175));
      polylineCoordinates.add(LatLng(6.8375, 109.2869));
      polylineCoordinates.add(LatLng(6.35, 106.6605));
      polylineCoordinates.add(LatLng(6.25, 106.3169));
      polylineCoordinates.add(LatLng(6.25, 106.2));
      polylineCoordinates.add(LatLng(6.0967, 105.82));
      polylineCoordinates.add(LatLng(7.05, 103.8667));
      polylineCoordinates.add(LatLng(7.3052, 103.5953));
      polylineCoordinates.add(LatLng(7.5667, 103.3167));
      polylineCoordinates.add(LatLng(7.7, 102.9667));
      polylineCoordinates.add(LatLng(7.7122, 102.9512));
      polylineCoordinates.add(LatLng(7.8167, 103.0417));
      polylineCoordinates.add(LatLng(8.7819, 102.2032));
      polylineCoordinates.add(LatLng(9.5834, 103.1711));
      polylineCoordinates.add(LatLng(9.9167, 102.8917));
      polylineCoordinates.add(LatLng(9.9033, 102.92));
      polylineCoordinates.add(LatLng(9.9083, 102.95));
      polylineCoordinates.add(LatLng(10.4017, 103.8));
      polylineCoordinates.add(LatLng(10.4267, 103.82));
      polylineCoordinates.add(LatLng(10.5, 103.79));
      polylineCoordinates.add(LatLng(10.54, 103.8033));

      _addMarker(LatLng(21.532618, 108.056009), "Tàu 1","Trieu Thanh Tung", 'lib/assets/images/bg13.png');
      _addMarker(LatLng(6.35, 106.6605), "Tàu 2","Trieu Thanh Tung", 'lib/assets/images/bg13.png');
      _addMarker(LatLng(17.8225, 116.99), "Tàu 3","Trieu Thanh Tung", 'lib/assets/images/bg13.png');
      _addMarker(LatLng(19.743, 117.6259), "Tàu 4","Trieu Thanh Tung", 'lib/assets/images/bg13.png');
      _addMarker(LatLng(17.4598, 111.2899), "Tàu 5","Trieu Thanh Tung", 'lib/assets/images/bg13.png');
      _addMarker(LatLng(19.2683, 107.19), "Tàu 6","Trieu Thanh Tung", 'lib/assets/images/bg13.png');


    });
  }

  void _addMarker(LatLng position, String nameship, String namethuyen, String iconPath) async {
    final BitmapDescriptor markerIcon =
    await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(30, 30)), 'lib/assets/images/bg13.png');

    markers.add(
      Marker(
        markerId: MarkerId("$nameship-$namethuyen"),
        position: position,
        icon: markerIcon,
        infoWindow: InfoWindow(),
        onTap: () {
          // Xử lý khi Marker được bấm
          _onMarkerTapped(nameship, namethuyen);
        },
      ),
    );
  }


  void _onMarkerTapped(String nameship,String namethuyen) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông tin thuyền"),
          content: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tên thuyền: $nameship"),
                SizedBox(height: 8), // Khoảng cách giữa các dòng
                Text("Tên thuyền trưởng: $namethuyen"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn nút
              },
              child: Text("Đóng"),
            ),
          ],
        );
      },
    );
  }



  Set<Polyline> _createPolylines() {
    Set<Polyline> polylines = Set<Polyline>();
    if (polylineCoordinates.isNotEmpty) {
      Polyline polyline = Polyline(
        polylineId: PolylineId("poly"),
        color: Colors.blue,
        points: polylineCoordinates,
        width: 1,
      );
      polylines.add(polyline);
    }
    return polylines;
  }
}
