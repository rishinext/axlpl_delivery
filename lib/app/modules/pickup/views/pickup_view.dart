import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/pickup_controller.dart';

class PickupView extends GetView<PickupController> {
  const PickupView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: commonAppbar('Pickup'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15.h,
            children: [
              ContainerTextfiled(
                hintText: '   Enter your pin code',
                suffixIcon: Icon(
                  CupertinoIcons.search,
                  color: themes.grayColor,
                ),
              ),
              Text(
                'Recent Selected Pin code',
                style: themes.fontSize14_500,
              ),
              SizedBox(
                height: 505.h,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 1.h,
                  ),
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                      tileColor: themes.whiteColor,
                      dense: false,
                      leading: CircleAvatar(
                        backgroundColor: themes.blueGray,
                        child: Image.asset(
                          gpsIcon,
                          width: 18.w,
                        ),
                      ),
                      title: Text('Company name'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('+91900000000'), Text('400089')],
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: themes.lightCream,
                        // radius: 15,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 20.w,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
