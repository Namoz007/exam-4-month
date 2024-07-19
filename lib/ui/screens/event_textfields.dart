import 'package:flutter/material.dart';

class EventTextfields extends StatefulWidget {
  TextEditingController eventName;
  TextEditingController eventDescription;
  EventTextfields({
    super.key,
    required this.eventName,
    required this.eventDescription,
  });

  @override
  State<EventTextfields> createState() => _EventTextfieldsState();
}

class _EventTextfieldsState extends State<EventTextfields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Tadbir nomi bo'sh bolmasligi kerak";
            }
            return null;
          },
          controller: widget.eventName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Tadbir nomi",
            hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
          ),
        ),
        SizedBox(height: 20,),

        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Tadbir haqida ma'lumot bo'sh bo'lmasligi kerak";
            }

            return null;
          },
          controller: widget.eventDescription,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Tadibr haqida ma'lumot",
            hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          ),
          style: TextStyle(fontSize: 40),
        ),
      ],
    );
  }
}
