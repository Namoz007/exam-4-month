import 'dart:io';
import 'package:exam_4_month/blocs/event_bloc/event_bloc.dart';
import 'package:exam_4_month/blocs/event_bloc/event_event.dart';
import 'package:exam_4_month/blocs/event_bloc/event_state.dart';
import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/ui/screens/event_textfields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _eventName = TextEditingController();
  final _description = TextEditingController();
  late YandexMapController mapController;
  XFile? _file;
  DateTime? _date;
  TimeOfDay? _time;


  Point myCurrentLocation = const Point(
    latitude: 41.3006,
    longitude: 69.2619,
  );


  void onMapCreated(YandexMapController controller) {
    mapController = controller;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: myCurrentLocation,
          zoom: 16,
        ),
      ),
    );
    setState(() {});
  }

  void onCameraPositionChanged(
      CameraPosition position,
      CameraUpdateReason reason,
      bool finished,
      ) async {
    myCurrentLocation = position.target;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Tadbir qo'shish"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: EventTextfields(
                        eventName: _eventName, eventDescription: _description),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value){
                            return null;
                          },
                          onTap: () async{
                            _date = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
                            setState(() {

                            });
                            },
                          initialValue: _date != null ? "Kun: ${_date!.day}/${_date!.month}/${_date!.year}" : '',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                            hintText: "Kun:",
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            return null;
                          },
                          onTap: () async{
                            _time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                            setState(() {

                            });
                          },
                          initialValue: _time != null ? "Vaqti: ${_time!.hour}:${_time!.minute}" : '',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                            hintText: _time != null ? "Vaqti: ${_time!.hour}:${_time!.minute}" : "Vaqti:",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Rasm yoki video yuklash (${_file != null ? "mavjud" : "mavjud emas"})",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),

                  SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: openCamera,
                    child: Container(
                      width: 150,
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
                      width: 150,
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
              ),
            ),

                  SizedBox(height: 20,),
                ],
              ),
            ),

            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  YandexMap(
                    onMapCreated: onMapCreated,
                    onCameraPositionChanged: onCameraPositionChanged,
                    mapType: MapType.map,
                    gestureRecognizers: Set()
                      ..add(Factory<EagerGestureRecognizer>(
                              () => EagerGestureRecognizer())),
                    mapObjects: [
                      PlacemarkMapObject(
                        mapId: const MapObjectId("najotTalim"),
                        point: myCurrentLocation,
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

            SizedBox(height: 20,),

          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: ()async{
          if(_formKey.currentState!.validate() && _date != null && _time != null && _file != null){
            final city = await YandexSearch.searchByPoint(point: myCurrentLocation, searchOptions: SearchOptions());
            context.read<EventBloc>().add(AddEventEventEvent(event: Event(id: '',userId: '', eventName: _eventName.text, description: _description.text, dateTime: _date!, eventTime: _time!, point: myCurrentLocation, img: '', cityName: '', addedUsers: [], canceledUsers: [],),file: File(_file!.path)));
          }
        },
        child: Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15)
          ),
          alignment: Alignment.center,
          child: BlocBuilder<EventBloc,EventState>(
            builder: (context,state){
              if(state is LoadingEventState){
                return const Center(child: CircularProgressIndicator(color: Colors.red,),);
              }

              return const Text("Tadbirni Qo'shish",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
            },
          ),
        ),
      ),
    );
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        _file = pickedImage;
      });
    }
  }
}
