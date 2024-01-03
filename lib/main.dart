import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantarainfra_test/controller/data_controller.dart';
import 'package:nusantarainfra_test/screen/login_screen.dart';
import 'package:nusantarainfra_test/services/api_service.dart';

void main() {
  Get.put(ApiService());
  Get.put(DataController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 19, 31, 137)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
