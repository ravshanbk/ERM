import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/models/creteria_model.dart';
import 'package:roxcrm/models/employee_model.dart';
import 'package:roxcrm/models/user/user_hive_model.dart';
import 'package:roxcrm/providers/auth/sign_in_provider.dart';
import 'package:roxcrm/providers/auth/sign_up_provider.dart';
import 'package:roxcrm/providers/bottom_nav_bar_provider.dart';
import 'package:roxcrm/providers/checking_provider.dart';
import 'package:roxcrm/providers/criteria/criteria_add_provider.dart';
import 'package:roxcrm/providers/criteria/criteria_edit_provider.dart';
import 'package:roxcrm/providers/employee/employee_add_provider.dart';
import 'package:roxcrm/providers/employee/employee_edit_page_provider.dart';
import 'package:roxcrm/providers/employee/get_employee_result_interval_provider.dart';
import 'package:roxcrm/providers/homepage_provider.dart';
import 'package:roxcrm/routes.dart';
// flutter build apk --build-name=1.0 --build-number=1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CriteriaAdapter());
  await Hive.openBox<Criteria>("criteria");
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox<Employee>("employee");
 Hive.registerAdapter(UserHiveAdapter());
  await Hive.openBox<UserHive>("user_hive");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeeEditingPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CriteriaEditingPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CriteriaAddPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeeAddPageProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => GetEmployeeResultIntervalProvider(),
        ),
         
         ChangeNotifierProvider(
          create: (_) => SignUpProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => SignInProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (setting) => RouteManager.generaRouter(setting),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const Scaffold(
            body: Center(
              child: Text('Not Found'),
            ),
          ),
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
