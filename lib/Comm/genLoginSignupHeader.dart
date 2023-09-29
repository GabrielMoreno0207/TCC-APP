import 'package:flutter/material.dart';

class genLoginSignupHeader extends StatelessWidget {
  final String headerName;
  genLoginSignupHeader(this.headerName);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10.0),
          // Text(
          //   'Login',
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: Colors.green[700],
          //     fontSize: 30.0,
          //   ),
          // ),
          SizedBox(height: 50.0),
          Image.asset(
            'assets/images/logo.png',
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(height: 10.0),
          Image.asset(
            'assets/images/log.png',
            height: 120.0,
            width: 200.0,
          ),
          SizedBox(height: 10.0),
          Text(
            '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black38,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
