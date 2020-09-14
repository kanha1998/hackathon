import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'payment/razorpay_flutter.dart';

class FailedPage extends StatelessWidget {
  final PaymentFailureResponse response;
  FailedPage({
    @required this.response,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        title: Text("Payment Success"),
      ),
      body: Center(
        child: Container(
          child: Text(
            "Your payment is Failed and the response is\n Code: ${response.code}\nMessage: ${response.message}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}