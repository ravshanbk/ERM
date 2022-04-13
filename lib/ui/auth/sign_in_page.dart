import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/show_toast.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/providers/auth/sign_in_provider.dart';
import 'package:roxcrm/services/user_service.dart';
import 'package:roxcrm/ui/auth/sign_up_page.dart';
import 'package:roxcrm/ui/body_page.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(context),
      body: Form(
        key: context.watch<SignInProvider>().formKey,
        child: Padding(
          padding: EdgeInsets.all(gW(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(gW(10.0))),
                  label: const Text("Emailingizni kiriting..."),
                ),
                controller: context.watch<SignInProvider>().emailController,
                validator: (v) {
                  if (v!.isEmpty) return "Emailingizni kiriting";
                },
              ),
              SizedBox(height: gH(20.0)),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(gW(10.0))),
                  label: const Text("Parolingizni kiriting..."),
                ),
                controller: context.watch<SignInProvider>().passwordController,
                validator: (v) {
                  if (v!.isEmpty) return "Parolingizni kiriting";
                },
              ),
              SizedBox(height: gH(20.0)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: Text(
                  "Agar hali ro'yhatdan o'tmagan bo'lsangiz buyerga bosib ro'yhatdan o'ting",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: gW(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      title: Text(
        "Sign In ...",
        style: TextStyle(letterSpacing: gW(5.0)),
      ),
      actions: [
        SubmitButtonForAppBar(onPressed: () async {
          if (Provider.of<SignInProvider>(context, listen: false)
              .formKey
              .currentState!
              .validate()) {
            try {
              bool success = await UserService().signInUser(
                  Provider.of<SignInProvider>(context, listen: false)
                      .emailController
                      .text,
                  Provider.of<SignInProvider>(context, listen: false)
                      .passwordController
                      .text);

              if (success) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const BodyPage()),
                    (route) => false);
              } else {
                showToast("Nimadir Xato bo'ldi. Qaytadan urunib ko'ring");
              }
            } catch (e) {
              throw Exception("SignInPage SubmitButtton: " + e.toString());
            }
          }
        })
      ],
    );
  }
}
