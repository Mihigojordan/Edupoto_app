import 'package:flutter/material.dart';
import 'package:hosomobile/features/student/widgets/student_uniform_info.dart';

class StudentProfileWidget extends StatelessWidget {
  final String name;
  final String code;
  final String? province;
  final String? school;
  final String? className;
  final VoidCallback? onEditPressed;

  const StudentProfileWidget({
    super.key,
    required this.name,
    required this.code,
    this.province,
    this.school,
    this.className,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height/1.3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with edit button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Student Profile',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (onEditPressed != null)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEditPressed,
                    ),
                ],
              ),
            ),
            
            // Divider
            const Divider(height: 1),
            
            // Profile content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Code
                  _buildProfileRow(
                    context,
                    icon: Icons.person_outline,
                    title: 'Name',
                    value: name,
                  ),
                  _buildProfileRow(
                    context,
                    icon: Icons.numbers,
                    title: 'Student Code',
                    value: code,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Academic Information
                  Text(
                    'Academic Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                  ),
                  const SizedBox(height: 8),
                  
                  if (province != null)
                    _buildProfileRow(
                      context,
                      icon: Icons.location_on_outlined,
                      title: 'Province',
                      value: province!,
                    ),
                  
                  if (school != null)
                    _buildProfileRow(
                      context,
                      icon: Icons.school_outlined,
                      title: 'School',
                      value: school!,
                    ),
                  
                  if (className != null)
                    _buildProfileRow(
                      context,
                      icon: Icons.class_outlined,
                      title: 'Class',
                      value: className!,
                    ),
                    // In your student profile view
        const  UniformInformationSection(
          gender: 'genderValue',
          age: 'ageValue',
          bottomWear: 'bottomWearValue',
          hipSize: 'hipSize',
          waistSize: 'waistSize',
          height: 'heightSize',
          topWear: 'topWearValue',
          chestSize: 'chestSize',
          shoulderSize: 'shoulderSize',
          handSize: 'handSize',
          sportsWear: 'sportsWearValue',
          feetWear: 'feetWearValue',
          shoeSize: 'shoeSizeValue',
        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}