import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:verifeye/core/injector/injector.dart';
import 'package:verifeye/firebase_options.dart';
import 'package:verifeye/verifeye.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  registerSingletons();
  runApp(
    Verifeye(),
  );
}
