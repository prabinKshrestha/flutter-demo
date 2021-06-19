import 'package:aim_business/business.dart';
import 'package:aim/presentation_constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/home_module_item.dart';
part 'components/home_module_item_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationStateUnAuthenticated) {
          Future.delayed(Duration(seconds: 1), () => Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Athrill Inventory"),
          titleSpacing: 25,
          elevation: 0,
        ),
        body: Container(
          width: _size.width,
          height: _size.height,
          child: Stack(
            children: [
              Container(
                width: _size.width,
                height: 120,
                decoration: BoxDecoration(color: AIMColors.primaryColor),
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bring Account to Your Wallet", style: TextStyle(color: Colors.white, fontSize: 13.5, letterSpacing: 1)),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 55,
                width: _size.width,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _size.width * 0.87,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 4)),
                      ],
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 20,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                      children:
                          List.generate(HOME_MODULE_ITEM_COLLECTION.length, (index) => HomeModuleItem(item: HOME_MODULE_ITEM_COLLECTION[index])),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
