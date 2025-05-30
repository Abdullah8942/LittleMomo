// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      // case TargetPlatform.iOS:
      //   return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      apiKey: "AIzaSyAUO22oRkGYneBF3mQD7A7kOYLWE0S4-Us",
      authDomain: "little-momo-6eab0.firebaseapp.com",
      projectId: "little-momo-6eab0",
      storageBucket: "little-momo-6eab0.firebasestorage.app",
      messagingSenderId: "1037837606124",
      appId: "1:1037837606124:web:5dfdd1f958c77ade3f59c9",
      measurementId: "G-LL20KF98XC",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuc1NYBSyV0mfaf3HWBMsZRVvS_tHGHpI',
    appId: '1:1037837606124:android:bc5742727987346e3f59c9',
    messagingSenderId: '1037837606124',
    projectId: 'little-momo-6eab0',
    storageBucket: 'little-momo-6eab0.firebasestorage.app',
  );

  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyACTwZO57BebCUoGXy4m8tE1OT9sdNvgpo',
  //   appId: '1:774889290546:ios:e5b207801ef383e73f352b',
  //   messagingSenderId: '774889290546',
  //   projectId: 'little-momo-9fbc2',
  //   storageBucket: 'little-momo-9fbc2.firebasestorage.app',
  //   iosBundleId: 'com.example.littilemomo',
  // );
}
