// if (controller.isTrackingLoading.value == Status.loading) {
//         return Center(
//           child: CircularProgressIndicator.adaptive(),
//         );
//       } else if (controller.isTrackingLoading.value == Status.error) {
//         return Center(
//           child: Text('No Tracking Data Found'),
//         );
//       } else if (controller.isTrackingLoading.value == Status.success) {
//         String formattedDate = trackingStatus.isNotEmpty
//             ? DateFormat('dd-MM-yyyy HH:mm')
//                 .format(trackingStatus[0].dateTime)
//             : 'No date available';
//         return Column(
//           spacing: 20,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: themes.whiteColor,
//                   borderRadius: BorderRadius.circular(5.r)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   spacing: 10,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: themes.blueGray,
//                           child: Image.asset(shopingIcon, width: 18.w),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             shipmentId.toString(),
//                             overflow: TextOverflow.fade,
//                             style: themes.fontSize14_500,
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: themes.blueGray,
//                               borderRadius: BorderRadius.circular(15.r)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 8.0,
//                                   height: 8.0,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: themes.darkCyanBlue),
//                                 ),
//                                 Text(
//                                   " ${status.toString()}",
//                                   style: themes.fontSize14_500.copyWith(
//                                       color: themes.darkCyanBlue),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Sender Name',
//                                   style: themes.fontSize14_500
//                                       .copyWith(color: themes.grayColor)),
//                               SizedBox(height: 4),
//                               Text(
//                                   senderData.isNotEmpty
//                                       ? senderData[0].senderName ??
//                                           'No sender name'
//                                       : 'No sender name',
//                                   style: themes.fontSize14_500),
//                               SizedBox(height: 16.h),
//                               Text('From',
//                                   style: themes.fontSize14_500
//                                       .copyWith(color: themes.grayColor)),
//                               Text(
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 senderData.isNotEmpty
//                                     ? senderData[0].address1 ?? ''
//                                     : '',
//                                 style: themes.fontSize14_500,
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 24),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Shipper Name',
//                                   style: themes.fontSize14_500
//                                       .copyWith(color: themes.grayColor)),
//                               SizedBox(height: 4),
//                               Text(
//                                   receiverData.isNotEmpty
//                                       ? receiverData[0].receiverName ??
//                                           'No receiver name'
//                                       : 'No receiver name',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: themes.fontSize14_500),
//                               SizedBox(height: 16),
//                               Text('To',
//                                   style: themes.fontSize14_500
//                                       .copyWith(color: themes.grayColor)),
//                               SizedBox(height: 4),
//                               Text(
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 receiverData.isNotEmpty
//                                     ? receiverData[0].address1 ?? ''
//                                     : '',
//                                 style: themes.fontSize14_500,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     IntrinsicHeight(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 Text('State',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   senderData.isNotEmpty
//                                       ? senderData[0].state ?? ''
//                                       : '',
//                                   style: themes.fontSize14_500,
//                                 ),
//                                 Text('City',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   senderData.isNotEmpty
//                                       ? senderData[0].city ?? ''
//                                       : 'N/A',
//                                   style: themes.fontSize14_500,
//                                 ),
//                                 Text('Area',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   senderData.isNotEmpty
//                                       ? senderData[0].area ?? ''
//                                       : 'N/A',
//                                   style: themes.fontSize14_500,
//                                 ),
//                                 Text('Zip',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   senderData.isNotEmpty
//                                       ? senderData[0].pincode ?? ''
//                                       : 'N/A',
//                                   style: themes.fontSize14_500,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           //receiver info
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 Text('State',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   receiverData.isNotEmpty
//                                       ? receiverData[0].state ?? ''
//                                       : '',
//                                   style: themes.fontSize14_500,
//                                 ),
//                                 Text('City',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   receiverData.isNotEmpty
//                                       ? receiverData[0].city ?? ''
//                                       : 'N/A',
//                                   style: themes.fontSize14_500,
//                                 ),
//                                 Text('Area',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   receiverData.isNotEmpty
//                                       ? receiverData[0].area ?? ''
//                                       : 'N/A',
//                                   style: themes.fontSize14_500,
//                                 ),
//                                 Text('Zip',
//                                     style: themes.fontSize14_500.copyWith(
//                                         color: themes.grayColor)),
//                                 Text(
//                                   receiverData.isNotEmpty
//                                       ? receiverData[0].pincode ?? ''
//                                       : 'N/A',
//                                   style: themes.fontSize14_500,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//                 decoration: BoxDecoration(
//                   color: themes.whiteColor,
//                   borderRadius: BorderRadius.circular(5.r),
//                 ),
//                 child: EnhanceStepper(
//                   physics: ClampingScrollPhysics(),
//                   stepIconSize: 40, // Adjust size if needed
//                   stepIconBuilder: (stepIndex, stepState) => Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: stepState == StepState.complete
//                           ? themes
//                               .blueGray // ✅ Change completed step color
//                           : Colors
//                               .grey[300], // ✅ Change pending step color
//                     ),
//                     padding: EdgeInsets.all(
//                         10), // Adjust spacing inside circle
//                     child: Icon(
//                       Icons.gps_fixed,
//                       color: themes
//                           .darkCyanBlue, // ✅ Ensure icon contrasts with background
//                       size: 20,
//                     ),
//                   ),
//                   type: StepperType.vertical,
//                   currentStep: controller.currentStep.value,
//                   // onStepTapped: (index) =>
//                   //     controller.currentStep.value = index,
//                   steps: controller.trackingStatus.map((step) {
//                     return EnhanceStep(
//                       isActive: true,
//                       state: StepState.complete,
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               step.status,
//                               style:
//                                   TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Text(
//                             formattedDate,
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       content: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Text(
//                           //   trackingStatus[0].status,
//                           //   style: TextStyle(color: Colors.grey),
//                           // ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               // CircleAvatar(
//                               //   // backgroundImage:
//                               //   //     AssetImage(step["driverImage"]),
//                               //   radius: 20,
//                               // ),
//                               SizedBox(width: 8),
//                               // Column(
//                               //   crossAxisAlignment:
//                               //       CrossAxisAlignment.start,
//                               //   children: [
//                               //     Text(
//                               //       "Driver",
//                               //       style: TextStyle(color: Colors.grey),
//                               //     ),
//                               //     Text(
//                               //       'driver name',
//                               //       style: TextStyle(
//                               //           fontWeight: FontWeight.bold),
//                               //     ),
//                               //   ],
//                               // ),
//                               Spacer(),
//                               // InkWell(
//                               //   onTap: () {
//                               //     // controller.makingPhoneCall();
//                               //   },
//                               //   child: Container(
//                               //     padding: EdgeInsets.symmetric(
//                               //         horizontal: 12.w, vertical: 5.h),
//                               //     decoration: BoxDecoration(
//                               //       color: Colors.blue[100],
//                               //       borderRadius:
//                               //           BorderRadius.circular(20),
//                               //     ),
//                               //     child: Row(
//                               //       children: [
//                               //         Image.asset(
//                               //           phoneIcon,
//                               //           width: 15.w,
//                               //         ),
//                               //         SizedBox(width: 5),
//                               //         Text('driver number',
//                               //             style: themes.fontSize14_500
//                               //                 .copyWith(
//                               //                     fontSize: 14.sp,
//                               //                     color: themes
//                               //                         .darkCyanBlue)),
//                               //       ],
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                   controlsBuilder: (context, details) =>
//                       SizedBox(), // Hide buttons
//                 )

//                 // Hide buttons
//                 ),
//           ],
//         );
//       } else {
//         return Center(
//           child: Text('No Track Data Found!'),
//         );
//       }
