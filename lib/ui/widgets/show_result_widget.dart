import 'package:flutter/material.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/result_model.dart';

class ShowResultWidget extends StatelessWidget {
  final List<Result> data;
  const ShowResultWidget(this.data,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      padding: EdgeInsets.all(gW(20.0)),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(gW(10.0)),
            border: Border.all(
              color: mainColor,
            ),
          ),
          child: ExpansionTile(
            iconColor: Colors.black,
            textColor: Colors.black,
            backgroundColor: mainColor_02,
            title: Text(
              data[__].when!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: gW(25.0), fontWeight: FontWeight.bold),
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
                children: [Text(data[__].result![index].context!)],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: gH(20.0),
        );
      },
      itemCount: data.length,
    );
    
  }
}
