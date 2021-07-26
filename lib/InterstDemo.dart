import 'package:flutter/material.dart';



class InterstDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    quickDelay(context);
    return Material(
      child: Scaffold(
        // appBar: AppBar(),
        body: Container(
          child: Center(
            child: Text('ESTO SIMULA LA VENTANA DE PUBLICIDAD QUE SE ABRE'),
          ),
        ),
      ),
    );
  }

  void quickDelay(BuildContext context) async {
    //this is to simulate the time of intersticio
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    });
  }
}
