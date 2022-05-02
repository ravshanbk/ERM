import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';

class SubmitButtonForAppBar extends StatelessWidget {
  final bool idf;
  final VoidCallback onPressed;
  const SubmitButtonForAppBar(this.idf,{required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: gH(8), right: gW(15.0), bottom: gH(8)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(gW(100.0), gH(50.0)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(gW(15.0)),
              side: const BorderSide(color: Colors.black)),
          primary: Colors.white,
        ),
        onPressed:idf?null : onPressed,
        child: Text(
          "Submit",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
