import 'package:flutter/material.dart';

class ATLoaderWidget extends StatelessWidget {
  const ATLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5)],
          ),
          child: SizedBox(width: 27, height: 27, child: CircularProgressIndicator(strokeWidth: 3)),
        ),
      ],
    );
  }
}
