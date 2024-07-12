import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithGoogleEvent extends LoginEvent {
  @override
  List<Object> get props => [];

  const LoginWithGoogleEvent();
}

class LogoutEvent extends LoginEvent {
  @override
  List<Object> get props => [];

  const LogoutEvent();
}