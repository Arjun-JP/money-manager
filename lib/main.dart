import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/home/screenhome.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:money_manager/screens/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered((CategoryTypeAdapter().typeId))) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CatagoryModelAdapter().typeId)) {
    Hive.registerAdapter(CatagoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered((TransactionModelAdapter().typeId))) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MoneyManager());
}

class MoneyManager extends StatelessWidget {
  const MoneyManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
