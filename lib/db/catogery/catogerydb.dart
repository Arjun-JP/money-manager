import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CatogeryDBfunctions {
  Future<List<CatagoryModel>> getCatogeries();
  Future<void> insertCatogery(CatagoryModel value);
  Future<void> deletecatogery(String categoryID);
}

// ignore: camel_case_types
class categoryDB implements CatogeryDBfunctions {
  categoryDB.internal();
  static categoryDB instence = categoryDB.internal();
  factory categoryDB() {
    return instence;
  }

  ValueNotifier<List<CatagoryModel>> incomCategorylist = ValueNotifier([]);
  ValueNotifier<List<CatagoryModel>> expenceCategorylist = ValueNotifier([]);
  @override
  Future<void> insertCatogery(CatagoryModel value) async {
    final categoryDB = await Hive.openBox<CatagoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CatagoryModel>> getCatogeries() async {
    final categoryDB = await Hive.openBox<CatagoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCAtegorys = await getCatogeries();
    incomCategorylist.value.clear();
    expenceCategorylist.value.clear();
    await Future.forEach(allCAtegorys, (CatagoryModel category) {
      if (category.type == CategoryType.income) {
        incomCategorylist.value.add(category);
      } else {
        expenceCategorylist.value.add(category);
      }
    });

    incomCategorylist.notifyListeners();
    expenceCategorylist.notifyListeners();
  }

  @override
  Future<void> deletecatogery(String categoryID) async {
    final categoryDB = await Hive.openBox<CatagoryModel>(CATEGORY_DB_NAME);
    categoryDB.delete(categoryID);
    refreshUI();
  }
}
