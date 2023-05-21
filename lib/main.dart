import 'package:app/firebase_options.dart';
import 'package:app/spotify_client/Example.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/sajt/MainPage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Future<void> main()async{
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.currentPlatform
//   // );
//   runApp(MainPage());
// }


Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const Home());
}