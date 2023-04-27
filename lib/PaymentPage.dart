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
  void deleteCard(String cardType) {
    print('Deleting $cardType');
    // TODO: Implement the deletion logic
  }
  void editCard(String cardType) {
    print('Editing $cardType');
    // TODO: Implement the editing logic
  }
  void lockCard(String cardType) {
    print('Locking $cardType');
    // TODO: Implement the locking logic
  }
  void makePayment () async {
    var options = {
      'key': 'rzp_test_5Bgwso33hAs8fR',
      'amount': 200000, // Rs 2000
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
        appBar: AppBar(
          title: Text("Payment Page"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              "Select a bill to pay:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text('Electricity Bill'),
                subtitle: Text('Rs 2000'),
                trailing: ElevatedButton(
                  onPressed: () {
                    makePayment();
                  },
                  child: Text("Pay Now"),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text('Gas Bill'),
                subtitle: Text('Rs 700'),
                trailing: ElevatedButton(
                  onPressed: () {
                    makePayment();
                  },
                  child: Text("Pay Now"),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text('Wifi Bill'),
                subtitle: Text('Rs 400'),
                trailing: ElevatedButton(
                  onPressed: () {
                    makePayment();
                  },
                  child: Text("Pay Now"),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text('Water Tax'),
                subtitle: Text('Rs 3000'),
                trailing: ElevatedButton(
                  onPressed: () {
                    makePayment();
                  },
                  child: Text("Pay Now"),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text('Credit Card'),
                subtitle: Text('Rs 10000'),
                trailing: ElevatedButton(
                  onPressed: () {
                    makePayment();
                  },
                  child: Text("Pay Now"),
                ),
              ),
            ),
    SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Your Cards",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Debit Card'),
                subtitle: Text('**** **** **** 1234'),
                trailing: IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: () {
                      lockCard('Debit Card');
                    },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Credit Card'),
                subtitle: Text('**** **** **** 5678'),
                trailing: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () {
                    lockCard('Credit Card');
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Visa Card'),
                subtitle: Text('**** **** **** 9012'),
                trailing: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () {
                    lockCard('Visa Card');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}