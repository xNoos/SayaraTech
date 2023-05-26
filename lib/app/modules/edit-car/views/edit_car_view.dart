import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_car_controller.dart';

class EditCarView extends GetView<EditCarController> {
  const EditCarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditCarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditCarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
