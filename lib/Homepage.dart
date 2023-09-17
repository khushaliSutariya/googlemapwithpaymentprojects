import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}
//AIzaSyDg_8Px5zGaHLF6JRQAp-fBDX2id7am6JY
class _HomepageState extends State<Homepage> {
   GoogleMapController? mapController;

   Set<Marker> markers =  Set();
   bool isloading = true;
   static const LatLng showLocation = const LatLng(21.1702, 72.8311);
   getmarkers() async{





     await BitmapDescriptor.fromAssetImage(
       ImageConfiguration(size: Size.fromWidth(10.0),),
       "img/location.png",
     ).then((markerbitmap)  async{
       Set<Marker> tepmarkers = Set();

       //for(var row in json)
       //{
       //row["title"]
      // }

       await FirebaseFirestore.instance.collection("Location").get().then((documents) async{
         documents.docs.forEach((document)  async{
           
           tepmarkers.add(Marker(
             markerId: MarkerId(document.id.toString()),
             position: LatLng(double.parse(document["latitude"]),double.parse(document["longitude"])),
             infoWindow: InfoWindow(
               title: 'Employee',
               snippet: document["Name"],
             ),
             icon: markerbitmap,
           ));

         });
       }).then((value){
         setState(() {
           markers = tepmarkers;
           isloading = false;
         });
       });
       
       
       
       // tepmarkers.add(Marker(
       //   markerId: MarkerId(showLocation.toString()),
       //   position: LatLng(21.190769, 72.794006),
       //   infoWindow: InfoWindow(
       //     title: 'Marker Title Second ',
       //     snippet: 'My Custom Subtitle',
       //   ),
       //   icon: markerbitmap,
       // ));
       // tepmarkers.add(Marker(
       //   markerId: MarkerId(showLocation.toString()),
       //   position: LatLng(21.228125, 72.833771),
       //   infoWindow: InfoWindow(
       //     title: 'Marker Title Third ',
       //     snippet: 'My Custom Subtitle',
       //   ),
       //   icon: markerbitmap,
       // ));
       // tepmarkers.add(Marker(
       //   markerId: MarkerId(showLocation.toString()),
       //   position: LatLng(21.247180, 72.890880),
       //   infoWindow: InfoWindow(
       //     title: 'Marker Title Third ',
       //     snippet: 'My Custom Subtitle',
       //   ),
       //   icon: markerbitmap,
       // ));
       // setState(() {
       //   markers = tepmarkers;
       //   isloading = false;
       //
       // });
     });


   }
   Timer? timer;

   @override
   void initState() {
     super.initState();
     getmarkers();
     timer = Timer.periodic(Duration(seconds: 15), (Timer t) => getmarkers());
   }

   @override
   void dispose() {
     timer?.cancel();
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map"),
      actions: [
        // PopupMenuButton(itemBuilder: (context) {
        //
        // },)
      ]),
      body: (isloading)?CircularProgressIndicator():GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: showLocation,
          zoom: 14.4746,
        ),
        markers: markers,
        onMapCreated: (controller)
        {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }

}
