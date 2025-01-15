import 'package:app_chess/theme_extension.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class FinancialTotalsScreen extends StatelessWidget {
  const FinancialTotalsScreen({Key? key}) : super(key: key);

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
                    _buildRow(context, "Tổng tiền mặt", "356,892"),
                    const SizedBox(height: 8),
                    _buildRow(context, "N Tiền mặt", "356,892"),
                    const SizedBox(height: 8),
                    _buildRow(context, "Tiền mặt", "356,892"),
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
                child: _buildRow(context, "Tổng tiền thẻ", "226,892"),
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
                child: _buildRow(context, "Tổng tất cả", "583,784"),
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
                  child: Text("Quay lại",
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
