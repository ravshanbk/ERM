import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/models/employee_model.dart';
import 'package:roxcrm/ui/checking_page.dart';
import 'package:roxcrm/ui/considering_page.dart';
import 'package:roxcrm/ui/widgets/add_button.dart';

class MyHomePage extends StatelessWidget {
  final bool isHome;

  const MyHomePage(this.isHome, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Ink(
      color: isHome ? mainColor : whiteColor,
      child: ValueListenableBuilder<Box<Employee>>(
        valueListenable: Boxes.getEmployee().listenable(),
        builder: (context, box, __) {
          final List<Employee> data = box.values.cast<Employee>().toList();
          return data.isEmpty
              ? _noDataWidget(context)
              : _mainWidget(context, data);
        },
      ),
    );
  }

  Center _noDataWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: gH(40.0),
          ),
          Text(
            "Birorta ham xodim mavjud emas. Qo'shish uchun quyidagi tugmani bosing",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isHome ? Colors.white : mainColor,
                fontSize: gW(18.0),
                letterSpacing: 2,
                wordSpacing: 3),
          ),
          SizedBox(
            height: gH(40.0),
          ),
          AddButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/addEmployee",
                );
              },
              label: "+"),
        ],
      ),
    );
  }

  Center _mainWidget(BuildContext context, List<Employee> data) {
    return Center(
      child: ListView.separated(
        padding: EdgeInsets.all(gW(20.0)),
        separatorBuilder: (_, __) {
          return SizedBox(
            height: gH(20.0),
          );
        },
        itemCount: data.length,
        itemBuilder: (_, __) {
          return _viewChild(context, data, __);
        },
      ),
    );
  }

  _viewChild(BuildContext context, List<Employee> data, int __) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => isHome
                ? CheckingPage(employeeName: data[__].name.capitalize())
                : ConsideringPage(data[__].name.capitalize()),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: mainColor_02,
        elevation: 0,
        fixedSize: Size(
          gW(335.0),
          gH(80.0),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: whiteColor),
          borderRadius: BorderRadius.circular(
            gW(45.0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: gW(55.0),
            width: gW(55.0),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(
                gW(30.0),
              ),
            ),
            child: Text(
              data[__].name[0].toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                height: gW(1.17),
                fontSize: gW(45.0),
                fontWeight: FontWeight.w600,
                color: mainColor,
              ),
            ),
          ),
          SizedBox(width: gW(20.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data[__].name.length > 9
                    ? data[__].name.capitalize().substring(0, 8) + "..."
                    : data[__].name.capitalize(),
                style: TextStyle(color: Colors.white, fontSize: gW(38.0)),
              ),
              Text(
                "${data[__].age} / ${data[__].phoneNumber}",
                style: const TextStyle(
                    color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
