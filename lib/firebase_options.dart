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
        return macos;
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
    apiKey: 'AIzaSyD6XH5QiAu90HgwRsJET8Wy6BJ_qVmnCgU',
    appId: '1:94421101014:web:a5faa5af0742e9351cdc77',
    messagingSenderId: '94421101014',
    projectId: 'crud-operations-b63e0',
    authDomain: 'crud-operations-b63e0.firebaseapp.com',
    storageBucket: 'crud-operations-b63e0.appspot.com',
    measurementId: 'G-NGTERCC5WR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB07JXtUwK3q1_LvEBCd1fFn_VWXVH8gSg',
    appId: '1:94421101014:android:99372a6c8c6d71661cdc77',
    messagingSenderId: '94421101014',
    projectId: 'crud-operations-b63e0',
    storageBucket: 'crud-operations-b63e0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCr4QTHeWXpSeSiJZM_QCzCHF5KEPg9HE',
    appId: '1:94421101014:ios:095bb97a5edbb71a1cdc77',
    messagingSenderId: '94421101014',
    projectId: 'crud-operations-b63e0',
    storageBucket: 'crud-operations-b63e0.appspot.com',
    iosBundleId: 'com.example.tasontime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCr4QTHeWXpSeSiJZM_QCzCHF5KEPg9HE',
    appId: '1:94421101014:ios:24993b8f65f511eb1cdc77',
    messagingSenderId: '94421101014',
    projectId: 'crud-operations-b63e0',
    storageBucket: 'crud-operations-b63e0.appspot.com',
    iosBundleId: 'com.example.tasontime.RunnerTests',
  );
}
