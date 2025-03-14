import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:get/get.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:hosomobile/features/transaction_money/widgets/share_statement_widget.dart';

class ShareController extends GetxController implements GetxService {
  ScreenshotController statementController = ScreenshotController();

  Future statementScreenShootFunction(
      {required String amount,
      required String? transactionType,
      required ContactModel? contactModel,
      required String charge,
      required String? trxId,
      required String? edubox_service,
      required String? studentInfo,
      required double? inputBalance,
      required List<EduboxMaterialModel>? dataList,
      required int? productIndex,
       required String? amountToPay,
  required String? nowPaid,
  required String?remainingAmount,
  required String? vat,
 required String?serviceCharge,
required String?totalNowPaid,
required String?serviceValue,
required int?serviceIndex,

      }) async {
    Uint8List? image;
    Get.to(ShareStatementWidget(
      amount: amount,
      transactionType: transactionType,
      contactModel: contactModel,
      charge: charge,
      trxId: trxId,
      edubox_service: edubox_service,
      inputBalance: inputBalance,
      studentInfo: studentInfo,
      dataList: dataList,
      productIndex: productIndex,
      amountToPay:amountToPay,
      nowPaid:nowPaid,
      remainingAmount:remainingAmount,
      vat:vat,
      serviceCharge:serviceCharge,
      totalNowPaid:totalNowPaid,
      serviceValue:serviceValue,
      serviceIndex:serviceIndex,
     
    ));
    Future.delayed(const Duration(milliseconds: 1000)).then((value) async {
      image = await statementController.capture();

      Navigator.pop(Get.context!);
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/share.png');
      imageFile.writeAsBytesSync(image!);
      await Share.shareXFiles([XFile(imageFile.path)]);
    });
  }

  Future<void> qrCodeDownloadAndShare(
      {required String qrCode,
      required String phoneNumber,
      required bool isShare}) async {
    Uint8List? image;
    Get.toNamed(RouteHelper.getQrCodeDownloadOrShareRoute(
        qrCode: qrCode, phoneNumber: phoneNumber));
    Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      image = await statementController.capture();

      Navigator.pop(Get.context!);

      if (isShare == true) {
        final directory = await getApplicationDocumentsDirectory();
        final imageFile = File('${directory.path}/share.png');
        imageFile.writeAsBytesSync(image!);
        await Share.shareXFiles([XFile(imageFile.path)]);
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final imageFile = File('${directory.path}/qr.png');
        imageFile.writeAsBytesSync(image!);
        // await GallerySaver.saveImage(imageFile.path,
        //         albumName: AppConstants.appName)
        //     .then((value) => showCustomSnackBarHelper(
        //         'QR code save to your Gallery',
        //         isError: false));
      }
    });
  }
}
