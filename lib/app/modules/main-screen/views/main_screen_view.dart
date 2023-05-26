import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_screen_controller.dart';

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MainScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
