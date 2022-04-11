import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/result_model.dart';
import 'package:roxcrm/services/post_result_service.dart';

class ShowResultSincePage extends StatelessWidget {
  
  const ShowResultSincePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: ResultService().getResultsSince(DateTime.now()),
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
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, __) {
                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data[__].result!.length,
                        itemBuilder: (con, n) {
                          return ListTile(
                            leading: IconButton(
                              onPressed: () {},
                              icon: data[__].result![n].done!
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: gW(45.0),
                                    )
                                  : Ink(
                                      height: gW(52.0),
                                      width: gW(52.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green,
                                            width: gW(3.0)),
                                        borderRadius: BorderRadius.circular(
                                          gW(26.0),
                                        ),
                                      ),
                                    ),
                            ),
                            title: Text(data[__].result![n].context!),
                          );
                        },
                        separatorBuilder: (c, n) {
                          return Divider(color: mainColor);
                        },
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: gH(20.0),
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
}
