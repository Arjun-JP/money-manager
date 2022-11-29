import 'package:flutter/material.dart';
import 'package:money_manager/category/category_addpopup.dart';
import 'package:money_manager/category/screen_category.dart';
import 'package:money_manager/db/transactions/add_transaction.dart';
import 'package:money_manager/home/widgets/bottomnavigationbar.dart';
import 'package:money_manager/transactions/screen_transaction.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final pages = const [ScreenTransaction(), ScreenCategory()];

  // ignore: unused_field
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 24, 77),
        centerTitle: true,
        title: const Text(
          'Money Manager',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: ScreenHome.selectedIndexNotifier,
          builder: (BuildContext context, int updatedindex, _) {
            return pages[updatedindex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (ScreenHome.selectedIndexNotifier.value == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const AddTransaction();
                },
              ),
            );
          } else {
            showCategoryAddPopup(context);
          }
        },
        backgroundColor: const Color.fromARGB(255, 43, 24, 77),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
