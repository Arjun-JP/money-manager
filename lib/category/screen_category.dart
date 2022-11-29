import 'package:flutter/material.dart';
import 'package:money_manager/category/expence_list.dart';
import 'package:money_manager/category/income_list.dart';
import 'package:money_manager/db/catogery/catogerydb.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;

  @override
  void initState() {
    tabcontroller = TabController(length: 2, vsync: this);
    categoryDB().refreshUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabcontroller,
          labelColor: Colors.black,
          indicatorColor: const Color.fromARGB(255, 43, 24, 77),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              text: "Income",
            ),
            Tab(
              text: "Expence",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(controller: tabcontroller, children: const [
            IncomeList(),
            ExpenceList(),
          ]),
        )
      ],
    );
  }
}
