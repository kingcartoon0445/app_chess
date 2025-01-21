import 'package:app_chess/bloc/summary/summary_bloc.dart';
import 'package:app_chess/bloc/summary/summary_event.dart';
import 'package:app_chess/main.dart';
import 'package:app_chess/screens/detail_summary/detail_summary_page.dart';
import 'package:app_chess/screens/detail_summary/detail_summary_screen.dart';
import 'package:app_chess/screens/financial_summary/financial_summary_screen.dart';
import 'package:app_chess/services/model/summary_response.dart';
import 'package:app_chess/theme_extension.dart';
import 'package:app_chess/util/covert_money.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialOneScreen extends StatefulWidget {
  final SummaryModel? summaryModel;
  const FinancialOneScreen({super.key, this.summaryModel});

  @override
  State<FinancialOneScreen> createState() => _FinancialOneScreenState();
}

class _FinancialOneScreenState extends State<FinancialOneScreen> {
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showIOS_DatePicker(context, date: dateFrom, onPresse: (date) {
              setState(() {
                dateFrom = date;
              });
              Navigator.pop(context);
              _showIOS_DatePicker(context, date: dateTo, onPresse: (date) {
                setState(() {
                  dateTo = date;
                });
                _getDateWithDateTime(dateFrom, dateTo);
                Navigator.pop(context);
              });
            });
          },
          child: Container(
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
                    child: Text(
                        "${formatter.format(dateFrom)} - ${formatter.format(dateTo)} ",
                        style: context.textTheme.titleMedium!),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 15),

        // List of items
        Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: widget.summaryModel != null
                ? widget.summaryModel!.users!.length
                : 0,
            itemBuilder: (context, index) {
              return _buildListItem(
                  context,
                  widget.summaryModel!.users![index].userName!,
                  CurrencyFormatter.formatEUR(
                    widget.summaryModel!.users![index].total!,
                  ),
                  widget.summaryModel!.users![index]);
            },
          ),
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
              Text("total".tr(), style: context.textTheme.labelSmall),
              Text(
                  CurrencyFormatter.formatEUR(widget.summaryModel != null
                      ? widget.summaryModel!.total!
                      : 0),
                  style: context.textTheme.labelMedium),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Clear Button

        SizedBox(
          height: 75,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              DateTime dateFrom = DateTime.now();
              DateTime dateTo = DateTime.now();
              _resetData();
            },
            child: Container(
              width: 300,
              // padding: EdgeInsets.fromLTRB(30, 10, 60, 10),
              height: 60,
              decoration: BoxDecoration(
                color: context.theme.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text("clear".tr(),
                    style: context.textTheme.titleMedium!
                        .copyWith(color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getDateWithDateTime(DateTime dateFrom, DateTime dateTo) {
    context.read<SummaryBloc>().add(
          FetchSummary(
            dateFrom: formatter.format(dateFrom),
            dateTo: formatter.format(dateTo),
          ),
        );
  }

  _resetData() {
    context.read<SummaryBloc>().add(
          FetchReset(),
        );
  }

  Widget _buildListItem(
      BuildContext context, String title, String amount, Users user) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailSummaryPage(
                    user: user.userName ?? "",
                    date_from: formatter.format(dateFrom),
                    date_to: formatter.format(dateTo),
                  )),
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

  // ignore: non_constant_identifier_names
  void _showIOS_DatePicker(ctx,
      {required DateTime date, required Function(DateTime) onPresse}) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => DateTimePicker(
              date: date,
              onPressed: onPresse,
            ));
  }
}

class DateTimePicker extends StatefulWidget {
  DateTime date;
  Function(DateTime) onPressed;
  DateTimePicker({super.key, required this.date, required this.onPressed});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

late DateTime _date;

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  void initState() {
    // TODO: implement initState
    _date = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 255,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    child: TextButton(
                  onPressed: () {
                    widget.onPressed(_date);
                  },
                  child: Text(
                    "done".tr(),
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                )),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 200, // Điều chỉnh chiều cao của DatePicker
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _date,
                onDateTimeChanged: (DateTime value) {
                  _date = value; // Chỉ cập nhật biến tạm thời
                },
              ),
            ),
            // const SizedBox(height: 16), // Khoảng cách giữa DatePicker và nút
            // CupertinoButton.filled(
            //   onPressed: () {
            //     // setState(() {
            //     //   // Cập nhật state khi nhấn nút xác nhận
            //     //   // Thêm xử lý khác ở đây nếu cần
            //     //   print("Ngày đã chọn: $selectedDate");
            //     // });
            //   },
            //   child: const Text('Xác nhận'),
            // ),
          ],
        ));
  }
}
