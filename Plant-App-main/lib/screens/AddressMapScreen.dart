import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressMapScreen extends StatefulWidget {
  const AddressMapScreen({super.key});

  @override
  _AddressMapScreenState createState() => _AddressMapScreenState();
}

class _AddressMapScreenState extends State<AddressMapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(16.0544, 108.2022); // Tọa độ trung tâm (Đà Nẵng)
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('123 Tôn Đức Thắng'),
          position: LatLng(16.0544, 108.2022), // Tọa độ của địa chỉ
          infoWindow: InfoWindow(
            title: '123 Tôn Đức Thắng',
            snippet: 'Phường Hòa Khánh Nam, Quận Liên Chiểu, Thành Phố Đà Nẵng',
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ của tôi'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0, // Điều chỉnh mức độ zoom tùy ý
        ),
        markers: _markers,
      ),
    );
  }
}