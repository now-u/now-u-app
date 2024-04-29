sealed class StartupState {
  const StartupState();
}

class Loading extends StartupState {
  const Loading();
}

class Error extends StartupState {
  final String message;

  const Error({required this.message});
}
