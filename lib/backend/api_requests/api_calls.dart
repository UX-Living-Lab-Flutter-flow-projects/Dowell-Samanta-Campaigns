import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class ListOfCitiesAPICall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'ListOfCities API',
      apiUrl:
          'https://100074.pythonanywhere.com/regions/johnDoe123/haikalsb1234/100074/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class NearbyPlaceCall {
  static Future<ApiCallResponse> call({
    String? query = 'school',
    String? location = '6.5243793, 3.3792057',
    int? radius = 2000,
    String? key = 'AIzaSyAsH8omDk8y0lSGLTW9YtZiiQ2MkmsF-uQ',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'NearbyPlace',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
      callType: ApiCallType.GET,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      params: {
        'query': query,
        'location': location,
        'radius': radius,
        'key': key,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic lat(dynamic response) => getJsonField(
        response,
        r'''$.results[:].geometry.location.lat''',
        true,
      );
  static dynamic lng(dynamic response) => getJsonField(
        response,
        r'''$.results[:].geometry.location.lng''',
        true,
      );
  static dynamic placeID(dynamic response) => getJsonField(
        response,
        r'''$.results[:].place_id''',
        true,
      );
  static dynamic address(dynamic response) => getJsonField(
        response,
        r'''$.results[:].formatted_address''',
        true,
      );
  static dynamic placeName(dynamic response) => getJsonField(
        response,
        r'''$.results[:].name''',
        true,
      );
  static dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
}

class LinkBasedLoginCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? os = '',
    String? device = '',
    String? browser = '',
    String? location = '',
    String? time = '',
    String? connection = '',
    String? ip = '',
  }) {
    final body = '''
{
  "Username": "${username}",
  "OS": "${os}",
  "Device": "${device}",
  "Browser": "${browser}",
  "Location": "${location}",
  "Time": "${time}",
  "Connection": "${connection}",
  "IP": "${ip}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Link based login',
      apiUrl: 'https://100014.pythonanywhere.com/api/linkbased/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class DirectionsCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'Directions',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/directions/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class DirectionDetailsCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'Direction details',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/details/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class CreateEventCall {
  static Future<ApiCallResponse> call({
    String? ipAddress = '192.168.0.155',
    String? loginId = '',
    String? sessionId = '',
    String? regionalTime = '',
    String? dowellTime = '',
    String? location = '',
  }) {
    final body = '''
{
  "platformcode": "FB",
  "citycode": "101",
  "daycode": "0",
  "dbcode": "pfm",
  "ip_address": "${ipAddress}",
  "login_id": "${loginId}",
  "session_id": "${sessionId}",
  "processcode": "1",
  "location": "${location}",
  "objectcode": "1",
  "instancecode": "100051",
  "context": "afdafa ",
  "document_id": "3004",
  "rules": "some rules",
  "status": "work",
  "data_type": "learn",
  "purpose_of_usage": "add",
  "colour": "color value",
  "hashtags": "hash tag alue",
  "mentions": "mentions value",
  "emojis": "emojis",
  "bookmarks": "a book marks"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Event',
      apiUrl: 'https://uxlivinglab.pythonanywhere.com/create_event',
      callType: ApiCallType.POST,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic isSuccess(dynamic response) => getJsonField(
        response,
        r'''$.is_success''',
      );
  static dynamic eventID(dynamic response) => getJsonField(
        response,
        r'''$.event_id''',
      );
}

class NearbyPlacesDataCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'Nearby Places Data',
      apiUrl: 'https://uxlivinglab.pythonanywhere.com/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class SendLogDataCall {
  static Future<ApiCallResponse> call({
    String? mongoID = '',
    String? reqID = '',
    String? eventId = '',
    String? dataTimeDone = '',
    String? userName = '',
    String? sessionId = '',
    String? locationDone = '',
  }) {
    final body = '''
{
  "cluster": "dowellmap",
  "collection": "log",
  "command": "insert",
  "database": "dowellmap",
  "document": "log",
  "field": {
    "data_time_done": "${dataTimeDone}",
    "eventId": "${eventId}",
    "location_done": "${locationDone}",
    "req_type": "<reqType>",
    "session_id": "${sessionId}",
    "user_name": "${userName}",
    "mongo_id": "${mongoID}",
    "req_id": "${reqID}"
  },
  "function_ID": "ABCDE",
  "platform": "bangalore",
  "team_member_ID": "1155",
  "update_field": {
    "order_nos": 1
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Log Data',
      apiUrl: 'https://uxlivinglab.pythonanywhere.com/',
      callType: ApiCallType.POST,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class IpifyCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'ipify',
      apiUrl: 'https://api.ipify.org/?format=json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic deviceIP(dynamic response) => getJsonField(
        response,
        r'''$.ip''',
      );
}

class MymapCall {
  static Future<ApiCallResponse> call({
    String? placeName = '',
    String? category = '',
    String? address = '',
    String? locationCord = '',
    String? dayHours = '',
    String? phone = '',
    String? website = '',
    String? hours = '',
    String? typeOfData = '',
    String? eventId = '',
    bool? isTestData = true,
    String? country = '',
  }) {
    final body = '''
{
  "cluster": "dowellmap",
  "database": "dowellmap",
  "collection": "my_map",
  "document": "my_map",
  "team_member_ID": "1164",
  "function_ID": "ABCDE",
  "command": "insert",
  "field": {
    "place_name": "${placeName}",
    "category": "${category}",
    "address": "${address}",
    "country": "${country}",
    "location_coord": "${locationCord}",
    "day_hours": "${dayHours}",
    "phone": "${phone}",
    "website": "${website}",
    "hours": "${hours}",
    "type_of_data": "${typeOfData}",
    "eventId": "${eventId}",
    "is_test_data": ${isTestData}
  },
  "update_field": {
    "order_nos": 21
  },
  "platform": "bangalore"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'mymap',
      apiUrl: 'https://uxlivinglab.pythonanywhere.com/',
      callType: ApiCallType.POST,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic isSuccessful(dynamic response) => getJsonField(
        response,
        r'''$.isSuccess''',
      );
  static dynamic insertedIDD(dynamic response) => getJsonField(
        response,
        r'''$.inserted_id''',
      );
}

class GetMymapCall {
  static Future<ApiCallResponse> call({
    double? radius1,
    double? radius2,
    double? centerLat,
    double? centerLon,
    String? query = '',
    String? dataType = '',
    String? apiKey = 'ghdaghagah',
  }) {
    final body = '''
{
  "radius1": ${radius1},
  "radius2": ${radius2},
  "center_lat": ${centerLat},
  "center_lon": ${centerLon},
  "query_string": "${query}",
  "data_type": "registered",
  "api_key": "${apiKey}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetMymap',
      apiUrl: 'https://100086.pythonanywhere.com/accounts/get-local-nearby/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic locationCord(dynamic response) => getJsonField(
        response,
        r'''$.data[:].location_coord''',
        true,
      );
  static dynamic distance(dynamic response) => getJsonField(
        response,
        r'''$.data[:].hav_distances''',
        true,
      );
  static dynamic category(dynamic response) => getJsonField(
        response,
        r'''$.data[:].category''',
        true,
      );
  static dynamic placeId(dynamic response) => getJsonField(
        response,
        r'''$.data[:].place_id''',
        true,
      );
  static dynamic placeName(dynamic response) => getJsonField(
        response,
        r'''$.data[:].place_name''',
        true,
      );
  static dynamic refinedData(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class GetCategoryCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Category',
      apiUrl: 'https://100086.pythonanywhere.com/accounts/get-categories/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic categoryList(dynamic response) => getJsonField(
        response,
        r'''$.categories''',
        true,
      );
}

class LogoutAPICall {
  static Future<ApiCallResponse> call({
    String? sessionId = '',
  }) {
    final body = '''
{
  "session_id": "${sessionId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'LogoutAPI',
      apiUrl: 'https://100014.pythonanywhere.com/api/mobilelogout/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class TwoCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'two',
      apiUrl: 'www.google.com',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ThreeCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'three',
      apiUrl: 'www.google.com',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class FourCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'four ',
      apiUrl: 'www.google.com',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class FiveCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'five',
      apiUrl: 'www.google.com',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
