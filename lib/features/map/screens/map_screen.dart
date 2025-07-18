import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/common/widgets/custom_dropdown.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/show_info_dialog.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_method.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/tereka_asome.dart';
import 'package:hosomobile/features/map/screens/left_aligned_row.dart';
import 'package:hosomobile/features/map/widgets/text_field_description.dart';
import 'package:hosomobile/features/map/widgets/text_field_formatter.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/screens/school_transaction_confirmation_screen.dart';
import 'package:hosomobile/features/transaction_money/screens/transaction_confirmation_screen.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_sl.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_sp.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({
    super.key,
    required this.schoolId,
    required this.classId,
    required this.studentId,
    required this.className,
    required this.schoolName,
    required this.studentName,
    required this.studentCode,
    required this.screenId,
    required this.calculatedTotal,
    required this.contactModel,
    required this.eduboxService,
    required this.dataList,
    required this.shipper,

    required this.homePhone,
    required this.productId,
    required this.pinCodeFieldController,
    required this.transactionType,
    required this.calculatedTotalWithServices,
    required this.productIndex,
    required this.purpose,
    required this.calculateServiceCharge,
    required this.calculateVAT,
    required this.productName,
    required this.randomNumber,
    required this.serviceIndex,
    required this.totalAmount,
    required this.vatPercentage,
    required this.isShop,
    required this.deliveryCost,
    this.cart,
    this.checkedStudents,
    this.checkedStudentsId,
    this.product,
    this.quantity,
    this.studentIndex,
   required this.phoneNumberEditingController,
  required  this.descriptionController,
  required  this.destinationController
  });

  final int schoolId;
  final int studentId;
  final int classId;
  final String schoolName;
  final String className;
  final String studentName;
  final String studentCode;
  final int screenId;
  final double calculatedTotal;
  final ContactModel contactModel;
  final String eduboxService;
  final List<EduboxMaterialModel> dataList;
  final String shipper;
  final String homePhone;

  final int productId;
  final String pinCodeFieldController;
  final String transactionType;
  final String purpose;
  final int productIndex;
  final double calculatedTotalWithServices;
  final double vatPercentage;
  final double calculateVAT;
  final double calculateServiceCharge;
  final double totalAmount;
  final String productName;
  final int serviceIndex;
  final int randomNumber;
  final int isShop;
  final Product? product;
  final int? checkedStudentsId;
  final List<StudentModel>? checkedStudents;
  final Map<Product, int>? cart;
  final int? quantity;
  final int? studentIndex;
  final double deliveryCost;
  final TextEditingController phoneNumberEditingController;
  final TextEditingController descriptionController;
  final TextEditingController destinationController;

  @override
  _DeliveryMapScreenState createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  late GoogleMapController _mapController;
  LatLng _initialPosition =
      const LatLng(-1.9536, 30.1044); // Default to Kigali, Rwanda
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final _formKey = GlobalKey<FormState>();
  late FocusNode addressFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode stateFocusNode;
  late FocusNode zipFocusNode;

  late TextEditingController addressTextController;
  late TextEditingController cityTextController;
  late TextEditingController stateTextController;
  late TextEditingController zipTextController;
  

  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory;
  ClassDetails? selectedSubCategory;
  Student? selectedStudent;
  TextEditingController studentCodeEditingController = TextEditingController();
  TextEditingController studentNameEditingController = TextEditingController();
  List<Districts>? allSchoolList;
  String deliveryOptionsValue = 'choose_delivery_company'.tr;
  String? _deliveryOptionError;


  List<Map<dynamic, String>> topSize =  [
    {'name': 'Dropp', 'logo': 'assets/icons1/dropp.jpeg', 'status': 'busy'.tr},
    {
      'name': 'i-Posita',
      'logo': 'assets/icons1/iposita.jpeg',
      'status': 'available'.tr
    },
    {
      'name': 'Vuba Vuba',
      'logo': 'assets/icons1/vuba.png',
      'status': 'available'.tr
    },
    {'name': 'Zugu', 'logo': 'assets/icons1/zugu.jpeg', 'status': 'busy'.tr},
  ];

  // Controllers for source and destination text fields
  final TextEditingController _sourceController = TextEditingController();
  String _distance = '';
  String _duration = '';

  // Variables to store source and destination coordinates
  LatLng? _sourceLatLng;
  LatLng? _destinationLatLng;

Marker? _draggableMarker;
bool _isDragging = false;
String _currentAddress = '';
bool _isLoadingAddress = false;
LatLng? _previousMarkerPosition;
bool _isInputLocation= false;

void onInputLocation(){
  setState(
    (){
_isInputLocation = !_isInputLocation;
    }
  );
}


  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch current_location .trand set it as the default source
    addressFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    zipFocusNode = FocusNode();

    addressTextController = TextEditingController();
    cityTextController = TextEditingController();
    stateTextController = TextEditingController();
    zipTextController = TextEditingController();
  }

  // when they choose an address
  String? onSuggestionClickGetTextToUseForControl(Place placeDetails) {
    String? forOurAddressBox = placeDetails.streetAddress;
    if (forOurAddressBox == null || forOurAddressBox.isEmpty) {
      forOurAddressBox = placeDetails.streetNumber ?? '';
      forOurAddressBox += (forOurAddressBox.isNotEmpty ? ' ' : '');
      forOurAddressBox += placeDetails.streetShort ?? '';
    }
    return forOurAddressBox;
  }

  /// countries other than the united states.
  String prepareQuery(String baseAddressQuery) {
    debugPrint('prepareQuery() baseAddressQuery=$baseAddressQuery');
    String built = baseAddressQuery;
    String city = cityTextController.text;
    String state = stateTextController.text;
    String zip = zipTextController.text;
    if (city.isNotEmpty) {
      built += ', $city';
    }
    if (state.isNotEmpty) {
      built += ', $state';
    }
    if (zip.isNotEmpty) {
      built += ' $zip';
    }
    built += ', USA';
    debugPrint('prepareQuery made built="$built"');
    return built;
  }

  void onClearClick() {
    debugPrint('onClearClickInAddressAutocomplete() clearing form');
    addressTextController.clear();
    cityTextController.clear();
    stateTextController.clear();
    zipTextController.clear();

    if (!addressFocusNode.hasFocus) {
      // if address does not have focus unfocus everything to close keyboard
      // and show the cleared form.
      FocusScopeNode currentFocus = FocusScope.of(context);
      currentFocus.unfocus();
    }
  }

  // This gets us an IMMEDIATE form fill but address has no abbreviations
  // and we must wait for the zipcode.
  void onInitialSuggestionClick(Suggestion suggestion) {
    final description = suggestion.description;

    debugPrint('onInitialSuggestionClick()  description=$description');
    debugPrint('  suggestion = $suggestion');
    /* COULD BE USED TO SHOW IMMEDIATE values in form
       BEFORE PlaceDetails arrive from API

    var parts = description.split(',');

    if(parts.length<4) {
      parts = [ '','','','' ];
    }
    addressTextController.text = parts[0];
    cityTextController.text = parts[1];
    stateTextController.text = parts[2].trim();
    zipTextController.clear(); // we wont have zip until details come thru
    */
  }

  void onSuggestionClick(Place placeDetails) {
    debugPrint('onSuggestionClick() placeDetails:$placeDetails');

    cityTextController.text = placeDetails.city ?? '';
    stateTextController.text = placeDetails.state ?? '';
    zipTextController.text = placeDetails.zipCode ?? '';
  }

  InputDecoration getInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.purple,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.black12,
          width: 1.0,
        ),
      ),
    );
  }

  void dispose() {
    addressFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    zipFocusNode.dispose();

    addressTextController.dispose();
    cityTextController.dispose();
    stateTextController.dispose();
    zipTextController.dispose();
    widget.descriptionController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.8,
            child: Stack(
              children: [
                // Google Map
      GoogleMap(
  onMapCreated: (controller) => _mapController = controller,
  initialCameraPosition: CameraPosition(
    target: _initialPosition,
    zoom: 14,
  ),
  markers: _markers,
  polylines: _polylines,
  onTap: (latLng) async {
    final address = await _getAddressFromLatLng(latLng);
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'draggable_marker');
      widget.destinationController!.text = address;
      _destinationLatLng = latLng;
      _draggableMarker = _createDraggableMarker(latLng, address);
      _markers.add(_draggableMarker!);
    });
    _drawRoute();
  },
),

                // Floating Source and Destination Input Fields
     _isInputLocation==false?Positioned(
        top: 20,
        left: 16,
        right: 16,
        child: InkWell(
          onTap: () => onInputLocation(),
          child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
                ),
                child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: '📍 ',
                style: TextStyle(
                  color: Colors.red.shade400,
                ),
              ),
              TextSpan(
                text: 'drop_the_pin_to_your'.tr,
               style:const TextStyle(
                 fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' ${'exact_delivery_location'.tr}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
                  TextSpan(
                text: ' ${'or'.tr} ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kTextBlackColor,
                ),
              ),
                     TextSpan(
            text: ' ${'click_here_to_enter_where_to_deliver'.tr}',
            style:const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              decoration: TextDecoration.underline, // This is the correct way to underline
            ),            ),
            ],
          ),
                ),
          ),
        ),
      ):
                    Positioned(
                      top: 20, // Adjust the position as needed
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                // Wrap  text field with a Stack to show loading
      Stack(
        children: [
         TextField(
        controller: widget.destinationController,
        decoration: InputDecoration(
          labelText: 'where_to'.tr,
          hintText: '${'eg'.tr} KN 360 St 6',
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
          // suffixIcon: IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () => _setDestinationFromInput(),
          // ),
        ),
        onChanged: (value) async {
          if (value.isNotEmpty && value.length > 3) {
            // Call your geocoding service for suggestions
            List<Location> locations = await locationFromAddress(value);
            if (locations.isNotEmpty) {
              // Update the marker position
              LatLng newPosition = LatLng(
                locations.first.latitude,
                locations.first.longitude,
              );
              setState(() {
                _draggableMarker = _draggableMarker!.copyWith(
                  positionParam: newPosition,
                );
                _mapController.animateCamera(
                  CameraUpdate.newLatLng(newPosition),
                );
              });
            }
          }
        },
      ),
          if (_isLoadingAddress)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
   
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
          // Floating Distance and Duration Information
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // widget.destinationController!.text == ''
                //     ? const SizedBox.shrink()
                //     : Column(
                //         children: [
                //           _buildListTile(
                //               icon: Icons.location_on,
                //               title: widget.destinationController!.text,
                //               onTap: () {}),
                //           sizedBox15,
                //         ],
                //       ),
                // _buildListTile(
                //     icon: Icons.star, title: 'choose_saved_place'.tr, onTap: () {}),
                sizedBox10,
                Text(
                  'please_provide_phone_number_available_at_your_current_location'.tr,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: kErrorBorderColor, fontWeight: FontWeight.normal),
                ),
                sizedBox10,
    buildFormField(
  'phone_number'.tr,
 widget.phoneNumberEditingController!,
  TextInputType.phone,
  '07XXXXXXXX',
  isPhoneNumber: true,
  validator: (value) {
    return _validatePhoneNumber(value) ?? 
      (value?.isEmpty ?? true ? 'please_select_receiver_phone_number'.tr : null);
  },
),
                sizedBox10,
                     ShortDescriptionInput(
                controller: widget.descriptionController!,
                labelText: 'product_delivery_description'.tr,
                hintText: 'describe_in_200_characters_or_less'.tr,
                maxLength: 200,
                onChanged: (value) {
                  // Handle real-time changes if needed
                },
              ),
              sizedBox10,
                // CustomDropdown(
                //     onChanged: (onChanged) {
                //       setState(() {
                //         deliveryOptionsValue = onChanged!;
                //       });
                //     },
                //     prefixIcon: 'assets/icons1/delivery.jpg',
                //     itemLists: topSize,
                //     title: deliveryOptionsValue,
                //     width: screenWidth,
                //     menuWidth: screenWidth/1.2,
                //     menuHeight: screenHeight/3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => _captureInformation(),
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child:  Text(
                          'next'.tr,
                          style:const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

TextFormField buildFormField(
  String labelText,
  TextEditingController editingController,
  TextInputType textInputType,
  String hintText, {
  String? Function(String?)? validator,
  bool isPhoneNumber = false,
}) {
  return TextFormField(
    textAlign: TextAlign.start,
    controller: editingController,
    keyboardType: textInputType,
    style: kInputTextStyle,
    validator: validator,
    inputFormatters: isPhoneNumber
        ? [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
            LengthLimitingTextInputFormatter(15), // For international numbers
            PhoneNumberFormatter(),
          ]
        : null,
    decoration: InputDecoration(
      isCollapsed: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: kamber300Color),
        borderRadius: BorderRadius.circular(20.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: kTextLightColor),
        borderRadius: BorderRadius.circular(20.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelText: labelText,
      hintStyle: const TextStyle(color: Colors.grey),
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: isPhoneNumber
          ? ValueListenableBuilder<TextEditingValue>(
              valueListenable: editingController,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                final isValid = _validatePhoneNumber(value.text) == null;
                return Icon(
                  isValid ? Icons.check_circle : Icons.error,
                  color: isValid ? Colors.green : Colors.red,
                  size: 20,
                );
              },
            )
          : null,
    ),
  );
}

String? _validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) return null;
  
  final cleaned = value.replaceAll(RegExp(r'[^\d+]'), '');

  // 1. International numbers (+ prefix)
  if (cleaned.startsWith('+')) {
    return cleaned.length >= 9 && cleaned.length <= 15 
        ? null 
        : 'Enter 9-15 digits after +';
  }

  // 2. Rwandan numbers (07, 72, 73, 78)
  if (cleaned.startsWith('07') || cleaned.startsWith('72') || 
     cleaned.startsWith('73') || cleaned.startsWith('78')) {
    return cleaned.length == 10 ? null : 'Rwandan number must be 10 digits';
  }

  // 3. General 10-digit numbers (US/Canada/India etc.)
  if (cleaned.length == 9 && !cleaned.startsWith('0')) {
    return null;
  }

  return 'Enter valid 10-digit, Rwandan (07...) or international (+...) number';
}



  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF000000)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }


// Add these variables to your state class
final List<String> _capturedAddresses = []; // Stores all captured addresses
String? _selectedAddress; // Currently selected address for printing

Future<void> _getCurrentLocation() async {
  // Check and request location permissions
  if (!await _checkLocationPermissions()) return;

  try {
    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    String address = await _getAddressFromLatLng(currentLatLng);

    setState(() {
      _initialPosition = currentLatLng;
      _sourceLatLng = const LatLng(-1.9482248511453184, 30.05919848211911); // Fixed pickup point
      _destinationLatLng = currentLatLng;
      _currentAddress = address;
      widget.destinationController.text = address;
      _capturedAddresses.add(address); // Store the initial address
      
      // Clear existing markers and add new ones
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('fixed_source'),
          position: _sourceLatLng!,
          infoWindow: const InfoWindow(title: 'Pickup Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
      
      _draggableMarker = _createDraggableMarker(currentLatLng, address);
      _markers.add(_draggableMarker!);
      
      // Draw initial route
      _drawRoute();
    });
    
  } catch (e) {
    debugPrint('Error getting location: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not get location: ${e.toString()}')),
    );
  }
}

Future<bool> _checkLocationPermissions() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enable location services')),
    );
    return false;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are required')),
      );
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enable location permissions in settings')),
    );
    return false;
  }

  return true;
}

Marker _createDraggableMarker(LatLng position, String address) {
  return Marker(
    markerId: const MarkerId('draggable_marker'),
    position: position,
    draggable: true,
    infoWindow: InfoWindow(
      title: 'Delivery Location',
      snippet: address.length > 30 ? '${address.substring(0, 30)}...' : address,
      onTap: () => _showAddressDialog(address),
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    onDragEnd: (newPosition) async {
      final newAddress = await _getAddressFromLatLng(newPosition);
      setState(() {
        _destinationLatLng = newPosition;
        widget.destinationController!.text = newAddress;
        _markers.removeWhere((m) => m.markerId.value == 'draggable_marker');
        _draggableMarker = _createDraggableMarker(newPosition, newAddress);
        _markers.add(_draggableMarker!);
      });
      _drawRoute();
    },
  );
}

// Add proper address dialog
void _showAddressDialog(String address) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Captured Address'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _printAddress(address);
                Navigator.pop(context);
              },
              child: const Text('Print Address'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
// Replace your _getAddressFromLatLng with this more robust version
// Future<String> _getAddressFromLatLng(LatLng position) async {
//   try {
//     final placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     ).timeout(const Duration(seconds: 5));

//     if (placemarks.isEmpty) {
//       return _formatFallbackCoordinates(position);
//     }

//     final place = placemarks.first;
//     final addressParts = <String>[];
    
//     void addPart(String? value, [String? prefix]) {
//       if (value != null && value.isNotEmpty) {
//         addressParts.add(prefix != null ? '$prefix $value' : value);
//       }
//     }

//     addPart(place.street);
//     addPart(place.subLocality);
//     addPart(place.locality);
//     addPart(place.administrativeArea, "Province");
//     addPart(place.country);
//     addPart(place.postalCode, "Postal Code");

//     return addressParts.isNotEmpty 
//         ? addressParts.join('\n')
//         : _formatFallbackCoordinates(position);

//   } on TimeoutException {
//     debugPrint("Geocoding timed out");
//     return _formatFallbackCoordinates(position);
//   } catch (e) {
//     debugPrint("Geocoding failed: $e");
//     return _formatFallbackCoordinates(position);
//   }
// }

String _formatFallbackCoordinates(LatLng position) {
  return "Location: ${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}";
}

void _printAddress(String address) {
  debugPrint('====== DELIVERY ADDRESS ======');
  debugPrint(address);
  debugPrint('Captured: ${DateTime.now()}');
  debugPrint('=============================');
  
  // For actual printing (requires printing package):
  // Printing.layoutPdf(
  //   onLayout: (format) => _generatePdf(address),
  // );
  
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Address prepared for printing')),
  );
}

  void _addCurrentLocationMarker(Position position) {
    final currentLocationMarker = Marker(
      markerId: const MarkerId('current_location'),
      position: LatLng(position.latitude, position.longitude),
      infoWindow:  InfoWindow(
        title: 'your_location'.tr,
        snippet: '${'you_are_here'.tr}!',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      _markers.add(currentLocationMarker);
    });
  }

Future<String> _getAddressFromLatLng(LatLng position) async {
  setState(() => _isLoadingAddress = true);
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      
      // Hierarchical address suggestion - tries to find the most specific name first
      String address = _getBestLocationName(place);
      
      // If we still don't have a good name, show coordinates
      if (address.isEmpty) {
        return '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      }
      
      // Add district/city if available to provide context
      if (place.locality != null && place.locality!.isNotEmpty && 
          !address.contains(place.locality!)) {
        address += ', ${place.locality}';
      }
      
      return address;
    }
    return '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
  } catch (e) {
    print('Reverse geocoding error: $e');
    return '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
  } finally {
    setState(() => _isLoadingAddress = false);
  }
}

// Helper method to get the best possible location name
String _getBestLocationName(Placemark place) {
  // Try to get the most specific name first
  if (place.name != null && place.name!.isNotEmpty && place.name != 'Unnamed Road') {
    return place.name!;
  }
  
  if (place.street != null && place.street!.isNotEmpty) {
    return place.street!;
  }
  
  if (place.subLocality != null && place.subLocality!.isNotEmpty) {
    return place.subLocality!;
  }
  
  if (place.locality != null && place.locality!.isNotEmpty) {
    return place.locality!;
  }
  
  if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
    return place.subAdministrativeArea!;
  }
  
  if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
    return place.administrativeArea!;
  }
  
  return '';
}

  void _setSourceFromInput() async {
    final source = _sourceController.text;

    // Geocode the entered source address
    final sourceLatLng = await _geocodeAddress(source);
    if (sourceLatLng != null) {
      setState(() {
        _sourceLatLng = sourceLatLng;
        _addMarker(sourceLatLng, 'Source', BitmapDescriptor.hueGreen);
      });
    }
    _drawRoute(); // Redraw the route
  }

  void _setDestinationFromInput() async {
    final destination = widget.destinationController!.text;

    if (destination.isEmpty || destination == 'current_location'.tr) {
      // If the source field is empty or set to "current_location".tr, use the current_location.tr    
      setState(() {
        _sourceLatLng = _initialPosition;
        _addMarker(_initialPosition, 'source'.tr, BitmapDescriptor.hueGreen);
      });
    } else {
      final destinationLatLng = await _geocodeAddress(destination);
      if (destinationLatLng != null) {
        setState(() {
          _destinationLatLng = destinationLatLng;
          _addMarker(destinationLatLng, 'destination'.tr, BitmapDescriptor.hueRed);
        });
        _drawRoute();
      }
    }
  }

  Future<void> _drawRoute() async {
    if (_sourceLatLng == null || _destinationLatLng == null) {
      print('Source or destination coordinates are missing.');
      return;
    }

    // OSRM API endpoint
    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${_sourceLatLng!.longitude},${_sourceLatLng!.latitude};'
      '${_destinationLatLng!.longitude},${_destinationLatLng!.latitude}?overview=full&geometries=geojson',
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (data['code'] == 'Ok') {
      final geometry = data['routes'][0]['geometry']['coordinates'];
      final distance = (data['routes'][0]['distance'] / 1000)
          .toStringAsFixed(2); // Distance in km
      final duration = ((data['routes'][0]['duration'] / 60)+5)
          .toStringAsFixed(2); // Duration in minutes

      setState(() {
        _distance = '$distance km';
        _duration = '$duration mins';
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: geometry
                .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
                .toList(),
            color: Colors.blue,
            width: 5,
          ),
        );
        
      });
    } else {
      print('Failed to fetch route from OSRM.');
    }
  }

  Future<LatLng?> _geocodeAddress(String address) async {
    // Use a geocoding service like Nominatim (OpenStreetMap)
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?format=json&q=$address',
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (data.isNotEmpty) {
      final lat = double.parse(data[0]['lat']);
      final lng = double.parse(data[0]['lon']);
      return LatLng(lat, lng);
    } else {
      print('Geocoding failed for address: $address');
      return null;
    }
  }

  void _addMarker(LatLng position, String title, double hue) {
    final marker = Marker(
      markerId: MarkerId(title),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: '${'coordinates'.tr}: ${position.latitude}, ${position.longitude}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(hue),
    );

    setState(() {
      _markers.add(marker);
    });
  }

  void _captureInformation() {
    final screenWidth = MediaQuery.of(context).size.width;

    if (_sourceLatLng == null || _destinationLatLng == null) {
      print('Source or destination coordinates are missing.');
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('please_enter_where_to'.tr),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } 
    // else if (deliveryOptionsValue == 'choose_delivery_company'.tr) {
    //   setState(() {
    //     _deliveryOptionError = 'please_select_delivery_option'.tr;
    //   });
    //   // Optionally show a snackbar for more visibility
    //   ScaffoldMessenger.of(context).showSnackBar(
    //      SnackBar(
    //       content: Text('please_select_delivery_option'.tr),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // } 
    else if (widget.phoneNumberEditingController!.text == '') {
       if (!_formKey.currentState!.validate()) {
    return; // Don't proceed if validation fails
  }
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('please_enter_receiver_phone_number'.tr),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('confirm'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${'where_to'.tr}: ${widget.destinationController.text}'),
              Text('${'receiver_phone_number'.tr}: ${widget.phoneNumberEditingController!.text}'),
            _distance==''?const SizedBox.shrink():  Text('${'distance'.tr}: $_distance'),
              _duration==''?const SizedBox.shrink():  Text('${'time_remaining'.tr}: $_duration'),
            ],
          ),
          actions: [
            DefaultButton2(
              color1: kamber300Color,
              color2: kyellowColor,
              onPress: () {
                widget.screenId == 1
                    ? Get.to(PaymentMethod(
                        amountTotal: widget.calculatedTotal.toString(),
                        parent: widget.contactModel.name,
                        studentName: widget.studentName,
                        studentCode: widget.studentCode,
                        schoolName: widget.schoolName,
                        className: widget.className,
                        product: widget.eduboxService,
                        material: widget.dataList,
                      ))
                    : showModalBottomSheet(
                        isScrollControlled: true,
                        context: Get.context!,
                        isDismissible: false,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(Dimensions.radiusSizeLarge),
                        )),
                        builder: (context) {
                          //**************** Bottom Sheet with slider */
                          return widget.isShop == 0
                              ? BottomSheetWithSlider(
                                 
                                  homePhone: widget.phoneNumberEditingController.text,
                                        shippingAddress1:'${widget.schoolName}, ${widget.className}, ${widget.studentName}, ${widget.studentCode}',
                                    shippingAddress2: '',
                                    shippingCompany: AppConstants.deliveryCompany,
                                    shippingCity: 'Kigali',
                                    shippingCountry: 'Rwanda',
                                  availableBalance: '0.00',
                                  amount: widget.calculatedTotal.toString(),
                                  productId: widget.productId,
                                  contactModel: widget.contactModel,
                                  pinCode: widget.pinCodeFieldController,
                                  transactionType: widget.transactionType,
                                  purpose: widget.purpose,
                                  studentId: widget.studentId,
                                  inputBalance: widget.calculatedTotal,
                                  dataList: widget.dataList,
                                  productIndex: widget.productIndex,
                                  edubox_service: widget.eduboxService,
                                  amountToPay:
                                      '${'delivery_cost'.tr}: ${widget.deliveryCost.toStringAsFixed(2)}',
                                  nowPaid:
                                      '${'material_cost'.tr}: ${widget.calculatedTotal.toStringAsFixed(2)}',
                                  vat:
                                      '${'vat'.tr} (${widget.vatPercentage.toStringAsFixed(1)}%): ${widget.calculateVAT.toStringAsFixed(2)} ${AppConstants.currency}',
                                  serviceCharge:
                                      '${'convenience_fee'.tr}: ${widget.calculateServiceCharge.toStringAsFixed(2)}',
                                  totalNowPaid:
                                      '${'total_amount_paid_now'.tr}: ${widget.totalAmount} ${AppConstants.currency}',
                                  serviceValue: widget.productName,
                                  serviceIndex: widget.serviceIndex,
                                  randomNumber: widget.randomNumber,
                                  studentName: widget.studentName,
                                  studentCode: widget.studentCode,
                                  className: widget.className,
                                  schoolName: widget.schoolName,
                                )
                              : BottomSheetWithSliderSp(
                                customerNote: widget.descriptionController.text,
                                  deliveryCost: widget.deliveryCost,
                                  materialCost: widget.calculatedTotal.toStringAsFixed(2),
                                    shippingAddress1:widget.destinationController.text,
                                    shippingAddress2: '',
                                    shippingCompany: AppConstants.deliveryCompany,
                                    shippingCity: 'Kigali',
                                    shippingCountry: 'Rwanda',
                                  homePhone: widget.phoneNumberEditingController.text,
                                  studentId: widget.checkedStudentsId??0,
                                  randomNumber: widget.randomNumber,
                                  selectedProducts: widget.cart!,
                                  quantity: widget.quantity!,
                                  studentIndex: widget.studentIndex!,
                                  availableBalance: '0.00',
                                  amount: widget.totalAmount.toStringAsFixed(2),
                                  productId: 1,
                                  contactModel: widget.contactModel,
                                  pinCode: widget.pinCodeFieldController,
                                  transactionType: widget.transactionType,
                                  purpose: widget.transactionType,
                                  studentInfo: widget.checkedStudents,
                                  inputBalance: widget.totalAmount,
                                  product: widget.product!,
                                  productIndex: widget.productIndex,
                                  edubox_service: 'shop'.tr,
                                  amountToPay:
                                      '${'delivery_cost'.tr}: ${widget.deliveryCost.toStringAsFixed(2)}',
                                  nowPaid:
                                      '${'material_cost'.tr}: ${widget.calculatedTotal.toStringAsFixed(2)}',
                                  vat:
                                      '${'vat'.tr} (${widget.vatPercentage.toStringAsFixed(1)}%): ${widget.calculateVAT.toStringAsFixed(2)} ${AppConstants.currency}',
                                  serviceCharge: widget.calculateServiceCharge
                                      .toStringAsFixed(2),
                                  totalNowPaid:
                                      '${'total_amount_paid_now'.tr}: ${widget.totalAmount}${AppConstants.currency}',
                                  serviceValue: widget.product!.name,
                                );
                        });
              },
              // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

              title: 'next'.tr,
              iconData: Icons.arrow_forward_outlined,
            ),
          ],
        );
      },
    );
  }
}
