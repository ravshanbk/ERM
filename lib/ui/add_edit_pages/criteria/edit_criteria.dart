import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:roxcrm/core/colors.dart';
import 'package:roxcrm/core/size_config.dart';
import 'package:roxcrm/hive/criteria_hive.dart';
import 'package:roxcrm/models/creteria_model.dart';
import 'package:roxcrm/providers/criteria/criteria_edit_provider.dart';
import 'package:roxcrm/ui/widgets/submit_button_for_appbar.dart';

class EditCriteriaPage extends StatelessWidget {
  const EditCriteriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("O'zgartirish"),
        actions: [_submitButton(context)],
      ),
      body: Center(
        child: Form(
          key: context.read<CriteriaEditingPageProvider>().formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: gH(20.0)),
                _letterInputField(context),
                SizedBox(height: gH(20.0)),
                _textCriteriaInputField(context),
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

  _letterInputField(BuildContext context) {
    return SizedBox(
      width: gW(150.0),
      height: gH(60.0),
      child: TextFormField(
        validator: (v) {
          if (v!.isEmpty) return "Nimadir kiriting!!!";
        },
        keyboardType: TextInputType.name,
        cursorColor: mainColor,
        controller:
            context.read<CriteriaEditingPageProvider>().letterController,
        style: TextStyle(
          fontSize: gW(18.0),
        ),
        decoration: _inputDecoration("Harfi..."),
      ),
    );
  }

  _textCriteriaInputField(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) return "Nimadir kiriting!!!";
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: mainColor,
      controller: context.read<CriteriaEditingPageProvider>().textController,
      style: TextStyle(
        fontSize: gW(18.0),
      ),
      decoration: _inputDecoration("Mazmuni..."),
    );
  }

  _submitButton(BuildContext context) {
    return SubmitButtonForAppBar(context.watch<CriteriaEditingPageProvider>().isInProgress,
      onPressed: () async {
        if (Provider.of<CriteriaEditingPageProvider>(context, listen: false)
            .formKey
            .currentState!
            .validate()) {

          await Hive.openBox<Criteria>("criteria");

          CriteriaHive().editCriteria(
             Provider.of<CriteriaEditingPageProvider>(context,listen: false).currentIndex,
              context.read<CriteriaEditingPageProvider>().letterController.text,
              context.read<CriteriaEditingPageProvider>().textController.text);
          context.read<CriteriaEditingPageProvider>().letterController.clear();
          context.read<CriteriaEditingPageProvider>().textController.clear();
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pop(context);
          });
        } else {
        }
      },
    );
  }
}
