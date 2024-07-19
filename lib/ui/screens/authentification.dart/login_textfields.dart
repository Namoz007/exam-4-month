import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextfield extends StatefulWidget {
  TextEditingController controller;
  LoginTextfield({super.key,required this.controller});

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value == null || value.isEmpty)
          return "Email bosh bolmasligi kerak";

        if(!value.contains('@')){
          return "Emailda @ belgisi bolishi shart";
        }

        return null;
      },
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: "Email",
        suffixIcon: Icon(Icons.email_rounded,size: 35,),
        hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
      ),
    );
  }
}


class PasswordTextField extends StatefulWidget {
  TextEditingController controller;
  PasswordTextField({super.key,required this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value == null || value.isEmpty){
          return "Parol bosh bolmasligi kerak";
        }

        if(value.length < 6){
          return "Parol eng kamida 6 ta elementdan iborat bo'lishi kerak";
        }

        return null;
      },
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: "Password",
        hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),
        suffixIcon: Icon(Icons.key)
      ),
    );
  }
}
