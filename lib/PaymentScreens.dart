import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreens extends StatefulWidget {
  const PaymentScreens({Key? key}) : super(key: key);

  @override
  State<PaymentScreens> createState() => _PaymentScreensState();
}

class _PaymentScreensState extends State<PaymentScreens> {
  var _razorpay = Razorpay();
  TextEditingController _amt = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    //thank you, API, Firebase
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    //Fail Page
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    // Watinig page
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Payment Module",style: TextStyle(fontSize: 20.0,color: Color(0xff231568)),),
            TextFormField(
              controller: _amt,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0,),

            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.red.shade300,
              child: ElevatedButton(onPressed: ()  async{

                var amt = _amt.text.toString();

                var options = {
                  'key': 'rzp_test_VJOdWx7AkuRnsS',
                  'amount': double.parse(amt) * 100,
                  'name': 'App Name',
                  'description': 'Package Purchase',
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  }
                };

                _razorpay.open(options);

              }, child: Text("Login")),
            )

          ],
        ),
      ),
    );
  }
}
