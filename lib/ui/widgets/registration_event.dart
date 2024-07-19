import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/blocs/event_bloc/event_bloc.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_bloc.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_event.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_state.dart';
import 'package:exam_4_month/ui/widgets/succes_registration_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationEvent extends StatefulWidget {
  String eventId;
  RegistrationEvent({super.key,required this.eventId,});

  @override
  State<RegistrationEvent> createState() => _RegistrationEventState();
}

class _RegistrationEventState extends State<RegistrationEvent> {
  int count = 0;
  int _selected = -1;

  List<Map<String,dynamic>> payments = [
    {"name": "Click","img": "https://cdn2.iconfinder.com/data/icons/payment-flat/614/1_-_Paypal-1024.png"},
    {"name": "Payme","img": "https://cdn2.iconfinder.com/data/icons/payment-flat/614/1_-_Paypal-1024.png"},
    {"name": "Naqd",'img':"https://cdn2.iconfinder.com/data/icons/payment-flat/614/1_-_Paypal-1024.png"}
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios)),
              Text("Tadbirga qo'shilish",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              IconButton(onPressed: (){
                Navigator.pop(context);
                }, icon: Icon(Icons.cancel_outlined))
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Joylar soni tanlang",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){
                        setState(() {
                          if(count > 0){
                            count--;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.remove),
                      ),
                    ),

                    SizedBox(width: 10,),


                    Text("$count",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          count++;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                
                Text("To'lov turini tanlang",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),

                for(int i = 0;i < 3; i++)
                  InkWell(
                    onTap: (){
                      setState(() {
                        _selected = i;
                      });
                    },
                    child: ListTile(
                      leading: Image.network("${payments[i]['img']}"),
                      title: Text("${payments[i]['name']}"),
                      trailing: InkWell(
                        onTap: (){
                          setState(() {
                            _selected = i;
                          });
                        },
                        child: _selected == i ? Icon(Icons.check_circle_outline_rounded) : Icon(Icons.circle_outlined),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          if (count != 0 && _selected > -1) Center(child: InkWell(
            onTap: (){
              context.read<WithEventBloc>().add(AddEventWithEvent(count, '', widget.eventId));
              showDialog(context: context, builder: (context) => SuccesRegistrationEvent(eventId: widget.eventId,count: count,));
            },
            child: Container(
                height: 50,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: BlocBuilder<WithEventBloc,WithEventState>(
                  builder: (context,state){
                    if(state is LoadingWithEventState){
                      return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                    }
                    return Text("Keyingi",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),);
                  },
                ),
              ),
          ),) else SizedBox()
        ],
      ),
    );
  }
}
