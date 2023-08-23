import '/components/app_bar_top_menu_component/app_bar_top_menu_component_widget.dart';
import '/components/ask_send_email_component/ask_send_email_component_widget.dart';
import '/components/campaign_delete_confirm_dialog/campaign_delete_confirm_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CamapignDetailScreenModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for App_bar_top_menu_component component.
  late AppBarTopMenuComponentModel appBarTopMenuComponentModel;
  // State field(s) for Switch widget.
  bool? switchValue;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    appBarTopMenuComponentModel =
        createModel(context, () => AppBarTopMenuComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    appBarTopMenuComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
