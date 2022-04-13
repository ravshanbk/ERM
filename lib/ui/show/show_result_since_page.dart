import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/result_model.dart';
import 'package:roxcrm/services/result_service.dart';
import 'package:roxcrm/ui/widgets/no_data_found_by_name_widget.dart';
import 'package:roxcrm/ui/widgets/show_result_widget.dart';

class ShowResultSincePage extends StatelessWidget {
  final int days;
  final String who;

  const ShowResultSincePage({required this.days, required this.who, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("uuuwho"),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: ResultService()
            .getResultsSince(DateTime.now().add(Duration(days: days)), who),
        builder: (context, AsyncSnapshot<List<Result>> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: gW(50.0),
              ),
            );
          } else if (snap.connectionState == ConnectionState.done &&
              snap.hasData) {
            return ShowResultWidget(snap.data!);
          } else {
            return NoDataFoundByNameWidget(who);
          }
        },
      ),
    );
  }
}
