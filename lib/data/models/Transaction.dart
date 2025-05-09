import 'package:hive/hive.dart';

part 'Transaction.g.dart'; // akan di-generate otomatis

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String type;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  int nominal;
  @HiveField(4)
  String description;
  @HiveField(5)
  int typeTransaction;

  Transaction({
    required this.type,
    required this.title,
    required this.date,
    required this.nominal,
    required this.description,
    required this.typeTransaction,
  });
}
