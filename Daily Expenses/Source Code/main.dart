import '../Widgets/new_transaction.dart';
import '../Widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'Models/transaction.dart';
import '../Widgets/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        secondaryHeaderColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
    //_userTransaction.where((tx) => return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),););
  }

  void _addNewTransaction(String title, double amount, DateTime ChosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: ChosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  // late String titleInput;
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransactionS(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: Container(
          height: 500,
          child: SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                Chart(_recentTransactions),
                TransactionList(_userTransaction, _deleteTransactionS),
              ]))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

//

