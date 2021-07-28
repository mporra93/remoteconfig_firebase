import 'package:flutter/material.dart';

class InterstDemo extends StatefulWidget {
  @override
  _InterstDemoState createState() => _InterstDemoState();
}

class _InterstDemoState extends State<InterstDemo> {
  @override
  int counter = 10;
  Widget build(BuildContext context) {
    quickDelay(context);
    return Material(
      child: Scaffold(
        // appBar: AppBar(),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ESTO SIMULA UN INTERSTITIAL'),
                Text(
                  '$counter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //un simple contador como para
  //esperar unos segundos que termine el supuesto intertitial

  void quickDelay(BuildContext context) async {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (counter <= 1) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'afterAPage', (route) => false);
      } else {
        counter = counter - 1;
        setState(() {});
      }
    });
  }
}
