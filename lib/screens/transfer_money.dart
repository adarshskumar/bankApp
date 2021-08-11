import 'package:bankapp/database/database_helper.dart';
import 'package:bankapp/models/userData.dart';
import 'package:bankapp/screens/payment.dart';
import 'package:flutter/material.dart';

class TransferMoney extends StatefulWidget {
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  UserData user;
  DatabaseHelper _dbHelper = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Money"),
        backgroundColor: Colors.deepPurple[400],
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Current Balance",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '₹ ${user.totalAmount}',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: FutureBuilder<List<UserData>>(
                initialData: [],
                future: _dbHelper.getUserDetailsList(user.id),
                builder: (context, snapshot) {
                  final receivers = snapshot.data;
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final receiver = receivers[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepOrange[100],
                            child: Text(
                              receiver.userName[0],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          title: Text(
                            receiver.userName,
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text('A/c :  ${receiver.cardNumber}'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Payment(
                                  senderUser: user,
                                  receiverUser: receiver,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
