import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:roxcrm/core/extentions_my.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/show_toast.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/boxes.dart';
import 'package:roxcrm/hive/userhive_hive.dart';
import 'package:roxcrm/models/user/user_hive_model.dart';
import 'package:roxcrm/services/user_service.dart';
import 'package:roxcrm/ui/auth/sign_in_page.dart';

class DrawerWidgetMy extends StatelessWidget {
  const DrawerWidgetMy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding:
            EdgeInsets.only(top: gH(50.0), left: gW(20.0), right: gW(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shaxsiy Malumotlar",
              style: TextStyle(
                color: mainColor,
                fontSize: gW(20.0),
              ),
            ),
            Divider(
              thickness: gW(2.0),
              color: mainColor,
            ),
            SizedBox(height: gH(20.0)),
            _divider(),
            Row(children: [
              const Text("Ism:  "),
              Text(
                Boxes.getUserHive().values.first.name.capitalize(),
                style: TextStyle(color: mainColor, fontSize: gW(22.0)),
              )
            ]),
            _divider(),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Email:  "),
              Expanded(
                child: Text(Boxes.getUserHive().values.first.email,
                    style: TextStyle(color: mainColor, fontSize: gW(22.0))),
              )
            ]),
            _divider(),
            SizedBox(height: gH(20.0)),
            _button(
              color: Colors.red,
              title: "Tizimdan\nChiqish",
              context: context,
              icon: Icons.logout_outlined,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const _ShowDialogDateContent(false);
                    });
              },
            ),
            SizedBox(height: gH(20.0)),
            _button(
              color: Colors.orange,
              title: "Log Out",
              context: context,
              icon: Icons.replay_outlined,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const _ShowDialogDateContent(
                      true,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(
            gW(20.0),
          ),
        ),
      ),
    );
  }

  Divider _divider() {
    return Divider(
      color: greyColor,
      endIndent: gW(80.0),
    );
  }

  ElevatedButton _button(
      {required Color color,
      required String title,
      required BuildContext context,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(gW(200), gH(90)),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color),
          borderRadius: BorderRadius.circular(
            gW(
              35.0,
            ),
          ),
        ),
        primary: whiteColor,
        elevation: 0,
        shadowColor: whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(color: color),
            ),
            Icon(
              icon,
              color: color,
              size: gW(40.0),
            )
          ],
        ),
      ),
    );
  }
}

class _ShowDialogDateContent extends StatefulWidget {
  final bool isLogOut;

  const _ShowDialogDateContent(
    this.isLogOut, {
    Key? key,
  }) : super(key: key);

  @override
  State<_ShowDialogDateContent> createState() => _ShowDialogDateContentState();
}

class _ShowDialogDateContentState extends State<_ShowDialogDateContent> {
  bool isInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.all(gW(20.0)),
        margin: EdgeInsets.only(
          top: gH(50.0),
          left: gW(10.0),
          right: gW(10.0),
          bottom: gH(350.0),
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              !widget.isLogOut
                  ? "Tizimdan chiqmoqchimisiz?"
                  : "Chiqishni  xohlaysizmi?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mainColor,
                fontSize: gW(25.0),
              ),
            ),
            Text(
              widget.isLogOut
                  ? "Tizimdan chiqish bilan siz qayta ro'yhatdan o'tishingizga to'g'ri keladi?"
                  : "Chiqqaningizdan keyin qayta signIn qilishingizga to'g'ri keladi",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: gW(25.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: gH(40.0),
                  width: gW(150.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          gW(15.0),
                        ),
                      ),
                      primary: mainColor_02,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text("Yo'q...", style: TextStyle(color: mainColor)),
                    onPressed: isInProgress
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                  ),
                ),
                SizedBox(
                  height: gH(40.0),
                  width: gW(150.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          gW(15.0),
                        ),
                      ),
                      primary: Colors.red.withOpacity(.15),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "Ha...",
                      style: TextStyle(color: mainColor),
                    ),
                    onPressed: isInProgress
                        ? null
                        : () async {
                           isInProgress = true;
                            setState(() {});
                            if (widget.isLogOut) {
                              isInProgress = false;
                              setState(() {});
                              await UserHiveService().deleteAll();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignInPage()),
                                  (route) => false);
                            } else {
                              await UserService()
                                  .deleteUser(
                                      Boxes.getUserHive().values.first.name)
                                  .then(
                                (value) async {
                                  if (value.success) {
                                     isInProgress = false;
                                    setState(() {});
                                    await UserHiveService().deleteAll();
                                    showToast(value.text);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInPage()),
                                        (route) => false);
                                  } else {
                                     isInProgress = false;
                                    setState(() {});
                                    showToast(value.text);
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            }
                          },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
