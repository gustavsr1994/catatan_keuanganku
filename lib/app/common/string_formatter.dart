import 'package:intl/intl.dart';

String currencyFormatter(int amount) {
  var currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  // Memformat angka menjadi string mata uang
  String formattedAmount = currencyFormat.format(amount);
  return formattedAmount;
}
