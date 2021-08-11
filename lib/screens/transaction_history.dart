import 'package:bankapp/database/database_helper.dart';
import 'package:bankapp/loginpage/constants.dart';
import 'package:bankapp/models/transactionData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  DatabaseHelper _dbHelper = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Transaction History'),
        elevation: 1.0,
        backgroundColor: kPrimaryLightColor,
      ),
      body: FutureBuilder<List<TransactionDetails>>(
        initialData: [],
        future: _dbHelper.getTransactionDetails(),
        builder: (context, snapshot) {
          final transactions = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (transactions.isEmpty) {
                return Center(child: Text('No Transactions to show'));
              } else {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final record = transactions[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child:
                              Icon(Icons.send_to_mobile, color: Colors.white),
                          backgroundColor: Colors.deepOrange[200],
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              record.senderName,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_rounded,
                                color: Colors.blue),
                            SizedBox(width: 10),
                            Text(
                              record.receiverName,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        trailing: Text(
                          '₹ ${record.transectionAmount.toString()}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
