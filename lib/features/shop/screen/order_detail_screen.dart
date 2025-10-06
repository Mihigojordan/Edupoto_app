import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/introduction/widget/custom_help_widget.dart';
import 'package:hosomobile/features/shop/domain/models/order_model.dart';
import 'package:hosomobile/features/shop/screen/track_order_screen.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
<<<<<<< HEAD
 final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
 
      final date = DateTime.tryParse(widget.order.dateCreated) ?? DateTime.now();
=======
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(widget.order.dateCreated) ?? DateTime.now();
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    final totalAmount = double.tryParse(widget.order.total) ?? 0;
    final shippingAmount = double.tryParse(widget.order.shippingTotal) ?? 0;
    final subtotal = totalAmount - shippingAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text('${'order'.tr} #${widget.order.id}'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _showShareOptions(context),
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
                // Order Status Card
            _buildStatusCard(context),
            const SizedBox(height: 20),

            // Order Summary
            Text('order_summary'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildSummaryCard(context, subtotal, shippingAmount, totalAmount),
            const SizedBox(height: 20),

            // Shipping Information
            Text('shipping_information'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildAddressCard(context, shipping:widget.order.shipping,billing:widget.order.billing,title: 'shipping'.tr),
            const SizedBox(height: 20),

            // Billing Information
            Text('billing_information'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildAddressCard(context,shipping:widget.order.shipping,billing: widget.order.billing,title: 'billing'.tr),
            const SizedBox(height: 20),

            // Payment Method
            Text('payment_method'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildPaymentCard(context),
            const SizedBox(height: 20),

            // Ordered Items
            Text('ordered_items'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...widget.order.lineItems.map((item) => _buildOrderItem(context, item)),
=======
              // Order Status Card
              _buildStatusCard(context),
              const SizedBox(height: 20),

              // Order Summary
              Text('order_summary'.tr, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _buildSummaryCard(context, subtotal, shippingAmount, totalAmount),
              const SizedBox(height: 20),

              // Shipping Information
              Text('shipping_information'.tr, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _buildAddressCard(context, shipping: widget.order.shipping, billing: widget.order.billing, title: 'shipping'.tr),
              const SizedBox(height: 20),

              // Billing Information
              Text('billing_information'.tr, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _buildAddressCard(context, shipping: widget.order.shipping, billing: widget.order.billing, title: 'billing'.tr),
              const SizedBox(height: 20),

              // Payment Method
              Text('payment_method'.tr, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _buildPaymentCard(context),
              const SizedBox(height: 20),

              // Ordered Items
              Text('ordered_items'.tr, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              ...widget.order.lineItems.map((item) => _buildOrderItem(context, item)),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
            ],
          ),
        ),
      ),
<<<<<<< HEAD
       bottomNavigationBar: _buildBottomActions(context),
=======
      bottomNavigationBar: _buildBottomActions(context),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
<<<<<<< HEAD
              title:  Text('save_as_image'.tr),
=======
              title: Text('save_as_image'.tr),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
              onTap: () {
                Navigator.pop(context);
                _captureAndSaveImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
<<<<<<< HEAD
              title:  Text('save_as_pdf'.tr),
=======
              title: Text('save_as_pdf'.tr),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
              onTap: () {
                Navigator.pop(context);
                _generateAndSavePdf();
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
<<<<<<< HEAD
              title:  Text('share_order'.tr),
=======
              title: Text('share_order'.tr),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
              onTap: () {
                Navigator.pop(context);
                _shareOrder();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndSaveImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/order_${widget.order.id}.png';
      
      await _screenshotController.captureAndSave(
        directory.path,
        fileName: 'order_${widget.order.id}.png',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${'order_saved_as_image_at'.tr} $imagePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${'failed_to_save_as_image'.tr}: $e')),
      );
    }
  }

  Future<void> _generateAndSavePdf() async {
    try {
      final pdf = pw.Document();
      final image = await _screenshotController.capture();
      
<<<<<<< HEAD
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                pw.MemoryImage(image!),
                fit: pw.BoxFit.contain,
              ),
            );
          },
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/order_${widget.order.id}.pdf');
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${'pdf_saved_at'.tr} ${file.path}')),
      );
=======
      if (image != null) {
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(
                  pw.MemoryImage(image),
                  fit: pw.BoxFit.contain,
                ),
              );
            },
          ),
        );

        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/order_${widget.order.id}.pdf');
        await file.writeAsBytes(await pdf.save());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${'pdf_saved_at'.tr} ${file.path}')),
        );
      }
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${'failed_to_generate_pdf'.tr}: $e')),
      );
    }
  }

  Future<void> _shareOrder() async {
    try {
      final image = await _screenshotController.capture();
      if (image == null) return;

      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/order_${widget.order.id}.png';
      await File(imagePath).writeAsBytes(image);

      await Share.shareXFiles(
<<<<<<< HEAD
       [ XFile(imagePath)],
=======
        [XFile(imagePath)],
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
        text: '${'here_are_my_order_details'.tr} #${widget.order.id}',
        subject: 'order_details'.tr,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${'failed_to_share'.tr}: $e')),
      );
    }
  }

<<<<<<< HEAD
Widget _buildStatusCard(BuildContext context) {
=======
  Widget _buildStatusCard(BuildContext context) {
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    return Card(
      elevation: 0,
      color: _getStatusColor(widget.order.status).withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.local_shipping, color: _getStatusColor(widget.order.status)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'order'.tr} ${widget.order.status.toUpperCase()}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(widget.order.status),
                    ),
                  ),
                  Text(
                    '${'estimated_delivery'.tr}: ${DateFormat('MMM dd').format(DateTime.now().add(const Duration(days: 3)))}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, double subtotal, double shipping, double total) {
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
            _buildSummaryRow(context, 'subtotal'.tr, subtotal),
            _buildSummaryRow(context, 'shipping'.tr, shipping),
            const Divider(height: 24),
            _buildSummaryRow(
              context,
              'total'.tr,
              total,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '${widget.order.currency}${amount.toStringAsFixed(2)}',
            style: isTotal
                ? Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildAddressCard(BuildContext context,{required ShippingInfo shipping,required String title,required BillingInfo billing}) {
=======
  Widget _buildAddressCard(BuildContext context, {required ShippingInfo shipping, required String title, required BillingInfo billing}) {
    final orderId = billing.email.replaceAll('@gmail.com', '');

>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
<<<<<<< HEAD
            Text(
              '${shipping.firstName} ${shipping.lastName}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (shipping.company.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  shipping.company,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                shipping.address1,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (shipping.address2.isNotEmpty)
=======
            if (title == 'shipping'.tr && shipping.firstName.isNotEmpty) ...[
              Text(
                '${shipping.firstName} ${shipping.lastName}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (title == 'billing'.tr && billing.firstName.isNotEmpty) ...[
              Text(
                '${billing.firstName} ${billing.lastName}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (title == 'shipping'.tr && shipping.company.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${'shipping_company'.tr}: ${shipping.company}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            if (title == 'shipping'.tr && shipping.address1.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  shipping.address1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            if (title == 'shipping'.tr && shipping.address2.isNotEmpty) ...[
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  shipping.address2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
<<<<<<< HEAD
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${shipping.city}, ${shipping.state} ${shipping.postcode}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                shipping.country,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (shipping.phone.isNotEmpty)
=======
            ],
            if (title == 'shipping'.tr && shipping.city.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${shipping.city}, ${shipping.state} ${shipping.postcode}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  shipping.country,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            if (title == 'billing'.tr && billing.city.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${billing.city}, ${billing.state} ${billing.postcode}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  billing.country,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            if (title == 'shipping'.tr && shipping.phone.isNotEmpty) ...[
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${'phone'.tr}: ${shipping.phone}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
<<<<<<< HEAD
            if (title == 'billing'.tr && billing.email.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${'email'.tr}: ${billing.email}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
=======
            ],

            if (title == 'billing'.tr && billing.phone.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${'phone'.tr}: ${billing.phone}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
                  if (title == 'billing'.tr && billing.company.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                 '${'billing_company'.tr}: ${billing.company}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            if (title == 'billing'.tr && billing.email.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${'order_id'.tr}: $orderId',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context) {
<<<<<<< HEAD
=======
    final datePaid = widget.order.datePaid != null && widget.order.datePaid!.isNotEmpty
        ? DateTime.tryParse(widget.order.datePaid!)
        : DateTime.now();

>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.credit_card, color: Colors.blue[700]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.order.paymentMethodTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
<<<<<<< HEAD
                    '${'paid_on'.tr} ${DateFormat('MMM dd, yyyy').format(DateTime.tryParse(widget.order.datePaid ?? '') ?? DateTime.now())}',
=======
                    '${'paid_on'.tr} ${DateFormat('MMM dd, yyyy').format(datePaid!)}',
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (widget.order.transactionId.isNotEmpty)
              Text(
                '${'ref'.tr}: ${widget.order.transactionId}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, LineItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.image.src.isNotEmpty
                  ? Image.network(
                      item.image.src,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
                    )
                  : _buildPlaceholderImage(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SKU: ${item.sku}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
<<<<<<< HEAD
                        '${widget.order.currency}${item.price.toStringAsFixed(2)}',
=======
                        '${widget.order.currency}${item.price.toStringAsFixed(2) ?? "0.00"}',
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '${'qty'.tr}: ${item.quantity}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Get.to(() => TrackOrderScreen(order: widget.order));
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              child: Text(
                'track_order'.tr,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
<<<<<<< HEAD
             showHelpOptions(email: 'katendeshema@gmail.com',phone: '250781699866');
=======
                showHelpOptions(email: 'katendeshema@gmail.com', phone: '250781699866');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
<<<<<<< HEAD
              child:  Text(
                'need_help'.tr,
                style: TextStyle(color: Colors.white),
=======
              child: Text(
                'need_help'.tr,
                style: const TextStyle(color: Colors.white),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[200],
      child: Icon(Icons.shopping_bag, color: Colors.grey[400]),
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
<<<<<<< HEAD

=======
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
}