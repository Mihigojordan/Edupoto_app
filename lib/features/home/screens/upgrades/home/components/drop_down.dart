
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/class_model.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';




class DropDown extends StatelessWidget {
  static String routeName = 'DropDown';
  final List<Map<dynamic, String>> itemLists; // Change the type to specify String type
  final Function(String?)? onChanged;
  final String title;
  final bool isExpanded;

  const DropDown({
    super.key,
    required this.onChanged,
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<dynamic, String>>(
            compareFn: (Map<dynamic, String>? item1,Map<dynamic, String>? item2) {
        if(item1 == null||item2 == null) {
          return false;
        }
         return item1 == item2;

      },
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      items: (filter, infiniteScrollProps) =>itemLists,
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          // labelStyle: TextStyle(color: Colors.grey),
          // hintText: "Make selection",
          // hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      onChanged: (Map<dynamic, String>? selectedItem) {
        if (selectedItem != null) {
          // You can access both product and price here if needed
          onChanged?.call(selectedItem['product']); // or you can handle both product and price as needed
        }
      },
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem != null) {
          return Text(
            '${selectedItem['product']} - ${selectedItem['price']}RWF',
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          title,
          style: const TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        );
      },
      itemAsString: (item) => '${item['product']} - ${item['price']}RWF', // Display product and price in the dropdown list
    );
  }
}

class DropDownStudentInfo extends StatelessWidget {
  static String routeName = 'DropDown';
  final List<Map<dynamic, String>> itemLists;
  final Function(String?)? onChanged;
  final String title;
  final double width; // Width of the dropdown field
  final double menuWidth; // Width of the dropdown popup menu

  const DropDownStudentInfo({
    super.key,
    required this.onChanged,
    required this.itemLists,
    required this.title,
    required this.width, // Default width for dropdown field
    required this.menuWidth, // Default width for dropdown menu
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     
        SizedBox(
          width: width, // Set dropdown field width
          child: DropdownSearch<Map<dynamic, String>>(
            compareFn: (item1, item2) => item1 == item2,
            popupProps: PopupProps.menu(
              showSearchBox: true,
              constraints: BoxConstraints(
                maxWidth: menuWidth, // Set width of dropdown menu
              ),
            ),
            items:(filter, infiniteScrollProps) => itemLists,
            decoratorProps:const DropDownDecoratorProps(
          
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),
            onChanged: (selectedItem) {
              if (selectedItem != null) {
                onChanged?.call(selectedItem['name']);
              }
            },
            dropdownBuilder: (context, selectedItem) {
              return Text(
                selectedItem != null ? selectedItem['name'] ?? '' : title,
                style:const TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              );
            },
            itemAsString: (item) => '${item['name']}',
          ),
        ),
      ],
    );
  }
}


class DropDownEdubox extends StatelessWidget {
  static String routeName = 'DropDown';
  final List<ProductTypeModel> itemLists; // Change the type to specify String type
  final Function(String?)? onChanged;
  final String title;

  final bool isExpanded;

  const DropDownEdubox({
    super.key,
    required this.onChanged,
 
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<ProductTypeModel>(
      compareFn: (ProductTypeModel? item1,ProductTypeModel? item2) {
        if(item1 == null||item2 == null) {
          return false;
        }
         return item1 == item2;

      },
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      items: (filter, infiniteScrollProps) =>itemLists,
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          // labelStyle: TextStyle(color: Colors.grey),
          // hintText: "Make selection",
          // hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      onChanged: (ProductTypeModel? selectedItem) {
        if (selectedItem != null) {
          // You can access both product and price here if needed
          onChanged?.call(selectedItem.name); // or you can handle both product and price as needed
        }
      },
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem != null) {
          return Text(
            '${selectedItem.name}${selectedItem.price==null?'': '- ${selectedItem.price}RWF'}',
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          title,
          style: const TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        );
      },
      itemAsString: (item) => '${item.name}${item.price==null?'': '- ${item.price}RWF'}', // Display product and price in the dropdown list
    );
  }
}

class DropDownEduboxMaterial extends StatelessWidget {
  static String routeName = 'DropDown';
  final List<EduboxMaterialModel> itemLists; // Change the type to specify String type
  final Function(String?)? onChanged;
  final String title;

  final bool isExpanded;

  const DropDownEduboxMaterial({
    super.key,
    required this.onChanged,
 
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<EduboxMaterialModel>(
         compareFn: (EduboxMaterialModel? item1,EduboxMaterialModel? item2) {
        if(item1 == null||item2 == null) {
          return false;
        }
         return item1 == item2;

      },
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
  
      items: (filter, infiniteScrollProps) =>itemLists,
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          // labelStyle: TextStyle(color: Colors.grey),
          // hintText: "Make selection",
          // hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      onChanged: (EduboxMaterialModel? selectedItem) {
        if (selectedItem != null) {
          // You can access both product and price here if needed
          onChanged?.call(selectedItem.name); // or you can handle both product and price as needed
        }
      },
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem != null) {
          return Text(
            '${selectedItem.name}${selectedItem.price==null?'': '- ${selectedItem.price}RWF'}',
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          title,
          style: const TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        );
      },
      itemAsString: (item) => '${item.name}${item.price==null?'': '- ${item.price}RWF'}', // Display product and price in the dropdown list
    );
  }
}

class DropDownPayment extends StatelessWidget {
  static String routeName = 'DropDown';
  final List<Map<dynamic, String>> itemLists; // Change the type to specify String type
  final Function(String?)? onChanged;
  final String title;
  final bool isExpanded;

  const DropDownPayment({
    super.key,
    required this.onChanged,
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<dynamic, String>>(
         compareFn: (Map<dynamic, String>? item1,Map<dynamic, String>? item2) {
        if(item1 == null||item2 == null) {
          return false;
        }
         return item1 == item2;

      },
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      items: (filter, infiniteScrollProps) =>itemLists,
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          // labelStyle: TextStyle(color: Colors.grey),
          // hintText: "Make selection",
          // hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      onChanged: (Map<dynamic, String>? selectedItem) {
        if (selectedItem != null) {
          // You can access both product and price here if needed
          onChanged?.call(selectedItem['no']); // or you can handle both product and price as needed
        }
      },
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem != null) {
          return Text(
            '${selectedItem['no']})  ${selectedItem['name']}',
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          title,
          style: const TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        );
      },
      itemAsString: (item) => '${item['no']}) ${item['name']}', // Display product and price in the dropdown list
    );
  }
}



class DropDownSchool extends StatelessWidget {
  static String routeName = 'DropDown';
  final List<Map<dynamic, String>> itemLists; // Change the type to specify String type
  final Function(String?)? onChanged;
  final String title;
  final bool isExpanded;

  const DropDownSchool({
    super.key,
    required this.onChanged,
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<dynamic, String>>(
           compareFn: (Map<dynamic, String>? item1,Map<dynamic, String>? item2) {
        if(item1 == null||item2 == null) {
          return false;
        }
         return item1 == item2;

      },
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      items: (filter, infiniteScrollProps) =>itemLists,
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          // labelStyle: TextStyle(color: Colors.grey),
          // hintText: "Make selection",
          // hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      onChanged: (Map<dynamic, String>? selectedItem) {
        if (selectedItem != null) {
          // You can access both product and price here if needed
          onChanged?.call(selectedItem['code']); // or you can handle both product and price as needed
        }
      },
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem != null) {
          return Text(
            '${selectedItem['code']} - ${selectedItem['name']}',
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          title,
          style: const TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        );
      },
      itemAsString: (item) => '${item['code']} - ${item['name']}', // Display product and price in the dropdown list
    );
  }
}


// Define your text styles and colors here
const Color kTextBlackColor = Colors.black; // Replace with your actual color
const TextStyle ktextBlack = TextStyle(color: kTextBlackColor); // Adjust as needed


class DropDownAccount extends StatelessWidget {
  static const String routeName = 'DropDown';
  final List<StudentModel> itemLists;
  final Function(String?)? onChanged;
  final String title;
  final bool isExpanded;

  const DropDownAccount({
    super.key,
    required this.onChanged,
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    return DropdownSearch<String>(
           compareFn: (String? item1,String? item2) {
        if(item1 == null||item2 == null) {
          return false;
        }
         return item1 == item2;

      },
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      items: (filter, infiniteScrollProps) =>itemLists
          .map((item) => 'Code: ${item.code}\nName: ${item.name}')
          .toList(),
      decoratorProps:  DropDownDecoratorProps(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.grey),
            borderRadius:screenHeight>=700? const BorderRadius.all(Radius.circular(15.0)):const BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.amber),
            borderRadius:screenHeight>=700? const BorderRadius.all(Radius.circular(15.0)):const BorderRadius.all(Radius.circular(12.0)),
          ),
          contentPadding:screenHeight>=700?const  EdgeInsets.symmetric(horizontal: 15):const EdgeInsets.symmetric(horizontal: 12),
          helperStyle: const TextStyle(color: Colors.grey,fontSize: 9),
          // hintText: "Make selection",
          // hintStyle: TextStyle(color: Colors.grey),
        ),
        
      ),
      onChanged: (selectedItem) {
        if (selectedItem != null) {
          // Extract the code from the selected item
          final selectedCode = selectedItem.split('\n')[0].replaceFirst('Code: ', '');
          
          // Find the index of the selected code
          final selectedIndex = itemLists.indexWhere((item) => item.code == selectedCode);

          // Call the onChanged function with the selected code
          onChanged?.call(selectedCode);

        }
      },
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? title,
          style:  TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: screenHeight>=700?12:10
          ),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}



class DropDownClass extends StatelessWidget {
  static const String routeName = 'DropDown';
  final List<ClassModel> itemLists;
  final Function(String?)? onChanged;
  final String title;
  final bool isExpanded;

  const DropDownClass({
    super.key,
    required this.onChanged,
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    return DropdownSearch<String>(
           compareFn: (String? item1,String? item2) {
        if(item1 == null||item2 == null) {
          return false;
        }
         return item1 == item2;

      },
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      items: (filter, infiniteScrollProps) =>itemLists
          .map((item) => '${item.name}')
          .toList(),
      decoratorProps:  DropDownDecoratorProps(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.grey),
            borderRadius:screenHeight>=700? const BorderRadius.all(Radius.circular(15.0)):const BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.amber),
            borderRadius:screenHeight>=700? const BorderRadius.all(Radius.circular(15.0)):const BorderRadius.all(Radius.circular(12.0)),
          ),
          contentPadding:screenHeight>=700?const  EdgeInsets.symmetric(horizontal: 15):const EdgeInsets.symmetric(horizontal: 12),
          helperStyle: const TextStyle(color: Colors.grey,fontSize: 9),
          // hintText: "Make selection",
          // hintStyle: TextStyle(color: Colors.grey),
        ),
        
      ),
      onChanged: (selectedItem) {
        if (selectedItem != null) {
          // Extract the code from the selected item
          final selectedCode = selectedItem.split('\n')[0].replaceFirst('Code: ', '');
          
          // Find the index of the selected code
          final selectedIndex = itemLists.indexWhere((item) => item.code == selectedCode);

          // Call the onChanged function with the selected code
          onChanged?.call(selectedCode);

        }
      },
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? title,
          style:  TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: screenHeight>=700?12:10
          ),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}


class DropDown1 extends StatelessWidget {
  static const String routeName = 'DropDown';
  final List<String> itemLists;
  final Function(String?)? onChanged;
  final String title; // Added type for title
  final bool isExpanded;

  const DropDown1({
    super.key,
    required this.onChanged,
    required this.itemLists,
    required this.title,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: isExpanded,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kTextBlackColor,
        ),
        hint: Text(
          title,
          style: ktextBlack,
          overflow: TextOverflow.ellipsis,
        ),
        items: itemLists.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item,
                style: ktextBlack,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
