import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerScreen extends StatefulWidget {
  static const String routeName="mapPicker";
  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? _selectedLatLng;

  void _onTap(LatLng latlng) {
    setState(() {
      _selectedLatLng = latlng;
    });
  }

  Future<void> _confirmLocation() async {
    if (_selectedLatLng != null) {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        _selectedLatLng!.latitude,
        _selectedLatLng!.longitude,
      );
      final address = placeMarks.isNotEmpty
          ? "${placeMarks.first.name},${placeMarks.first.locality}"
          : "Unknown location";
      final locationLink =
          "https://www.google.com/maps/search/?api=1&query=${_selectedLatLng!.latitude},${_selectedLatLng!.longitude}";

      Navigator.pop(context, {
        "lat": _selectedLatLng!.latitude,
        "lng": _selectedLatLng!.longitude,
        "address": address,
        "link": locationLink,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location on Map",style: TextStyle(
        fontSize: 22.sp,fontWeight: FontWeight.w600
      ),)),
      body: FlutterMap(
        options: MapOptions(
         initialCenter: LatLng(21.4735, 55.9754),
          initialZoom: 6.5,
          onTap: (_, latlng) => _onTap(latlng),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          if (_selectedLatLng != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _selectedLatLng!,
                  width: 40.w,
                  height: 40.h,
                  child:Icon(Icons.location_on, color: Colors.red, size: 36),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _confirmLocation,
        label: Text("Confirm",style: TextStyle(
          fontSize: 18.sp,fontWeight: FontWeight.w600
        ),),
        backgroundColor: Colors.green,
        extendedPadding: EdgeInsets.all(16),
      ),
    );
  }
}
