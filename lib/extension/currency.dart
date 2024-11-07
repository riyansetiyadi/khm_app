import 'package:intl/intl.dart';

extension CurrencyFormatter on double {
  String toRupiah() {
    final formatRupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatRupiah.format(this);
  }
}
