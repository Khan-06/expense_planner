import 'package:flutter/material.dart';
import '../models/Transactoin.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    Color myPrimaryColor = Theme.of(context).primaryColor;

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
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        transactions[index].date,
                      ),
                      style: const TextStyle(color: Colors.brown),
                    ),
                    trailing: MediaQuery.of(context).size.width > 350
                        ? TextButton.icon(
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'))
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
