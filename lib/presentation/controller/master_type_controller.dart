import 'dart:math';

import 'package:catatan_keuanganku/app/base/base_controller.dart';
import 'package:catatan_keuanganku/data/models/TypeTransaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../app/misc/constant_value.dart';

class MasterTypeController extends BaseController {
  int indexTabSelected = 0;
  TextEditingController typeField = TextEditingController();

  void initialData() async {
    await Hive.openBox<TypeTransaction>(boxTypeTransaction);
    refreshUI();
  }

  void actionTabSelect(int value) {
    indexTabSelected = value;
    refreshUI();
  }

  Stream<List<TypeTransaction>> fetchTypeTransaction() async* {
    var box = Hive.box<TypeTransaction>(boxTypeTransaction);
    yield box.values
        .toList()
        .where(
          (element) => element.type == indexTabSelected,
        )
        .toList();
  }

  void openForm() {
    typeField.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: typeField,
          decoration: const InputDecoration(
            labelText: 'Type Transaction',
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => addType(typeField.text), child: const Text('Submit'))
        ],
      ),
    );
  }

  void addType(String value) {
    Navigator.pop(context);
    var typeTransaction = Hive.box<TypeTransaction>(boxTypeTransaction);
    typeTransaction.add(TypeTransaction(nameTransaction: value, type: indexTabSelected));
    refreshUI();
  }
}
