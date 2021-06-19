part of '../home_screen.dart';

class HomeModuleItemModel {
  final String text;
  final IconData iconData;
  final String routeName;

  const HomeModuleItemModel({
    required this.text,
    required this.iconData,
    required this.routeName,
  });
}

const List<HomeModuleItemModel> HOME_MODULE_ITEM_COLLECTION = [
  HomeModuleItemModel(text: "Personal Transaction", iconData: Icons.sync_alt, routeName: "/transaction"),
  HomeModuleItemModel(text: "Card", iconData: Icons.credit_card, routeName: "/card"),
  HomeModuleItemModel(text: "Reports", iconData: Icons.report, routeName: "/transaction-report"),
  HomeModuleItemModel(text: "Card", iconData: Icons.account_balance_wallet, routeName: "/card"),
  HomeModuleItemModel(text: "Transaction", iconData: Icons.account_balance, routeName: "/transaction"),
];
