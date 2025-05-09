import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catatan_keuanganku/app/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../app/misc/constant_value.dart';
import '../../data/models/Transaction.dart';
import '../../data/models/TypeTransaction.dart';

class TransactionController extends BaseController {
  int _typeTransaction = 0;
  int get typeTransaction => _typeTransaction;

  TextEditingController nameField = TextEditingController();
  TextEditingController nominalField = TextEditingController();
  TextEditingController dateField = TextEditingController();
  TextEditingController descriptionField = TextEditingController();

  List<String> listTypeTransaction = [];
  String typeSelected = '';
  int type = 0;
  DateTime dateTransaction = DateTime.now();

  void initialData(int type) async {
    showLoading();
    loadTypeTransaction(type);
  }

  void loadTypeTransaction(int indexType) async {
    type = indexType;
    var box = Hive.box<TypeTransaction>(boxTypeTransaction);
    listTypeTransaction = box.values
        .where(
          (element) => element.type == indexType,
        )
        .map(
          (e) => e.nameTransaction,
        )
        .toList();
    typeSelected = listTypeTransaction.first;
    refreshUI();
  }

  void selectType(String value) {
    typeSelected = value;
    refreshUI();
  }

  void openDatePicker() async {
    var _dateSelected = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 40)),
        lastDate: DateTime.now());
    var formatter = DateFormat('dd-MMM-yyyy');
    var date = formatter.format(_dateSelected!);
    dateField.text = date;
    dateTransaction = _dateSelected;
    refreshUI();
  }

  void addTransaction() async {
    try {
      var transaction = Hive.box<Transaction>(boxTransaction);
      await transaction.add(Transaction(
          type: typeSelected,
          title: nameField.text,
          date: dateTransaction,
          nominal: int.parse(nominalField.text),
          description: descriptionField.text,
          typeTransaction: type));
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Success Submited',
        desc: 'Transaction have submitted :)',
        btnOkOnPress: () {
          Navigator.pop(context);
          refreshUI();
        },
      ).show();
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error Submited',
        desc: e.toString(),
        btnOkOnPress: () {},
      ).show();
    }
  }
}
