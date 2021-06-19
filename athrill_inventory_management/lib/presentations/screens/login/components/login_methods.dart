part of '../login_screen.dart';

Future<bool> _authenticateUser(LocalAuthentication localAuthentication) async {
  bool isAuthenticated = false;
  try {
    isAuthenticated = await localAuthentication.authenticate(
      localizedReason: "Authenticate with your Fingerprint.",
      androidAuthStrings: AndroidAuthMessages(cancelButton: "Cancel", signInTitle: "Athrill Inventory Management"),
      stickyAuth: true,
    );
  } on PlatformException catch (e) {
    print(e.code);
  }
  return isAuthenticated;
}
