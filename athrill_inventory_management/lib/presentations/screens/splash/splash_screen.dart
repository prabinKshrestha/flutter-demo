import 'package:aim_business/business.dart';
import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aim/presentation_constants/presentation_contants_barrel.dart';

// todo : find the solution to change the system status bar and system navigation bar
// following code can be used and workds property, but it affects other screens
// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     // statusBarColor: AIMColors.primaryColor,
//     // systemNavigationBarColor: AIMColors.primaryColor,
//     ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> anotherAnimation;

  @override
  void initState() {
    super.initState();
    _setAnimation();
    //Instead of redirecting directly to login screen, we are calling start event so that we use it in future reference.
    //We can pop to login screen as per business instead of raising event
    new Future.delayed(
      const Duration(seconds: AppConstant.SPLASH_SCREEN_HOLD_TIME_IN_SECOND),
      () async {
        if (await context.read<FirmContextStore>().hasUserContext()) {
          context.read<AuthenticationBloc>().add(AuthenticationEventStart());
        } else {
          Navigator.pushNamedAndRemoveUntil(context, "/setup", (_) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        // As per current business of authentication; this path will never hit
        if (state is AuthenticationStateAuthenticated) {
          Future.delayed(
            Duration(milliseconds: 1),
            () => Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false),
          );
        }
        if (state is AuthenticationStateUnAuthenticated) {
          Future.delayed(
            Duration(milliseconds: 1),
            () => Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AIMColors.primaryColor,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 150),
              Text('AIM', style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold)),
              Text(
                'Athrill Inventory Management',
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1),
              ),
              SizedBox(height: 250),
              ScaleTransition(
                scale: anotherAnimation,
                child: SizedBox(height: 60, width: 60, child: Image.asset('assets/images/open-box.png')),
              ),
              Spacer(),
              Text(
                'Athrill Technology',
                style: TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 1),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _setAnimation() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    anotherAnimation = Tween(begin: 0.4, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.elasticOut))
      ..addListener(() => setState(() {}));
    animationController.repeat(reverse: true);
  }
}
