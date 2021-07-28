import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remoteconfig_firebase/AfterAction.dart';

import 'InterstDemo.dart';
import 'services/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => SateManage(), lazy: false),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Remote Config',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'interstPage': (_) => InterstDemo(),
        'afterAPage': (_) => AfterAction(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManage =
        Provider.of<SateManage>(context); //tomamos los valores del provider

    //si o si es necesario tomar los valores con un FutureBuilder
    //porque es una promesa, por ende hay que esperar que se cargue la info
    //mientras tanto, se muestra un CircularProgressIndicator
    return FutureBuilder<RemoteConfig>(
      future: stateManage.setupRemoteConfig(),
      builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
        return !snapshot.hasData
            ? Center(
                child: Scaffold(
                    body:
                        CircularProgressIndicator())) //hasta que llegue la data
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Remote Config'),
                ),
                body: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        //---configuracion
                        RemoteConfig remoteConfig = snapshot.requireData;
                        await remoteConfig
                            .setConfigSettings(RemoteConfigSettings(
                          fetchTimeout: const Duration(seconds: 10),
                          minimumFetchInterval: Duration.zero,
                        ));
                        //configuracion
                        await remoteConfig
                            .fetchAndActivate(); //actualizando valores
                        bool addsEnabled = remoteConfig.getBool('addsEnabled');
                        if (stateManage.getInterst && addsEnabled) {
                          //si publicidad habilitada y adds activadas...
                          String duration =
                              remoteConfig.getString('interstDelay');
                          stateManage.intersticioSwitch();
                          stateManage.setDur(duration);
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              'interstPage',
                              (route) => false); //llamada a la publicidad
                          // Aca iria la funcion que llama a la accion que
                          //sique despues de la publicidad
                          print(
                              'interstitial delay: $duration'); //se puede eliminar esto
                        } else {
                          // Aca iria la funcion que llama a la accion que
                          // le sigue a la publidicad en caso de que falle
                          //en este caso yo puse que vaya al aferPage que seria
                          //lo que sigue despues de la publicidad
                          //que en este caso no se ejecuto
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'afterAPage', (route) => false);
                          // print('Aun no han pasado ${stateManage.getDuration} segundos para el proximo Intersticio'); //el print de abajo se puede eliminar
                        }
                        //--------
                      } on PlatformException catch (exception) {
                        // Aca iria la funcion que llama a la accion que
                          // le sigue a la publidicad en caso de que falle
                          //en este caso yo puse que vaya al aferPage que seria
                          //lo que sigue despues de la publicidad
                          //que en este caso no se ejecuto
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'afterAPage', (route) => false);
                        print(exception);
                      } catch (exception) {
                        // Aca iria la funcion que llama a la accion que
                          // le sigue a la publidicad en caso de que falle
                          //en este caso yo puse que vaya al aferPage que seria
                          //lo que sigue despues de la publicidad
                          //que en este caso no se ejecuto
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'afterAPage', (route) => false);
                        print(exception);
                      }
                    },
                    child: Text('Action'),
                  ),
                ),
              );
      },
    );
  }
}
