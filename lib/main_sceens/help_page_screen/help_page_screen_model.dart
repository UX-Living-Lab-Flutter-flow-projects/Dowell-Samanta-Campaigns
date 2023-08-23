import '/components/top_menu_component/top_menu_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HelpPageScreenModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for top_menu_component component.
  late TopMenuComponentModel topMenuComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    topMenuComponentModel = createModel(context, () => TopMenuComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    topMenuComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
