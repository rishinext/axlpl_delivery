import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showRatingDialog(BuildContext context) {
  final profileController = Get.put(ProfileController());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        contentPadding: EdgeInsets.zero,
        content: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                spacing: 20,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Rate Messenger',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  RatingBar(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    onRatingChanged: (value) =>
                        profileController.rating.value = value,
                    initialRating: 0,
                    alignment: Alignment.center,
                  ),
                  CommonTextfiled(
                    lableText: 'Feedback',
                    controller: profileController.feedbackController,
                  ),
                  CommonButton(
                    title: 'Submit',
                    isLoading:
                        profileController.isRatting.value == Status.loading,
                    onPressed: () {
                      profileController.rateMessanger();
                    },
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: Icon(Icons.cancel, color: themes.grayColor),
                onPressed: () => Get.back(),
              ),
            )
          ],
        ),
      );
    },
  );
}
