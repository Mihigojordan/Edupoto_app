import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/models/order_model.dart';
import 'package:hosomobile/features/shop/screen/order_detail_screen.dart';
import 'package:hosomobile/features/shop/screen/track_order_screen.dart';
import 'package:intl/intl.dart';


class ShopOrderScreen extends StatelessWidget {
  final int? customerId;
  ShopOrderScreen({
    super.key, 
    this.customerId
  });

  @override
  Widget build(BuildContext context) {
    final shopController = Get.find<ShopController>();
 
    return Scaffold(
      appBar: AppBar(
        title: Text('my_orders'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => shopController.getOrderList(true),
          ),
        ],
      ),
      body: GetBuilder<ShopController>(
        builder: (shopController) {
          // Filter orders by customerId first
          final filteredOrders = shopController.orderList
              ?.where((order) => order.customerId == customerId)
              .toList() ?? [];
          
          // Show loading indicator while loading
          if (shopController.isLoading && shopController.orderList == null) {
            return Center(child: CircularProgressIndicator());
          }
          
          // Handle empty state for filtered orders
          if (filteredOrders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey[300]),
                  SizedBox(height: 16),
                  Text(
                    shopController.orderList == null ? 'loading'.tr : 'no_order_found'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  if (shopController.orderList != null)
                    ElevatedButton(
                      onPressed: () => shopController.getOrderList(true),
                      child: Text('retry'.tr),
                    ),
                ],
              ),
            );
          }
          
          return Container(
            color: Colors.grey[50],
            child: RefreshIndicator(
              onRefresh: () async => await shopController.getOrderList(true),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: filteredOrders.length, // Use filtered list length
                itemBuilder: (context, index) {
                  final order = filteredOrders[index]; // Use filtered order
                  return OrderCard(order: order);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (order.dateCreated == null) {
      return SizedBox.shrink(); // or return a placeholder
    }

    final date = DateTime.tryParse(order.dateCreated!) ?? DateTime.now();
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    
    return  Card(
     margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to order details
        },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'order'.tr} #${order.id ?? ''}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (order.status != null) // Only show status if exists
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status!.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            SizedBox(height: 16),
            // Product items - add null check
            if (order.lineItems != null) ...[
              ...order.lineItems!.take(2).map((item) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: item.image?.src != null 
                        ? Image.network(
                            item.image!.src,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
                          )
                        : _buildPlaceholderImage(),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name ?? 'unnamed_product'.tr,
                            style: TextStyle(fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${item.quantity ?? 0} × ${order.currency ?? ''}${item.price ?? 0}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              if (order.lineItems!.length > 2) Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  '+ ${order.lineItems!.length - 2} ${'more_items'.tr}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ),
            ],
            SizedBox(height: 16),
            Divider(height: 1),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'total_amount'.tr,
                  style:const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${order.currency ?? ''}${order.total ?? '0'}',
                  style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
                  SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => TrackOrderScreen(order: order));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text('track_order'.tr),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                      Get.to(() => OrderDetailsScreen(order: order));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'view_details'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),),
    );
  }

    Widget _buildPlaceholderImage() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.grey[200],
      child: Icon(Icons.shopping_bag, color: Colors.grey),
    );
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

