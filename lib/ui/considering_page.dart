import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/ui/show_result_all_by_name_page.dart';
import 'package:roxcrm/ui/show_result_since_page.dart';

class ConsideringPage extends StatelessWidget {
  final String who;
  const ConsideringPage(this.who, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> considerings = [
      "OXIRGI BIR OY",
      "OXIRGI BIR HAFTA",
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
              onPressed: () {
                switch (__) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowResultSincePage(
                          days: -30,
                          who: who,
                        ),
                      ),
                    );

                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowResultAllByNamePage(
                         
                          who: who,
                        ),
                      ),
                    );

                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowResultSincePage(
                          days: -7,
                          who: who,
                        ),
                      ),
                    );

                    break;

                  default:
                    break;
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    gW(10.0),
                  ),
                ),
                primary: mainColor,
                elevation: 0,
                fixedSize: Size(
                  gW(335.0),
                  gH(62.0),
                ),
              ),
              child: Text(
                considerings[__],
                style: TextStyle(fontSize: gW(25.0)),
              ));
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
