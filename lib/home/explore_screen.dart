import 'package:bankapp/home/categories.dart';
import 'package:bankapp/home/discount_banner.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            DiscountBanner(),
            Categories(),
          ],
        ),
      ),
    );
  }
}
