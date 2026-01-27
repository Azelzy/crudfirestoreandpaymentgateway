import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpkIaoKFlPpJsc2u3VLI9hGrKx4TCjTA0',
    appId: '1:327380011364:android:f96708cf451b8ce62c1271',
    messagingSenderId: '327380011364',
    projectId: 'burgerqueen-68da0',
    storageBucket: 'burgerqueen-68da0.firebasestorage.app',
  );
}
