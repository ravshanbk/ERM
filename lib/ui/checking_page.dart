import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/creteria_model.dart';
import 'package:roxcrm/models/result_model.dart';
import 'package:roxcrm/providers/checking_provider.dart';
import 'package:roxcrm/services/result_service.dart';
import 'package:roxcrm/ui/settings/criteria_settings.dart';
import 'package:roxcrm/ui/widgets/add_button.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class CheckingPage extends StatelessWidget {
  final String employeeName;

  const CheckingPage({required this.employeeName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<CheckingProvider>(context, listen: false)
            .changeIsInProgress(false);
        Provider.of<CheckingProvider>(context, listen: false).clearCriterias();
        Navigator.pop(context);

        return Future.value(true);
      },
      child: Scaffold(
        appBar: _appBar(context),
        body: ValueListenableBuilder<Box<Criteria>>(
          valueListenable: Boxes.getCriterias().listenable(),
          builder: (context, box, __) {
            final List<Criteria> data = box.values.cast<Criteria>().toList();

            return data.isEmpty
                ? _noDataWidget(context)
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: gW(25.0)),
                    child: ListView.separated(
                        padding: EdgeInsets.only(top: gW(20.0)),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, __) {
                          return _viewChild(context, data[__], __);
                        },
                        separatorBuilder: (_, __) {
                          return SizedBox(
                            height: gH(20.0),
                          );
                        },
                        itemCount: data.length),
                  );
          },
        ),
      ),
    );
  }

  Center _noDataWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Birorta Ham Mezon Mavjud Emas. Sozlamalar Bo'limiga O'tib Mezon Qo'shing !",
              textAlign: TextAlign.center,
              style: TextStyle(color: mainColor, fontSize: gW(22.0)),
            ),
            SizedBox(height: gH(20.0)),
            AddButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CriteriaSettingsPage(),
                  ),
                );
              },
              label: "O'tish",
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: mainColor,
      title: Text(employeeName),
      actions: [
        SubmitButtonForAppBar(
          context.watch<CheckingProvider>().isInProgress,
          onPressed: () async {
            Provider.of<CheckingProvider>(context, listen: false)
                .changeIsInProgress(true);
            try {
////////////////////////////////////////
              List<Criteria> criterias =
                  Boxes.getCriterias().values.cast<Criteria>().toList();

              List<ResultElement> result =
                  List.generate(criterias.length, (__) {
                return ResultElement(
                  letter: criterias[__].criteriaLetter,
                  context: criterias[__].criteriaText,
                  done: Provider.of<CheckingProvider>(context, listen: false)
                      .criteries[__],
                );
              });
///////////////////////////////////////////////
              ResultService()
                  .postResult(
                Result(
                  result: result,
                  when: DateTime.now().millisecondsSinceEpoch,
                  who: employeeName,
                ),
              )
                  .then((value) {
                if (value.success) {
                  Provider.of<CheckingProvider>(context, listen: false)
                      .changeIsInProgress(false);

                  Provider.of<CheckingProvider>(context, listen: false)
                      .clearCriterias();

                  ScaffoldMessenger.of(context).showSnackBar(
                    _snakBar(true, value.text),
                  );
                  Navigator.pop(context);
                } else {
                  Provider.of<CheckingProvider>(context, listen: false)
                      .changeIsInProgress(false);

                  ScaffoldMessenger.of(context).showSnackBar(
                    _snakBar(false, value.text),
                  );
                }
              });
            } catch (e) {
              throw Exception("Checking Page Submit: " + e.toString());
            }
          },
        )
      ],
    );
  }

  SnackBar _snakBar(bool success, String text) {
    return SnackBar(
      dismissDirection: DismissDirection.endToStart,
      backgroundColor: whiteColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: gH(600.0),
        left: gW(50.0),
        right: gW(50.0),
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: success ? Colors.green : Colors.red,
          fontSize: gW(30.0),
        ),
      ),
    );
  }

  _viewChild(BuildContext context, Criteria data, int __) {
    return Ink(
      decoration: BoxDecoration(
      
        border: Border.all(color: mainColor),
        borderRadius: BorderRadius.circular(
          gW(10.0),
        ),
      ),
      child: ExpansionTile(
        collapsedIconColor: mainColor,
        iconColor: mainColor,
       
        backgroundColor: Colors.white,
        expandedAlignment: Alignment.topCenter,
        childrenPadding:
            EdgeInsets.only(left: gW(20.0), right: gW(20.0), bottom: gW(20.0)),
        leading: TextButton(
            style: TextButton.styleFrom(shadowColor: whiteColor,elevation: 0), 
              onPressed: () {
                context.read<CheckingProvider>().submitFunction(__);
              },
              child: Icon(
                context.watch<CheckingProvider>().criteries[__]
                    ? Icons.add
                    : Icons.check_box_outline_blank,
                color: Colors.cyan,
                size: gW(45.0),
              ),
            ),
        title: Text(
          data.criteriaLetter,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: gW(20.0),
          ),
        ),
        children: [
          const Divider(),
          Text(
            data.criteriaText,
            style: TextStyle(fontSize: gW(18.0)),
          )
        ],
      ),
    );
  }
}
