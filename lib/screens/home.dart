import 'package:bankapp/loginpage/constants.dart';
import 'package:bankapp/loginpage/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bankmin.png'), fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 28.0, 8.0, 0.0),
                child: Text(
                  'Gulshan',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Text(
                  'Pay Bank',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(child: SizedBox(height: 360, width: 350)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10, top: 10),
                      height: 140,
                      width: 160,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: Offset(8, 8),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.supervised_user_circle,
                                color: kPrimaryColor,
                              ),
                              iconSize: 70.0,
                              onPressed: () {
                                Navigator.pushNamed(context, '/customer_list');
                              }),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'All Users',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 140, width: 8),
                    Container(
                      margin: const EdgeInsets.only(right: 0, top: 10),
                      height: 140,
                      width: 160,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: Offset(8, 8),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.monetization_on_outlined,
                                color: kPrimaryColor,
                              ),
                              iconSize: 70.0,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/transaction_history');
                              }),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Transactions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
