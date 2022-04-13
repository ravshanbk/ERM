import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/employee_hive.dart';
import 'package:roxcrm/models/employee_model.dart';
import 'package:roxcrm/providers/employee/employee_add_provider.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("Yangi xodim"),
        actions: [_submitButton(context)],
      ),
      body: Center(
        child: Form(
          key: context.read<EmployeeAddPageProvider>().formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: gH(20.0)),
                _nameInputField(context),
                SizedBox(height: gH(20.0)),
                _ageInputField(context),
                SizedBox(height: gH(20.0)),
                _phoneInputField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _inputDecoration(label) {
    return InputDecoration(
      labelStyle: TextStyle(color: mainColor),
      label: Text(label),
      errorBorder: _outlineInputBorder(Colors.red),
      focusedBorder: _outlineInputBorder(mainColor),
      focusColor: mainColor,
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

  _nameInputField(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) return "Nimadir kiriting!!!";
      },
      keyboardType: TextInputType.name,
      cursorColor: mainColor,
      controller: context.read<EmployeeAddPageProvider>().nameController,
      style: TextStyle(
        fontSize: gW(18.0),
      ),
      decoration: _inputDecoration("Ismi..."),
    );
  }

  _phoneInputField(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) return "Nimadir kiriting!!!";
      },
      keyboardType: TextInputType.phone,
      cursorColor: mainColor,
      controller:
          context.read<EmployeeAddPageProvider>().phoneNumberController,
      style: TextStyle(
        fontSize: gW(18.0),
      ),
      decoration: _inputDecoration("Telefon..."),
    );
  }

  _ageInputField(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) return "Nimadir kiriting!!!";
      },
      keyboardType: TextInputType.number,
      maxLines: null,
      cursorColor: mainColor,
      controller: context.read<EmployeeAddPageProvider>().ageController,
      style: TextStyle(
        fontSize: gW(18.0),
      ),
      decoration: _inputDecoration("Yoshi..."),
    );
  }

  _submitButton(BuildContext context) {
    return SubmitButtonForAppBar(
      onPressed: () async {
        if (Provider.of<EmployeeAddPageProvider>(context, listen: false)
            .formKey
            .currentState!
            .validate()) {

          await Hive.openBox<Employee>("employee");

          var criteria = EmployeeHive();
          await criteria.addEmployee(
            DateTime.now().toString(),
              context.read<EmployeeAddPageProvider>().nameController.text,
              context.read<EmployeeAddPageProvider>().ageController.text,
              context
                  .read<EmployeeAddPageProvider>()
                  .phoneNumberController
                  .text,);
          await context.read<EmployeeAddPageProvider>().clearControllers();
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
