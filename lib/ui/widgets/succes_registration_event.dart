import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/services/push_notification_services.dart';
import 'package:exam_4_month/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SuccesRegistrationEvent extends StatefulWidget {
  String eventId;
  int count;
  SuccesRegistrationEvent({super.key,required this.eventId,required this.count});

  @override
  State<SuccesRegistrationEvent> createState() => _SuccesRegistrationEventState();
}

class _SuccesRegistrationEventState extends State<SuccesRegistrationEvent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber
            ),
            child: Icon(Icons.check_circle_outline_rounded,size: 100,color: Colors.green,),
          ),
          
          SizedBox(height: 20,),
          
          Text("Tabriklaymiz siz tadbirga muvafaqqiyatli ro'yxatdan o'tdingiz",textAlign: TextAlign.center,),
          SizedBox(height: 30,),

          InkWell(
            onTap: (){
              FirebasePushNotificationService.sendNotificationMessage(widget.count,widget.eventId, false);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Container(
              width: 230,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              alignment: Alignment.center,
              child: Text("Eslatish",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
          ),
          SizedBox(height: 20,),

          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Container(
              width: 230,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey)
              ),
              alignment: Alignment.center,
              child: Text("Bosh Sahifa",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
          ),


        ],
      ),
    );
  }
}
