abstract class LoginStates {
  const LoginStates();
}

class InitialLoginState extends LoginStates {
  const InitialLoginState();
}

class LoadingLoginWithGoogleState extends LoginStates {
  const LoadingLoginWithGoogleState();
}

class SuccessLoginWithGoogleState extends LoginStates {
  const SuccessLoginWithGoogleState();
}

class ErrorLoginWithGoogleState extends LoginStates {
  const ErrorLoginWithGoogleState();
}

class LoadingLogoutState extends LoginStates {
  const LoadingLogoutState();
}

class SuccessLogoutState extends LoginStates {
  const SuccessLogoutState();
}

class ErrorLogoutState extends LoginStates {
  const ErrorLogoutState();
}