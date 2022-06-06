import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/employee_hive.dart';
import 'package:roxcrm/providers/employee/employee_edit_page_provider.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class EditEmployeePage extends StatelessWidget {
  const EditEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("..o'zgartirish"),
        actions: [
          SubmitButtonForAppBar(
            context.watch<EmployeeEditingPageProvider>().isInProgress,
            onPressed: () async {
              if (Provider.of<EmployeeEditingPageProvider>(context,
                      listen: false)
                  .formKey
                  .currentState!
                  .validate()) {
                await EmployeeHive().editEmployee(
                    Provider.of<EmployeeEditingPageProvider>(context,
                            listen: false)
                        .currentIndex,
                    Provider.of<EmployeeEditingPageProvider>(context,
                            listen: false)
                        .nameController
                        .text,
                    Provider.of<EmployeeEditingPageProvider>(context,
                            listen: false)
                        .ageController
                        .text,
                    Provider.of<EmployeeEditingPageProvider>(context,
                            listen: false)
                        .phoneNumberController
                        .text);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: context.read<EmployeeEditingPageProvider>().formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: gH(20.0)),
                  SizedBox(
                    height: gH(60.0),
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Bo'sh qoldirmang";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      cursorColor: mainColor,
                      controller: context
                          .read<EmployeeEditingPageProvider>()
                          .nameController,
                      style: TextStyle(
                        fontSize: gW(20.0),
                      ),
                      decoration: _inputDecoration("Ism..."),
                    ),
                  ),
                  SizedBox(height: gH(20.0)),
                  SizedBox(
                    height: gH(60.0),
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Bosh qoldirmang";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: mainColor,
                      controller: context
                          .read<EmployeeEditingPageProvider>()
                          .ageController,
                      style: TextStyle(
                        fontSize: gW(20.0),
                      ),
                      decoration: _inputDecoration("Yoshi.."),
                    ),
                  ),
                  SizedBox(height: gH(20.0)),
                  SizedBox(
                    height: gH(60.0),
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Bosh qoldirmang";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      cursorColor: mainColor,
                      controller: context
                          .read<EmployeeEditingPageProvider>()
                          .phoneNumberController,
                      style: TextStyle(
                        fontSize: gW(20.0),
                      ),
                      decoration: _inputDecoration("Telefon..."),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _inputDecoration(hint) {
    return InputDecoration(
      errorBorder: _outlineInputBorder(Colors.red),
      focusedBorder: _outlineInputBorder(mainColor),
      focusColor: mainColor,
      hintText: hint,
      border: _outlineInputBorder(mainColor),
    );
  }

  _outlineInputBorder(color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(
        gW(25.0),
      ),
    );
  }
}
