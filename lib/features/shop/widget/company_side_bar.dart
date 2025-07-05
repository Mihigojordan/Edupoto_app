import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/shop/domain/models/category_model.dart';
import 'package:hosomobile/features/shop/domain/models/company_category.dart';
import 'package:hosomobile/util/images.dart';

class CompanySideBar extends StatelessWidget {
  final List<WooCategory> categoryList;
  final int selectedIndex;
  final Function(int) onTap;

  const CompanySideBar({
    super.key,
    required this.categoryList,
    required this.selectedIndex,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    // Add validation
    if (categoryList.isEmpty) {
      return Container(width: 60, child: Center(child: Text('no_categories'.tr)));
    }

    // Ensure selectedIndex is valid
    final safeSelectedIndex = selectedIndex.clamp(0, categoryList.length - 1);

    return Container(
     width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 0),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          // Add index validation
          if (index >= categoryList.length) return const SizedBox.shrink();
          
          final category = categoryList[index];
           return InkWell(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.amber.withOpacity(0.1) : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: selectedIndex == index ? Colors.amber : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomImageWidget(
                    image: category.image ?? 'no image',
                    fit: BoxFit.cover,
                    placeholder: Images.bannerPlaceHolder),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                        color: selectedIndex == index ? Colors.amber : Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}