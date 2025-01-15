import 'package:app_chess/screens/detail_financial_summary/detail_financial_summary_screen.dart';
import 'package:app_chess/screens/financial_summary/financial_summary_screen.dart';
import 'package:app_chess/theme_extension.dart';
import 'package:flutter/material.dart';

class FinancialOneScreen extends StatefulWidget {
  const FinancialOneScreen({super.key});

  @override
  State<FinancialOneScreen> createState() => _FinancialOneScreenState();
}

class _FinancialOneScreenState extends State<FinancialOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFBB8B6B)),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_month, size: 40, color: Colors.brown[400]),
              Expanded(
                child: Center(
                  child: Text("01.11.2024 - 30.11.2024",
                      style: context.textTheme.titleMedium!),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        // List of items
        ListView(
          shrinkWrap: true,
          children: [
            _buildListItem(context, "Thu", "356,892"),
            _buildListItem(context, "Ngọc", "226,892"),
            _buildListItem(context, "Admin", "583,784"),
          ],
        ),

        const SizedBox(height: 16),

        // Total Amount
        Container(
          // padding:
          // const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFE6D5CC),
            border: Border.all(color: context.theme.primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tổng tiền", style: context.textTheme.labelSmall),
              Text("583,784", style: context.textTheme.labelMedium),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Clear Button

        Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FinancialSummaryScreen()),
              );
            },
            child: Container(
              width: 300,
              // padding: EdgeInsets.fromLTRB(30, 10, 60, 10),
              height: 60,
              child: Center(
                child: Text('Làm sạch',
                    style: context.textTheme.titleMedium!
                        .copyWith(color: Colors.white)),
              ),
              decoration: BoxDecoration(
                color: context.theme.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(BuildContext context, String title, String amount) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinancialTotalsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: context.theme.primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.textTheme.labelSmall),
            Text(amount, style: context.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
