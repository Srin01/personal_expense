import 'package:flutter/material.dart';
import 'package:personal_expense1/widgets/transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  var _transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TransactionList(
            transactions: _transactions,
          ),
        ],
      ),
    );
  }
}
