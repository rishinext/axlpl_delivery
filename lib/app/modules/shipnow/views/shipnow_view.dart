import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shipnow_controller.dart';

class ShipnowView extends GetView<ShipnowController> {
  const ShipnowView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShipnowView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShipnowView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
