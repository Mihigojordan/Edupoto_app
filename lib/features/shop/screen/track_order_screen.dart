import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/introduction/widget/custom_help_widget.dart';
import 'package:hosomobile/features/shop/domain/models/order_model.dart';
import 'package:intl/intl.dart';

class TrackOrderScreen extends StatelessWidget {
  final OrderModel order;

  const TrackOrderScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${'track_order'.tr} #${order.id}'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Progress
            _buildDeliveryProgress(context),
            const SizedBox(height: 24),

            // Estimated Delivery
            _buildDeliveryEstimate(context),
            const SizedBox(height: 24),

            // Shipping Information
            Text('shipping_details'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildShippingDetails(context),
            const SizedBox(height: 24),

            // Tracking History
            Text('tracking_history'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildTrackingHistory(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(context),
    );
  }

  Widget _buildDeliveryProgress(BuildContext context) {
    // This would come from your order status
    final currentStep = _getCurrentStep(order.status);
    final totalSteps = 4; // Ordered → Processed → Shipped → Delivered

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Stepper
            Row(
              children: [
                _buildProgressStep(context, 'ordered'.tr, 1, currentStep),
                _buildProgressLine(context, 1, currentStep, totalSteps),
                _buildProgressStep(context, 'processed'.tr, 2, currentStep),
                _buildProgressLine(context, 2, currentStep, totalSteps),
                _buildProgressStep(context, 'shipped'.tr, 3, currentStep),
                _buildProgressLine(context, 3, currentStep, totalSteps),
                _buildProgressStep(context, 'delivered'.tr, 4, currentStep),
              ],
            ),
            const SizedBox(height: 16),
            // Status Message
            Text(
              _getStatusMessage(order.status),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(order.status),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(BuildContext context, String title, int step, int currentStep) {
    final isCompleted = step <= currentStep;
    final isCurrent = step == currentStep;

    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isCompleted 
              ? Theme.of(context).primaryColor 
              : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? Icon(
                  isCurrent ? Icons.directions_bus : Icons.check,
                  color: Colors.white,
                  size: 20,
                )
              : Center(
                  child: Text(
                    '$step',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isCompleted ? Colors.black : Colors.grey,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(BuildContext context, int step, int currentStep, int totalSteps) {
    final isCompleted = step < currentStep;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        color: isCompleted 
          ? Theme.of(context).primaryColor 
          : Colors.grey[300],
      ),
    );
  }

  Widget _buildDeliveryEstimate(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).primaryColor.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.schedule, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'estimated_delivery'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  Text(
                    _getEstimatedDeliveryDate(order.status),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingDetails(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildShippingDetailRow(
              context,
              'carrier'.tr,
             order.shipping.company,
              Icons.local_shipping,
            ),
            const Divider(height: 24),
            _buildShippingDetailRow(
              context,
              'tracking_number'.tr,
              'RW${order.id}',
              Icons.confirmation_number,
            ),
            const Divider(height: 24),
            _buildShippingDetailRow(
              context,
              'shipping_to'.tr,
              '${order.shipping.address1}, ${order.shipping.city}',
              Icons.location_on,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingDetailRow(
      BuildContext context, String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[500], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        if (title == 'tracking_number'.tr)
          IconButton(
            icon: Icon(Icons.copy, size: 20, color: Theme.of(context).primaryColor),
            onPressed: () {
              // Copy tracking_number
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('tracking_number_copied'.tr)),
              );
            },
          ),
      ],
    );
  }

  Widget _buildTrackingHistory(BuildContext context) {
    final history = _getTrackingHistory(order.status);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...history.map((entry) => _buildTrackingEntry(context, entry)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingEntry(BuildContext context, Map<String, dynamic> entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: entry['isActive'] 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              if (entry != _getTrackingHistory(order.status).last)
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.grey[300],
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry['status'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: entry['isActive'] ? Colors.black : Colors.grey[600],
                      ),
                ),
                Text(
                  entry['date'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
                if (entry['location'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    entry['location'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
               showHelpOptions();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  'contact_support'.tr,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // View order details
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'view_order'.tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  int _getCurrentStep(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 4;
      case 'processing':
        return 2;
      case 'shipped':
        return 3;
      case 'pending':
      default:
        return 1;
    }
  }

  String _getStatusMessage(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'your_order_has_been_delivered'.tr;
      case 'processing':
        return 'your_order_is_being_processed'.tr;
      case 'shipped':
        return 'your_order_is_on_the_way'.tr;
      case 'pending':
      default:
        return 'your_order_has_been_placed'.tr;
    }
  }

  String _getEstimatedDeliveryDate(String status) {
    final daysToAdd = _getCurrentStep(status) == 4 ? 0 : 
                      _getCurrentStep(status) == 3 ? 2 : 
                      _getCurrentStep(status) == 2 ? 4 : 7;
    
    return DateFormat('MMMM dd, yyyy').format(
      DateTime.now().add(Duration(days: daysToAdd))
    );
  }

  List<Map<String, dynamic>> _getTrackingHistory(String status) {
    final currentStep = _getCurrentStep(status);
    final now = DateTime.now();

    return [
      {
        'status': 'order_placed'.tr,
        'date': DateFormat('MMM dd, hh:mm a').format(now.subtract(const Duration(days: 3))),
        'location': 'Kigali, Rwanda',
        'isActive': currentStep >= 1,
      },
      if (currentStep >= 2) 
        {
          'status': 'processing'.tr,
          'date': DateFormat('MMM dd, hh:mm a').format(now.subtract(const Duration(days: 2))),
          'location': 'Warehouse',
          'isActive': currentStep >= 2,
        },
      if (currentStep >= 3)
        {
          'status': 'shipped'.tr,
          'date': DateFormat('MMM dd, hh:mm a').format(now.subtract(const Duration(days: 1))),
          'location': 'In transit',
          'isActive': currentStep >= 3,
        },
      if (currentStep >= 4)
        {
          'status': 'delivered'.tr,
          'date': DateFormat('MMM dd, hh:mm a').format(now),
          'isActive': currentStep >= 4,
        },
    ];
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'processing':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'refunded':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}