import 'package:catatan_keuanganku/app/base/base_controller.dart';
import 'package:catatan_keuanganku/presentation/controller/master_type_controller.dart';
import 'package:catatan_keuanganku/presentation/controller/transaction_controller.dart';
import 'package:catatan_keuanganku/presentation/page/form_transaction.dart';
import 'package:catatan_keuanganku/presentation/page/master_type_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../app/misc/constant_value.dart';
import '../../data/models/Transaction.dart';

class DashboardController extends BaseController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  int _totalBalance = 0;
  int get totalBalance => _totalBalance;

  void actionOpenDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
    refreshUI();
  }

  void actionOpenMaster() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MasterTypePage(pageController: MasterTypeController()),
        ));
  }

  void actionOpenFormTransaction(int typeTransaction) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormTransaction(typeTransaction,
              pageController: TransactionController()),
        ));
  }

  Stream<List<Transaction>> fetchTransaction() async* {
    var box = Hive.box<Transaction>(boxTransaction);
    // _totalBalance = box.values
    //     .toList()
    //     .where(
    //       (element) => element.typeTransaction == 1,
    //     )
    //     .map(
    //       (e) => e.nominal,
    //     )
    //     .reduce(
    //       (value, element) => value + element,
    //     );
    yield box.values.toList();
  }
}
