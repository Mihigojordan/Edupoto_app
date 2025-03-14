
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/story_pannel.dart';

late bool _passwordVisible;

class ChallengeRegister extends StatefulWidget {
  static String routeName = 'ChallengeRegister';

  const ChallengeRegister({super.key});

  @override
  _ChallengeRegisterState createState() => _ChallengeRegisterState();
}

class _ChallengeRegisterState extends State<ChallengeRegister> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  String getUserID = "", getUserName = "";

  saveUser() {
    // HelperFunctions.saveUserIDSharedPreference("parent");
    // HelperFunctions.saveUserNameSharedPreference("teacher");
  }

  @override
  void initState() {
    // TODO: implement initState
    saveUser();
    super.initState();
    _passwordVisible = true;
  }

  FilePickerResult? result;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController schoolEditingController = TextEditingController();
  TextEditingController classEditingController = TextEditingController();
  TextEditingController ageEditingController = TextEditingController();
  TextEditingController contactEditingController = TextEditingController();

  bool isLoading = false;

  signIn() async {
    saveUser();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      print(getUserID);

      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4'],
      );
      if (result == null) {
        print("No file selected");
      } else {
        setState(() {});
        result?.files.forEach((element) {
          print(element.name);
        });
      }
      // await HelperFunctions.getUserIDSharedPreference().then((value) {
      //   setState(() {
      //     getUserID = value!;
      //   });
      // });
      // await HelperFunctions.getUserNameSharedPreference().then((value) {
      //   setState(() {
      //     getUserName = value!;
      //   });
      // });

      // if (getUserID != passwordEditingController.text) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, ParentScreen.routeName, (route) => false);
      // } else if (getUserName != passwordEditingController.text) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, TeacherScreen.routeName, (route) => false);
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text("Already a user sign in"),
      //   ));
      //}
    } else {
      setState(() {
        isLoading = false;
        //show snackbar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //when user taps anywhere on the screen, keyboard hides
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: kOtherColor,
        appBar: AppBar(
          backgroundColor: kyellow800Color,
          title: const Text('Upload your challenge'),
          actions: const [],
        ),
        body: Container(
          color: kyellow800Color,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: const BoxDecoration(
              color: kOtherColor,
              //reusable radius,
              borderRadius: kTopBorderRadius,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sizedBox,
                    nameField(),
                    sizedBox5,
                    schoolField(),
                    sizedBox5,
                    classField(),
                    sizedBox5,
                    ageField(),
                    sizedBox5,
                    contactField(),
                    sizedBox,
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: result?.files.length ?? 0,
                        itemBuilder: (context, index) {
                          return Text(result?.files[index].name ?? '',
                              style:  TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kTextBlackColor));
                        }),
                    DefaultButton2(
                      color1: kyellow800Color,
                      color2: kamber300Color,
                      onPress: () {
                        signIn();
                      },
                      title: 'Upload your challenge video',
                      iconData: Icons.arrow_forward_outlined,
                    ),
                    sizedBox,
                    DefaultButton2(
                      color1: kyellow800Color,
                      color2: kamber300Color,
                      onPress: () =>
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const StoryPannel())),
                      title: 'SUBMIT',
                      iconData: Icons.arrow_forward_outlined,
                    ),
                    sizedBox
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNav(color: kamber300Color),
      ),
    );
  }

  TextFormField nameField() {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'My Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        }
        return null;
      },
    );
  }

  TextFormField schoolField() {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: schoolEditingController,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'My school',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation

        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        }
        return null;
      },
    );
  }

  TextFormField classField() {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: classEditingController,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'My class',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        // RegExp regExp = new RegExp(mobilePattern);

        if (value == null || value.isEmpty) {
          return 'Please enter some value';
          //if it does not matches the pattern, like
          //it not contains @
        }
        return null;
      },
    );
  }

  TextFormField ageField() {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: ageEditingController,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'My age',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field Must be filled';
        }
        return null;
      },
    );
  }

  TextFormField contactField() {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: contactEditingController,
      keyboardType: TextInputType.phone,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'Contact mobile number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field Must be filled';
        }
        return null;
      },
    );
  }
}
