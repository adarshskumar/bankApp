import 'package:bankapp/database/database_helper.dart';
import 'package:bankapp/loginpage/components/customTextField.dart';
import 'package:bankapp/loginpage/constants.dart';
import 'package:bankapp/models/userData.dart';
import 'package:flutter/material.dart';

class AddNewCustomer extends StatefulWidget {
  const AddNewCustomer({Key key}) : super(key: key);

  @override
  _AddNewCustomerState createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  String cardHolderName;
  String cardNumber;
  double currentBalance;
  DatabaseHelper _dbhelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Add Account Details"),
        elevation: 1.0,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => SafeArea(
          child: Column(
            children: [
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  child: Column(
                    children: [
                      CustomTextField(
                        hintName: "Enter Customer name",
                        onChanged: (value) => {cardHolderName = value},
                        keyboardTypeNumber: false,
                      ),
                      CustomTextField(
                        hintName: "Enter Account number",
                        onChanged: (value) => {cardNumber = value},
                        keyboardTypeNumber: true,
                      ),
                      CustomTextField(
                        hintName: "Enter Initial balance",
                        onChanged: (value) =>
                            {currentBalance = double.parse(value)},
                        keyboardTypeNumber: true,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryColor),
                          onPressed: () async {
                            if (cardHolderName != null &&
                                cardNumber != null &&
                                currentBalance != null) {
                              UserData _userData = UserData(
                                  userName: cardHolderName,
                                  cardNumber: cardNumber,
                                  totalAmount: currentBalance);
                              await _dbhelper.insertUserDetails(_userData);
                              Navigator.pop(context, _userData);
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                    Text(
                                        '  Please fill all the details before submitting.'),
                                  ],
                                ),
                              ));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
