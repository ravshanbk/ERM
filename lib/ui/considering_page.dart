import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';

class ConsideringPage extends StatelessWidget {
  final String who;
  const ConsideringPage(this.who, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> considerings = [
      "OXIRGI BIR OY",
      "OXIRGI BIR HAFTA",
      "O'RTACHA UMUMIY",
      "HAMMASI"
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text(
          who,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(
          gW(20.0),
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, __) {
          return ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    gW(10.0),
                  ),
                ),
                primary: mainColor_02,
                elevation: 0,
                fixedSize: Size(
                  gW(335.0),
                  gH(62.0),
                ),
              ),
              child: Text(considerings[__],style: TextStyle(fontSize: gW(25.0)),));
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(20.0),
          );
        },
        itemCount: considerings.length,
      ),
    );
  }
}
