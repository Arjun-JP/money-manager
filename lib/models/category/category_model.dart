import 'package:hive_flutter/adapters.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expence,
}

@HiveType(typeId: 1)
class CatagoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleacted;
  @HiveField(3)
  final CategoryType type;

  CatagoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleacted = false,
  });

  @override
  String toString() {
    return '{$name  $type}';
  }
}




















//flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs