import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/hive/employee_hive.dart';
import 'package:roxcrm/models/employee_model.dart';
import 'package:roxcrm/providers/employee/employee_edit_page_provider.dart';
import 'package:roxcrm/ui/widgets/add_button.dart';
import 'package:roxcrm/ui/widgets/icon_button.dart';

class EmployeeSettingsPage extends StatelessWidget {
  const EmployeeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _valueListenableBuilder(context),
      ),
    );
  }

  _valueListenableBuilder(BuildContext __) {
    return ValueListenableBuilder<Box<Employee>>(
      valueListenable: Boxes.getEmployee().listenable(),
      builder: (context, box, _) {
        final data = box.values.toList().cast<Employee>();

        return data.isEmpty
            ? _noDataWidget(__)
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(vertical: gH(20.0)),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, __) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            shape: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),
                            leading: _leading(context, data[__].name, __),
                            trailing: _trailing(context, data[__].name,
                                data[__].age, data[__].phoneNumber,__),
                            title: Text(
                              data[__].name,
                              style: TextStyle(
                                fontSize: gW(20.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${data[__].age} / ${data[__].phoneNumber}",
                              style: TextStyle(color: mainColor),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return SizedBox(
                            height: gH(20.0),
                          );
                        },
                      ),
                      _addButton(__)
                    ],
                  ),
                ),
              );
      },
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
                color: mainColor,
                fontSize: gW(18.0),
                letterSpacing: 2,
                wordSpacing: 3),
          ),
          SizedBox(
            height: gH(40.0),
          ),
          _addButton(context),
        ],
      ),
    );
  }

  AddButton _addButton(BuildContext context) {
    return AddButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addEmployee");
        },
        label: "+");
  }

  _trailing(
      BuildContext context, String name, String age, String phone, int __) {
    return IconButtonMy(
      onPressed: () {
        context
            .read<EmployeeEditingPageProvider>()
            .makeInitialValued(name, age, phone,__);
        Navigator.pushNamed(context, "/editEmployee");
      },
      icon: Icons.edit_outlined,
    );
  }

  _leading(BuildContext context, String name, int __) {
    return IconButtonMy(
      onPressed: () {
        _showDialogReallyDelete(context, name, __);
      },
      icon: Icons.delete_outline,
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      title: const Text(
        "Xodimlar",
        style: TextStyle(),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            switch (result) {
              case "add":
                Navigator.pushNamed(context, "/addEmployee");
                break;

              case "getHome":
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
                break;
              default:
                Navigator.pop(context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: "add",
              child: Text("Yangi Qo'shish"),
            ),
            const PopupMenuItem<String>(
              value: "getHome",
              child: Text("Bosh menyuga qaytish"),
            ),
          ],
        )
      ],
    );
  }

  _showDialogReallyDelete(context, name, __) {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(gW(20.0)),
          margin: EdgeInsets.only(
            left: gW(32.5),
            right: gW(32.5),
            top: gH(50.0),
            bottom: gH(300.0),
          ),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(
              gW(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        color: redColor,
                        fontSize: gW(22),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "ni rostdan ham o'chiramizmi?",
                      style: TextStyle(
                        letterSpacing: 3.0,
                        color: Colors.white,
                        fontSize: gW(20.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: gW(300.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: redColor,
                        elevation: 0,
                        fixedSize: Size(
                          gW(100.0),
                          gH(48.0),
                        ),
                      ),
                      onPressed: () async {
                        await EmployeeHive().deleteEmployee(__);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ha",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: gW(25.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 0,
                        fixedSize: Size(
                          gW(100.0),
                          gH(48.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Yo'q",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: gW(25.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
