import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transaction.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'Nothing added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 200,
                  child: Image.asset('Assets/Images/Waiting.png',
                      fit: BoxFit.cover),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Text(
                          '\$' + transaction[index].amount.toStringAsFixed(2),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transaction[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transaction[index].date),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => deleteTx(transaction[index].id),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
