import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hosomobile/features/home/controllers/menu_controller.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';

class BottomItemWidget extends StatelessWidget {
  final String icon;
  final String name;
  final int? selectIndex;
  final VoidCallback? onTop;
  const BottomItemWidget({super.key, required this.icon, required this.name, this.selectIndex, this.onTop});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTop, child: GetBuilder<MenuItemController>(
        builder: (menuItemController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              height: 20,
              width: Dimensions.fontSizeExtraLarge,
              child: Image.asset(
                icon, fit: BoxFit.contain,
                color: menuItemController.currentTabIndex == selectIndex
                    ? Theme.of(context).textTheme.titleLarge?.color : ColorResources.nevDefaultColor,
              ),
            ),
            const SizedBox(height: 6.0),

            Text(name, style: TextStyle(
              color: menuItemController.currentTabIndex == selectIndex
                  ? Theme.of(context).textTheme.titleLarge?.color : ColorResources.nevDefaultColor,
              fontSize: Dimensions.fontSizeSmall, fontWeight: FontWeight.w400,
            ))

          ]);
        }
    ));
  }
}
