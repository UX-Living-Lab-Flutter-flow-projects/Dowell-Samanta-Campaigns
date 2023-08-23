import '/backend/api_requests/api_calls.dart';
import '/components/menu_components/menu_components_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/place.dart';
import 'dart:io';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'livinglabmap_model.dart';
export 'livinglabmap_model.dart';

class LivinglabmapWidget extends StatefulWidget {
  const LivinglabmapWidget({Key? key}) : super(key: key);

  @override
  _LivinglabmapWidgetState createState() => _LivinglabmapWidgetState();
}

class _LivinglabmapWidgetState extends State<LivinglabmapWidget> {
  late LivinglabmapModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LivinglabmapModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().sessionId != null && FFAppState().sessionId != '') {
        setState(() {
          FFAppState().isAuthUser = true;
        });
      } else {
        setState(() {
          FFAppState().isAuthUser = false;
        });
      }

      _model.isLocationEnable = await actions.checkLocationEnabled();
      if (_model.isLocationEnable != true) {
        var confirmDialogResponse = await showDialog<bool>(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('Location Service'),
                  content: Text(
                      'To continue, please turn on  your location using Google  location service.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, true),
                      child: Text('Turn on'),
                    ),
                  ],
                );
              },
            ) ??
            false;
        await actions.gotoSettings();
      }
      _model.myIPAddress = await IpifyCall.call();
      setState(() {
        FFAppState().myIpAddress = IpifyCall.deviceIP(
          (_model.myIPAddress?.jsonBody ?? ''),
        ).toString().toString();
      });
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _model.textController1?.text = FFLocalizations.of(context).getText(
            'iheue23a' /* 0 */,
          );
          _model.textController2?.text = FFLocalizations.of(context).getText(
            '4cnw2jqj' /* 2000 */,
          );
          _model.textController3?.text = FFLocalizations.of(context).getText(
            '28ehlezs' /* school */,
          );
        }));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return FutureBuilder<ApiCallResponse>(
      future: LinkBasedLoginCall.call(
        username: FFAppState().sessionId,
        device: isAndroid.toString(),
        os: isAndroid.toString(),
        browser: 'browser',
        location: currentUserLocationValue?.toString(),
        time: dateTimeFormat(
          'Hm',
          getCurrentTimestamp,
          locale: FFLocalizations.of(context).languageCode,
        ),
        connection: 'wifi',
        ip: FFAppState().myIpAddress,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final livinglabmapLinkBasedLoginResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            drawer: Drawer(
              elevation: 16.0,
              child: wrapWithModel(
                model: _model.menuComponentsModel,
                updateCallback: () => setState(() {}),
                child: MenuComponentsWidget(),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.07,
                      decoration: BoxDecoration(
                        color: Color(0xFF03804D),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (FFAppState().isLogedIn == true)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 35.0,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'tp79swum' /* DoWell Maps */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 18.0,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    40.0, 0.0, 0.0, 0.0),
                                child: FlutterFlowLanguageSelector(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  backgroundColor: Color(0xFF005734),
                                  borderColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  dropdownColor: Color(0xFF005734),
                                  dropdownIconColor: Color(0xFF14181B),
                                  borderRadius: 8.0,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.0,
                                  ),
                                  hideFlags: false,
                                  flagSize: 24.0,
                                  flagTextGap: 8.0,
                                  currentLanguage:
                                      FFLocalizations.of(context).languageCode,
                                  languages: FFLocalizations.languages(),
                                  onChanged: (lang) =>
                                      setAppLanguage(context, lang),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              'placedetail',
                              queryParameters: {
                                'ipAddress': serializeParam(
                                  FFAppState().myIpAddress,
                                  ParamType.String,
                                ),
                                'sessionID': serializeParam(
                                  FFAppState().sessionId,
                                  ParamType.String,
                                ),
                                'currentCord': serializeParam(
                                  FFAppState().selectedLocation,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.rightToLeft,
                                ),
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: custom_widgets.MyMapWidget(
                              width: double.infinity,
                              height: double.infinity,
                              radius1:
                                  double.parse(_model.textController1.text),
                              radius2:
                                  double.parse(_model.textController2.text),
                              query: _model.textController3.text,
                              iOSGoogleMapsApiKey: FFAppState().iosAPIKey,
                              androidGoogleMapsApiKey: FFAppState().androidKey,
                              webGoogleMapsApiKey: FFAppState().webMapApiKey,
                              origin:
                                  _model.radioButtonValue == 'Current Location'
                                      ? currentUserLocationValue
                                      : _model.placePickerValue.latLng,
                              result: _model.googleResult,
                              address: _model.googlePlaceName,
                              clearmap: FFAppState().clearmap,
                              dbResult: _model.dblocationCord,
                              dbAddress: _model.dbPlacename,
                              PlaceIds: _model.placeIDs,
                              navigateTo: () async {
                                context.pushNamed(
                                  'placedetail',
                                  queryParameters: {
                                    'ipAddress': serializeParam(
                                      FFAppState().myIpAddress,
                                      ParamType.String,
                                    ),
                                    'currentCord': serializeParam(
                                      FFAppState().selectedLocation,
                                      ParamType.String,
                                    ),
                                    'sessionID': serializeParam(
                                      '',
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.bottomToTop,
                                    ),
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (FFAppState().currentAddress == '2')
                                Align(
                                  alignment: AlignmentDirectional(1.03, -0.97),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      '2puxfdgn' /* Save */,
                                    ),
                                    options: FFButtonOptions(
                                      height: 49.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFF03804D),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                              if (FFAppState().isLogedIn == true)
                                Align(
                                  alignment: AlignmentDirectional(1.03, -0.97),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      setState(() {
                                        FFAppState().currentAddress = '2';
                                      });
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('success'),
                                            content: Text(
                                                'Place add to campagn list'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      '0w5q1vi5' /* Add place */,
                                    ),
                                    icon: Icon(
                                      Icons.add,
                                      size: 15.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 49.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFF03804D),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                  ),
                                ),
                              if (valueOrDefault<bool>(
                                FFAppState().isLogedIn == false,
                                true,
                              ))
                                Align(
                                  alignment: AlignmentDirectional(1.03, -0.97),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'login',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.rightToLeft,
                                          ),
                                        },
                                      );
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'soa6i3oi' /* Log in */,
                                    ),
                                    options: FFButtonOptions(
                                      height: 49.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFF03804D),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 16.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: Image.asset(
                                          'assets/images/background.jpg',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(-0.15, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (_model.radioButtonValue ==
                                              'Select Location')
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.05, -1.0),
                                              child: FlutterFlowPlacePicker(
                                                iOSGoogleMapsApiKey:
                                                    'AIzaSyAD6nxAHweq0zMBZkI5bcUWJI0k3fLLhVk',
                                                androidGoogleMapsApiKey:
                                                    'AIzaSyA_i4bbFV0iKxU_nUI7L3p0--r6UR89du4',
                                                webGoogleMapsApiKey:
                                                    'AIzaSyAsH8omDk8y0lSGLTW9YtZiiQ2MkmsF-uQ',
                                                onSelect: (place) async {
                                                  setState(() =>
                                                      _model.placePickerValue =
                                                          place);
                                                },
                                                defaultText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'vmzmf6u8' /* Search Location */,
                                                ),
                                                icon: Icon(
                                                  Icons.place,
                                                  color: Colors.white,
                                                  size: 16.0,
                                                ),
                                                buttonOptions: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 56.0,
                                                  color: Color(0xFF03804D),
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.white,
                                                            letterSpacing: 2.0,
                                                          ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                              ),
                                            ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 8.0, 10.0, 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    FlutterFlowRadioButton(
                                                      options: [
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'zzw54amt' /* Current Location */,
                                                        ),
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'm4vt7298' /* Select Location */,
                                                        )
                                                      ].toList(),
                                                      onChanged: (val) async {
                                                        setState(() {});
                                                        setState(() {
                                                          FFAppState()
                                                                  .currentLocation =
                                                              _model
                                                                  .radioButtonValue!;
                                                        });
                                                      },
                                                      controller: _model
                                                              .radioButtonValueController ??=
                                                          FormFieldController<
                                                                  String>(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                        'j662l18p' /* Current Location */,
                                                      )),
                                                      optionHeight: 24.0,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                      textPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0),
                                                      buttonPosition:
                                                          RadioButtonPosition
                                                              .left,
                                                      direction:
                                                          Axis.horizontal,
                                                      radioButtonColor:
                                                          Color(0xFF015534),
                                                      inactiveRadioButtonColor:
                                                          Color(0x8A000000),
                                                      toggleable: false,
                                                      horizontalAlignment:
                                                          WrapAlignment.start,
                                                      verticalAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 0.0, 20.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'jmek49of' /* Distance Between */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController1,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                'l41emut2' /* From Distance */,
                                                              ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF015534),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: _model
                                                                .textController1Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController2,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                'tq8kr8vu' /* To Distance */,
                                                              ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF015534),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: _model
                                                                .textController2Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 12.0, 10.0, 16.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 5.0,
                                                        borderWidth: 1.0,
                                                        buttonSize: 43.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                        icon: Icon(
                                                          Icons.refresh,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 20.0,
                                                        ),
                                                        showLoadingIndicator:
                                                            true,
                                                        onPressed: () async {
                                                          setState(() {
                                                            FFAppState()
                                                                    .clearmap =
                                                                true;
                                                          });
                                                          if (FFAppState()
                                                                  .clearmap ==
                                                              true) {
                                                            setState(() {
                                                              _model.textController1
                                                                      ?.text =
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                'iheue23a' /* 0 */,
                                                              );
                                                              _model.textController2
                                                                      ?.text =
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                '4cnw2jqj' /* 2000 */,
                                                              );
                                                              _model.textController3
                                                                      ?.text =
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                '28ehlezs' /* school */,
                                                              );
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    8.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController3,
                                                            onChanged: (_) =>
                                                                EasyDebounce
                                                                    .debounce(
                                                              '_model.textController3',
                                                              Duration(
                                                                  milliseconds:
                                                                      2000),
                                                              () => setState(
                                                                  () {}),
                                                            ),
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                '4ar1jv3k' /* Search  e.g School, Park */,
                                                              ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF015534),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              suffixIcon: _model
                                                                      .textController3!
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        _model
                                                                            .textController3
                                                                            ?.clear();
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: Color(
                                                                            0xFF757575),
                                                                        size:
                                                                            22.0,
                                                                      ),
                                                                    )
                                                                  : null,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                            validator: _model
                                                                .textController3Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        borderRadius: 5.0,
                                                        borderWidth: 1.0,
                                                        buttonSize: 46.0,
                                                        fillColor:
                                                            Color(0xFF03804D),
                                                        icon: Icon(
                                                          Icons.search_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          size: 20.0,
                                                        ),
                                                        showLoadingIndicator:
                                                            true,
                                                        onPressed: () async {
                                                          currentUserLocationValue =
                                                              await getCurrentUserLocation(
                                                                  defaultLocation:
                                                                      LatLng(
                                                                          0.0,
                                                                          0.0));
                                                          setState(() {
                                                            FFAppState()
                                                                    .clearmap =
                                                                false;
                                                          });
                                                          await actions
                                                              .hideSoftKeyboard();
                                                          _model.nearbyPlaceResponse =
                                                              await NearbyPlaceCall
                                                                  .call(
                                                            query: _model
                                                                .textController3
                                                                .text,
                                                            location: functions.latlngToString(FFAppState()
                                                                        .currentLocation ==
                                                                    'Current Location'
                                                                ? currentUserLocationValue!
                                                                : _model
                                                                    .placePickerValue
                                                                    .latLng),
                                                            radius: int
                                                                .tryParse(_model
                                                                    .textController2
                                                                    .text),
                                                            key: () {
                                                              if (isAndroid) {
                                                                return FFAppState()
                                                                    .androidKey;
                                                              } else if (isiOS) {
                                                                return FFAppState()
                                                                    .iosAPIKey;
                                                              } else {
                                                                return FFAppState()
                                                                    .webMapApiKey;
                                                              }
                                                            }(),
                                                          );
                                                          if ((_model
                                                                  .nearbyPlaceResponse
                                                                  ?.succeeded ??
                                                              true)) {
                                                            if (functions
                                                                    .convertToList(
                                                                        NearbyPlaceCall
                                                                            .data(
                                                                      (_model.nearbyPlaceResponse
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    )?.toList())
                                                                    ?.length !=
                                                                0) {
                                                              _model.googleResult =
                                                                  await actions
                                                                      .refineGoogleResult(
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].geometry.location.lat''',
                                                                )!,
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].geometry.location.lng''',
                                                                )!,
                                                                double.parse(_model
                                                                    .textController1
                                                                    .text),
                                                                double.parse(_model
                                                                    .textController2
                                                                    .text),
                                                                FFAppState().currentLocation ==
                                                                        'Current Location'
                                                                    ? currentUserLocationValue!
                                                                    : _model
                                                                        .placePickerValue
                                                                        .latLng,
                                                              );
                                                              _model.placeIDs =
                                                                  await actions
                                                                      .refineplaceid(
                                                                double.parse(_model
                                                                    .textController1
                                                                    .text),
                                                                double.parse(_model
                                                                    .textController2
                                                                    .text),
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].geometry.location.lat''',
                                                                )!,
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].geometry.location.lng''',
                                                                )!,
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].place_id''',
                                                                )!,
                                                                FFAppState().currentLocation ==
                                                                        'Current Location'
                                                                    ? currentUserLocationValue!
                                                                    : _model
                                                                        .placePickerValue
                                                                        .latLng,
                                                              );
                                                              _model.googlePlaceName =
                                                                  await actions
                                                                      .getGooglePlaceName(
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].name''',
                                                                ),
                                                                double.parse(_model
                                                                    .textController1
                                                                    .text),
                                                                FFAppState().currentLocation ==
                                                                        'Current Location'
                                                                    ? currentUserLocationValue!
                                                                    : _model
                                                                        .placePickerValue
                                                                        .latLng,
                                                                double.parse(_model
                                                                    .textController2
                                                                    .text),
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].geometry.location.lat''',
                                                                )!,
                                                                getJsonField(
                                                                  (_model.nearbyPlaceResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.results[:].geometry.location.lng''',
                                                                )!,
                                                              );
                                                              _model.evenntID =
                                                                  await CreateEventCall
                                                                      .call(
                                                                ipAddress:
                                                                    FFAppState()
                                                                        .myIpAddress,
                                                                loginId:
                                                                    FFAppState()
                                                                        .sessionId,
                                                                sessionId:
                                                                    FFAppState()
                                                                        .sessionId,
                                                              );
                                                              if ((_model
                                                                      .evenntID
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                _model.currentAddress =
                                                                    await actions
                                                                        .getAddressFromLatLng(
                                                                  FFAppState().currentLocation ==
                                                                          'Current Location'
                                                                      ? currentUserLocationValue!
                                                                      : _model
                                                                          .placePickerValue
                                                                          .latLng,
                                                                );
                                                                setState(() {
                                                                  FFAppState()
                                                                          .currentAddress =
                                                                      _model
                                                                          .currentAddress!;
                                                                });
                                                                _model.logResponse =
                                                                    await SendLogDataCall
                                                                        .call(
                                                                  mongoID:
                                                                      random_data
                                                                          .randomString(
                                                                    1,
                                                                    10,
                                                                    true,
                                                                    false,
                                                                    false,
                                                                  ),
                                                                  reqID: random_data
                                                                      .randomString(
                                                                    1,
                                                                    10,
                                                                    true,
                                                                    false,
                                                                    false,
                                                                  ),
                                                                  dataTimeDone:
                                                                      dateTimeFormat(
                                                                    'yMMMd',
                                                                    getCurrentTimestamp,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  userName: random_data
                                                                      .randomName(
                                                                          true,
                                                                          true),
                                                                  eventId:
                                                                      CreateEventCall
                                                                          .eventID(
                                                                    (_model.evenntID
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ).toString(),
                                                                  sessionId:
                                                                      FFAppState()
                                                                          .sessionId,
                                                                  locationDone: (FFAppState().currentLocation ==
                                                                              'Current Location'
                                                                          ? currentUserLocationValue
                                                                          : _model
                                                                              .placePickerValue
                                                                              .latLng)
                                                                      ?.toString(),
                                                                );
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Search event failed!',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Something went wrong',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Please wait...',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                              ),
                                                            );
                                                          }

                                                          _model.mymapBackendRefinedResult =
                                                              await GetMymapCall
                                                                  .call(
                                                            radius1: double
                                                                .tryParse(_model
                                                                    .textController1
                                                                    .text),
                                                            radius2: double
                                                                .tryParse(_model
                                                                    .textController2
                                                                    .text),
                                                            centerLat: functions.getlan(FFAppState()
                                                                        .currentLocation ==
                                                                    'Current Location'
                                                                ? currentUserLocationValue!
                                                                : _model
                                                                    .placePickerValue
                                                                    .latLng),
                                                            centerLon: functions.getlon(FFAppState()
                                                                        .currentLocation ==
                                                                    'Current Location'
                                                                ? currentUserLocationValue!
                                                                : _model
                                                                    .placePickerValue
                                                                    .latLng),
                                                            query: _model
                                                                .textController3
                                                                .text,
                                                            dataType:
                                                                'registered',
                                                            apiKey: 'fgffgff',
                                                          );
                                                          if ((_model
                                                                  .mymapBackendRefinedResult
                                                                  ?.succeeded ??
                                                              true)) {
                                                            if (functions
                                                                    .convertToList(
                                                                        GetMymapCall
                                                                            .refinedData(
                                                                      (_model.mymapBackendRefinedResult
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    )?.toList())
                                                                    ?.length !=
                                                                0) {
                                                              _model.dblocationCord =
                                                                  await actions
                                                                      .getLocatCordFromString(
                                                                (getJsonField(
                                                                  (_model.mymapBackendRefinedResult
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.data[:].location_coord''',
                                                                ) as List)
                                                                    .map<String>(
                                                                        (s) => s
                                                                            .toString())
                                                                    .toList(),
                                                              );
                                                              _model.dbPlacename =
                                                                  await actions
                                                                      .getDbPlaceName(
                                                                getJsonField(
                                                                  (_model.mymapBackendRefinedResult
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.data[:].place_name''',
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Search failed , please try again.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                              ),
                                                            );
                                                          }

                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
