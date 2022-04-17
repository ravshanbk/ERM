import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/show_toast.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/providers/auth/sign_up_provider.dart';
import 'package:roxcrm/services/user_service.dart';
import 'package:roxcrm/ui/auth/sign_in_page.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<String> signUpItems = [
      "Ismingiz...",
      "Emailingiz...",
      "Parolingiz..."
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text(
          "Sign Up...",
          style: TextStyle(letterSpacing: gW(5.0)),
        ),
        actions: [
          SubmitButtonForAppBar(onPressed: () async {
            if (Provider.of<SignUpProvider>(context, listen: false)
                .formKey
                .currentState!
                .validate()) {
              try {
                UserService()
                    .signUpUser(
                        Provider.of<SignUpProvider>(context, listen: false)
                            .controllers[0]
                            .text,
                        Provider.of<SignUpProvider>(context, listen: false)
                            .controllers[1]
                            .text,
                        Provider.of<SignUpProvider>(context, listen: false)
                            .controllers[2]
                            .text,
                        isAdmin)
                    .then(
                  (value) {
                    if (value.name ==
                        Provider.of<SignUpProvider>(context, listen: false)
                            .controllers[0]
                            .text) {
                      Provider.of<SignUpProvider>(context, listen: false)
                          .clear();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>const  SignInPage()),
                          (route) => false);
                    } else {
                      showToast(
                          "Nimadir Xato: Internet Yaxshi Bolmasligidan bo'lishi ham mumkin");
                      Provider.of<SignUpProvider>(context, listen: false)
                          .clear();
                      isAdmin = false;
                      setState(
                        () {},
                      );
                    }
                  },
                );
              } catch (e) {
                throw Exception(
                    "SubmitButtonForAppBar in SignUpPage: " + e.toString());
              }
            }
          })
        ],
      ),
      body: Form(
        key: context.watch<SignUpProvider>().formKey,
        child: Column(
          children: [
            Column(
              children: List.generate(
                signUpItems.length,
                (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: gW(20.0), vertical: gH(10.0)),
                    child: _textFormField(signUpItems, index, context),
                  );
                },
              ),
            ),
            CheckboxListTile(
              selected: isAdmin,
              title: const Text("Adminmisiz"),
              value: isAdmin,
              onChanged: (v) {
                isAdmin = !isAdmin;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _textFormField(
      List<String> signUpItems, int index, BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: Text(signUpItems[index])),
      controller: context.watch<SignUpProvider>().controllers[index],
      validator: (v) {
        if (v!.isEmpty) {
          return "Hech biri bo'sh qolmasligi kerak !";
        }
      },
    );
  }
}
