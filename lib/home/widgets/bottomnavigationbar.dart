import 'package:flutter/material.dart';
import 'package:money_manager/home/screenhome.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext context, int updatedIndex, _) {
        return BottomNavigationBar(
            selectedItemColor: const Color.fromARGB(255, 43, 24, 77),
            unselectedItemColor: Colors.grey,
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Category',
              ),
            ]);
      },
    );
  }
}
