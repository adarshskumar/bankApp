import 'package:bankapp/database/database_helper.dart';
import 'package:bankapp/loginpage/components/customDialog.dart';
import 'package:bankapp/loginpage/constants.dart';
import 'package:bankapp/models/transactionData.dart';
import 'package:bankapp/models/userData.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  final UserData senderUser;
  final UserData receiverUser;
  Payment({this.senderUser, this.receiverUser});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double transferAmount;
  DatabaseHelper _dbHelper = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    widget.receiverUser.userName[0],
                    style: TextStyle(fontSize: 28),
                  ),
                  radius: 30,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.receiverUser.userName,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                ),
                Text(widget.receiverUser.cardNumber,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 20, color: Colors.grey[600])),
              ],
            ),
          ),
          SizedBox(height: 100),
          Column(
            children: [
              Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  onChanged: (value) {
                    transferAmount = double.parse(value);
                  },
                  initialValue: null,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Amount",
                    prefixText: "₹ ",
                    hintStyle: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              )),
            ],
          ),
          Spacer(),
          Flexible(
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your A/c No: ${widget.senderUser.cardNumber}",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 20)),
                    SizedBox(height: 7),
                    Text(
                      'Balance: ₹${widget.senderUser.totalAmount}',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.green,
                          ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        onPressed: () async {
                          if (transferAmount == null || transferAmount == 0) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    title: "Amount not added",
                                    description: "Please add some valid amount",
                                    buttonText: "Cancel",
                                    addIcon: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  );
                                });
                          } else if (transferAmount >
                              widget.senderUser.totalAmount) {
                            // print("Balance is insufficient");
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    title: "Insufficient Balance",
                                    description:
                                        "Please make sure that your account has sufficient balance",
                                    buttonText: "Cancel",
                                    addIcon: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  );
                                });
                          } else {
                            double currentUserRemainingBalance =
                                widget.senderUser.totalAmount - transferAmount;

                            await _dbHelper.updateTotalAmount(
                                widget.senderUser.id,
                                currentUserRemainingBalance);

                            double transferToCurrentBalance =
                                widget.receiverUser.totalAmount +
                                    transferAmount;

                            await _dbHelper.updateTotalAmount(
                                widget.receiverUser.id,
                                transferToCurrentBalance);

                            TransactionDetails _transactionDetails =
                                TransactionDetails(
                              transectionId: widget.senderUser.id,
                              receiverName: widget.receiverUser.userName,
                              senderName: widget.senderUser.userName,
                              transectionAmount: transferAmount,
                            );

                            await _dbHelper
                                .insertTransactionHistory(_transactionDetails);

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              '/customer_list'));
                                    },
                                    title: "Paid Successfully",
                                    isSuccess: true,
                                    description:
                                        "Thanks for using our service. Have a nice day.",
                                    buttonText: "Ok",
                                    addIcon: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  );
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Transfer Now",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
