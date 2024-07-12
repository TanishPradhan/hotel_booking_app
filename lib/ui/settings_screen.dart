import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:housr_task_project/bloc/login/login_bloc.dart';
import 'package:housr_task_project/bloc/login/login_states.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/constants/widget_constants.dart';
import 'package:housr_task_project/reusable_widgets/loader.dart';
import 'package:housr_task_project/reusable_widgets/setting_screen_cards.dart';
import 'package:housr_task_project/ui/login_screen.dart';
import 'package:housr_task_project/ui/past_bookings_screen.dart';

import '../bloc/login/login_events.dart';
import '../models/user_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late LoginBloc _loginBloc;
  Box<UserModel> userBox = Hive.box<UserModel>('users');

  @override
  void initState() {
    _loginBloc = LoginBloc();
    debugPrint("User Box Length: ${userBox.length}");
    debugPrint("User Box Length: ${userBox.getAt(0)!.name!}");
    debugPrint("User Box Length: ${userBox.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onTap() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Coming soon...",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          closeIconColor: Colors.white,
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor.withOpacity(0.9),
        ),
      );
    }

    return Scaffold(
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginStates>(
          listener: (BuildContext context, LoginStates state) {
            if (state is LoadingLogoutState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const LoaderDialog();
                },
              );
            }
            if (state is SuccessLogoutState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false);
              userBox.clear();
              debugPrint("User Box Length: ${userBox.length}");
            }
            if (state is ErrorLogoutState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Encountered Error Logging you out.",
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
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "DisplayPicture",
                        child: CachedNetworkImage(
                          imageUrl: userBox.getAt(0)!.displayPicture!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => imageWidget(60),
                          errorWidget: (context, url, error) => imageWidget(60),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        userBox.getAt(0)!.name!,
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        userBox.getAt(0)!.email!,
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Divider(color: Colors.black12, height: 1.0, thickness: 1.0,),
                      const SizedBox(height: 20.0,),
                      SettingsScreenCard(
                          icon: Icons.edit, text: "Edit Profile", onTap: onTap),
                      // SettingsScreenCard(
                      //     icon: Icons.mode_of_travel_outlined,
                      //     text: "My Bookings",
                      //     onTap: () {
                      //       Navigator.push(context, MaterialPageRoute(builder: (_) => const PastBookingsScreen()));
                      //     }),
                      SettingsScreenCard(
                          icon: Icons.lock,
                          text: "Change Password",
                          onTap: onTap),
                      SettingsScreenCard(
                          icon: Icons.call, text: "Contact us", onTap: onTap),
                      SettingsScreenCard(
                          icon: Icons.settings, text: "Settings", onTap: onTap),
                      SettingsScreenCard(
                        icon: Icons.logout_rounded,
                        text: "Logout",
                        onTap: () {
                          _loginBloc.add(const LogoutEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
