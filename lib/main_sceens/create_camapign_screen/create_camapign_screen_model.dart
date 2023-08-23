import '/components/app_bar_top_menu_component/app_bar_top_menu_component_widget.dart';
import '/components/campaign_created_success_dialog/campaign_created_success_dialog_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateCamapignScreenModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // Model for App_bar_top_menu_component component.
  late AppBarTopMenuComponentModel appBarTopMenuComponentModel;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for campaign_title widget.
  TextEditingController? campaignTitleController;
  String? Function(BuildContext, String?)? campaignTitleControllerValidator;
  // State field(s) for campaign_purpose widget.
  TextEditingController? campaignPurposeController;
  String? Function(BuildContext, String?)? campaignPurposeControllerValidator;
  // State field(s) for repeatPeriod_field widget.
  String? repeatPeriodFieldValue1;
  FormFieldController<String>? repeatPeriodFieldValueController1;
  // State field(s) for repeatPeriod_field widget.
  String? repeatPeriodFieldValue2;
  FormFieldController<String>? repeatPeriodFieldValueController2;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for budget_field widget.
  TextEditingController? budgetFieldController;
  String? Function(BuildContext, String?)? budgetFieldControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    appBarTopMenuComponentModel =
        createModel(context, () => AppBarTopMenuComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    appBarTopMenuComponentModel.dispose();
    campaignTitleController?.dispose();
    campaignPurposeController?.dispose();
    budgetFieldController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
