import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() {
  runApp(const razorpay());
}

class razorpay extends StatefulWidget {
  const razorpay({Key? key}) : super(key: key);

  @override
  State<razorpay> createState() => _razorpayState();
}

class _razorpayState extends State<razorpay> {

  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment () async {
    var options = {
      'key': 'rzp_test_gkCCoVm4Vy4ScI',
      'amount': 20000, // Rs 200
      'name': "Sharad",
      'description': 'iphone 69',
      'prefill': {
        'contact': "+919876543021",
        'email': "santhoshgold12@gamil.com"
      },
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Apple 69 pro max'),
                subtitle: Text('Sell your kidney and buy it now'),
                trailing: ElevatedButton(
                  onPressed: ()
                  {
                    makePayment();
                  },
                  child: Text("buy now"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}