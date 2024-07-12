import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:housr_task_project/ui/home_screen.dart';

import '../models/user_model.dart';
import 'bottom_nav_bar.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Box<UserModel> userBox = Hive.box<UserModel>('users');
  final _image = const AssetImage("assets/room3.jpg");

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => userBox.length == 0 ? const LoginScreen() : const BottomNavBar()));
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(_image, context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFc8ae95),
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: "backgroundImage",
              // child: Image.asset(
              //   "assets/room3.jpg",
              //   height: MediaQuery.sizeOf(context).height,
              //   width: MediaQuery.sizeOf(context).width,
              //   fit: BoxFit.cover,
              // ),
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: _image, fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              color: Colors.black38,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/housr_logo.jpg",
                    width: MediaQuery.sizeOf(context).width / 1.7,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    "Experience Luxury",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                        height: 1.0),
                  ),
                  const Text(
                    "Living at Housr",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
