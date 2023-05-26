import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/view_car_controller.dart';

class ViewCarView extends GetView<ViewCarController> {
  const ViewCarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ViewCarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ViewCarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
