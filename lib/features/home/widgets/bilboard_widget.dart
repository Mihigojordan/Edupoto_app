import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/bilboard_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/add_money/screens/web_screen.dart';
import 'package:hosomobile/features/home/widgets/banner_shimmer_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BilboardWidget extends StatelessWidget {
  const BilboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return (splashController.configModel?.systemFeature?.bannerStatus ?? false)
            ? GetBuilder<BilboardController>(
                builder: (bilboardController) {
                  return bilboardController.bannerList == null
                      ? const Center(child: BannerShimmerWidget())
                      : bilboardController.bannerList!.isNotEmpty
                          ? Center(
                              child: Stack(
                                children: [
                                  CarouselSlider.builder(
                                    itemCount: bilboardController.bannerList!.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final image = bilboardController.bannerList!.isNotEmpty
                                          ? bilboardController.bannerList![index].image
                                          : '';
                                      return InkWell(
                                        onTap: () {
                                          if (bilboardController.bannerList!.isNotEmpty) {
                                            Get.to(WebScreen(
                                                selectedUrl: bilboardController.bannerList![index].url!));
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions.paddingSizeSuperExtraSmall),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CustomImageWidget(
                                                image: "${Get.find<SplashController>().configModel!.baseUrls!.bannerImageUrl}/$image",
                                                //  height: size.height / 1, // Set height to cover the container
                                                width:  size.width, // Set width to cover the container
                                                fit: BoxFit.fitHeight, // Ensure the image covers the container
                                                placeholder: Images.bannerPlaceHolder,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      aspectRatio: 0.6,
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      autoPlayInterval: const Duration(seconds: 4),
                                      viewportFraction: 1,
                                      onPageChanged: (index, reason) =>
                                          bilboardController.updateBannerActiveIndex(index),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: AnimatedSmoothIndicator(
                                        activeIndex: bilboardController.bannerActiveIndex,
                                        count: Get.find<BilboardController>().bannerList!.length,
                                        effect: CustomizableEffect(
                                          dotDecoration: DotDecoration(
                                            height: 5,
                                            width: 5,
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white.withOpacity(0.37),
                                          ),
                                          activeDotDecoration: const DotDecoration(
                                            height: 7,
                                            width: 7,
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox();
                },
              )
            : const SizedBox();
      },
    );
  }
}