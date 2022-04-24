import 'dart:async';

import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:draw_route_googlemap/marker_ganratoe.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMaps extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyMapsState();
  }

}
class MyMapsState extends State<MyMaps>{
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.4435, 78.3772),
    zoom: 14.0,
  );
  List<MarkerId>listMarkerIds=List<MarkerId>.empty(growable: true);
  //final MarkerId markerId = MarkerId("current");

  LatLng latlng3=  LatLng(17.4837, 78.3158);
  LatLng latlng4=  LatLng(17.8651111, 79.474557);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(leading: Icon(Icons.map),backgroundColor: Colors.blue,title: Text("Google Maps With Markers"),),
        body: Container(
          child: Stack(
            children: [
              GoogleMap(initialCameraPosition: _kGooglePlex,
                onTap: (position) {
                  _customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!();
                },

                mapType: MapType.normal,
                markers: Set<Marker>.of(markers.values),

                onMapCreated: (GoogleMapController controler) async {
                  _controller.complete(controler);
                  _customInfoWindowController.googleMapController = controler;
                  MarkerId markerId1 = MarkerId("1");
                  MarkerId markerId2 = MarkerId("2");
                  MarkerId markerId3 = MarkerId("3");
                  MarkerId markerId4 = MarkerId("4");

                  listMarkerIds.add(markerId1);
                  listMarkerIds.add(markerId2);
                  listMarkerIds.add(markerId3);
                  listMarkerIds.add(markerId4);


                  Marker marker1=Marker(
                      markerId: markerId1,
                      position: LatLng(17.4435, 78.3772),
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),infoWindow: InfoWindow(
                      title: "Hytech City",onTap: (){

                    var  bottomSheetController=scaffoldKey.currentState!.showBottomSheet((context) => Container(
                      child: getBottomSheet("17.4435, 78.3772"),
                      height: 250,
                      color: Colors.transparent,
                    ));

                  },snippet: "Snipet Hitech City"
                  ));

                /*  Marker marker2=Marker(markerId: markerId2,position: LatLng(17.4837, 78.3158),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),);*/
                  Marker marker3=Marker(markerId: markerId3,position: LatLng(17.5169, 78.3428),
                      infoWindow: InfoWindow(
                          title: "Miyapur",onTap: (){


                      },snippet: "Miyapur"
                      ));




                  Marker marker2= Marker(
                    markerId: MarkerId("marker_id"),
                    position: latlng3,
                    onTap: () {
                      showcustominfowindow(latlng3);
                    },
                  );



                  final bitmapDescriptor = await MarkerGenerator(110)
                      .createBitmapDescriptorFromIconData(Icons.info, Colors.white, Colors.teal, Colors.transparent);

                  Marker marker4= Marker(
                    markerId: MarkerId("marker_i4"),
                    position: latlng4,
                    onTap: () {
                      showcustominfowindow(latlng4);
                    },
                    icon: bitmapDescriptor
                  );



                  setState(() {
                    markers[markerId1]=marker1;
                    markers[markerId2]=marker2;
                    markers[markerId3]=marker3;
                    markers[markerId4]=marker4;
                  });
                },

              ),

              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 75,
                width: 150,
                offset: 50,
              ),
            ],
          ),
        )
    );
  }




  Widget showcustominfowindow(LatLng latlng3){
   return _customInfoWindowController.addInfoWindow!(
      Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "I am here",
                      style:
                      Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
           Triangle.isosceles(
                              edge: Edge.BOTTOM,
                              child: Container(
                                color: Colors.blue,
                                width: 20.0,
                                height: 10.0,
                              ),
                            ),
        ],
      ),
      latlng3,
    );
  }





  Widget getBottomSheet(String s)
  {
    return Stack(
      children: <Widget>[
        Container(

          margin: EdgeInsets.only(top: 32),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Hytech City Public School \n CBSC",style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      ),),
                      SizedBox(height: 5,),
                      Row(children: <Widget>[

                        Text("4.5",style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        )),
                        Icon(Icons.star,color: Colors.yellow,),
                        SizedBox(width: 20,),
                        Text("970 Folowers",style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                        ))
                      ],),
                      SizedBox(height: 5,),
                      Text("Memorial Park",style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[SizedBox(width: 20,),Icon(Icons.map,color: Colors.blue,),SizedBox(width: 20,),Text("$s")],
              ),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[SizedBox(width: 20,),Icon(Icons.call,color: Colors.blue,),SizedBox(width: 20,),Text("040-123456")],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,

            child: FloatingActionButton(
                child: Icon(Icons.navigation),
                onPressed: (){

                }),
          ),
        )
      ],

    );
  }

}