import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Container(
                color: Colors.white,
                child: Stack(children: [
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Image.asset('images/ic_launcher.png', height: 200,width: 200,),
                  // ),
                  Align(
                    alignment: Alignment(0, 0.9),
                    child: Text(
                      'Made in India',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ]))));
  }
}
