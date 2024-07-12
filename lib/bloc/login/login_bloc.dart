import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:housr_task_project/bloc/login/login_events.dart';
import 'package:housr_task_project/bloc/login/login_states.dart';
import '../../models/user_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  LoginBloc() : super(const InitialLoginState()) {
    Box<UserModel> userBox = Hive.box<UserModel>('users');

    on<LoginWithGoogleEvent>((event, emit) async {
      emit(const LoadingLoginWithGoogleState());

      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final user = await FirebaseAuth.instance.currentUser;
        // print(user?.uid);
        debugPrint("User Logged in");

        debugPrint("User: ${user?.email}");
        debugPrint(userCredential.toString());

        debugPrint("User: ${user?.displayName}, ${user?.email}, ${user?.photoURL}");


        await userBox.put('user', UserModel(user?.displayName, user?.email, user?.photoURL));

        debugPrint("User Box Length: ${userBox.length}");

        if (user != null && userBox.isNotEmpty) {
          emit(const SuccessLoginWithGoogleState());
        } else {
          emit(const ErrorLoginWithGoogleState());
        }

      } on Exception catch (e) {
        emit(const ErrorLoginWithGoogleState());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(const LoadingLogoutState());
      try {
        await FirebaseAuth.instance.signOut();
        emit(const SuccessLogoutState());
      } on Exception catch (e) {
        emit(const ErrorLogoutState());
      }
    });
  }
}
