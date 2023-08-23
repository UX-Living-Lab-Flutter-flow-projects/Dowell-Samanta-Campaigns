import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_bar_top_menu_component_model.dart';
export 'app_bar_top_menu_component_model.dart';

class AppBarTopMenuComponentWidget extends StatefulWidget {
  const AppBarTopMenuComponentWidget({Key? key}) : super(key: key);

  @override
  _AppBarTopMenuComponentWidgetState createState() =>
      _AppBarTopMenuComponentWidgetState();
}

class _AppBarTopMenuComponentWidgetState
    extends State<AppBarTopMenuComponentWidget> {
  late AppBarTopMenuComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarTopMenuComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 50.0,
      child: custom_widgets.AppBarComponent(
        width: double.infinity,
        height: 50.0,
        profileImg: getJsonField(
          FFAppState().response,
          r'''$.userinfo.profile_img''',
        ).toString(),
        orgImg: getJsonField(
          FFAppState().response,
          r'''$.userinfo.org_img''',
        ).toString(),
        sessionId: FFAppState().sessionId,
        onHome: () async {
          context.pushNamed('Home_Page_Screen');
        },
        onExit: () async {
          _model.logoutapiResponse = await LogoutAPICall.call(
            sessionId: FFAppState().sessionId,
          );
          if ((_model.logoutapiResponse?.succeeded ?? true)) {
            FFAppState().isLogedIn = false;

            context.pushNamed('Guest_home_page_screen');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  getJsonField(
                    (_model.logoutapiResponse?.jsonBody ?? ''),
                    r'''$.msg''',
                  ).toString(),
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: Color(0xFF7CEF8B),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Something went wrong try again',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: Color(0xFFE92D30),
              ),
            );
          }

          setState(() {});
        },
        onPrivacy: () async {},
        onSettings: () async {
          context.pushNamed('settings_screen');
        },
      ),
    );
  }
}
