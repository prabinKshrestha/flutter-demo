part of '../home_screen.dart';

/// Widget used for Module Item shown in Home Screen
class HomeModuleItem extends StatelessWidget {
  final HomeModuleItemModel item;

  const HomeModuleItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(item.routeName),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(color: AIMColors.primaryColor),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(item.iconData, size: 30, color: AIMColors.primaryColor),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            height: 30,
            child: Text(item.text, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
