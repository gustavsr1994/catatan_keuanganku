  import 'package:intl/intl.dart';

String currencyFormatter(int amount) {
    var currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

    // Memformat angka menjadi string mata uang
    String formattedAmount = currencyFormat.format(amount);
    return formattedAmount;
  
}