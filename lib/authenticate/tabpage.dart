import 'package:notifications/account/account.dart';
import 'package:notifications/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoTabScaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            tabBar: CupertinoTabBar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.person,
                      ),
                      label: 'Account')
                ]),
            tabBuilder: (context, index) {
              CupertinoTabView returnValue;
              switch (index) {
                case 0:
                  returnValue = CupertinoTabView(builder: (context) {
                    return Scaffold(
                        body: CupertinoPageScaffold(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            child: Home()));
                  });
                  break;
                case 1:
                  returnValue = CupertinoTabView(builder: (context) {
                    return Scaffold(
                        body: CupertinoPageScaffold(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            child: Account()));
                  });
                  break;
              }
              return returnValue;
            }));
  }
}
