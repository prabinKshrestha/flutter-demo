import 'package:flutter/material.dart';

Future<void> showMoreActionDialog(BuildContext context, {required List<MoreActionItemModel> items, required RelativeRect position}) async {
  int? actionItemId = await showMenu(context: context, position: position, items: _getPopUpItems(items), elevation: 20);
  if (actionItemId != null) {
    MoreActionItemModel item = items[actionItemId - 1];
    item.action();
  }
}

List<PopupMenuItem<int>> _getPopUpItems(List<MoreActionItemModel> items) {
  List<PopupMenuItem<int>> retVal = [];
  for (int i = 0; i < items.length; i++) {
    retVal.add(PopupMenuItem<int>(
      value: i + 1,
      child: items[i].content,
    ));
  }
  return retVal;
}

class MoreActionItemModel {
  final Widget content;
  final Function action;

  MoreActionItemModel({required this.content, required this.action});
}
