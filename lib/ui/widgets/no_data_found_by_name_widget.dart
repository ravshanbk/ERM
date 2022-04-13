import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/extentions_my.dart';
import 'package:roxcrm/core/size_config.dart';

class NoDataFoundByNameWidget extends StatelessWidget {
  final String who;
  const NoDataFoundByNameWidget(this.who,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(fontSize: gW(25.0), color: mainColor),
          children: [
            TextSpan(
              text: capitalizer(who) + "ga",
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            const TextSpan(
              text: " tegishli natijalar topilmadi !",
            ),
          ],
        ),
      ),
    );
  }
}
