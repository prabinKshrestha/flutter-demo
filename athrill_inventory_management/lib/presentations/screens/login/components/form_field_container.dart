part of '../login_screen.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;

  const FormFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: AIMColors.secondaryColor), borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
