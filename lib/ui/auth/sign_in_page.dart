import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/show_toast.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/models/dfms_model.dart';
import 'package:roxcrm/models/response_model.dart';
import 'package:roxcrm/providers/auth/sign_in_provider.dart';
import 'package:roxcrm/services/user_service.dart';
import 'package:roxcrm/ui/auth/sign_up_page.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset:true,
      appBar: _appBar(context),
      body: Form(
        key: Provider.of<SignInProvider>(context, listen: false).formKey,
        child: Padding(
          padding: EdgeInsets.all(gW(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              context.watch<SignInProvider>().isInProgress
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: mainColor,
                              elevation: 0,
                            ),
                            onPressed: () {
                              Provider.of<SignInProvider>(context,
                                      listen: false)
                                  .changeIsInProgress(false);
                            },
                            child: const Text("Bekor qilish")),
                        const CupertinoActivityIndicator(),
                      ],
                    )
                  : const SizedBox(),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(gW(10.0))),
                  label: const Text("Emailingizni kiriting..."),
                ),
                controller: context.watch<SignInProvider>().emailController,
                validator: (v) {
                  if (v!.isEmpty) return "Emailingizni kiriting";
                  return null;
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
        SubmitButtonForAppBar(
          context.watch<SignInProvider>().isInProgress,
          onPressed: () async {
            Provider.of<SignInProvider>(context, listen: false)
                .changeIsInProgress(true);
            if (Provider.of<SignInProvider>(context, listen: false)
                .formKey
                .currentState!
                .validate()) {
              UserService()
                  .signInUser(
                      Provider.of<SignInProvider>(context, listen: false)
                          .emailController
                          .text,
                      Provider.of<SignInProvider>(context, listen: false)
                          .passwordController
                          .text)
                  .then(
                (value) {
                  if (value.success) {
                    showToast(value.text);
                    Provider.of<SignInProvider>(context, listen: false)
                        .changeIsInProgress(false);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/body', ModalRoute.withName('/'));
                  } else {
                    showToast(value.text);
                    Provider.of<SignInProvider>(context, listen: false)
                        .changeIsInProgress(false);
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }
}
