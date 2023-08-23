// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;

import 'dart:io';

var ip;

Future<String> getIpAddress() async {
  var response = await http.get(Uri.parse('https://api.ipify.org'));
  if (response.statusCode == 200) {
    ip = response.body;
    return ip;
  } else {
    throw Exception('Failed to get user IP address');
  }
}
