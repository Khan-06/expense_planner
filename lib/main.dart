// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables
import 'package:expense_planner/models/Transactoin.dart';
import './widgets/Transaction_list.dart';
import './widgets/chart.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);   //This is to lock the screen in portrait mode
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: const ColorScheme.light().copyWith(
          error: Colors.grey,
          primary: Colors.amber.shade800,
          secondary: Colors.amber.shade800,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber.shade800,
            textStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [];

  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      const duration = Duration(days: 7);
      return tx.date.isAfter(DateTime.now().subtract(duration));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      //Tx means Transaction
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        print('Modal Bottom Sheet');
        return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: NewTransaction(_addNewTransaction));
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);;
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Center(
        child: Text(
          'Expense Manager',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _startAddNewTransaction,
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column( //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)  SizedBox(
              height: (mediaQuery.size.height -
                  appBar.preferredSize.height) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
            if (!isLandscape) txListWidget,
            _showChart
                ? SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                : txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startAddNewTransaction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
