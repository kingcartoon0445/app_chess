import 'package:app_chess/services/model/summary_of_user_response.dart';
import 'package:app_chess/theme_extension.dart';
import 'package:app_chess/util/covert_money.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class DetailSummaryScreen extends StatelessWidget {
  final DetailSummaryModel? detailSummaryModel;
  const DetailSummaryScreen({super.key, required this.detailSummaryModel});

  @override
  Widget build(BuildContext context) {
    // final formatter = NumberFormat("#,###", "vi_VN");

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // Cash totals section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.theme.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildRow(
                        context,
                        "total_cash".tr(),
                        CurrencyFormatter.formatEUR(detailSummaryModel != null
                            ? detailSummaryModel!.totalCash ?? 0
                            : 0)),
                    const SizedBox(height: 8),
                    _buildRow(
                        context,
                        "n_cash".tr(),
                        CurrencyFormatter.formatEUR(detailSummaryModel != null
                            ? detailSummaryModel!.nCash ?? 0
                            : 0)),
                    const SizedBox(height: 8),
                    _buildRow(
                        context,
                        "cash".tr(),
                        CurrencyFormatter.formatEUR(detailSummaryModel != null
                            ? detailSummaryModel!.cash ?? 0
                            : 0)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Card total section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.theme.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _buildRow(
                    context,
                    "total_card".tr(),
                    CurrencyFormatter.formatEUR(detailSummaryModel != null
                        ? detailSummaryModel!.card ?? 0
                        : 0)),
              ),

              const SizedBox(height: 16),

              // Grand total section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6D5CC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _buildRow(
                    context,
                    "total".tr(),
                    CurrencyFormatter.formatEUR(detailSummaryModel != null
                        ? detailSummaryModel!.total ?? 0
                        : 0)),
              ),

              const Spacer(),

              // Back button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text("back".tr(),
                      style: context.textTheme.titleMedium!
                          .copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.labelSmall),
        Text(amount, style: context.textTheme.labelMedium),
      ],
    );
  }
}
