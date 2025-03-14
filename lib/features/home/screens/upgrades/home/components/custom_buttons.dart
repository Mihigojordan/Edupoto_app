
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:sizer/sizer.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final IconData iconData;

  const DefaultButton(
      {super.key,
      required this.onPress,
      required this.title,
      required this.iconData});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.only(right: kDefaultPadding),
        width: MediaQuery.of(context).size.width/2,
        height:  MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kSecondaryColor, kPrimaryColor],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(kDefaultPadding)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            Icon(
              iconData,
              size: 26.sp,
              color: kOtherColor,
            )
          ],
        ),
      ),
    );
  }
}

class DefaultButton2 extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final IconData iconData;
  final Color color1;
  final Color color2;

  const DefaultButton2(
      {super.key,
      required this.onPress,
      required this.title,
      required this.iconData,
      required this.color1,
      required this.color2});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.only(right: kDefaultPadding),
        width: MediaQuery.of(context).size.width,
        height:  50,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(kDefaultPadding)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 12, color: kTextBlackColor,fontWeight:FontWeight.w700)),
            const Spacer(),
            Icon(
              iconData,
              size: 26,
              color: kTextBlackColor,
            )
          ],
        ),
      ),
    );
  }
}
class DefaultButtonWidth extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final Color color1;
  final Color color2;
  final double width;

  const DefaultButtonWidth(
      {super.key,
      required this.onPress,
      required this.title,
      required this.color1,
      required this.color2,
       required this.width
       });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        // padding: EdgeInsets.only(right: kDefaultPadding),
        width: width,
        height:  MediaQuery.of(context).size.width/9,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(kDefaultPadding)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Text(title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 12, color: kTextBlackColor,fontWeight:FontWeight.w700)),
         
          ],
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  const BorderButton(
      {super.key,
      required this.onPress,
      required this.icon,
      required this.title,
      required this.clas,
      required this.height,
      required this.width,
      required this.horizontal,
      required this.vertical});
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String clas;
  final double height;
  final double width;
  final double vertical;
  final double horizontal;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: const Color(0x0fffffff), //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: IconImages(icon),
        ),
      ),
    );
  }
}

class BorderButtonR extends StatelessWidget {
  const BorderButtonR(
      {super.key,
      required this.onPress,
      required this.radius,
      required this.title,
      required this.clas,
      required this.height,
      required this.width,
      required this.horizontal,
      required this.vertical});
  final VoidCallback onPress;
  final double radius;
  final String title;
  final String clas;
  final double height;
  final double width;
  final double vertical;
  final double horizontal;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: kTextBlackColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        height:  height,
        width: width,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child:Center(child: Text(title,style: Theme.of(context).textTheme.bodyMedium))
        ),
      ),
    );
  }
}

class BorderButton1 extends StatelessWidget {

  const BorderButton1({
    super.key,
    required this.onPress,
    required this.icon,
    required this.title,
    required this.clas,
    required this.height,
    required this.width,
    required this.horizontal,
    required this.vertical,
    required this.textColor,
    required this.borderColor,
  });
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String clas;
  final double height;
  final double width;
  final double vertical;
  final double horizontal;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
   final screenHeight=MediaQuery.of(context).size.height;
   final screenWidth=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: borderColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius:screenHeight>=680? const BorderRadius.all(Radius.circular(10)):const BorderRadius.all(Radius.circular(7))),
      
        width: width,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height:screenHeight>=680? 22:14,
                width: screenHeight>=680?22:14,
                child: IconImages(title)),
              sizedBox5,
              Text(icon,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: screenHeight>=680?12:10, color: textColor,fontWeight:screenHeight>=680? FontWeight.bold:FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center
                      ),
            ],
          ),
        ),
      ),
    );
  }
}

class PartinerServices extends StatelessWidget {
  const PartinerServices({
    super.key,
    required this.onPress,
    required this.icon,
    required this.title,
    required this.clas,
    required this.height,
    required this.width,
    required this.horizontal,
    required this.vertical,
    required this.textColor,
    required this.borderColor,
  });
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String clas;
  final double height;
  final double width;
  final double vertical;
  final double horizontal;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
              color: Colors.amber[600],
            border: Border.all(
              color: borderColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
      
        width: width,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 22,
                width: 22,
                child: IconImages(title)),
              sizedBox5,
Flexible(
  child: Text(
    icon,
    style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: screenHeight >= 700 ? 12 : 10,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
    overflow: TextOverflow.ellipsis,
    maxLines: 1, // Ensure it fits within one line
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}


class BorderButton2 extends StatelessWidget {
  const BorderButton2({
    super.key,
    required this.onPress,
    required this.icon,
    required this.title,
    required this.clas,
    required this.height,
    required this.width,
    required this.horizontal,
    required this.vertical,
    required this.textColor,
    required this.borderColor,
  });
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String clas;
  final double height;
  final double width;
  final double vertical;
  final double horizontal;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: borderColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25, width: 25, child: IconImages(icon)),
              const SizedBox(width: 10),
              Text(title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      color: textColor,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderButton3 extends StatelessWidget {
  const BorderButton3({
    super.key,
    required this.onPress,
    required this.icon,
    required this.title,
    required this.clas,
    required this.height,
    required this.width,
    required this.horizontal,
    required this.vertical,
    required this.textColor,
    required this.borderColor,
  });
  final VoidCallback onPress;
  final IconData icon;
  final String title;
  final String clas;
  final double height;
  final double width;
  final double vertical;
  final double horizontal;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: borderColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 25,
                  width: 25,
                  child: Icon(
                    icon,
                    color: kyellow800Color,
                  )),
              const SizedBox(width: 10),
              Flexible(
                child: Text(title,
                    overflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderButtonIco extends StatelessWidget {
  const BorderButtonIco({
    super.key,
    required this.onPress,
    required this.title,
    required this.clas,
    required this.height,
    required this.width,
    required this.horizontal,
    required this.vertical,
    required this.textColor,
    required this.borderColor,
  });
  final VoidCallback onPress;
  final String title;
  final String clas;
  final double height;
  final double width;
  final double vertical;
  final double horizontal;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
      
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: borderColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        child: Padding(
          padding:
              const EdgeInsets.only(left:10),
          child: SizedBox(height:vertical,width:horizontal,child: IconImages(title)),
        ),
      ),
    );
  }
}
