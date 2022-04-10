import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';

class BorderedButton extends StatelessWidget {
  final String title;
 final VoidCallback onPressed;
  const BorderedButton(this.title, {required this.onPressed,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(gW(150.0), gW(130.0)),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: mainColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(gW(20.0)),
            bottomRight: Radius.circular(gW(20.0)),
            bottomLeft: Radius.circular(gW(50.0)),
            topRight: Radius.circular(gW(50.0)),
          ),
        ),
        primary: mainColor_02,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
            fontSize: gW(30.0), fontWeight: FontWeight.w700, color: mainColor),
      ),
    );
  }
}
