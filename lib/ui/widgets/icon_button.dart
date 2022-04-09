import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';

class IconButtonMy extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const IconButtonMy({required this.icon, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Ink(
            height: gW(50.0),width: gW(50.0),
            decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.circular(
                gW(25.0),
              ),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(icon,color: mainColor,),
            ),
          );
  }
}
