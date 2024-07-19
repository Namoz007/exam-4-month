import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RegistrationPasswords extends StatefulWidget {
  TextEditingController firstController;
  TextEditingController secondController;
  TextEditingController name;
  RegistrationPasswords({super.key,required this.firstController,required this.secondController,required this.name});

  @override
  State<RegistrationPasswords> createState() => _RegistrationPasswordsState();
}

class _RegistrationPasswordsState extends State<RegistrationPasswords> {
  bool obCureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Parol bo'sh bo'lmasligi kerak";
            }

            if(value.length < 6){
              return "Parol kamida 6 ta elementdan iborat bo'lishi kerak";
            }

            if(widget.firstController.text != widget.secondController.text){
              return "Parollar bir xil emas";
            }
            return null;
          },
          controller: widget.firstController,
          obscureText: obCureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Password",
            hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
            suffixIcon: InkWell(onTap: (){
              setState(() {
                obCureText = !obCureText;
              });
            },child: obCureText ? Icon(Icons.visibility_off_rounded) : Icon(Icons.remove_red_eye),)

          ),
        ),
        const SizedBox(height: 20,),
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Parol bo'sh bo'lmasligi kerak";
            }

            if(value.length < 6){
              return "Parol kamida 6 ta elementdan iborat bolishi kerak";
            }

            if(widget.firstController.text != widget.secondController.text){
              return "Ikkala parol ham bir xil bo'lishi kerak";
            }

          },
          controller: widget.secondController,
          obscureText: obCureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Confirm Password",
            hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
          ),
        ),
        const SizedBox(height: 20,),
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Foydlanuvchi ismi bo'sh bolmasligi kerak";
            }

            return null;
          },
          controller: widget.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Full Name",
            hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
          ),
        )
      ],
    );
  }
}
