import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_tranaction.dart';
import 'package:expenses_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          cursorColor: Colors.purpleAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light()
              .textTheme
              .copyWith(headline6: TextStyle(fontFamily: 'Bitter')),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Bitter', fontWeight: FontWeight.bold)))),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(String title, String amount, DateTime date) {
    if (title.isEmpty || amount.isEmpty || date == null) {
      return;
    }
    final transaction = Transaction("id", title, double.parse(amount), date);
    setState(() {
      _userTransactions.add(transaction);
    });
    Navigator.of(context).pop(); // hide the bottom sheet
  }

  void _showAddTransactionsSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(
              'https://scontent.fjed4-6.fna.fbcdn.net/v/t1.0-1/p320x320/70012026_1396145760559602_7724483374592557056_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=7206a8&_nc_ohc=ZfTABSbh5oAAX80rg8o&_nc_ht=scontent.fjed4-6.fna&tp=6&oh=38c2ae9332fdb5cb98dd76efbaa0c4a7&oe=6076D114'),
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddTransactionsSheet(context))
      ],
    );

    return Scaffold(
        appBar: appBar,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _showAddTransactionsSheet(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.05),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.65,
              child: _userTransactions.isNotEmpty
                  ? Expanded(
                      child: TransactionsList(
                          _userTransactions, _removeTransaction))
                  : Center(
                      child: Column(
                        children: [
                          Text(
                            'No Transactions',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 10),
                          Container(
                              height: 200,
                              width: 200,
                              child: Image.asset(
                                  'assets/images/no_transactions.png'))
                        ],
                      ),
                    ),
            ),
          ],
        ));
  }

  void _removeTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }
}
