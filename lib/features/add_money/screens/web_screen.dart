import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_dialog_widget.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/helper/dialog_helper.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/common/widgets/custom_loader_widget.dart';
import 'package:hosomobile/features/home/screens/nav_bar_screen.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class WebScreen extends StatefulWidget {
  final String selectedUrl;
  final bool? isPaymentUrl;
  const WebScreen({super.key, required this.selectedUrl, this.isPaymentUrl = false});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  double value = 0.0;

  PullToRefreshController? pullToRefreshController;
  late MyInAppBrowser browser;


  @override
  void initState() {
    super.initState();
    _initData();

  }

  void _initData() async {
    browser = MyInAppBrowser(widget.isPaymentUrl!,context);

    final settings = InAppBrowserClassSettings(
      browserSettings: InAppBrowserSettings(hideUrlBar: false),
      webViewSettings: InAppWebViewSettings(javaScriptEnabled: true, isInspectable: kDebugMode, useShouldOverrideUrlLoading: false, useOnLoadResource: false),
    );




    await browser.openUrlRequest(
      urlRequest: URLRequest(url: WebUri(widget.selectedUrl)),
      settings: settings,
    );



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
             Center(
              child: CustomLoaderWidget(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }

}


class MyInAppBrowser extends InAppBrowser {
  final bool isPaymentUrl;
  final BuildContext context;
  bool _canRedirect = true;

  MyInAppBrowser(this.isPaymentUrl, this.context);

  @override
  Future onBrowserCreated() async {
    debugPrint("\n\nBrowser Created!\n\n");

  }

  @override
  Future onLoadStart(url) async {
    debugPrint("\n\nStarted: $url\n\n");

    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    debugPrint("\n\nStopped: $url\n\n");

    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    debugPrint("Can't load [$url] Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }

    debugPrint("Progress: $progress");

  }

  @override
  void onExit() {
    if(_canRedirect) {
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const NavBarScreen(destination:'web')), (route) => false);

    }

    debugPrint("\n\nBrowser closed!\n\n");

  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(navigationAction) async {
    debugPrint("\n\nOverride ${navigationAction.request.url}\n\n");

    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(resource) {
    // print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    debugPrint("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }

  void _pageRedirect(String url) {
    
    print('is payment redirected?????????????????: $url');
    
    
    
    if(_canRedirect && isPaymentUrl) {
 print('wowoooooooooooooooo it isss: $url');
      if(url.contains(AppConstants.baseUrl) && url.contains('token')) {
        bool isSuccess = url.contains('success');
        bool isFailed = url.contains('fail');
 print('is payment successfully?????????????????: $url');

        if(isSuccess || isFailed) {
          _canRedirect = false;
           close();
        }


       if (isSuccess) {
  _canRedirect = false;
  //....................Here is Where we can save our data that transaction has been completed..................
  // Show the dialog first
  DialogHelper.showAnimatedDialog(context, CustomDialogWidget(
    icon: Icons.done,
    title: 'add_money'.tr,
    description: 'your_money_added_successfully'.tr,
    isSingleButton: true,
  ), dismissible: false, isFlip: true);
  
  // Delay closing the browser to ensure dialog shows
  Future.delayed(const Duration(seconds: 5), () {

    close();
    Get.offAll(const NavBarScreen(destination: 'home',));
    Get.find<ProfileController>().getProfileData(reload:true);
  });
}


        } else{
 print('noooooooooooooooooooooooo failed: $url');
        Get.offAll(const NavBarScreen(destination: 'home',));

        DialogHelper.showAnimatedDialog(context, CustomDialogWidget(
          icon: Icons.clear,
          title: 'add_money'.tr,
          description: 'your_payment_failed'.tr,
          isFailed: true,
          isSingleButton: true,
        ), dismissible: false, isFlip: true);
          Future.delayed(const Duration(seconds: 5), () {
    close();
    Get.offAll(const NavBarScreen(destination: 'home',));
    Get.find<ProfileController>().getProfileData(reload:true);
  });
      }
    }
  }

}
