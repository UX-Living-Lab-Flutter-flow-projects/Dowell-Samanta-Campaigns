import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'top_menu_component_model.dart';
export 'top_menu_component_model.dart';

class TopMenuComponentWidget extends StatefulWidget {
  const TopMenuComponentWidget({Key? key}) : super(key: key);

  @override
  _TopMenuComponentWidgetState createState() => _TopMenuComponentWidgetState();
}

class _TopMenuComponentWidgetState extends State<TopMenuComponentWidget> {
  late TopMenuComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopMenuComponentModel());

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
      height: 65.0,
      decoration: BoxDecoration(
        color: Color(0xFF3BC067),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(21.0, 0.0, 21.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if (FFAppState().isLogedIn) {
                  context.pushNamed('Home_Page_Screen');
                } else {
                  context.pushNamed('Guest_home_page_screen');
                }
              },
              child: Icon(
                Icons.home_outlined,
                color: FlutterFlowTheme.of(context).white,
                size: 25.0,
              ),
            ),
            Icon(
              Icons.location_on,
              color: FlutterFlowTheme.of(context).white,
              size: 25.0,
            ),
            Icon(
              Icons.person,
              color: FlutterFlowTheme.of(context).white,
              size: 25.0,
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('settings_screen');
              },
              child: Icon(
                Icons.settings,
                color: FlutterFlowTheme.of(context).white,
                size: 25.0,
              ),
            ),
            Icon(
              Icons.list,
              color: FlutterFlowTheme.of(context).white,
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
