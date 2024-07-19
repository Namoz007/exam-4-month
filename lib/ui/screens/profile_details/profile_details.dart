import 'dart:io';

import 'package:exam_4_month/blocs/user_bloc/user_bloc.dart';
import 'package:exam_4_month/blocs/user_bloc/user_event.dart';
import 'package:exam_4_month/blocs/user_bloc/user_state.dart';
import 'package:exam_4_month/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final _formKey = GlobalKey<FormState>();
  final _newName = TextEditingController();

  XFile? file;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        file = pickedImage;
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        file = pickedImage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Profilni tahrirlash"),
        centerTitle: true,
        actions: [
          ElevatedButton(onPressed: () async{
            if(_formKey.currentState!.validate() && file != null){
              context.read<UserBloc>().add(EditUserDetailsUserEvent(newName: _newName.text,img: File(file!.path)));
            }
          }, child: BlocBuilder<UserBloc,UserState>(
            builder: (context,state){
              if(state is LoadingUserState){
                return const Center(child: CircularProgressIndicator(color: Colors.red,),);
              }
              return Text("Saqlash");
            },
          )),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _newName,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Foydalanuvchi nomi bo'sh bo'lmasligi kerak";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                    hintText: "Yangi ism"
                  ),
                ),
              ),

              SizedBox(height: 30,),


              file != null ? Image.file(File(file!.path)) : SizedBox(child: Text("surat yuklanmagan"),),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: openCamera,
                    child: Icon(Icons.camera_alt_outlined,size: 40,),
                  ),
                  InkWell(
                    onTap: openGallery,
                    child: Icon(Icons.image,size: 40,),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
