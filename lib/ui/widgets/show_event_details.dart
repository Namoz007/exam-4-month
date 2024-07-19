import 'package:exam_4_month/blocs/with_event_bloc/with_event_bloc.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_event.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_state.dart';
import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/ui/widgets/registration_event.dart';
import 'package:exam_4_month/ui/widgets/show_event_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShowEventDetails extends StatefulWidget {
  bool me;
  Event event;
  ShowEventDetails({super.key,required this.event,required this.me});

  @override
  State<ShowEventDetails> createState() => _ShowEventDetailsState();
}

class _ShowEventDetailsState extends State<ShowEventDetails> {
  String userId = '';
  void initState(){
    super.initState();
    Future.delayed(Duration.zero,()async{
      final pref = await SharedPreferences.getInstance();
      setState(() {
        userId = pref.getString("userId").toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.event.img),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25),),
              ),
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: Colors.white,)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.event.eventName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 30,),
                  ShowEventAddress(event: widget.event,)
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: widget.me  ? SizedBox() : InkWell(
        onTap: (){
          showModalBottomSheet(context: context, builder: (context) => RegistrationEvent(eventId: widget.event.id,));
        },
        child: widget.event.addedUsers.contains(userId) ? Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15)
          ),
          alignment: Alignment.center,
          child: BlocBuilder<WithEventBloc,WithEventState>(
            builder: (context,state){
              if(state is LoadingWithEventState){
                return const Center(child: CircularProgressIndicator(color: Colors.red,),);
              }

              return Text("${DateTime.now().isBefore(widget.event.dateTime) ?"Bekor qilish" : "Tadbir yakunlandi" }",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
            },
          ),
        ) : Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15)
          ),
          alignment: Alignment.center,
          child: BlocBuilder<WithEventBloc,WithEventState>(
            builder: (context,state){
              if(state is LoadingWithEventState){
                return const Center(child: CircularProgressIndicator(color: Colors.red,),);
              }

              return const Text("Tadbirga Qo'shilish",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
            },
          ),
        ),
      )
    );
  }
}
