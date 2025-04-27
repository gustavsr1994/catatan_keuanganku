import 'package:hive/hive.dart';

part 'TypeTransaction.g.dart'; // akan di-generate otomatis

@HiveType(typeId: 0)
class TypeTransaction extends HiveObject {
  @HiveField(0)
  String nameTransaction;
  @HiveField(1)
  int type;

  TypeTransaction({required this.nameTransaction, required this.type});
}
