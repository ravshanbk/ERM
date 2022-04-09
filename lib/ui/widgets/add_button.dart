import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const AddButton({required this.onPressed, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: mainColor_02,
        elevation: 0,
        fixedSize: Size(gW(185.0), gH(50.0)),
        shape: RoundedRectangleBorder(
          side:const  BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(
            gW(20.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: gW(30.0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
