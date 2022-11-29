import 'package:flutter/material.dart';
import 'package:money_manager/db/catogery/catogerydb.dart';
import 'package:money_manager/models/category/category_model.dart';

ValueNotifier<CategoryType> SelectedValueNotifier =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final nameController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: const Color.fromARGB(255, 240, 238, 238),
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Category name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expence', type: CategoryType.expence),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final type = SelectedValueNotifier.value;
                  final category = CatagoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: type);
                  categoryDB().insertCatogery(category);
                  Navigator.of(ctx).pop();
                  print(category);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 43, 24, 77)),
                child: const Text("Add"),
              ),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: SelectedValueNotifier,
      builder: (BuildContext ctx, CategoryType value, child_) {
        return Row(
          children: [
            Radio<CategoryType>(
                activeColor: const Color.fromARGB(255, 43, 24, 77),
                value: type,
                groupValue: SelectedValueNotifier.value,
                onChanged: ((value) {
                  if (value == null) {
                    return;
                  }
                  SelectedValueNotifier.value = value;
                  SelectedValueNotifier.notifyListeners();
                })),
            Text(title),
          ],
        );
      },
    );
  }
}
