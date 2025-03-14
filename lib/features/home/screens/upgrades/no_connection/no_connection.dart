import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/util/images.dart';


late bool _passwordVisible;

class NoConnection extends StatefulWidget {
  static String routeName = 'NoConnection';

  const NoConnection({super.key});

  @override
  _NoConnectionState createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  //changes current state

  @override
  Widget build(BuildContext context) {
  // Images('assets/icons1/Coming Soon.png');
    return const Scaffold(
      
      body:Center(child:HomeCard())
    ) ;
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  // const HomeCard({
  //   Key? key,
  //   required this.icon,
  //   required this.title,
  // }) : super(key: key);

  // final String icon;
  // final String title;

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: 87,
        width: 95,
        child: IconImages(Images.logo),
      ),
      sizedBox10,
      Text(
        'This service is not available for you right now !',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      sizedBox5,
         Text(
        'It will be available later',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    ]);
  }
}
