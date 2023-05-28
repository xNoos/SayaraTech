import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BookingsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
