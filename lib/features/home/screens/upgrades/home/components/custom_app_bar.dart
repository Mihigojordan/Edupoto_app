
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static String routeName = 'CustomAppBar';
  final List<String> itemLists;
  final Function(String?)? onChanged;
  final String title;
  final Color color;

  const CustomAppBar(
      {super.key, required this.onChanged,
      required this.itemLists,
      required this.title,
      required this.color});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: color,
        title: Text(
          title,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: kTextWhiteColor,
                ),
                items: itemLists.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: ktextBlack,
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                // (newValue) {
                //   dropdownvalue = newValue!;
                //   if (dropdownvalue == 'Register') {
                //     Navigator.pushNamed(context, NoDataFound.routeName);
                //   } else if (dropdownvalue == 'Teacher Jobs') {
                //     Navigator.pushNamed(context, NoConnection.routeName);
                //   }
                // },
              ),
            ),
          ),
        ]);
  }
}
