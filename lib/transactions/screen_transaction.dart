import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/catogery/catogerydb.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    categoryDB.instence.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionlistnotifier,
        builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(5),
            itemBuilder: ((context, index) {
              final value = newlist[index];
              // print(value.amount);

              return Slidable(
                key: Key(value.iD!),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDB.instance
                            .dltTransaction(value.iD.toString());
                      },
                      icon: Icons.delete,
                      foregroundColor: const Color.fromARGB(255, 177, 0, 0),
                      label: "Delete",
                    )
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDB.instance
                            .dltTransaction(value.iD.toString());
                      },
                      icon: Icons.delete,
                      foregroundColor: Color.fromARGB(255, 177, 0, 0),
                      label: "Delete",
                    ),
                  ],
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: value.type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        width: 4,
                      )),
                  tileColor: Colors.white,
                  leading: SizedBox(
                    height: 50,
                    width: 65,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          parsedate(value.date),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  title: Center(
                    child: Text(
                      "Rs ${value.amount}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      value.category.name,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
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

  String parsedate(DateTime date) {
    final dates = DateFormat.MMMd().format(date);
    final splitdate = dates.split(' ');
    return '  ${splitdate.last}\n${splitdate.first}';
  }

  String transactionparsedate(DateTime date) {
    final dates = DateFormat.yMMMMd().format(date);
    final splitdate = dates.split(' ');
    return '  ${splitdate.last}\n${splitdate.first}';
  }
}
