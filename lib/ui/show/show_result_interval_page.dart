import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/result_model.dart';
import 'package:roxcrm/providers/employee/get_employee_result_interval_provider.dart';
import 'package:roxcrm/services/result_service.dart';
import 'package:roxcrm/ui/widgets/no_data_found_by_name_widget.dart';
import 'package:roxcrm/ui/widgets/show_result_widget.dart';

class ShowResultByNameInterval extends StatelessWidget {
  final String who;
  final DateTime from;
  final DateTime to;

  const ShowResultByNameInterval(
      {required this.from, required this.to, required this.who, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(who),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: ResultService().getResultByNameInterval(from, to, who),
        builder: (context, AsyncSnapshot<List<Result>> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: gW(50.0),
              ),
            );
          } else if (snap.connectionState == ConnectionState.done &&
              snap.data!.isNotEmpty) {
            context.read<GetEmployeeResultIntervalProvider>().clear();
            return ShowResultWidget(snap.data!);
          } else {
            context.read<GetEmployeeResultIntervalProvider>().clear();

            return NoDataFoundByNameWidget(who);
          }
        },
      ),
    );
  }
}
