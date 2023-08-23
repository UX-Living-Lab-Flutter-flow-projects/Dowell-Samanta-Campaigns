import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

List<dynamic>? convertToList(List<dynamic>? data) {
  return data;
}

double getlan(LatLng latlng) {
  double lat = latlng.latitude;
  return lat!;
}

double getlon(LatLng latlng) {
  double lng = latlng.longitude;
  //String lat = latlng.latitude as String;
  //String lng = latlng.longitude as String;
  return lng!;
}

dynamic jsondata(
  List<String>? address,
  List<LatLng>? latlon,
) {
  List<Map<String, dynamic>> data = [];

  for (int i = 0, n = address!.length; i < n; ++i) {
    Map<String, dynamic> map = {
      'Address': address.elementAt(i),
      'lat_lon': latlon!.elementAt(i)
    };

    data.add(map);
  }
  return json.encode(data);
}

String latlngToString(LatLng latlng) {
  double lat = latlng.latitude;
  double lng = latlng.longitude;
  //String lat = latlng.latitude as String;
  //String lng = latlng.longitude as String;
  return "$lat,$lng";
}

LatLng? newCustomFunction(
  double? lat,
  double? lng,
) {
  return LatLng(lat!, lng!);
}

List<String>? refineCategoryList(
  List<String>? categoryList,
  String? categoryAdded,
) {
  if (!categoryList!.contains(categoryAdded)) {
    categoryList.add(categoryAdded!);
    //FFAppState().categoriesState.add(categoryAdded!);
  }

  return categoryList;
}

String? saveSessionID(String? qrid) {
  return qrid;
}
