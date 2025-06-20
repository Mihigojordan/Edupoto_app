import 'package:flutter/material.dart';
import 'package:hosomobile/features/shop/widget/company.dart';

class CompanyNavigationBar extends StatelessWidget {
  final List<Company> companies;
  final int selectedIndex;
  final Function(int) onTap;

  const CompanyNavigationBar({
    super.key,
    required this.companies,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
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
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedIndex == index ? Colors.amber : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    company.logo,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                      color: selectedIndex == index ? Colors.amber : Colors.grey,
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