import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/story_lists.dart';

class UploadStory extends StatefulWidget {
  static const String routeName = 'UploadStory';

  const UploadStory({super.key});

  @override
  _UploadStoryState createState() => _UploadStoryState();
}

class _UploadStoryState extends State<UploadStory> {
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;
  bool isLoading = false;

  FilePickerResult? result, result1, result2;
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController authurEditingController = TextEditingController();
  final TextEditingController writeStoryEditingController = TextEditingController();

  String getUserID = "", getUserName = "";
  String changeItem = 'Sections';
  String changeLevel = 'Level';

  final snackBar = const SnackBar(content: Text('Your story submitted for review'));

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    saveUser();
  }

  saveUser() {
    // Handle saving user functionality here
  }

  Future<void> signIn() async {
    saveUser();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      clearFields();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const StoryLists()));
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void clearFields() {
    titleEditingController.clear();
    authurEditingController.clear();
    writeStoryEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: kOtherColor,
        appBar: AppBar(
          backgroundColor: kyellow800Color,
          title: const Text('Upload your story'),
        ),
        body: Container(
          color: kyellow800Color,
          child: SingleChildScrollView(
            child: Container(
              
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox,
                    titleField(),
                    sizedBox10,
                    buildDropdowns(),
                        sizedBox10,
                            DropDown(
            isExpanded: false,
            title: changeLevel,
            onChanged: (change) {
              setState(() {
                changeLevel = change!;
              });
            },
            itemLists: const [
              {'name':'Jr/Primary','none':''},
              {'name':'Sr/Secondary','none':''},
             {'name':'Tr/Teacher','none':''}
            ],
                    ),
                    sizedBox5,
                    authurField(),
                    sizedBox5,
                    writeStoryField(),
                    sizedBox,
                   buildFilePickerList(result),
                    HomeCard(
                      onPress: () => pickFiles(FileType.custom, ['jpg', 'png', 'web']),
                      icon: Icons.photo,
                      title: 'Upload Photo',
                    ),
                    sizedBox05h,
                    buildFilePickerList(result1),
                    HomeCard(
                      onPress: () => pickFiles(FileType.custom, ['doc', 'pdf']),
                      icon: Icons.document_scanner,
                      title: 'Upload document',
                    ),
                    sizedBox05h,
                    buildFilePickerList(result2),
                    HomeCard(
                      onPress: () => pickFiles(FileType.custom, ['mp3']),
                      icon: Icons.audiotrack,
                      title: 'Upload audio',
                    ),
                    sizedBox,
                    DefaultButton2(
                      color1: kyellow800Color,
                      color2: kamber300Color,
                      onPress: signIn,
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

 buildDropdowns() {
    return DropDown(
      isExpanded: false,
      title: changeItem,
      onChanged: (change) {
        setState(() {
          changeItem = change!;
        });
      },
      itemLists: const [
    {'name': 'Good Citizenry', 'none': ''},
    {'name': 'Personal Hygiene', 'none': ''},
    {'name': 'Reproductive Health', 'none': ''},
    {'name': 'Career Guidance', 'none': ''},
    {'name': 'Environmental Education', 'none': ''},
    {'name': 'Digital Literacy', 'none': ''},
    {'name': 'Financial Literacy', 'none': ''},
    {'name': 'My School', 'none': ''},
    {'name': 'National History', 'none': ''}
]
,
    );
  }

  Widget buildFilePickerList(FilePickerResult? result) {
    return ListView.builder(
       shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: result?.files.length ?? 0,
      itemBuilder: (context, index) {
        return Text(
          result?.files[index].name ?? '',
          style:const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        );
      },
    );
  }

  Future<void> pickFiles(FileType fileType, List<String> extensions) async {
    final pickedResult = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: fileType,
      allowedExtensions: extensions,
    );
    if (pickedResult == null) {
      print("No file selected");
    } else {
      setState(() {
        if (fileType == FileType.custom && extensions.contains('jpg')) {
          result = pickedResult;
        } else if (fileType == FileType.custom && extensions.contains('doc')) {
          result1 = pickedResult;
        } else if (fileType == FileType.custom && extensions.contains('mp3')) {
          result2 = pickedResult;
        }
      });
    }
  }

  TextFormField titleField() {
    return TextFormField(
      controller: titleEditingController,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'Title',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  TextFormField authurField() {
    return TextFormField(
      controller: authurEditingController,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'Author',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some value';
        }
        return null;
      },
    );
  }

  TextFormField writeStoryField() {
    return TextFormField(
      controller: writeStoryEditingController,
      keyboardType: TextInputType.multiline,
      style: kInputTextStyle,
      autofocus: false,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Write story',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.onPress,
    required this.icon,
    required this.title,
  });
  final VoidCallback onPress;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: kTextLightColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: MediaQuery.of(context).size.height / 15,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(icon),
            Text(
              title,
              style:const TextStyle(color: Colors.black),
            ),
          ]),
        ),
      ),
    );
  }
}
