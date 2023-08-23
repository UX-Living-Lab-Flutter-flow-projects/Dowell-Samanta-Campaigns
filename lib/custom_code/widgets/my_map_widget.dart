// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

//import 'package:do_well_maps/flutter_flow/flutter_flow_google_map.dart';
// Set your widget name, define your parameter, and then add the
// boilerplate code using the button on the right!
import 'package:google_maps_flutter/google_maps_flutter.dart' hide LatLng;
import 'package:google_maps_flutter/google_maps_flutter.dart' as latlng;
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class MyMapWidget extends StatefulWidget {
  const MyMapWidget(
      {Key? key,
      this.width,
      this.height,
      this.origin,
      required this.radius1,
      required this.radius2,
      this.query,
      this.result,
      this.address,
      required this.clearmap,
      required this.iOSGoogleMapsApiKey,
      required this.androidGoogleMapsApiKey,
      required this.webGoogleMapsApiKey,
      this.dbResult,
      this.dbAddress,
      this.PlaceIds,
      required this.navigateTo})
      : super(key: key);

  final double? width;
  final double? height;
  final LatLng? origin;
  final double radius1;
  final double radius2;
  final String? query;
  final List<LatLng>? result;
  final List<String>? address;
  final bool clearmap;
  final String iOSGoogleMapsApiKey;
  final String androidGoogleMapsApiKey;
  final String webGoogleMapsApiKey;
  final List<LatLng>? dbResult;
  final List<String>? dbAddress;
  final List<String>? PlaceIds;
  final Future<dynamic> Function() navigateTo;

  @override
  _MyMapWidget createState() => _MyMapWidget();
}

class _MyMapWidget extends State<MyMapWidget> {
  //late var ori;
  //Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _controller;

  late GoogleMapPolyline? googleMapPolyline;
  final Set<Marker> markers = new Set();
  final Set<Marker> draggableMarkers = new Set();
  late var placepicked;
  late var selectedlocatn;
  late BitmapDescriptor pinLocationIcon;

  String get googleMapsApiKey {
    if (kIsWeb) {
      return widget.webGoogleMapsApiKey;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return '';
      case TargetPlatform.iOS:
        return widget.iOSGoogleMapsApiKey;
      case TargetPlatform.android:
        return widget.androidGoogleMapsApiKey;
      default:
        return widget.webGoogleMapsApiKey;
    }
  }

  final List<latlng.Polyline> polyline = [];
  List<latlng.LatLng>? routeCoords = [];
  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }

  @override
  void initState() {
    googleMapPolyline = new GoogleMapPolyline(apiKey: googleMapsApiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Container(
        width: widget.width,
        height: widget.height,
        child: GoogleMap(
          zoomControlsEnabled: false,
          tiltGesturesEnabled: true,
          markers: getmarkers(
                  widget.PlaceIds,
                  widget.result,
                  widget.dbResult,
                  widget.dbAddress,
                  widget.address,
                  widget.origin!,
                  widget.clearmap,
                  context)
              .toSet(),
          //debugPrint(
          //"..............................THIS Check Point crossed.....................");
          polylines: Set.from(polyline),
          initialCameraPosition: CameraPosition(
              target: getPlacePicker(), bearing: 180.0, tilt: 30.0),
          circles: Set.from([
            Circle(
                circleId: CircleId(generateRandomString(10)),
                center: latlng.LatLng(
                    widget.origin!.latitude, widget.origin!.longitude),
                radius: widget.radius1,
                strokeWidth: 2,
                strokeColor: Color.fromARGB(255, 3, 124, 7),
                fillColor: Colors.transparent),
            Circle(
                circleId: CircleId(generateRandomString(10)),
                center: latlng.LatLng(
                    widget.origin!.latitude, widget.origin!.longitude),
                radius: widget.radius2,
                strokeWidth: 2,
                strokeColor: Color.fromARGB(255, 3, 124, 7),
                fillColor: Colors.transparent),
          ]),
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              _controller = controller;
              googleMapPolyline =
                  new GoogleMapPolyline(apiKey: googleMapsApiKey);
              _controller?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: latlng.LatLng(
                        widget.origin!.latitude, widget.origin!.longitude),
                    zoom: 16,
                    bearing: 180.0,
                    tilt: 30.0,
                  ),
                ),
              );
            });
          },
        ));
  }

  String getlatlngToString(latlng.LatLng latlng) {
    double lat = latlng.latitude;
    double lng = latlng.longitude;
    return "$lat,$lng";
  }

  _getDraggableMarkers(
      LatLng origin, bool clearmap, BuildContext context) async {
    setState(() async {
      double meters = 800;
      double coef = meters / 111320.0;
      double originLat = widget.origin!.latitude;
      double originLong = widget.origin!.longitude;

      double new_lat = originLat + coef;

      double new_long = originLong + coef / cos(originLong * 0.01745);

      markers.add(Marker(
          draggable: true,
          markerId: MarkerId(generateRandomString(10)),
          position: latlng.LatLng(new_lat, new_long), //position of marker
          infoWindow: InfoWindow(title: "Add Location"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onDragEnd: ((newPosition) {
            debugPrint("Dragged Loc ${newPosition}");
            selectedlocatn = getlatlngToString(
                latlng.LatLng(newPosition.latitude, newPosition.longitude));

            FFAppState().selectedLocation = getlatlngToString(
                latlng.LatLng(newPosition.latitude, newPosition.longitude));
          }),
          onTap: () async {
            Widget addToMyMap = SimpleDialogOption(
              child: const Text('Add place to map'),
              onPressed: () {
                widget.navigateTo();
              },
            );

            Widget FeatureB = SimpleDialogOption(
              child: const Text('Feature B'),
              onPressed: () {},
            );

            Widget FeatureC = SimpleDialogOption(
              child: const Text('Feature C'),
              onPressed: () {},
            );

            // set up the SimpleDialog
            SimpleDialog dialog = SimpleDialog(
              title: Text('Location Selected: $selectedlocatn'),
              children: <Widget>[addToMyMap, FeatureB, FeatureC],
            );

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return dialog;
              },
            );
          }));
    });
  }

  Set<Marker> getmarkers(
      List<String>? PlaceIds,
      List<LatLng>? locationInfo,
      List<LatLng>? dblocationInfo,
      List<String>? dbAddress,
      List<String>? googeAddress,
      LatLng origin,
      bool clearmap,
      BuildContext context) {
    if (clearmap) {
      if (markers.length > 1) {
        removeMarker();
      }
    } else {
      // setState(() {});
      setState(() {
        if (markers.length > 1) {
          removeMarker();
        }

        if (FFAppState().isAuthUser == true) {
          _getDraggableMarkers(origin, clearmap, context);
        }
        if (locationInfo == null) {
          debugPrint("Location Info is null");
        }
        if (locationInfo != null) {
          debugPrint("$locationInfo.length");
          debugPrint("This is run");
          for (var i = 0; i < locationInfo.length; i++) {
            markers.add(Marker(
                markerId: MarkerId(PlaceIds!.elementAt(i)),
                position: latlng.LatLng(locationInfo[i].latitude,
                    locationInfo[i].longitude), //position of marker
                infoWindow: InfoWindow(title: googeAddress!.elementAt(i)),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                onTap: () async {
                  //logic for direction api request
                  _computePath(
                      latlng.LatLng(
                          widget.origin!.latitude, widget.origin!.longitude),
                      latlng.LatLng(
                          locationInfo[i].latitude, locationInfo[i].longitude));

                  getPlaceDetail(
                      context, PlaceIds.elementAt(i), locationInfo[i]);
                }));
          }
          debugPrint("G Markers $markers");
        }

        if (dblocationInfo != null) {
          for (var i = 0; i < dblocationInfo.length; i++) {
            markers.add(Marker(
                markerId: MarkerId(PlaceIds!.elementAt(i)),
                position: latlng.LatLng(dblocationInfo[i].latitude,
                    dblocationInfo[i].longitude), //position of marker
                infoWindow: InfoWindow(title: dbAddress!.elementAt(i)),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                onTap: () async {
                  _computePath(
                      latlng.LatLng(
                          widget.origin!.latitude, widget.origin!.longitude),
                      latlng.LatLng(dblocationInfo[i].latitude,
                          dblocationInfo[i].longitude));
                }));
          }
          debugPrint("Db Markers $markers");
          debugPrint("Db Markers ${markers.length}");
        }
      });
    }

    return markers;
  }

  getPlaceDetail(
      BuildContext context, String? PlaceIds, LatLng? locationInfo) async {
    //logic for getting more details from google api
    ///
    ///ADDING OF PRELOADER
    ///
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        builder: (context) {
          return SizedBox(
              height: 100,
              width: double.infinity,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.red)));
        });

    ///
    ///
    ///
    if (PlaceIds != null && locationInfo != null) {
      Map<String, dynamic>? markerDetails;
      var markerId = PlaceIds;
      List<Elements?>? distanceListInfo;

      String getdetailUrl =
          'https://corsproxy.io/?https://maps.googleapis.com/maps/api/place/details/json?placeid=$markerId&key=$googleMapsApiKey';
      try {
        Map<String, String> headers = {
          'Origin':
              '*', // Replace with the origin of your client (your Flutter app's domain)
          'X-Requested-With':
              'XMLHttpRequest', // Indicate that the request was sent using XMLHttpRequest
        };
        final response =
            await http.get(Uri.parse(getdetailUrl), headers: headers);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          debugPrint(":::::: url:::: $getdetailUrl");
          if (jsonResponse['status'] == 'OK') {
            markerDetails = jsonResponse['result'];
            String getdistancetimeUrl =
                'https://corsproxy.io/?https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${widget.origin!.latitude}, ${widget.origin!.longitude}&destinations=${locationInfo.latitude},${locationInfo.longitude}&key=$googleMapsApiKey';

            try {
              final distanceTimeResponse =
                  await http.get(Uri.parse(getdistancetimeUrl));
              if (response.statusCode == 200) {
                final parsed = json.decode(distanceTimeResponse.body);

                DistanceTime distanceTime = DistanceTime.fromJson(parsed);

                //final jsonResponse = json.decode(distanceTimeResponse.body);

                List<Elements?> elements = [];

                if (distanceTime.status == 'OK') {
                  debugPrint("::::: from the distance room element row:::0");
                  if (distanceTime.rows != null &&
                      distanceTime.rows!.length != 0) {
                    debugPrint("::::: from the distance room element row:::1");
                    for (var i = 0; i < distanceTime.rows!.length; i++) {
                      debugPrint(
                          "::::: from the distance room element row:::2");
                      for (var j = 0;
                          j < distanceTime.rows!.elementAt(i).elements!.length;
                          j++) {
                        debugPrint(
                            "::::: from the distance room element row:::3");
                        if (distanceTime.rows
                                ?.elementAt(i)
                                .elements
                                ?.elementAt(j) !=
                            null) {
                          debugPrint(
                              "::::: from the distance room element row:::4:: ${distanceTime.rows?.elementAt(i).elements?.elementAt(j)}");
                          elements.add(distanceTime.rows
                              ?.elementAt(i)
                              .elements
                              ?.elementAt(j));
                        }
                      }
                    }
                  }
                  elements.isNotEmpty ? distanceListInfo = elements : null;
                  debugPrint(
                      "::::: from the distance room element row::: $elements");
                  // print(distanceTime.rows?.elementAt(0).elements?.elementAt(0));

                  ///
                  ///Location for details 2
                  ///
                } else {
                  debugPrint("::::: from the distance room element row:::5");
                  print(
                      'Failed to get distance and time. Status code: ${distanceTimeResponse.statusCode}');
                }

                // if (jsonResponse['status'] == 'OK') {

                // } else {
                //   print(
                //       'Failed to get distance and time. Status code: ${distanceTimeResponse.statusCode}');
                // }
              }
            } catch (e) {
              print('Error getting place distance and time: $e');
            }
            /*return {
                          'placeName': placeName,
                          'formattedPhoneNumber': formattedPhoneNumber,
                          'website': website,
                        };*/
          }
        } else {
          print(
              'Failed to load place details. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching place details: $e');
      }

      ///
      /// THE BOTTOMSHEET CALLER
      ///
      if (markerDetails != null && distanceListInfo != null) {
        Navigator.pop(context);
        debugPrint(":::::::: we have entered the bottomsheet caller::::");
        final res = await showModalBottomSheet(
            context: context,
            isDismissible: false,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            builder: (context) {
              return MakerBottomDetailsBuilder(
                dataInfo: markerDetails!,
                distanceInfo: getShortestDistance(distanceListInfo!)!,
              );
            });
      }
    }
  }

  ///
  ///LOGIC TO GET THE SHORTEST DISTANCE
  ///
  Elements? getShortestDistance(List<Elements?> data) {
    if (data.isNotEmpty) {
      Elements shortestElement = data[0]!;
      //This is to prevent unnessary iterations
      if (data.length == 1) {
        return shortestElement;
      }
      for (Elements? element in data) {
        if (element!.distance!.value! < shortestElement.distance!.value!) {
          shortestElement = element;
        }
        return shortestElement;
      }
    }
    return null;
  }

  removeMarker() {
    polyline.clear();
    setState(() {
      if (markers.length > 1) {
        // Keep the first marker
      }
      final firstMarker = markers.first;
      markers.clear();
      markers.add(firstMarker);
    });

    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _computePath(latlng.LatLng origin, latlng.LatLng destination) async {
    routeCoords = await googleMapPolyline?.getCoordinatesWithLocation(
        origin: origin, destination: destination, mode: RouteMode.driving);

    debugPrint("Result --- ${routeCoords}");

    CameraPosition nepPos =
        CameraPosition(target: origin, zoom: 16, bearing: 180.0, tilt: 30.0);

    _controller?.animateCamera(CameraUpdate.newCameraPosition(nepPos));

    setState(() {
      polyline.clear();
      if (routeCoords != null) {
        polyline.add(latlng.Polyline(
            polylineId: latlng.PolylineId('iter'),
            visible: true,
            points: routeCoords!,
            width: 4,
            color: Colors.blue,
            startCap: Cap.roundCap,
            endCap: Cap.buttCap));
      }
    });
  }

  // function for place picked

  latlng.LatLng getPlacePicker() {
    if (markers.length > 0) {
      // debugPrint(":::::; from the marker trancing::: 00");
      markers.clear();
      setState(() {});
    }
    setState(() {
      placepicked =
          latlng.LatLng(widget.origin!.latitude, widget.origin!.longitude);

      // debugPrint(":::::; from the marker trancing::: 3");
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: placepicked, zoom: 14, bearing: 180.0, tilt: 30.0)));

      markers.add(Marker(
        markerId: MarkerId(generateRandomString(10)),
        position: placepicked, //position of marker
        infoWindow: InfoWindow(
            //popup info
            title: "Starting Point"),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
    debugPrint(":::::; from the marker trancing::: 4");
    debugPrint("Place picked $placepicked");
    return placepicked;
  }
}

///
/// TO REPLACE FROM HERE
///
class DistanceTime {
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<Rows>? rows;
  String? status;

  DistanceTime(
      {this.destinationAddresses,
      this.originAddresses,
      this.rows,
      this.status});

  DistanceTime.fromJson(Map<String, dynamic> json) {
    destinationAddresses = json['destination_addresses'].cast<String>();
    originAddresses = json['origin_addresses'].cast<String>();
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination_addresses'] = this.destinationAddresses;
    data['origin_addresses'] = this.originAddresses;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Rows {
  List<Elements>? elements;

  Rows({this.elements});

  Rows.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(new Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.elements != null) {
      data['elements'] = this.elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elements {
  Distance? distance;
  Distance? duration;
  String? status;

  Elements({this.distance, this.duration, this.status});

  Elements.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}

///
/// IT ENDS HERE
///

//TODO: To be make better later
class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final bool? isCenter;
  final FontStyle? isItalic;
  final Color? color;
  final TextOverflow? overflow;
  final FontWeight? weight;
  const CustomText({
    Key? key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.isCenter,
    this.isItalic,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: (isCenter == true) ? TextAlign.center : TextAlign.left,
      overflow: overflow ?? TextOverflow.clip,
      style: TextStyle(
        fontStyle: isItalic ?? FontStyle.normal,
        fontWeight: weight ?? FontWeight.normal,
        color: color ?? Colors.black,
        fontSize: size ?? 16,
      ),
    );
  }
}

///
/// LOGIC FOR RATING
///
RatingBar generateRating(
    {required double rate, Color? color, double? size, bool? allowHalfRating}) {
  return RatingBar(
    initialRating: rate,
    itemSize: size ?? 12,
    direction: Axis.horizontal,
    allowHalfRating: allowHalfRating ?? false,
    itemCount: 5,
    ignoreGestures: true,
    ratingWidget: RatingWidget(
      full: Icon(Icons.star, color: color ?? Colors.green),
      half: Icon(Icons.star_half, color: color ?? Colors.green),
      empty: Icon(Icons.star_border_outlined, color: color ?? Colors.grey),
    ),
    itemPadding: const EdgeInsets.symmetric(horizontal: 0),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}

class MakerBottomDetailsBuilder extends StatefulWidget {
  final Map<String, dynamic> dataInfo;
  final Elements distanceInfo;
  const MakerBottomDetailsBuilder(
      {super.key, required this.dataInfo, required this.distanceInfo});

  @override
  State<MakerBottomDetailsBuilder> createState() =>
      _MakerBottomDetailsBuilderState();
}

class _MakerBottomDetailsBuilderState extends State<MakerBottomDetailsBuilder> {
  @override
  Widget build(BuildContext context) {
    // ValueNotifier<bool> showOpeningList = useState(false);
    return Stack(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Stack(children: [
          //   ClipRRect(
          //     borderRadius: const BorderRadius.only(
          //       topLeft: Radius.circular(24),
          //       topRight: Radius.circular(24),
          //     ),
          //     child: Image.network(
          //       "https://images.pexels.com/photos/13911606/pexels-photo-13911606.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load",
          //       height: 150,
          //       width: double.infinity,
          //       fit: BoxFit.cover,
          //       loadingBuilder: (BuildContext context, Widget child,
          //           ImageChunkEvent? loadingProgress) {
          //         if (loadingProgress == null) return child;
          //         return Center(
          //           child: CircularProgressIndicator(
          //             value: loadingProgress.expectedTotalBytes != null
          //                 ? loadingProgress.cumulativeBytesLoaded /
          //                     loadingProgress.expectedTotalBytes!
          //                 : null,
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          //   Positioned(
          //     top: 10,
          //     right: 10,
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: const CircleAvatar(
          //         backgroundColor: Colors.black54,
          //         child: Icon(
          //           Icons.close,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   )
          // ]),
          ///
          ///
          ///
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox.shrink(),
            Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black54,
                )),
            const SizedBox.shrink()
          ]),
          const SizedBox(height: 50),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(
                      int.parse(widget.dataInfo["icon_background_color"]
                          .replaceFirst("#", "0xff")),
                    ),
                    child: Image.network(
                      widget.dataInfo["icon"],
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: widget.dataInfo["name"],
                        weight: FontWeight.w600,
                        size: 20,
                      ),
                    ),
                  ),
                  // widget.dataInfo["opening_hours"] != null
                  //     ? Positioned(
                  //         top: 1,
                  //         right: 1,
                  //         child: CircleAvatar(
                  //           radius: 4,
                  //           backgroundColor: widget.dataInfo["opening_hours"]
                  //                   ["open_now"]
                  //               ? Colors.green
                  //               : Colors.red,
                  //         ),
                  //       )
                  //     : SizedBox.shrink(),
                  // ]),
                ]),
                const SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  generateRating(
                      rate: widget.dataInfo["rating"] ?? 0,
                      allowHalfRating: true),
                  const SizedBox(width: 15),
                  widget.dataInfo["opening_hours"] != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Container(
                                height: 12,
                                width: 3,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 15),
                              CustomText(
                                text: widget.dataInfo["opening_hours"]
                                        ["open_now"]
                                    ? "OPEN"
                                    : "CLOSE",
                                weight: FontWeight.w500,
                                size: 13,
                                color: widget.dataInfo["opening_hours"]
                                        ["open_now"]
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ])
                      : SizedBox.shrink(),
                ]),
                const SizedBox(height: 15),
                buildMapInfoTap(
                  context,
                  icon: Icons.location_city,
                  label: widget.dataInfo["formatted_address"] ?? "N/A",
                ),
                const SizedBox(height: 15),
                buildMapInfoTap(
                  context,
                  icon: Icons.phone,
                  label: widget.dataInfo["formatted_phone_number"] ?? "N/A",
                ),
                const SizedBox(height: 15),
                buildMapInfoTap(
                  context,
                  icon: Icons.social_distance,
                  label:
                      "${widget.distanceInfo.distance?.value}m ( ${(widget.distanceInfo.distance!.value! / 1000).toStringAsFixed(2)} Km )",
                ),
                const SizedBox(height: 15),
                buildMapInfoTap(
                  context,
                  icon: Icons.timer,
                  label: "${widget.distanceInfo.duration?.text}",
                ),
                const SizedBox(height: 15),
                buildMapInfoTap(
                  context,
                  icon: Icons.wb_cloudy,
                  label: widget.dataInfo["website"] ?? "N/A",
                ),
              ]),
            ),
          ),
        ]),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      )
    ]);
  }
}

//TODO: convert to custom widget
Row buildMapInfoTap(BuildContext context,
    {required String label, required IconData icon}) {
  return Row(children: [
    Icon(
      icon,
      color: Colors.black26,
    ),
    const SizedBox(width: 10),
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: CustomText(
        text: label,
        overflow: TextOverflow.clip,
        color: Colors.black54,
        weight: FontWeight.w500,
      ),
    )
  ]);
}
