// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      case TargetPlatform.iOS:
        return ios;
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
    apiKey: 'AIzaSyD1ZtWBPLDf7Xk2VqfMYqKscrVyokHm_hs',
    appId: '1:809385533224:web:99dafcdc2784ddea0aba1d',
    messagingSenderId: '809385533224',
    projectId: 'shoppy-da710',
    authDomain: 'shoppy-da710.firebaseapp.com',
    storageBucket: 'shoppy-da710.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAihuOyaoZpJJD1po0gfyxONa-7u2vEriI',
    appId: '1:809385533224:android:c0ebd345a32a32bb0aba1d',
    messagingSenderId: '809385533224',
    projectId: 'shoppy-da710',
    storageBucket: 'shoppy-da710.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVkucfZDgqfRbj3JRHbi9-ALDgx0JPTCU',
    appId: '1:809385533224:ios:dc54cee66fe408630aba1d',
    messagingSenderId: '809385533224',
    projectId: 'shoppy-da710',
    storageBucket: 'shoppy-da710.appspot.com',
    androidClientId: '809385533224-3ifns948tu4b3kenmovri47mbhm5ec4a.apps.googleusercontent.com',
    iosClientId: '809385533224-fb3j2167mgetsdg2isn32hdj19gie46i.apps.googleusercontent.com',
    iosBundleId: 'com.example.shoppy',
  );
}
