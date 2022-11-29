import 'package:flutter/material.dart';
import 'package:money_manager/db/catogery/catogerydb.dart';
import 'package:money_manager/models/category/category_model.dart';

class ExpenceList extends StatelessWidget {
  const ExpenceList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryDB().expenceCategorylist,
        builder: (BuildContext ctx, List<CatagoryModel> newlist, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(5),
            itemBuilder: ((context, index) {
              final category = newlist[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 71, 55, 218),
                  ),
                ),
                tileColor: Colors.white,
                title: Text(
                  category.name,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                subtitle: const Text(
                  'catagory',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                trailing: IconButton(
                  onPressed: () {
                    categoryDB.instence.deletecatogery(category.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 177, 0, 0),
                  ),
                ),
              );
            }),
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 6,
              );
            }),
            itemCount: newlist.length,
          );
        });
  }
}
