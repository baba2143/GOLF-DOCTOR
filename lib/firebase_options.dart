import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDAsCUGjM-rCO-ru25qQdSsDH6CtWhE-t8',
    appId: '1:539469926669:web:b42f23cb3d398366d7e044',
    messagingSenderId: '539469926669',
    projectId: 'golf-doctor-2da08',
    authDomain: 'golf-doctor-2da08.firebaseapp.com',
    storageBucket: 'golf-doctor-2da08.firebasestorage.app',
    measurementId: 'G-2QN6H07KVL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAukv7YzKiMR0rjWSqd8LUt2jtALT0xp5s',
    appId: '1:539469926669:android:fb4f592dfff88509d7e044',
    messagingSenderId: '539469926669',
    projectId: 'golf-doctor-2da08',
    storageBucket: 'golf-doctor-2da08.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7Y3JBh0vOxUQ-YwRU643t9sAXh7Bslxo',
    appId: '1:539469926669:ios:22472c92ce1c13f1d7e044',
    messagingSenderId: '539469926669',
    projectId: 'golf-doctor-2da08',
    storageBucket: 'golf-doctor-2da08.firebasestorage.app',
    iosBundleId: 'com.golfdoctor.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7Y3JBh0vOxUQ-YwRU643t9sAXh7Bslxo',
    appId: '1:539469926669:ios:22472c92ce1c13f1d7e044',
    messagingSenderId: '539469926669',
    projectId: 'golf-doctor-2da08',
    storageBucket: 'golf-doctor-2da08.firebasestorage.app',
    iosBundleId: 'com.golfdoctor.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC7Y3JBh0vOxUQ-YwRU643t9sAXh7Bslxo',
    appId: '1:539469926669:web:0000000000000000d7e044',
    messagingSenderId: '539469926669',
    projectId: 'golf-doctor-2da08',
    storageBucket: 'golf-doctor-2da08.firebasestorage.app',
  );
}
