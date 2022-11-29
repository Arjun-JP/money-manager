import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/catogery/catogerydb.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? selectedDate;

  final purposeController = TextEditingController();

  final amountController = TextEditingController();
  CategoryType? selectedCategoryType;

  CatagoryModel? selectedCategorymodel;
  dynamic value = CategoryType.income;
  String? categoryID;
  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 24, 77),
        title: const Text('Transaction',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [
          Column(
            children: [
              // textfield for Purpose Entery
              TextFormField(
                controller: purposeController,
                decoration: InputDecoration(
                  hintText: 'Purpose',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // textfield for amount Entery
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Date selection button
              ElevatedButton.icon(
                onPressed: () async {
                  final selectedDatetemp = await showDatePicker(
                    initialDate: DateTime.now(),
                    context: context,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  setState(() {
                    selectedDate = selectedDatetemp;
                    value = CategoryType.values;
                  });

                  if (selectedDate == null) {
                    return;
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(selectedDate == null
                    ? 'Select Date'
                    : selectedDate.toString()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 43, 24, 77),
                ),
              ),
              const SizedBox(height: 15),
              // radio button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: selectedCategoryType,
                      onChanged: (ValueKey) {
                        setState(() {
                          selectedCategoryType = CategoryType.income;
                          categoryID = null;
                        });
                      }),
                  const Text('Income'),
                  Radio(
                      value: CategoryType.expence,
                      groupValue: selectedCategoryType,
                      onChanged: (ValueKey) {
                        setState(() {
                          selectedCategoryType = CategoryType.expence;
                          categoryID = null;
                        });
                      }),
                  const Text('Expence'),
                ],
              ),

              const SizedBox(
                height: 15,
              ),
              // dropdown menu
              DropdownButton(
                  iconSize: 34,
                  iconEnabledColor: const Color.fromARGB(255, 43, 24, 77),
                  borderRadius: BorderRadius.circular(20),
                  elevation: 10,
                  hint: const Text('Select category'),
                  value: categoryID,
                  items: (selectedCategoryType == CategoryType.income
                          ? categoryDB().incomCategorylist
                          : categoryDB().expenceCategorylist)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                        onTap: (() {
                          selectedCategorymodel = e;
                        }));
                  }).toList(),
                  onChanged: (selectedvalue) {
                    print(selectedvalue);
                    setState(() {
                      categoryID = selectedvalue;
                    });
                  }),

              const SizedBox(height: 15),

              // Submit button
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 24, 77),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 30,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      addTransaction();
                    });
                  },
                  child: const Center(
                      child: Text(
                    'submit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  )),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> addTransaction() async {
    final purposetext = purposeController.text;
    final amounttext = amountController.text;
    if (purposetext == null) {
      return;
    }
    if (amounttext == null) {
      return;
    }
    if (categoryID == null) {
      return;
    }
    if (selectedCategorymodel == null) {
      return;
    }
    if (selectedDate == null) {
      return;
    }
    final parsedamount = double.tryParse(amounttext);
    if (parsedamount == null) {
      return;
    }
    final model = TransactionModel(
      purpose: purposetext,
      amount: parsedamount,
      date: selectedDate!,
      type: selectedCategoryType!,
      category: selectedCategorymodel!,
    );
    await TransactionDB.instance.addTransaction(model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
