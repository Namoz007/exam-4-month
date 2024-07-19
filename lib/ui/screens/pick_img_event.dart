import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImgEvent extends StatefulWidget {
  XFile file;
  PickImgEvent({super.key,required this.file});

  @override
  State<PickImgEvent> createState() => _PickImgEventState();
}

class _PickImgEventState extends State<PickImgEvent> {
  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        widget.file = pickedImage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Container(
            width: 180,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined,size: 50,),
                SizedBox(height: 10,),
                Text("Rasm",style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
        ),

        InkWell(
          child: Container(
            width: 180,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.videocam_sharp,size: 50,),
                SizedBox(height: 10,),
                Text("Video",style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
