import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/show_toast.dart';
import 'package:roxcrm/core/size_config.dart';

import 'package:roxcrm/providers/employee/get_employee_result_interval_provider.dart';
import 'package:roxcrm/ui/show/show_result_all_by_name_page.dart';
import 'package:roxcrm/ui/show/show_result_interval_page.dart';
import 'package:roxcrm/ui/show/show_result_since_page.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
      body: Column(
        children: [
          ListView.separated(
            padding: EdgeInsets.all(
              gW(20.0),
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) {
              return ElevatedButton(
                  onPressed: () {
                    switch (__) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShowResultSincePage(days: -30, who: who),
                          ),
                        );

                        break;
                      case 1:
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

                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowResultAllByNamePage(who: who)),
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: gW(20.0)),
            decoration: BoxDecoration(
              color:
                  context.watch<GetEmployeeResultIntervalProvider>().collapsed
                      ? whiteColor
                      : mainColor,
              borderRadius: BorderRadius.circular(
                gW(10.0),
              ),
            ),
            child: ExpansionTile(
              collapsedIconColor: Colors.transparent,
              textColor: mainColor,
              collapsedTextColor: whiteColor,
              onExpansionChanged: (v) {
                if (v) {
                  Provider.of<GetEmployeeResultIntervalProvider>(context,
                          listen: false)
                      .changeCallapsed();
                } else {
                  Provider.of<GetEmployeeResultIntervalProvider>(context,
                          listen: false)
                      .changeCallapsed();
                  Provider.of<GetEmployeeResultIntervalProvider>(context,
                          listen: false)
                      .clear();
                }
              },
              initiallyExpanded: Provider.of<GetEmployeeResultIntervalProvider>(
                      context,
                      listen: false)
                  .collapsed,
              children: [
                Divider(
                  color: mainColor,
                ),
                _korishButton(context),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          context
                              .watch<GetEmployeeResultIntervalProvider>()
                              .stringFrom,
                          style: TextStyle(fontSize: gW(18.0))),
                      Text(
                        context
                            .watch<GetEmployeeResultIntervalProvider>()
                            .stringTo,
                        style: TextStyle(fontSize: gW(18.0)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        elevation: 0,
                        fixedSize: Size(
                          gW(150.0),
                          gH(42.0),
                        ),
                      ),
                      onPressed: () {
                        _showDataPicker(true, context);
                      },
                      child: Text(
                        "...dan",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: gW(20.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        elevation: 0,
                        fixedSize: Size(
                          gW(150.0),
                          gH(42.0),
                        ),
                      ),
                      onPressed: () {
                        _showDataPicker(false, context);
                      },
                      child: Text(
                        "...gacha",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: gW(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              title: Text(
                "INTERVAL",
                style: TextStyle(fontSize: gW(25.0)),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  ElevatedButton _korishButton(BuildContext context) {
    return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: mainColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      gW(15.0),
                    ),
                  ),
                  primary: (Provider.of<GetEmployeeResultIntervalProvider>(
                                  context,
                                  listen: false)
                              .stringFrom
                              .isNotEmpty &&
                          Provider.of<GetEmployeeResultIntervalProvider>(
                                  context,
                                  listen: false)
                              .stringTo
                              .isNotEmpty)
                      ? mainColor_02
                      : Colors.grey.shade300,
                  elevation: 0,
                  fixedSize: Size(
                    gW(335.0),
                    gH(42.0),
                  ),
                ),
                onPressed: () {
                  if (Provider.of<GetEmployeeResultIntervalProvider>(context,
                              listen: false)
                          .stringFrom
                          .isNotEmpty &&
                      Provider.of<GetEmployeeResultIntervalProvider>(context,
                              listen: false)
                          .stringTo
                          .isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowResultByNameInterval(
                          from: context
                              .watch<GetEmployeeResultIntervalProvider>()
                              .from,
                          to: context
                              .watch<GetEmployeeResultIntervalProvider>()
                              .to,
                          who: who,
                        ),
                      ),
                    );
                  } else {
                    showToast(
                        '"...dan" va "...gacha" lar ikkalasi ham kiritilishi lozim. Kiritish uchun ustiga bosing.');
                  }
                },
                child: Text(
                  "Ko'rish",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: gW(18.0),
                      letterSpacing: gW(5.0)),
                ),
              );
  }

  _showDataPicker(bool isFrom, BuildContext context) {
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: whiteColor,
        containerHeight: gH(200.0),
        headerColor: mainColor,
        itemStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        doneStyle: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: gW(1.5),
            decoration: TextDecoration.underline),
      ),
      onConfirm: (date) {
        if (isFrom) {
          debugPrint(date.toString());
          Provider.of<GetEmployeeResultIntervalProvider>(context, listen: false)
              .initFrom(date);
        } else {
          Provider.of<GetEmployeeResultIntervalProvider>(context, listen: false)
              .initTo(date);

          debugPrint(date.toString());
        }
      },
      locale: LocaleType.en,
    );
  }

 
}
