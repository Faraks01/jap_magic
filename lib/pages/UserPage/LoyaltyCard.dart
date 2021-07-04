import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoyaltyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      widthFactor: 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12)
        ),
        height: 200,
        child: Row(
          children: [
            Container(
              height: 60,
            ),

          ],
        ),
      ),
    );
  }
}