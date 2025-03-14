import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/announcement_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/common/widgets/custom_ink_well_widget.dart';
import 'package:hosomobile/features/home/widgets/banner_shimmer_widget.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<SplashController>(
      builder: (splashController) {
        // Check if the linked website status is enabled
        if (!(splashController.configModel?.systemFeature?.linkedWebSiteStatus ?? false)) {
          return const SizedBox();
        }

        return GetBuilder<AnnouncementController>(
          builder: (announcementController) {
            if (announcementController.isLoading) {
              return const Center(child: BannerShimmerWidget());
            }

            if (announcementController.announcementList == null ||
                announcementController.announcementList!.isEmpty) {
              return const SizedBox();
            }

            return Expanded(
              child: Container(
                width: screenWidth >= 520 ? 340 : screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: Scrollbar(
                  thumbVisibility: true, // Ensures scrollbar visibility
                  child: SingleChildScrollView(
                    child: CustomInkWellWidget(
                      onTap: () {
                        // Handle tap event
                        // Get.to(WebScreen(selectedUrl: announcementController.announcementList![0].url!));
                      },
                      radius: Dimensions.radiusSizeExtraSmall,
                      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        width: screenWidth,
                        child: Text(
                          announcementController.announcementList![0].name ?? "No Announcement",
                          style: screenHeight >= 763
                              ? Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal)
                              : Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
