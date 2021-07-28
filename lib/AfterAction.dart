import 'package:flutter/material.dart';

class AfterAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        // appBar: AppBar(),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ESTO SIMULA LA VENTANA LUEGO DEL ADD',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'SI NO APARECIO EL INTERTITIAL ES PORQUE AUN NO TERMINO EL TIEMPO O ESTA DESHABILITADO',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'home', (route) => false);
                    },
                    child: Text('Reiniciar Prueba'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
