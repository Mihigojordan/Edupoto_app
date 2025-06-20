import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:hosomobile/features/shop/widget/product.dart';
import 'package:hosomobile/features/transaction_money/widgets/share_statement_widget_sp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:get/get.dart';

class ShareControllerSp extends GetxController implements GetxService {
  final ScreenshotController statementController = ScreenshotController();
  final _isProcessing = false.obs;

  bool get isProcessing => _isProcessing.value;

  Future<void> statementScreenShootFunction({
    required String amount,
    required String? transactionType,
    required ContactModel? contactModel,
    required String charge,
    required String? trxId,
    required String? eduboxService,
    required String? studentInfo,
    required double? inputBalance,
    required Product? product,
    required int? productIndex,
    required String? amountToPay,
    required String? nowPaid,
    required String? remainingAmount,
    required String? vat,
    required String? serviceCharge,
    required String? totalNowPaid,
    required String? serviceValue,
    required int? serviceIndex,
    required String destination,
    required String deliveryCost
   
  }) async {
    if (_isProcessing.value) return;
    _isProcessing.value = true;

    try {
      _validateParameters(contactModel);

      await _navigateToStatementWidget(
        deliveryCost: deliveryCost,
        amount: amount,
        transactionType: transactionType,
        contactModel: contactModel!,
        charge: charge,
        trxId: trxId,
        eduboxService: eduboxService,
        studentInfo: studentInfo,
        inputBalance: inputBalance,
        product: product,
        productIndex: productIndex,
        amountToPay: amountToPay,
        nowPaid: nowPaid,
        remainingAmount: remainingAmount,
        vat: vat,
        serviceCharge: serviceCharge,
        totalNowPaid: totalNowPaid,
        serviceValue: serviceValue,
        serviceIndex: serviceIndex,
        destination: destination,
    
      );

      await _processScreenshotOperation(
        delay: const Duration(milliseconds: 1000),
        operation: _shareImageFile,
      );
    } catch (e) {
      _handleError('statementScreenShootFunction', e);
      rethrow;
    } finally {
      _isProcessing.value = false;
    }
  }

  Future<void> qrCodeDownloadAndShare({
    required String qrCode,
    required String phoneNumber,
    required bool isShare,
  }) async {
    if (_isProcessing.value) return;
    _isProcessing.value = true;

    try {
      await _navigateToQrScreen(qrCode, phoneNumber);

      await _processScreenshotOperation(
        delay: const Duration(milliseconds: 100),
        operation: isShare ? _shareImageFile : _saveQrCodeToGallery,
      );
    } catch (e) {
      _handleError('qrCodeDownloadAndShare', e);
      rethrow;
    } finally {
      _isProcessing.value = false;
    }
  }

  void _validateParameters(ContactModel? contactModel) {
    if (contactModel == null) {
      throw ArgumentError('Contact model cannot be null');
    }
  }

  Future<void> _navigateToStatementWidget({
    required String amount,
    required String? transactionType,
    required ContactModel contactModel,
    required String charge,
    required String? trxId,
    required String? eduboxService,
    required String? studentInfo,
    required double? inputBalance,
    required Product? product,
    required int? productIndex,
    required String? amountToPay,
    required String? nowPaid,
    required String? remainingAmount,
    required String? vat,
    required String? serviceCharge,
    required String? totalNowPaid,
    required String? serviceValue,
    required int? serviceIndex,
    required String destination,
    required String deliveryCost
  }) async {
    await Get.to(
      () => ShareStatementWidgetSp(
        deliveryCost:deliveryCost??'' ,
        destination: destination,
        amount: amount,
        transactionType: transactionType ?? '',
        contactModel: contactModel,
        charge: charge,
        trxId: trxId ?? '',
        edubox_service: eduboxService ?? '',
        inputBalance: inputBalance ?? 0.0,
        studentInfo: studentInfo ?? '',
        dataList: product,
        productIndex: productIndex ?? 0,
        amountToPay: amountToPay ?? '',
        nowPaid: nowPaid ?? '',
        remainingAmount: remainingAmount ?? '',
        vat: vat ?? '',
        serviceCharge: serviceCharge ?? '',
        totalNowPaid: totalNowPaid ?? '',
        serviceValue: serviceValue ?? '',
        serviceIndex: serviceIndex ?? 0,
       
      ),
    );
  }

  Future<void> _navigateToQrScreen(String qrCode, String phoneNumber) async {
    await Get.toNamed(
      RouteHelper.getQrCodeDownloadOrShareRoute(
        qrCode: qrCode,
        phoneNumber: phoneNumber,
      ),
    );
  }

  Future<void> _processScreenshotOperation({
    required Duration delay,
    required Future<void> Function(Uint8List) operation,
  }) async {
    try {
      await Future.delayed(delay);
      final image = await _captureScreenshot();
      if (image != null) {
        await operation(image);
      }
    } catch (e) {
      debugPrint('Error in screenshot operation: $e');
      rethrow;
    }
  }

  Future<Uint8List?> _captureScreenshot() async {
    try {
      final image = await statementController.capture();
      if (image == null) {
        throw Exception('Failed to capture screenshot');
      }
      if (Get.context != null && Navigator.canPop(Get.context!)) {
        Navigator.of(Get.context!).pop();
      }
      return image;
    } catch (e) {
      debugPrint('Error capturing screenshot: $e');
      return null;
    }
  }

  Future<void> _shareImageFile(Uint8List image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/share_${DateTime.now().millisecondsSinceEpoch}.png');
      await imageFile.writeAsBytes(image);
      await Share.shareXFiles([XFile(imageFile.path)],
          subject: 'Transaction Statement',
          text: 'Here is your transaction statement');
    } catch (e) {
      debugPrint('Error sharing image: $e');
      rethrow;
    }
  }

  Future<void> _saveQrCodeToGallery(Uint8List image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png');
      await imageFile.writeAsBytes(image);
      // Uncomment if you have gallery_saver package
      // await GallerySaver.saveImage(imageFile.path, albumName: 'YourAppName');
      // showCustomSnackBarHelper('QR code saved to your Gallery', isError: false);
    } catch (e) {
      debugPrint('Error saving QR code: $e');
      rethrow;
    }
  }

  void _handleError(String methodName, dynamic error) {
    debugPrint('Error in $methodName: $error');
    // Add your error reporting logic here (e.g., Sentry, Firebase Crashlytics)
  }
}