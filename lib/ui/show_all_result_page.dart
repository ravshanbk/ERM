import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/result_model.dart';
import 'package:roxcrm/services/post_result_service.dart';

class ShowResultAllPage extends StatelessWidget {
  final int days;
  final String who;

  const ShowResultAllPage({required this.days, required this.who, Key? key})
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
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: gW(50.0),
              ),
            );
          } else if (snap.connectionState == ConnectionState.done) {
            List<Result> data = snap.data!;

            return ListView.separated(
              padding: EdgeInsets.all(gW(20.0)),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, __) {
                return Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(gW(10.0)),
                    border: Border.all(
                      color: mainColor,
                    ),
                  ),
                  child: ExpansionTile(
                    iconColor: whiteColor,
                    textColor: whiteColor,
                    backgroundColor: mainColor_02,
                    title: Text(
                      data[__].when!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: gW(25.0), fontWeight: FontWeight.bold),
                    ),
                    children: List.generate(
                        data[__].result!.length,
                        (index) => ExpansionTile(
                              leading: Icon(
                                data[__].result![index].done!
                                    ? Icons.check
                                    : Icons.panorama_fish_eye,
                                color: Colors.green,
                                size: gW(45.0),
                              ),
                              title: Text(data[__].result![index].letter!),
                              children: [
                                Text(data[__].result![index].context!)
                              ],
                            )),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                // debugPrint(  DateTime.parse(ObjectId.fromTimestamp(DateTime.now()).toString()).toIso8601String());
                return SizedBox(
                  height: gH(20.0),
                  child: Text(data[index].id.toString()),
                );
              },
              itemCount: data.length,
            );
          } else {
            return Center(
              child: Text(snap.connectionState.toString()),
            );
          }
        },
      ),
    );
  }
}
