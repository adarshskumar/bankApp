import 'package:bankapp/home/homepage.dart';
import 'package:bankapp/screens/addNewCustomer.dart';
import 'package:bankapp/screens/customer_info.dart';
import 'package:bankapp/screens/customer_list.dart';
import 'package:bankapp/screens/transaction_history.dart';
import 'package:bankapp/screens/transfer_money.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/customer_list': (context) => CustomerList(),
        '/addNewCustomer': (context) => AddNewCustomer(),
        '/customer_info': (context) => CustomerInfo(),
        '/transaction_history': (context) => TransactionHistory(),
        '/transfer_money': (context) => TransferMoney(),
      },
    );
  }
}
