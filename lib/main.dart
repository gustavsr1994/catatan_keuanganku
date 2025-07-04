import 'package:catatan_keuanganku/app/misc/constant_value.dart';
import 'package:catatan_keuanganku/data/models/TypeTransaction.dart';
import 'package:catatan_keuanganku/presentation/controller/dashboard_controller.dart';
import 'package:catatan_keuanganku/presentation/page/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'data/models/Transaction.dart';

void main() {
  initialData();
  runApp(const MyApp());
}

void initialData() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocument = await getApplicationDocumentsDirectory();
  // Hive.init(appDocument.path);
  await Hive.initFlutter(appDocument.path);
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TypeTransactionAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(TransactionAdapter());
  }
  await Hive.openBox<Transaction>(boxTransaction);
  await Hive.openBox<TypeTransaction>(boxTypeTransaction);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Catatan Keuanganku',
        home: DashboardPage(
          pageController: DashboardController(),
        ));
  }
}
