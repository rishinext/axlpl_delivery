import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/myorders_controller.dart';

class MyordersView extends GetView<MyordersController> {
  const MyordersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyordersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyordersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
