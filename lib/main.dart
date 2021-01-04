import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _cupertinoStyle() {
    return CupertinoApp(
      title: 'Personal Expenses',
      theme: CupertinoThemeData(primaryColor: Colors.purple),
    );
  }

  Widget _materialStyle() {
    return MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            errorColor: Colors.red,
            fontFamily: 'QuickSand',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            )),
        home: HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _cupertinoStyle() : _materialStyle();
  }
}

class HomePage extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    /*  Transaction(
        id: 't1',
        description: 'New Shoes from Converse',
        value: 200,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        description: 'Weekly Groceries',
        value: 16.57,
        date: DateTime.now()) */
  ];

  bool _showChart = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String description, double amount, DateTime date) {
    Transaction t = new Transaction(
        id: DateTime.now().toString(),
        description: description,
        value: amount,
        date: date);

    setState(() {
      _userTransactions.add(t);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

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

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionList,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          )
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .75,
              child: Chart(_recentTransactions),
            )
          : transactionList,
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionList,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            .33,
        child: Chart(_recentTransactions),
      ),
      transactionList
    ];
  }

  Widget _cupertinoNavigationBar() {
    return CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    );
  }

  Widget _materialNavigationBar() {
    return AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //String descriptionInput;
    //String amountInput;
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _cupertinoNavigationBar() : _materialNavigationBar();

    final transactionList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .67,
      width: double.infinity,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                transactionList,
              ),
            if (!isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                transactionList,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: appBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButtonLocation: Platform.isIOS
                ? Container()
                : FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }
}
