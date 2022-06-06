
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/hive/criteria_hive.dart';
import 'package:roxcrm/models/creteria_model.dart';
import 'package:roxcrm/providers/criteria/criteria_edit_provider.dart';
import 'package:roxcrm/ui/widgets/add_button.dart';
import 'package:roxcrm/ui/widgets/icon_button.dart';

class CriteriaSettingsPage extends StatelessWidget {
  const CriteriaSettingsPage({Key? key}) : super(key: key);

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
    return ValueListenableBuilder<Box<Criteria>>(
      valueListenable: Boxes.getCriterias().listenable(),
      builder: (context, box, _) {
        final data = box.values.toList().cast<Criteria>();

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
                            leading:
                                _leading(context, data[__].criteriaLetter, __),
                            trailing: _trailing(context, data[__].criteriaText,
                                data[__].criteriaLetter, __),
                            title: Text(
                              data[__].criteriaLetter.toUpperCase(),
                              style: TextStyle(
                                fontSize: gW(30.0),
                                fontWeight: FontWeight.bold,
                                color: redColor,
                              ),
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
            "Birorta ham mezon mavjud emas. Qo'shish uchun quyidagi tugmani bosing",
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
          Navigator.pushNamed(context, "/addCriteria");
        },
        label: "+");
  }

  _trailing(BuildContext context, String text, String letter, __) {
    return SizedBox(
      width: gW(120),
      child: Row(
        children: [
          IconButtonMy(
            onPressed: () {
              context
                  .read<CriteriaEditingPageProvider>()
                  .letterController
                  .text = letter;
              context.read<CriteriaEditingPageProvider>().currentIndex = __;
              context.read<CriteriaEditingPageProvider>().textController.text =
                  text;
              Navigator.pushNamed(context, "/editCriteria");
            },
            icon: Icons.edit_outlined,
          ),
          const Spacer(),
          IconButtonMy(
            onPressed: () {
              _showDialog(context, text);
            },
            icon: Icons.more_vert,
          ),
        ],
      ),
    );
  }

  _leading(BuildContext context, letter, __) {
    return IconButtonMy(
      onPressed: () {
        _showDialogReallyDelete(
            context: context, letter: letter, index: __, isAll: false);
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
        "Mezonlar",
        style: TextStyle(),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            switch (result) {
              case "add":
                Navigator.pushNamed(context, "/addCriteria");
                break;
              case "deleteAll":
                _showDialogReallyDelete(
                    context: context, index: 0, isAll: true, letter: "");
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
              value: "deleteAll",
              child: Text("Hammasini O'chirish"),
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

  _showDialog(BuildContext context, text) {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(
              gW(20.0),
            ),
          ),
          padding: EdgeInsets.all(gW(10.0)),
          margin: EdgeInsets.only(
              right: gW(20.0),
              left: gW(20.0),
              bottom: gH(200.0),
              top: gH(30.0)),
          height: 200.0,
          width: 100.0,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: gW(20.0),
              ),
            ),
          ),
        );
      },
    );
  }

  _showDialogReallyDelete(
      {required bool isAll,
      required BuildContext context,
      required String letter,
      required int index}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body: Container(
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
                isAll
                    ? Text(
                        "Hammasini o'chirmoqchiligingizga ishonchingiz komilmi?",textAlign: TextAlign.center,
                        style: TextStyle(color: whiteColor, fontSize: gW(22.0)),
                      )
                    : _letterMessage(letter),
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
                          if (isAll) {
                            await CriteriaHive().deleteAll();
                          } else {
                            await CriteriaHive().deleteCriteria(index);
                          }
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
          ),
        );
      },
    );
  }

  RichText _letterMessage(String letter) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: letter,
            style: TextStyle(
              letterSpacing: 3.0,
              color: redColor,
              fontSize: gW(30),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: " mezonini rostdan ham o'chirmoqchimisiz?",
          
            style: TextStyle(
              letterSpacing: 3.0,
              color: Colors.white,
              fontSize: gW(20.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
