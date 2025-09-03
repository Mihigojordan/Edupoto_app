import 'package:flutter/material.dart';
import 'package:google_maps_places_autocomplete_widgets/model/suggestion.dart';
import 'package:google_maps_places_autocomplete_widgets/widgets/address_autocomplete_textformfield.dart';
import 'package:hosomobile/util/app_constants.dart';

class AddressAutocompleteTextFormFieldExampleState
    extends State {
  final _formKey = GlobalKey<FormState>();
  late FocusNode addressFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode stateFocusNode;
  late FocusNode zipFocusNode;

  late TextEditingController addressTextController;
  late TextEditingController cityTextController;
  late TextEditingController stateTextController;
  late TextEditingController zipTextController;

  @override
  void initState() {
    debugPrint('_LocationInformationPageState() init()');

    super.initState();

    addressFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    zipFocusNode = FocusNode();

    addressTextController = TextEditingController();
    cityTextController = TextEditingController();
    stateTextController = TextEditingController();
    zipTextController = TextEditingController();
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    zipFocusNode.dispose();

    addressTextController.dispose();
    cityTextController.dispose();
    stateTextController.dispose();
    zipTextController.dispose();

    super.dispose();
  }

  // This callback returns what we want to be put into the text control
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

  /// This method really does not seem to help...
  /// But i left the ability in because it might help more in
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

  // write a function to receive the place details callback
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const LeftAlignedLabelRow('Address'),
                AddressAutocompleteTextFormField(
                  // following args specific to AddressAutocompleteTextFormField()
                  mapsApiKey: AppConstants.googlePlacesApiKey,
                  debounceTime: 200,
                  //In practice this does not seem to help United States address//prepareQuery: prepareQuery,
                  onClearClick: onClearClick,
                  onSuggestionClickGetTextToUseForControl:
                      onSuggestionClickGetTextToUseForControl,
                  onInitialSuggestionClick: onInitialSuggestionClick,
                  onSuggestionClick: onSuggestionClick,
                  onFinishedEditingWithNoSuggestion: (text) {
                    // you should invalidate the last entry of onSuggestionClick if you really need a valid location,
                    // otherwise decide what to do based on what the user typed, can be an empty string
                    debugPrint(
                        'onFinishedEditingWithNoSuggestion()  text typed: $text');
                  },
                  hoverColor: Colors.purple, // for desktop platforms with mouse
                  selectionColor:
                      Colors.purpleAccent, // for desktop platforms with mouse
                  buildItem: (Suggestion suggestion, int index) {
                    return Container(
                        margin: const EdgeInsets.fromLTRB(2, 2, 2,
                            2), //<<This area will get hoverColor/selectionColor on desktop
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: Text(suggestion.description,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)));
                  },
                  clearButton: const Icon(Icons.close),
                  componentCountry: 'us',
                  language: 'en-Us',

                  // 'normal' TextFormField arguments:
                  autofocus: true,
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    debugPrint('onEditingComplete() for TextFormField');
                  },
                  onChanged: (newText) {
                    debugPrint('onChanged() for TextFormField got "$newText"');
                  },
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  decoration: getInputDecoration(
                      'Start typing address for Autocomplete..'),
                ),
                const LeftAlignedLabelRow('City'),
                TextFormField(
                  controller: cityTextController,
                  focusNode: cityFocusNode,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  decoration: getInputDecoration('New York'),
                  validator: (value) {
                    // validation logic
                    return null;
                  },
                ),
                const LeftAlignedLabelRow('State'),
                TextFormField(
                  controller: stateTextController,
                  focusNode: stateFocusNode,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  decoration: getInputDecoration('NY'),
                  validator: (value) {
                    // validation logic
                    return null;
                  },
                ),
                const LeftAlignedLabelRow('Zip'),
                TextFormField(
                  controller: zipTextController,
                  focusNode: zipFocusNode,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  decoration: getInputDecoration('10001'),
                  validator: (value) {
                    // validation logic
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeftAlignedLabelRow extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  const LeftAlignedLabelRow(this.label,
      {this.fontSize = 16.0, this.fontWeight = FontWeight.normal, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ],
    );
  }
}