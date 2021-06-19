import 'package:aim/presentations/screens/setups/firm_registration_screen.dart';
import 'package:flutter/material.dart';

import 'package:aim/presentations/screens/screens.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/setup':
        return MaterialPageRoute(builder: (_) => SetupScreen());
      case '/firm-registration':
        return MaterialPageRoute(builder: (_) => FirmRegistrationScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/transaction':
        return MaterialPageRoute(builder: (_) => TransactionScreen());
      case '/transaction-report':
        return MaterialPageRoute(builder: (_) => TransactionReportScreen());
      case '/card':
        return MaterialPageRoute(builder: (_) => CardScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
