// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDAprWXIqQo3VC4K40yfKNXme_xMF5NyVY',
    appId: '1:972193568481:web:801af9dee800f91abc09a0',
    messagingSenderId: '972193568481',
    projectId: 'clean-home-bbddd',
    authDomain: 'clean-home-bbddd.firebaseapp.com',
    storageBucket: 'clean-home-bbddd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdDeqkFDW_uxgdHtr0065EJqkHTZyid0I',
    appId: '1:972193568481:android:42419ef5e0cc9a85bc09a0',
    messagingSenderId: '972193568481',
    projectId: 'clean-home-bbddd',
    storageBucket: 'clean-home-bbddd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDym1QQ4tYyXj2572Q3Pvat35yq7kd8SpY',
    appId: '1:972193568481:ios:fdc5485daef3e00bbc09a0',
    messagingSenderId: '972193568481',
    projectId: 'clean-home-bbddd',
    storageBucket: 'clean-home-bbddd.appspot.com',
    iosBundleId: 'com.example.clearHome',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDym1QQ4tYyXj2572Q3Pvat35yq7kd8SpY',
    appId: '1:972193568481:ios:fdc5485daef3e00bbc09a0',
    messagingSenderId: '972193568481',
    projectId: 'clean-home-bbddd',
    storageBucket: 'clean-home-bbddd.appspot.com',
    iosBundleId: 'com.example.clearHome',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDAprWXIqQo3VC4K40yfKNXme_xMF5NyVY',
    appId: '1:972193568481:web:03f53a21b64fe06bbc09a0',
    messagingSenderId: '972193568481',
    projectId: 'clean-home-bbddd',
    authDomain: 'clean-home-bbddd.firebaseapp.com',
    storageBucket: 'clean-home-bbddd.appspot.com',
  );
}
