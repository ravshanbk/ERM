import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/dfms_model.dart';
import 'package:roxcrm/providers/bottom_nav_bar_provider.dart';
import 'package:roxcrm/ui/home_page.dart';
import 'package:roxcrm/ui/settings_page.dart';
import 'package:roxcrm/ui/widgets/drawer_widget.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({Key? key}) : super(key: key);

  final List<Widget> widgets = const [
    MyHomePage(true),
    MyHomePage(false),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // UserHiveHive().deleteAll();

    SizeConfig().init(context);
    return Scaffold(
      drawer:const  DrawerWidgetMy(),
        appBar: _appBar(),
        backgroundColor: mainColor,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: mainColor,
           
          iconSize: gW(40.0),
          currentIndex: context.watch<BottomNavBarProvider>().currentIndex,
          onTap: (v) {
            context.read<BottomNavBarProvider>().onPressed(v);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.query_stats_sharp), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
          ],
        ),
        body: widgets[context.watch<BottomNavBarProvider>().currentIndex]);
  }

  _appBar() {
    return AppBar(
      shape: UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        DTFM.maker(DateTime.now().millisecondsSinceEpoch),
        style: TextStyle(
          letterSpacing: 5.0,
          fontSize: gW(30.0),
        ),
      ),
    );
  }
}
