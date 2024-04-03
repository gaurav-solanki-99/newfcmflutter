import 'package:fcmapp/Services/FirebaseServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SecondScreeen extends StatefulWidget {
  const SecondScreeen({Key? key}) : super(key: key);

  @override
  State<SecondScreeen> createState() => _SecondScreeenState();
}

class _SecondScreeenState extends State<SecondScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Text(Get.find<MyRedirectionService>().data.value),
        ),
      ),
    );
  }
}
