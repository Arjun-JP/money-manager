import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> dltTransaction(String iD);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB.internals();
  static TransactionDB instance = TransactionDB.internals();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionlistnotifier =
      ValueNotifier([]);

  Future<void> refresh() async {
    final list = await getAllTransaction();
    transactionlistnotifier.value.clear();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionlistnotifier.value.addAll(list);
    print(transactionlistnotifier.value);
    transactionlistnotifier.notifyListeners();
  }

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    db.put(obj.iD, obj);
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> dltTransaction(String iD) async {
    final ddb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await ddb.delete(iD);
    refresh();
  }
}
