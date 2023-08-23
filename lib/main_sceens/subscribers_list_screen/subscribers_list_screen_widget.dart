import '/components/app_bar_top_menu_component/app_bar_top_menu_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'subscribers_list_screen_model.dart';
export 'subscribers_list_screen_model.dart';

class SubscribersListScreenWidget extends StatefulWidget {
  const SubscribersListScreenWidget({Key? key}) : super(key: key);

  @override
  _SubscribersListScreenWidgetState createState() =>
      _SubscribersListScreenWidgetState();
}

class _SubscribersListScreenWidgetState
    extends State<SubscribersListScreenWidget> with TickerProviderStateMixin {
  late SubscribersListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscribersListScreenModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF7CEF8B),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.appBarTopMenuComponentModel,
                  updateCallback: () => setState(() {}),
                  child: AppBarTopMenuComponentWidget(),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: Color(0xFF3BC067),
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelStyle:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Outfit',
                                    fontSize: 14.0,
                                  ),
                          unselectedLabelStyle: TextStyle(),
                          indicatorColor: Color(0xFF3BC067),
                          indicatorWeight: 1.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              2.0, 2.0, 2.0, 2.0),
                          tabs: [
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                'pi2eiino' /* Subscribers */,
                              ),
                              icon: Icon(
                                Icons.subscriptions,
                              ),
                            ),
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                'ln4ixjly' /* Unsubscried */,
                              ),
                              icon: Icon(
                                Icons.unsubscribe_sharp,
                              ),
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (value) => setState(() {}),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            Container(),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
