import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_car_controller.dart';

class AddCarView extends GetView<AddCarController> {
  const AddCarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddCarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddCarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
