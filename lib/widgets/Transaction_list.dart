import 'package:flutter/material.dart';

import '../models/Transactoin.dart';
import './Transaction_Item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {

    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions added yet!',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              const SizedBox(height: 20),
              Expanded(child: Image.asset('assets/images/waiting.png'))
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
            },
            itemCount: transactions.length,
          );
  }
}
