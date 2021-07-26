

# remote_config_firebase

Este es un ejemplo de Remote Config para controlar el tiempo entre publicidades en diferentes plataformas como iOS, Android, Web de manera remota a traves de un [Remote Config File](https://firebase.google.com/products/remote-config?gclid=Cj0KCQjw9O6HBhCrARIsADx5qCRRRcS2fYw--OvqHIJEQN6UGG4xR8S0kvRxUx9KCvKK_9Yii0GXe18aAgj7EALw_wcB&gclsrc=aw.ds)


# Funcionamiento 

Al presionar el boton Action, abre una ventana (solo por algunos segundos) que simula la publicidad, al ejecutar esta accion tambien hace un fetch de los valores actuales en el remote-config-file de Firebase y los actualiza. 
    - si se presiona nuevamente el boton Action, abrira nuevamente la publicidad en caso de haber transcurrido el tiempo de delay entre intersticios, de lo contrario se imprime un mensaje por consola informando que aun no ha pasado el tiempo necesario. En ese caso podes esperar, o ejecutar la accion de todos modos sin publicidad. Todo esta comentado en el codigo.


# Como agregar esta implementacion a tu proyecto



## Agregar dependencias en pubspec.yaml

```

firebase_core: "^1.4.0"
firebase_remote_config: "^0.10.0+3"
provider: ^5.0.0

```

## Agregar Firebase a tu app


- Antes de empezar, te dejo un [video](https://www.youtube.com/watch?v=EGgsT_fSP50&list=WL&index=5&t=609s) paso a paso que explica bastante bien como agregar Firebase a tu proyecto.


- Crear Aplicaciones para Android & iOs en el proyecto de firebase
    - iOs> completar la configuracion con el App ID
        - iOs lo sacamos usando XCode clickeando en Runner -> Signing&Capabilities, en este caso: com.example.remoteconfigFirebase
        - Agregamos el archivo de configuracion de google en la ruta especificada (IMPORTANTE USAR XCode para mover el archivo)
        - No es necesario hacer los pasos siguientes para flutter
        - si se obtiene el error `Automatically assigning platform iOS with version 9.0 on target Runner because no platform was specified.` se deme modificar el archivo ios/Podfile, descomentamos y reemplazamos la primera linea por ```platform :ios, '10.0'```
    - Android> completar la configuracion con el App ID, simplemente desde el archivo build.gradle en android/app, en este caso: com.example.remoteconfig_firebase
        - Agregar archivo de configuracion de google en Android/app/ 
        - Agregar las lineas de codigo como indica  en build.gradle en /Android/build.gradle y en /Android/app/build.gradle

