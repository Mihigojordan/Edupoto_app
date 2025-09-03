import 'package:flutter/material.dart';

class UniformInformationSection extends StatelessWidget {
  final String gender;
  final String age;
  final String bottomWear;
  final String hipSize;
  final String waistSize;
  final String height;
  final String topWear;
  final String chestSize;
  final String shoulderSize;
  final String handSize;
  final String sportsWear;
  final String feetWear;
  final String shoeSize;

  const UniformInformationSection({
    super.key,
    required this.gender,
    required this.age,
    required this.bottomWear,
    required this.hipSize,
    required this.waistSize,
    required this.height,
    required this.topWear,
    required this.chestSize,
    required this.shoulderSize,
    required this.handSize,
    required this.sportsWear,
    required this.feetWear,
    required this.shoeSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Uniform Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        
        const Divider(height: 1),
        
        // Content
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Info
              _buildInfoRow(context, 'Gender', gender),
              _buildInfoRow(context, 'Age', '$age years'),
              
              const SizedBox(height: 16),
              
              // Bottom Wear Section
              Text(
                'Bottom Wear',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(context, 'Type', bottomWear),
              if (gender == 'Female') _buildInfoRow(context, 'Hip Size', '$hipSize ft'),
              _buildInfoRow(context, 'Waist Size', '$waistSize ft'),
              _buildInfoRow(context, 'Height', '$height ft'),
              
              const SizedBox(height: 16),
              
              // Top Wear Section
              Text(
                'Top Wear',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(context, 'Type', topWear),
              _buildInfoRow(context, 'Chest Size', '$chestSize ft'),
              _buildInfoRow(context, 'Shoulder Size', '$shoulderSize ft'),
              _buildInfoRow(context, 'Hand Length', '$handSize ft'),
              
              const SizedBox(height: 16),
              
              // Sports & Footwear
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sports Wear',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(context, 'Type', sportsWear),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Footwear',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(context, 'Type', feetWear),
                        _buildInfoRow(context, 'Shoe Size', shoeSize),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            ':',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}