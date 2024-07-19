import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class EventInMaps extends StatefulWidget {
  String? address;
  String description;
  Point point;
  EventInMaps({super.key,required this.address, required this.description,required this.point,});

  @override
  State<EventInMaps> createState() => _EventInMapsState();
}


class _EventInMapsState extends State<EventInMaps> {
  late YandexMapController mapController;

  void onMapCreated(YandexMapController controller) {
    mapController = controller;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: widget.point,
          zoom: 16,
        ),
      ),
    );
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tadbir haqida",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        SizedBox(height: 10,),
        Text("${widget.description}",style: TextStyle(fontSize: 16,),),

        SizedBox(height: 20,),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),child: Text('Manzil',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),child: Text("${widget.address ?? "Aniqlanmoqda"}"),),


        Container(
          height: 250,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              YandexMap(
                onMapCreated: onMapCreated,
                mapType: MapType.map,
                gestureRecognizers: Set()
                  ..add(Factory<EagerGestureRecognizer>(
                          () => EagerGestureRecognizer())),
                mapObjects: [
                  PlacemarkMapObject(
                    mapId: const MapObjectId("Tadbir manzili"),
                    point: widget.point,
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                          "assets/route_start.png",
                        ),
                      ),
                    ),
                  ),
                ],

              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 10,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap:()async{
                          final res = await mapController.getUserCameraPosition();
                          mapController.moveCamera(
                            CameraUpdate.zoomIn(),
                          );
                        },
                        child: Icon(Icons.add),
                      ),
                      Container(width: 30,
                        height: 3,color: Colors.grey,),
                      InkWell(
                        onTap: ()async{
                          final res = await mapController.getUserCameraPosition();
                          mapController.moveCamera(
                            CameraUpdate.zoomOut(),
                          );
                        },
                        child: Icon(Icons.remove),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        
        
      ],
    );
  }
}
