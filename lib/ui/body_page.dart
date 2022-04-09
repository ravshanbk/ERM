import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/providers/bottom_nav_bar_provider.dart';
import 'package:roxcrm/ui/home_page.dart';
import 'package:roxcrm/ui/settings_page.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({Key? key}) : super(key: key);

  final List<Widget> widgets = const [
    MyHomePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: _appBar(),
        backgroundColor: mainColor,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<BottomNavBarProvider>().currentIndex,
          onTap: (v) {
            context.read<BottomNavBarProvider>().onPressed(v);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
          ],
        ),
        body: widgets[context.watch<BottomNavBarProvider>().currentIndex]);
  }

  _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "CRM",
        style: TextStyle(
          letterSpacing: 5.0,
          fontSize: gW(30.0),
        ),
      ),
    );
  }
}