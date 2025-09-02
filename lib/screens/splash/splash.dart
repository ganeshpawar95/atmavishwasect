import 'package:atmavishwasect/screens/home/home_screen.dart';
import 'package:atmavishwasect/utilites/helper.dart';
import 'package:atmavishwasect/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void init() async {
    Future.delayed(Duration(seconds: 3), () async {
      Helper.toRemoveUntiScreen(context, HomeScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Color for Android
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      sized: false,
      child: Scaffold(
        //  backgroundColor: kPrimaryColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: CustomText(title: "Welcome to Atmavishwas")),
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     fit: BoxFit.cover,
          //     image: AssetImage("assets/images/splash.jpeg"),
          //   ),
          // ),
        ),
      ),
    );
  }
}
