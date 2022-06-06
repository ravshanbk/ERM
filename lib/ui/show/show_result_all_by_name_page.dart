import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/result_model.dart';
import 'package:roxcrm/services/result_service.dart';
import 'package:roxcrm/ui/widgets/no_data_found_by_name_widget.dart';
import 'package:roxcrm/ui/widgets/show_result_widget.dart';

class ShowResultAllByNamePage extends StatelessWidget {
  final String who;

  const ShowResultAllByNamePage({required this.who, Key? key})
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
        future: ResultService().getResultAllByName(who),
        builder: (context, AsyncSnapshot<List<Result>> snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (snap.data!.isEmpty) {
              return NoDataFoundByNameWidget(who);
            }
            return ShowResultWidget(snap.data!);
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                radius: gW(50.0),
              ),
            );
          }
        },
      ),
    );
  }
}
