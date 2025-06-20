import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/transaction_money/widgets/share_statement_widget_sl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:get/get.dart';

class ShareControllerSl extends GetxController implements GetxService {
  final ScreenshotController statementController = ScreenshotController();

  Future<void> statementScreenShootFunction({
    required String amount,
    required String? transactionType,
    required ContactModel? contactModel,
    required String charge,
    required String? trxId,
    required String? eduboxService,
    required String? studentInfo,
    required double? inputBalance,
    required List<SchoolLists>? dataList,
    required int? productIndex,
    required String? amountToPay,
    required String? nowPaid,
    required String? remainingAmount,
    required String? vat,
    required String? serviceCharge,
    required String? totalNowPaid,
    required String? serviceValue,
    required int? serviceIndex,
    String? destination,
  }) async {
    try {
      // Navigate to share widget
      await Get.to(
        () => ShareStatementWidgetSl(
          amount: amount,
          destination: destination ?? '',
          transactionType: transactionType ?? '',
          contactModel: contactModel,
          charge: charge,
          trxId: trxId ?? '',
          edubox_service: eduboxService ?? '',
          inputBalance: inputBalance ?? 0.0,
          studentInfo: studentInfo ?? '',
          dataList: dataList ?? [],
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

      // Capture screenshot after delay
      await Future.delayed(const Duration(milliseconds: 1000)).then((_) async {
        final image = await _captureAndShareScreenshot();
        if (image != null) {
          await _shareImageFile(image);
        }
      });
    } catch (e) {
      debugPrint('Error in statementScreenShootFunction: $e');
      rethrow;
    }
  }

  Future<void> qrCodeDownloadAndShare({
    required String qrCode,
    required String phoneNumber,
    required bool isShare,
  }) async {
    try {
      // Navigate to QR code screen
      await Get.toNamed(
        RouteHelper.getQrCodeDownloadOrShareRoute(
          qrCode: qrCode,
          phoneNumber: phoneNumber,
        ),
      );

      // Capture and handle after delay
      await Future.delayed(const Duration(milliseconds: 100)).then((_) async {
        final image = await _captureAndShareScreenshot();
        if (image != null) {
          if (isShare) {
            await _shareImageFile(image);
          } else {
            await _saveQrCodeToGallery(image);
          }
        }
      });
    } catch (e) {
      debugPrint('Error in qrCodeDownloadAndShare: $e');
      rethrow;
    }
  }

  Future<Uint8List?> _captureAndShareScreenshot() async {
    try {
      final image = await statementController.capture();
      if (image == null) {
        throw Exception('Failed to capture screenshot');
      }
      Navigator.of(Get.context!).pop();
      return image;
    } catch (e) {
      debugPrint('Error capturing screenshot: $e');
      return null;
    }
  }

  Future<void> _shareImageFile(Uint8List image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/share.png');
      await imageFile.writeAsBytes(image);
      await Share.shareXFiles([XFile(imageFile.path)]);
    } catch (e) {
      debugPrint('Error sharing image: $e');
      rethrow;
    }
  }

  Future<void> _saveQrCodeToGallery(Uint8List image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/qr.png');
      await imageFile.writeAsBytes(image);
      // Uncomment if you have gallery_saver package
      // await GallerySaver.saveImage(imageFile.path, albumName: 'YourAppName');
      // showCustomSnackBarHelper('QR code saved to your Gallery', isError: false);
    } catch (e) {
      debugPrint('Error saving QR code: $e');
      rethrow;
    }
  }
}