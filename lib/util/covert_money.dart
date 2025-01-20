import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatVND(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  static String formatEUR(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'de_DE',
      symbol: '€',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static String formatUSD(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }
}

// Extension để sử dụng dễ dàng hơn
extension CurrencyFormatterExtension on num {
  String toVND() => CurrencyFormatter.formatVND(this);
  String toEUR() => CurrencyFormatter.formatEUR(this);
  String toUSD() => CurrencyFormatter.formatUSD(this);
}
