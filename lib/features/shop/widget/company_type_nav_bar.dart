import 'package:flutter/material.dart';
import 'package:hosomobile/features/shop/domain/models/attribute_model.dart';
import 'package:hosomobile/features/shop/domain/models/company.dart';
import 'package:hosomobile/features/shop/domain/models/company_type.dart';

class CompanyTypeNavigationBar extends StatelessWidget {
  final List<AttributeModel> companyTypes;
  final int selectedIndex;
  final Function(int) onTap;

  const CompanyTypeNavigationBar({
    super.key,
    required this.companyTypes,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: companyTypes.length,
        itemBuilder: (context, index) {
          final company = companyTypes[index];
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedIndex == index ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    company.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.bold,
                      color: selectedIndex == index ? Colors.blue : Colors.black,
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