import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/category/category_model.dart';
part 'transaction_model.g.dart';

// transaction_model.dart
@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CatagoryModel category;

  @HiveField(5)
  String? iD;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }) {
    iD = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
