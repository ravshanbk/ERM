import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/result_model.dart';
import 'package:roxcrm/services/post_result_service.dart';

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
        title: Text(who),
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
                      title: Text(data[__].when!,textAlign: TextAlign.center,style: TextStyle(fontSize: gW(25.0),fontWeight: FontWeight.bold),),
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
          }),
    );
  }

  _viewChild(
    Result data,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return Ink(
          decoration: BoxDecoration(
            border: Border.all(
              color: mainColor,
            ),
            borderRadius: BorderRadius.circular(
              gW(10.0),
            ),
          ),
          child: ExpansionTile(
            leading: Icon(
              data.result![0].done! ? Icons.check : Icons.brightness_1,
              color: Colors.green,
              size: gW(45.0),
            ),
            title: Text(data.result![__].context!),
            children: List.generate(
              data.result!.length,
              (index) {
                return Text(data.result![index].context!);
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: gH(20.0));
      },
      itemCount: data.result!.length,
    );
  }
}
