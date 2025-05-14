import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showRatingDialog() {
  Get.defaultDialog(
    title: '',
    contentPadding: EdgeInsets.zero,
    content: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Rate Messenger',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              RatingBar(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                onRatingChanged: (value) => debugPrint('$value'),
                initialRating: 3,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: Icon(Icons.cancel, color: Colors.grey),
            onPressed: () => Get.back(),
          ),
        )
      ],
    ),
  );
}
