import 'dart:async';

import 'package:app_chess/main.dart';
import 'package:app_chess/screens/login/login_page.dart';
import 'package:app_chess/services/ws_connector.dart';
import 'package:app_chess/theme_extension.dart';
import 'package:app_chess/util/global_data.dart';
import 'package:app_chess/util/global_event.dart';
import 'package:app_chess/util/shared_preferences_setup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../bloc/login_bloc/login_export.dart';
import 'summary_page.dart';
import 'widget/device_page.dart';
// import 'package:intl/intl.dart';

class FinancialSummaryScreen extends StatefulWidget {
  const FinancialSummaryScreen({
    super.key,
  });

  @override
  State<FinancialSummaryScreen> createState() => _FinancialSummaryScreenState();
}

class _FinancialSummaryScreenState extends State<FinancialSummaryScreen> {
  int focusIndex = 0;
  final prefs = SharedPrefsService();
  @override
  Widget build(BuildContext context) {
    // final formatter = NumberFormat("#,###", "vi_VN");

    return BlocProvider(
      create: (context) => LoginBloc(
        dioService: DioService(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LogOutLoaded) {
            prefs.clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (Route<dynamic> route) => true,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: (focusIndex == 0) ? SummaryPage() : DevicePage(),
                  ), // Date Range Container,

                  // const Spacer(),

                  // Bottom Navigation
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    // height: ,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              print(focusIndex);
                              setState(() {
                                focusIndex = 0;
                              });
                              // setState(() {
                              //   focusIndex = 0;
                              // });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: focusIndex == 0
                                    ? context.theme.primaryColor
                                    : Color(0xFFE6D5CC),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              child: Center(
                                child: Text("revenue".tr(),
                                    style: context.textTheme.titleMedium!
                                        .copyWith(
                                            color: focusIndex == 1
                                                ? context.theme.primaryColor
                                                : Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              print(focusIndex);

                              setState(() {
                                focusIndex = 1;
                              });
                              // setState(() {
                              //   focusIndex = 1;
                              // });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: focusIndex == 1
                                    ? context.theme.primaryColor
                                    : Color(0xFFE6D5CC),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: Center(
                                child: Text("device".tr(),
                                    style: context.textTheme.titleMedium!
                                        .copyWith(
                                            color: focusIndex == 0
                                                ? context.theme.primaryColor
                                                : Colors.white)),
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
          ),
        ),
      ),
    );
  }
}
