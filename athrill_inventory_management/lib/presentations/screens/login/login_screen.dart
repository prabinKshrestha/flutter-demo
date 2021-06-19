import 'package:aim_business/business.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import 'package:aim/presentation_constants/color_constant.dart';

part 'components/form_field_container.dart';
part 'components/local_auth_container.dart';
part 'components/login_form.dart';
part 'components/login_methods.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state is AuthenticationStateAuthenticated) {
          // For the current business of authentication; this path will never hit
          Future.delayed(
            Duration(milliseconds: 1),
            () => Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: _size.height,
            width: _size.width,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    child: Container(
                      height: _size.height * 0.8,
                      width: _size.width * 0.8,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.9),
                          boxShadow: [BoxShadow(color: AIMColors.primaryColor.withOpacity(0.5), blurRadius: 2)]),
                      child: Column(
                        children: [
                          Container(
                            height: 5,
                            width: _size.width * 0.8 * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
                              color: AIMColors.secondaryColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          Icon(Icons.account_circle, size: 120, color: AIMColors.primaryColor),
                          SizedBox(height: 10),
                          Text(
                            "Sign In to Start your Session",
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 0.5, color: AIMColors.primaryColor),
                          ),
                          SizedBox(height: 40),
                          LoginForm(),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(fontSize: 15, color: AIMColors.primaryColor, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 40),
                          LocalAuthContainer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
