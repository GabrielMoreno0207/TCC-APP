import 'package:flutter/material.dart';
// import 'package:tcc_app/Comm/comHelper.dart';

class getTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintName;
  final IconData icon;
  final bool isObscureText;
  final TextInputType inputType;

  getTextFormField(
      {required this.controller,
      required this.hintName,
      required this.icon,
      this.inputType = TextInputType.text,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: TextInputType.text,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Por favor informe o $hintName';
        //   }
        //   if (hintName == "Email" && !validateEmail(value)) {
        //     return 'Por favor informe um email valido';
        //   }
        //   return null;
        // },
        // onSaved: (val) => controller.text = val!,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.green),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          // labelText: hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
