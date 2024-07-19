import 'package:flutter/material.dart';


class SearchTextfield extends StatefulWidget {
  TextEditingController searchController;
  SearchTextfield({super.key,required this.searchController});

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.searchController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "Tadbirlar izlash",
          suffixIcon: PopupMenuButton(
            onSelected: (value) {

            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text("Tadbir nomi bo'yicha"),),
                PopupMenuItem(child: Text("Tadbir manzili bo'yicha"),),
              ];
            },
            icon: Icon(Icons.menu),
          )),
    );
  }
}
