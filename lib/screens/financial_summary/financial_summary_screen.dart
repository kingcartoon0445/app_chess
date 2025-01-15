import 'package:app_chess/screens/financial_summary/widget/financial_one.dart';
import 'package:app_chess/screens/login/login_screen.dart';
import 'package:app_chess/theme_extension.dart';
import 'package:flutter/material.dart';

import 'widget/financial_two.dart';
// import 'package:intl/intl.dart';

class FinancialSummaryScreen extends StatefulWidget {
  const FinancialSummaryScreen({Key? key}) : super(key: key);

  @override
  State<FinancialSummaryScreen> createState() => _FinancialSummaryScreenState();
}

class _FinancialSummaryScreenState extends State<FinancialSummaryScreen> {
  int focusIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final formatter = NumberFormat("#,###", "vi_VN");

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Date Range Container
              if (focusIndex == 0) ...[
                FinancialOneScreen()
              ] else ...[
                DeviceListScreen()
              ],
              const Spacer(),

              // Bottom Navigation
              SizedBox(
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
                            child: Text("Doanh thu",
                                style: context.textTheme.titleMedium!.copyWith(
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
                            child: Text("Thiết bị",
                                style: context.textTheme.titleMedium!.copyWith(
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
    );
  }
}
