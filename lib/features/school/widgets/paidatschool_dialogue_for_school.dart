import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDialog extends StatelessWidget {
  final String accountNumber;
  final String shortCode;
  final String phoneNumber;

  const PaymentDialog({
    super.key,
    required this.accountNumber,
    required this.shortCode,
    required this.phoneNumber,
  });

  Future<void> _copyToClipboard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  Future<void> _dialPaymentNumber() async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('School Payment Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPaymentInfoRow(
            context,
            'Account Number:',
            accountNumber,
            Icons.content_copy,
            () => _copyToClipboard(accountNumber, context),
          ),
          const SizedBox(height: 16),
          _buildPaymentInfoRow(
            context,
            'Payment Code:',
            shortCode,
            Icons.content_copy,
            () => _copyToClipboard(shortCode, context),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text('Initiate Payment via USSD'),
              onPressed: _dialPaymentNumber,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildPaymentInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

