import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/ui/widgets/event_in_maps.dart';
import 'package:exam_4_month/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ShowEventAddress extends StatefulWidget {
  Event event;
  ShowEventAddress({super.key,required this.event});

  @override
  State<ShowEventAddress> createState() => _ShowEventAddressState();
}

class _ShowEventAddressState extends State<ShowEventAddress> {
  String? addres;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,() async{
      final res = await YandexSearch.searchByPoint(point: widget.event.point, searchOptions: SearchOptions(searchType: SearchType.geo));
      final a = (await res.$2).items?[0].name ?? "Manzil topilmadi";
      setState(() {
        addres = a;
      });
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.calendar_month,size: 40,),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.event.dateTime.day} ${AppUtils.months[widget.event.dateTime.month]}, ${widget.event.dateTime.year}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text('${AppUtils.weekdays[widget.event.dateTime.weekday]},${widget.event.eventTime.hour}:${widget.event.eventTime.minute}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ],
            ),

          ],
        ),

        SizedBox(height: 20,),

        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.place,size: 40,),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addres ?? "Manzil aniqlanmoqda",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),

          ],
        ),

        SizedBox(height: 20,),

        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.person,size: 40,),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.event.addedUsers.length} kishi bormoqda",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text("Siz ham ro'xyatdan o'ting",style: TextStyle(fontSize: 16),),
              ],
            ),
          ],
        ),
        SizedBox(height: 20,),

        EventInMaps(address: addres,description: widget.event.description, point: widget.event.point),
      ],
    );
  }
}
