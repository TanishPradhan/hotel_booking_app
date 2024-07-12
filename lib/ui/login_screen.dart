import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:housr_task_project/bloc/login/login_bloc.dart';
import 'package:housr_task_project/bloc/login/login_events.dart';
import 'package:housr_task_project/bloc/login/login_states.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/ui/bottom_nav_bar.dart';
import 'package:housr_task_project/ui/home_screen.dart';

import '../reusable_widgets/loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final _image = const AssetImage("assets/room3.jpg");

  @override
  void initState() {
    // precacheImage(_image, context);
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(_image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFc8ae95),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginStates>(
          listener: (BuildContext context, LoginStates state) {
            if (state is LoadingLoginWithGoogleState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const LoaderDialog();
                  });
            }
            if (state is SuccessLoginWithGoogleState) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BottomNavBar()));
            }
            if (state is ErrorLoginWithGoogleState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Encountered Error Logging you in.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  elevation: 5.0,
                  showCloseIcon: true,
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: [
                  Hero(
                    tag: "backgroundImage",
                    // child: Image.asset(
                    //   _image,
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.05),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Find your Best Hotel",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Indulge in the ultimate luxury of managed living at Housr.",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white60,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),),
                                contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 16.0,),
                            TextField(
                              obscureText: true,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),),
                                contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 24.0,),
                            GestureDetector(
                              onTap: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Row(
                                      children: [
                                        Icon(Icons.warning_amber, color: Colors.black54, size: 25.0,),
                                        SizedBox(width: 14.0),
                                        Expanded(
                                          child: Text(
                                            "This is a dummy button, use Google Login to continue...",
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                    closeIconColor: Colors.black54,
                                    showCloseIcon: true,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.yellow.shade800,
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: primaryColor,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: MediaQuery.sizeOf(context).width / 2.8, child: Divider(height: 1.0, thickness: 1.0, color: Colors.white30,)),
                                const Text("OR", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.white30),),
                                SizedBox(width: MediaQuery.sizeOf(context).width / 2.8, child: Divider(height: 1.0, thickness: 1.0, color: Colors.white30,)),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            GestureDetector(
                              onTap: () async {
                                _loginBloc.add(const LoginWithGoogleEvent());
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: primaryColor.withOpacity(0.3),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/google.png", height: 30, width: 30,),
                                      const SizedBox(width: 20.0,),
                                      const Text(
                                        "Login with Google",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
