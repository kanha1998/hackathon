


import 'package:flutter/material.dart';
import '../paymentFailed.dart';
import '../paymentSuccess.dart';

import 'razorpay_flutter.dart';

class CheckRazor extends StatefulWidget {
  final int bill;
  CheckRazor(this.bill);
  @override
  _CheckRazorState createState() => _CheckRazorState(bill);
}

class _CheckRazorState extends State<CheckRazor> {
  final int bill;
  _CheckRazorState(this.bill);
  Razorpay _razorpay = Razorpay();
  var options;
  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SuccessPage(
              response: response,
            ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
              response: response,
            ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options = {
      'key': "rzp_test_m03jIn7GtrZfCV", // Enter the Key ID generated from the Dashboard

      'amount': bill, //in the smallest currency sub-unit.
      'name': 'organization',

      'currency': "INR",
      'theme.color': "#F37254",
      'buttontext': "Pay with Razorpay",
      'description': 'RazorPay example',
      'prefill': {
        'contact': '9123456789',
        'email': 'gaurav.kumar@example.com',
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}