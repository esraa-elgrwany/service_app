import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:service_app/l10n/app_localizations.dart';

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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.mapBar,style: TextStyle(
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
            urlTemplate: "https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}.png?key=8CYQHrSMkQmkKENk7ZeY",
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
      floatingActionButton: InkWell(
        onTap: _confirmLocation,
        child: Container(
          width: 120.w,
          height: 56.h,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),color: Colors.green
          ),
          child: Center(
            child: Text(AppLocalizations.of(context)!.confirm,style: TextStyle(
              fontSize: 18.sp,fontWeight: FontWeight.w600,color: Colors.white
            ),),
          ),
        ),
      ),
    );
  }
}
