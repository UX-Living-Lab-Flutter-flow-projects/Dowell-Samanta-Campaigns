import '/components/app_bar_top_menu_component/app_bar_top_menu_component_widget.dart';
import '/components/search_component/search_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CampaignListScreenModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for App_bar_top_menu_component component.
  late AppBarTopMenuComponentModel appBarTopMenuComponentModel;
  // Model for search_component component.
  late SearchComponentModel searchComponentModel;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // State field(s) for Switch widget.
  bool? switchValue4;
  // State field(s) for Switch widget.
  bool? switchValue5;
  // State field(s) for Switch widget.
  bool? switchValue6;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    appBarTopMenuComponentModel =
        createModel(context, () => AppBarTopMenuComponentModel());
    searchComponentModel = createModel(context, () => SearchComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    appBarTopMenuComponentModel.dispose();
    searchComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
