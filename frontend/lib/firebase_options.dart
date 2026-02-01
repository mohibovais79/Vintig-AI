// TODO: Replace placeholder Firebase configuration values with your project settings.
// Run `flutterfire configure` to regenerate this file with accurate options for
// every platform you target.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCeYmKMykqq4bjwv1PNm16h4E1tU4k922k',
    appId: '1:842728522603:web:5069d31f7cb7a8347ec22e',
    messagingSenderId: '842728522603',
    projectId: 'vintigai',
    authDomain: 'vintigai.firebaseapp.com',
    storageBucket: 'vintigai.firebasestorage.app',
    measurementId: 'G-NSJXRWFTCX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAy7Jx0IjgCoSNVGxZKqhHQf1czHurXYAY',
    appId: '1:842728522603:android:c178c7f938b658de7ec22e',
    messagingSenderId: '842728522603',
    projectId: 'vintigai',
    storageBucket: 'vintigai.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBTTJy6j5ytSOn664nDMh7FIfWtWh0Ors',
    appId: '1:842728522603:ios:a6c696f14b7e583c7ec22e',
    messagingSenderId: '842728522603',
    projectId: 'vintigai',
    storageBucket: 'vintigai.firebasestorage.app',
    iosBundleId: 'com.vintigai.vintigAi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBTTJy6j5ytSOn664nDMh7FIfWtWh0Ors',
    appId: '1:842728522603:ios:a6c696f14b7e583c7ec22e',
    messagingSenderId: '842728522603',
    projectId: 'vintigai',
    storageBucket: 'vintigai.firebasestorage.app',
    iosBundleId: 'com.vintigai.vintigAi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCeYmKMykqq4bjwv1PNm16h4E1tU4k922k',
    appId: '1:842728522603:web:f6eb9e89f4d52dfa7ec22e',
    messagingSenderId: '842728522603',
    projectId: 'vintigai',
    authDomain: 'vintigai.firebaseapp.com',
    storageBucket: 'vintigai.firebasestorage.app',
    measurementId: 'G-QV6ZYVZ3B2',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'YOUR_LINUX_API_KEY',
    appId: 'YOUR_LINUX_APP_ID',
    messagingSenderId: 'YOUR_LINUX_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_LINUX_STORAGE_BUCKET',
  );
}