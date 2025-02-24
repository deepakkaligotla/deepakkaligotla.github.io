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
    apiKey: 'AIzaSyCAyJQuFzusljREnGjVmhu8OHj7GOsBNeE',
    appId: '1:293109249507:web:882e9308ce92ff75081cd6',
    messagingSenderId: '293109249507',
    projectId: 'deepakkaligotla-githubio',
    authDomain: 'deepakkaligotla-githubio.firebaseapp.com',
    databaseURL: 'https://deepakkaligotla-githubio-default-rtdb.firebaseio.com/',
    storageBucket: 'deepakkaligotla-githubio.firebasestorage.app',
    measurementId: 'G-PST254JLDP',
  );

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyBpZi5Xw9wMuuvsD6mxgCtS-1ExDETkZHo',
      appId: '1:293109249507:android:1ad0cae198641738081cd6',
      messagingSenderId: '293109249507',
      projectId: 'deepakkaligotla-githubio',
      databaseURL: 'https://deepakkaligotla-githubio-default-rtdb.firebaseio.com/',
      storageBucket: 'deepakkaligotla-githubio.firebasestorage.app',
      androidClientId: '293109249507-9jlqhe7du902jntau7vb6h879et60kfg.apps.googleusercontent.com'
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZ_MD-p-Wn9Ycgusu2x68vPNfnRJ9qjzo',
    appId: '1:293109249507:android:1ad0cae198641738081cd6',
    messagingSenderId: '293109249507',
    projectId: 'deepakkaligotla-githubio',
    databaseURL: 'https://deepakkaligotla-githubio-default-rtdb.firebaseio.com/',
    storageBucket: 'deepakkaligotla-githubio.firebasestorage.app',
    iosClientId: '293109249507-n1776lhsb0iunmo10n2geui22e2qcrl5.apps.googleusercontent.com',
    iosBundleId: 'in.kaligotla.deepak',
  );
}