import 'package:bankapp/home/categories.dart';
import 'package:bankapp/home/discount_banner.dart';
import 'package:bankapp/home/explore_screen.dart';
import 'package:bankapp/home/widgets/avatar.dart';
import 'package:bankapp/home/widgets/bank_card.dart';
import 'package:bankapp/loginpage/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<BankCardModel> cards = [
    BankCardModel('assets/images/bg_purple_card.png', 'ADARSH S KUMAR',
        '4221 5168 7464 2283', '10/21', 10000000),
    BankCardModel('assets/images/bg_red_card.png', 'ADARSH S KUMAR',
        '4221 5168 7464 2283', '10/21', 10000000),
    BankCardModel('assets/images/bg_blue_card.png', 'ADARSH S KUMAR',
        '4221 5168 7464 2283', '10/21', 10000000),
    BankCardModel('assets/images/bg_blue_circle_card.png', 'ADARSH S KUMAR',
        '4221 5168 7464 2283', '10/21', 10000000),
  ];

  double screenWidth = 0.0;
//  EdgeInsets smallItemPadding;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _userInfoWidget();
            } else if (index == 1) {
              return _userBankCardsWidget();
            } else {
              return _sendMoneySectionWidget();
            }
          }),
    );
  }

  Widget _userInfoWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Avatar(
                displayImage: "assets/images/9.jpg",
                displayStatus: false,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'ADARSH S KUMAR',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          )),
          Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Icon(
                Icons.notifications_active_rounded,
                color: kPrimaryColor,
                size: 30.0,
              ),
            ),
            // new Positioned(
            //   // draw a red marble
            //   top: 3.0,
            //   left: 3.0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Color(0xFFAC375C),
            //         borderRadius: BorderRadius.circular(20)),
            //     child: Padding(
            //       padding: const EdgeInsets.all(2.0),
            //       child: Text(
            //         '3',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 10.0,
            //             fontWeight: FontWeight.w700),
            //       ),
            //     ),
            //   ),
            // )
          ]),
        ],
      ),
    );
  }

  Widget _userBankCardsWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
//      height: 400.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DiscountBanner(),
          Categories(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text(
                'My Accounts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            height: 166.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return _getBankCard(index);
              },
            ),
          ),
          Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    // onTapUp: (tapDetail) {
                    //   Navigator.push();
                    // },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.supervised_user_circle,
                                  color: kPrimaryColor,
                                ),
                                iconSize: 40.0,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/customer_list');
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'All Users',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.monetization_on_outlined,
                                color: kPrimaryColor,
                              ),
                              iconSize: 40.0,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/transaction_history');
                              }),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Transactions',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sendMoneySectionWidget() {
    var smallItemPadding = EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0);
    if (screenWidth <= 320) {
      smallItemPadding = EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0);
    }
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Send money to',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTapUp: null,
                child: Text('View all'),
              )
            ],
          ),
          Container(
            height: 100.0,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Add New'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Text('G',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Gamer'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Text('K',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Kunjus'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Text(
                            'N',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Nick'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getBankCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BankCard(card: cards[index]),
    );
  }
}
