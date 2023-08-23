import 'package:flutter/material.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _useremail =
          await secureStorage.getStringList('ff_useremail') ?? _useremail;
    });
    await _safeInitAsync(() async {
      _isVitingAgain =
          await secureStorage.getBool('ff_isVitingAgain') ?? _isVitingAgain;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  dynamic _response;
  dynamic get response => _response;
  set response(dynamic _value) {
    _response = _value;
  }

  List<String> _useremail = [];
  List<String> get useremail => _useremail;
  set useremail(List<String> _value) {
    _useremail = _value;
    secureStorage.setStringList('ff_useremail', _value);
  }

  void deleteUseremail() {
    secureStorage.delete(key: 'ff_useremail');
  }

  void addToUseremail(String _value) {
    _useremail.add(_value);
    secureStorage.setStringList('ff_useremail', _useremail);
  }

  void removeFromUseremail(String _value) {
    _useremail.remove(_value);
    secureStorage.setStringList('ff_useremail', _useremail);
  }

  void removeAtIndexFromUseremail(int _index) {
    _useremail.removeAt(_index);
    secureStorage.setStringList('ff_useremail', _useremail);
  }

  void updateUseremailAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _useremail[_index] = updateFn(_useremail[_index]);
    secureStorage.setStringList('ff_useremail', _useremail);
  }

  bool _isVitingAgain = true;
  bool get isVitingAgain => _isVitingAgain;
  set isVitingAgain(bool _value) {
    _isVitingAgain = _value;
    secureStorage.setBool('ff_isVitingAgain', _value);
  }

  void deleteIsVitingAgain() {
    secureStorage.delete(key: 'ff_isVitingAgain');
  }

  String _currentLocation = 'Current Location';
  String get currentLocation => _currentLocation;
  set currentLocation(String _value) {
    _currentLocation = _value;
  }

  bool _clearmap = false;
  bool get clearmap => _clearmap;
  set clearmap(bool _value) {
    _clearmap = _value;
  }

  String _usernametype = 'User Name';
  String get usernametype => _usernametype;
  set usernametype(String _value) {
    _usernametype = _value;
  }

  bool _isAuthUser = false;
  bool get isAuthUser => _isAuthUser;
  set isAuthUser(bool _value) {
    _isAuthUser = _value;
  }

  String _iosAPIKey = 'AIzaSyAD6nxAHweq0zMBZkI5bcUWJI0k3fLLhVk';
  String get iosAPIKey => _iosAPIKey;
  set iosAPIKey(String _value) {
    _iosAPIKey = _value;
  }

  String _androidKey = 'AIzaSyA_i4bbFV0iKxU_nUI7L3p0--r6UR89du4';
  String get androidKey => _androidKey;
  set androidKey(String _value) {
    _androidKey = _value;
  }

  String _webMapApiKey = 'AIzaSyAsH8omDk8y0lSGLTW9YtZiiQ2MkmsF-uQ';
  String get webMapApiKey => _webMapApiKey;
  set webMapApiKey(String _value) {
    _webMapApiKey = _value;
  }

  String _myIpAddress = '';
  String get myIpAddress => _myIpAddress;
  set myIpAddress(String _value) {
    _myIpAddress = _value;
  }

  bool _isMarkerTapped = false;
  bool get isMarkerTapped => _isMarkerTapped;
  set isMarkerTapped(bool _value) {
    _isMarkerTapped = _value;
  }

  String _selectedLocation = '';
  String get selectedLocation => _selectedLocation;
  set selectedLocation(String _value) {
    _selectedLocation = _value;
  }

  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;
  set selectedCategory(String _value) {
    _selectedCategory = _value;
  }

  String _newCategoryTyped = '';
  String get newCategoryTyped => _newCategoryTyped;
  set newCategoryTyped(String _value) {
    _newCategoryTyped = _value;
  }

  bool _mapDataReady = false;
  bool get mapDataReady => _mapDataReady;
  set mapDataReady(bool _value) {
    _mapDataReady = _value;
  }

  List<String> _compaignPlacesIdList = [];
  List<String> get compaignPlacesIdList => _compaignPlacesIdList;
  set compaignPlacesIdList(List<String> _value) {
    _compaignPlacesIdList = _value;
  }

  void addToCompaignPlacesIdList(String _value) {
    _compaignPlacesIdList.add(_value);
  }

  void removeFromCompaignPlacesIdList(String _value) {
    _compaignPlacesIdList.remove(_value);
  }

  void removeAtIndexFromCompaignPlacesIdList(int _index) {
    _compaignPlacesIdList.removeAt(_index);
  }

  void updateCompaignPlacesIdListAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _compaignPlacesIdList[_index] = updateFn(_compaignPlacesIdList[_index]);
  }

  bool _isLogedIn = false;
  bool get isLogedIn => _isLogedIn;
  set isLogedIn(bool _value) {
    _isLogedIn = _value;
  }

  String _currentAddress = '';
  String get currentAddress => _currentAddress;
  set currentAddress(String _value) {
    _currentAddress = _value;
  }

  String _sessionId = '';
  String get sessionId => _sessionId;
  set sessionId(String _value) {
    _sessionId = _value;
  }

  bool _selectedCampaign = false;
  bool get selectedCampaign => _selectedCampaign;
  set selectedCampaign(bool _value) {
    _selectedCampaign = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
