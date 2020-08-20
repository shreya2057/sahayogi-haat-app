import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';

import '../components/RoundedButton.dart';

class Dashboard extends StatelessWidget {
  static const id = 'dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Dashboard',
              ),
            ),
          ),
          RoundButton(
              text: 'Donate Rs 10',
              onPress: () async {
                await initEpayment();
              }),
          RaisedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}

initEpayment() async {
  ESewaConfiguration _configuration = ESewaConfiguration(
    clientID: "NhINFhgcDAxZLRIEAwlTLwoXBAcMGA9JJTVUICBIJCA7Kjw2Ijo=",
    secretKey: "NhINFhgcDAxZLRIEAwk=",
    environment: ESewaConfiguration.ENVIRONMENT_TEST,
  );

  ESewaPnp _eSewaPnp = ESewaPnp(configuration: _configuration);

  ESewaPayment _payment = ESewaPayment(
    amount: 500,
    productName: 'Demo_org',
    productID: '001',
    callBackURL: 'https://sahayaogi_haath.com',
  );

  final _res = await _eSewaPnp.initPayment(payment: _payment);

  _res.fold(
    (failure) {
      print(failure.message);
    },
    (success) {
      print(success.message);
    },
  );
}
