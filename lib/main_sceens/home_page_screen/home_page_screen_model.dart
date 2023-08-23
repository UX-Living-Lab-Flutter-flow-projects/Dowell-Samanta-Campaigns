import '/components/app_bar_top_menu_component/app_bar_top_menu_component_widget.dart';
import '/components/search_component/search_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageScreenModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for App_bar_top_menu_component component.
  late AppBarTopMenuComponentModel appBarTopMenuComponentModel;
  // Model for search_component component.
  late SearchComponentModel searchComponentModel;
  // State field(s) for Switch widget.
  bool? switchValue;

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
