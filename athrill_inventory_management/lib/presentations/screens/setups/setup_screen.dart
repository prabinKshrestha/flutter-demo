import 'package:flutter/material.dart';

import 'package:aim/presentation_constants/presentation_contants_barrel.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AIMColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text('Welcome', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Bring store to your pocket', style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(height: 80),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image(image: AssetImage("assets/images/setup.png")),
            ),
            SizedBox(height: 80),
            GestureDetector(
              onTap: () {
                Future.delayed(
                  Duration(milliseconds: 1),
                  () => Navigator.pushNamed(context, "/firm-registration"),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Register Firm', style: TextStyle(fontSize: 14, color: AIMColors.primaryColor)),
                    SizedBox(width: 10),
                    Icon(Icons.account_balance, color: AIMColors.primaryColor),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Future.delayed(
                  Duration(milliseconds: 1),
                  () => Navigator.pushNamed(context, "/login"),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Already Setup ? Sign In', style: TextStyle(fontSize: 14, color: AIMColors.primaryColor)),
                    SizedBox(width: 10),
                    Icon(Icons.login, color: AIMColors.primaryColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
