import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/main.dart';
import 'package:roxcrm/ui/widgets/bordered_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sozlamalar",
          style: TextStyle(
            color: mainColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
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
