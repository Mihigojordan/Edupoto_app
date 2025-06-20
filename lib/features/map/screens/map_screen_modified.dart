import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryMapScreenWidget extends StatefulWidget {
  const DeliveryMapScreenWidget({super.key});

  @override
  _DeliveryMapScreenState createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreenWidget> {
  late GoogleMapController _mapController;

  // Initial map position (latitude and longitude)
  LatLng _initialPosition = const LatLng(-1.9684194263108883, 30.122329823396427); // Default to Kigali, Rwanda

  // Markers for delivery locations
  final Set<Marker> _markers = {};

  // Polylines for delivery routes
  final Set<Polyline> _polylines = {};

  // Marker for the user's current location
  Marker? _currentLocationMarker;

  // Google Maps API key
  final String _googleMapsApiKey = 'AIzaSyCHnRFq9SThd7xhhUDMFm6dN8EM02H48zg';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch the user's current location
    _addMarkers(); // Add delivery location markers
    _drawRoute(); // Draw the proper route
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12, // Zoom level
        ),
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }

  // Fetch the user's current location
  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude); // Update initial position
      _addCurrentLocationMarker(position); // Add a marker for the current location
    });
  }

  // Add a marker for the user's current location
  void _addCurrentLocationMarker(Position position) {
    final currentLocationMarker = Marker(
      markerId: const MarkerId('current_location'),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: const InfoWindow(
        title: 'Your Location',
        snippet: 'You are here!',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Blue marker
    );

    setState(() {
      _currentLocationMarker = currentLocationMarker;
      _markers.add(currentLocationMarker); // Add the marker to the map
    });
  }

  // Add markers for delivery locations
  void _addMarkers() {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('delivery_location_1'),
          position: LatLng(-1.9684194263108883, 30.122329823396427), // Source
          infoWindow: InfoWindow(
            title: 'Delivery Location 1',
            snippet: '123 Main St, Kigali',
          ),
        ),
      );

      _markers.add(
        const Marker(
          markerId: MarkerId('delivery_location_2'),
          position: LatLng(-1.960171898407573, 30.108516972386624), // Destination
          infoWindow: InfoWindow(
            title: 'Delivery Location 2',
            snippet: '456 Market St, Kigali',
          ),
        ),
      );
    });
  }

  // Draw the proper route between source and destination
  Future<void> _drawRoute() async {
    final source = const LatLng(-1.9684194263108883, 30.122329823396427); // Source coordinates
    final destination = const LatLng(-1.960171898407573, 30.108516972386624); // Destination coordinates

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?'
      'origin=${source.latitude},${source.longitude}&'
      'destination=${destination.latitude},${destination.longitude}&'
      'key=$_googleMapsApiKey',
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      final points = data['routes'][0]['overview_polyline']['points'];
      final route = _decodePolyline(points);

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: route,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    } else {
      print('Failed to fetch route: ${data['status']}');
    }
  }

  // Decode the polyline points
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}