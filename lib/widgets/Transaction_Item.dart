import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transactoin.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTx,
  });

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        elevation: 5,
        margin:
        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
          ),
          title: Text(
            transaction.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(
              transaction.date,
            ),
            style: const TextStyle(color: Colors.brown),
          ),
          trailing: MediaQuery.of(context).size.width > 350
              ? TextButton.icon(
              onPressed: () {
                deleteTx(transaction.id);
              },
              icon: const Icon(Icons.delete),
              label: const Text('Delete'))
              : IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.error,
            onPressed: () => deleteTx(transaction.id),
          ),
        ),
      ),
    );
  }
}
