import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ReceiverAddressView extends GetView {
  const ReceiverAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Column(
        spacing: 10,
        children: [dropdownText('Recevier Info'), Text('Same UI As address')],
      ),
    );
  }
}
