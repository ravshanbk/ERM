import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/creteria_model.dart';
import 'package:roxcrm/providers/checking_provider.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class CheckingPage extends StatelessWidget {
  final String employeeName;

  const CheckingPage({required this.employeeName,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        title: Text(employeeName),
        actions: [
          SubmitButtonForAppBar(
            onPressed: () {
              
            },
          )
        ],
      ),
      body: ValueListenableBuilder<Box<Criteria>>(
        valueListenable: Boxes.getCriterias().listenable(),
        builder: (context, box, __) {
          final List<Criteria> data = box.values.cast<Criteria>().toList();

          return Padding(
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
        expandedAlignment: Alignment.topCenter,
        childrenPadding:
            EdgeInsets.only(left: gW(20.0), right: gW(20.0), bottom: gW(20.0)),
        leading: IconButton(
          onPressed: () {
            context.read<CheckingProvider>().submitFunction(__);
          },
          icon: context.watch<CheckingProvider>().criteries[__]
              ? Icon(
                  Icons.check,
                  color: Colors.green,
                  size: gW(45.0),
                )
              : Ink(
                  height: gW(52.0),
                  width: gW(52.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: gW(3.0)),
                    borderRadius: BorderRadius.circular(
                      gW(26.0),
                    ),
                  ),
                ),
        ),
        title: Text(
          data.criteriaLetter,
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
