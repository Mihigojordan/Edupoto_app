// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DeliveryNamedMapScreen extends StatefulWidget {
//   const DeliveryNamedMapScreen({super.key});

//   @override
//   _DeliveryMapScreenState createState() => _DeliveryMapScreenState();
// }

// class _DeliveryMapScreenState extends State<DeliveryNamedMapScreen> {
//   late GoogleMapController _mapController;

//   // Initial map position (latitude and longitude)
//   LatLng _initialPosition = const LatLng(-1.9536, 30.1044); // Default to Kigali, Rwanda

//   // Markers for source, destination, and current location
//   final Set<Marker> _markers = {};

//   // Polylines for the route
//   final Set<Polyline> _polylines = {};

//   // Controllers for source and destination text fields
//   final TextEditingController _sourceController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();

//   // Google Places API key
//   final String _googleMapsApiKey = 'AIzaSyCHnRFq9SThd7xhhUDMFm6dN8EM02H48zg';

//   // Google Places instance
//   final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyCHnRFq9SThd7xhhUDMFm6dN8EM02H48zg');

//   // Distance and duration
//   String _distance = '';
//   String _duration = '';

//   // Sample customer product and order ID
//   final String _customerProduct = 'Sample Product';
//   final String _orderId = 'ORDER123456';

//   @override
//   void initState() {
//     super.initState();
//     // Set default source and destination
//     _sourceController.text = 'Kabeza Escarie';
//     _destinationController.text = 'Chibagabaga Munsi Ibitalo';
//     _getCurrentLocation(); // Fetch the user's current location
//     _drawRoute(); // Draw the default route
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height / 1.3,
//       child: Column(
//         children: [
//           // Source and Destination Input Fields
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _sourceController,
//                   decoration: InputDecoration(
//                     labelText: 'Source',
//                     hintText: 'Enter source address',
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.search),
//                       onPressed: () => _showPlaceAutocomplete(isSource: true),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: _destinationController,
//                   decoration: InputDecoration(
//                     labelText: 'Destination',
//                     hintText: 'Enter destination address',
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.search),
//                       onPressed: () => _showPlaceAutocomplete(isSource: false),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Map
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: (controller) {
//                 setState(() {
//                   _mapController = controller;
//                 });
//               },
//               initialCameraPosition: CameraPosition(
//                 target: _initialPosition,
//                 zoom: 12, // Zoom level
//               ),
//               markers: _markers,
//               polylines: _polylines,
//             ),
//           ),
//           // Distance and Duration
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Text(
//                   'Distance: $_distance',
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Time Remaining: $_duration',
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           // Capture Information Button
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: InkWell(
//               onTap: ()=>_captureInformation(),
//               child: Container(
//                 margin: const EdgeInsets.all(10.0), // Add margin if needed
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Add padding if needed
//                 decoration: BoxDecoration(
//                   color: kgoldYellowColor, // Background color of the container
//                   borderRadius: BorderRadius.circular(15.0), // Rounded corners
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0, 2),
//                       blurRadius: 4.0,
//                     ),
//                   ],
//                 ),
//                 child: const Text(
//                     'next',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.white,
//                     ),
//                   ),
              
//               ),
//             )
//           ),
//         ],
//       ),
//     );
//   }

//   // Fetch the user's current location
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print('Location services are disabled.');
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         print('Location permissions are denied.');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       print('Location permissions are permanently denied.');
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _initialPosition = LatLng(position.latitude, position.longitude);
//       _addCurrentLocationMarker(position);
//     });
//   }

//   // Add a marker for the user's current location
//   void _addCurrentLocationMarker(Position position) {
//     final currentLocationMarker = Marker(
//       markerId: const MarkerId('current_location'),
//       position: LatLng(position.latitude, position.longitude),
//       infoWindow: const InfoWindow(
//         title: 'Your Location',
//         snippet: 'You are here!',
//       ),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//     );

//     setState(() {
//       _markers.add(currentLocationMarker);
//     });
//   }

//   // Show Google Places Autocomplete
//   Future<void> _showPlaceAutocomplete({required bool isSource}) async {
//     Prediction? prediction = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: _googleMapsApiKey,
//       mode: Mode.overlay, // Display autocomplete in an overlay
//       language: 'en', // Language for autocomplete suggestions
//     );

//     if (prediction != null) {
//       // Get place details using the place ID
//       PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(prediction.placeId!);

//       final lat = detail.result.geometry!.location.lat;
//       final lng = detail.result.geometry!.location.lng;

//       setState(() {
//         if (isSource) {
//           _sourceController.text = prediction.description!;
//           _addMarker(LatLng(lat, lng), 'Source', BitmapDescriptor.hueGreen);
//         } else {
//           _destinationController.text = prediction.description!;
//           _addMarker(LatLng(lat, lng), 'Destination', BitmapDescriptor.hueRed);
//         }
//       });

//       // Draw route if both source and destination are selected
//       if (_sourceController.text.isNotEmpty && _destinationController.text.isNotEmpty) {
//         _drawRoute();
//       }
//     }
//   }

//   // Add a marker for source or destination
//   void _addMarker(LatLng position, String title, double hue) {
//     final marker = Marker(
//       markerId: MarkerId(title),
//       position: position,
//       infoWindow: InfoWindow(
//         title: title,
//         snippet: title == 'Source' ? _sourceController.text : _destinationController.text,
//       ),
//       icon: BitmapDescriptor.defaultMarkerWithHue(hue),
//     );

//     setState(() {
//       _markers.add(marker);
//     });
//   }

//   // Draw a route between source and destination
//   Future<void> _drawRoute() async {
//     final source = _sourceController.text;
//     final destination = _destinationController.text;

//     // Geocode source and destination addresses to get their coordinates
//     final sourceLatLng = await _geocodeAddress(source);
//     final destinationLatLng = await _geocodeAddress(destination);

//     if (sourceLatLng == null || destinationLatLng == null) {
//       print('Failed to geocode addresses.');
//       return;
//     }

//     // Add markers for source and destination
//     _addMarker(sourceLatLng, 'Source', BitmapDescriptor.hueGreen);
//     _addMarker(destinationLatLng, 'Destination', BitmapDescriptor.hueRed);

//     final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/directions/json?'
//       'origin=${sourceLatLng.latitude},${sourceLatLng.longitude}&'
//       'destination=${destinationLatLng.latitude},${destinationLatLng.longitude}&'
//       'key=$_googleMapsApiKey',
//     );

//     final response = await http.get(url);
//     final data = jsonDecode(response.body);

//     if (data['status'] == 'OK') {
//       final points = data['routes'][0]['overview_polyline']['points'];
//       final route = _decodePolyline(points);

//       // Extract distance and duration
//       final distance = data['routes'][0]['legs'][0]['distance']['text'];
//       final duration = data['routes'][0]['legs'][0]['duration']['text'];

//       setState(() {
//         _distance = distance;
//         _duration = duration;
//         _polylines.add(
//           Polyline(
//             polylineId: const PolylineId('route'),
//             points: route,
//             color: Colors.blue,
//             width: 5,
//           ),
//         );
//       });
//     }
//   }

//   // Geocode an address to get its coordinates
//   Future<LatLng?> _geocodeAddress(String address) async {
//     final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/geocode/json?'
//       'address=$address&'
//       'key=$_googleMapsApiKey',
//     );

//     final response = await http.get(url);
//     final data = jsonDecode(response.body);

//     if (data['status'] == 'OK') {
//       final lat = data['results'][0]['geometry']['location']['lat'];
//       final lng = data['results'][0]['geometry']['location']['lng'];
//       return LatLng(lat, lng);
//     } else {
//       print('Geocoding failed for address: $address');
//       return null;
//     }
//   }

//   // Decode the polyline points
//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       points.add(LatLng(lat / 1E5, lng / 1E5));
//     }

//     return points;
//   }

//   // Capture information and display it
//   void _captureInformation() {
//     final source = _sourceController.text;
//     final destination = _destinationController.text;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirm'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Source: $source'),
//               Text('Destination: $destination'),
//               Text('Distance: $_distance'),
//               Text('Time Remaining: $_duration'),
//               Text('Customer Product: $_customerProduct'),
//               Text('Order ID: $_orderId'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }