import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/banner_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/add_money/screens/web_screen.dart';
import 'package:hosomobile/features/home/widgets/banner_shimmer_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(
      builder: (splashController) {


        return (splashController.configModel?.systemFeature?.bannerStatus ?? false) ? GetBuilder<BannerController>(builder: (bannerController){
          return bannerController.bannerList == null  ? const Center(child: BannerShimmerWidget()) :
          bannerController.bannerList!.isNotEmpty ?  Center(
            // margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
            child: Stack(
              children: [
                SizedBox(
                  height: size.width>=520?170:size.height>=763?170 :170, width:size.width>=520? 340: size.width,
                  child: CarouselSlider.builder(itemCount: bannerController.bannerList!.length,
                    itemBuilder: (context, index, realIndex) {
                      final image = bannerController.bannerList!.isNotEmpty ? bannerController.bannerList![index].image : '';
                      return InkWell(
                        onTap: (){
                          if(bannerController.bannerList!.isNotEmpty){
                            Get.to(WebScreen(selectedUrl: bannerController.bannerList![index].url!));
                          }
                        },

                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSuperExtraSmall),
                          child: Container(
                             width:size.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)),
                            child: ClipRRect(borderRadius: BorderRadius.circular(10),
                              child: CustomImageWidget(image: "${Get.find<SplashController>().configModel!.baseUrls!.bannerImageUrl}/$image", fit: BoxFit.cover, placeholder: Images.bannerPlaceHolder),
                            ),
                          ),
                        ),
                      );
                    },

                    options: CarouselOptions(autoPlay: true,
                      enlargeCenterPage: true, autoPlayInterval: const Duration(seconds: 4), viewportFraction: 1,
                      onPageChanged: (index, reason)=>bannerController.updateBannerActiveIndex(index),
                    ),
                  ),
                ),


                Positioned(bottom: 10, left: 0, right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:  AnimatedSmoothIndicator(
                      activeIndex: bannerController.bannerActiveIndex,
                      count: Get.find<BannerController>().bannerList!.length,
                      effect: CustomizableEffect(
                        dotDecoration: DotDecoration(
                          height: 5, width: 5, borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.37),
                        ),
                        activeDotDecoration: const DotDecoration(
                          height: 7, width: 7, borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) : const SizedBox();
        }) : const SizedBox();
      }
    );
  }
}
