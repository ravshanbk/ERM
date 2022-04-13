import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/ui/widgets/bordered_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: whiteColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BorderedButton(
                "Xodim",
                onPressed: () {
                  Navigator.pushNamed(context, "/employee");
                },
              ),
              BorderedButton(
                "Mezon",
                onPressed: () {
                  Navigator.pushNamed(context, "/criterias");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
