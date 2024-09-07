import 'package:flutter/widgets.dart';

class SplashScreenEvent {}

class LoadSplashEvent extends SplashScreenEvent {
  final VoidCallback onDone;
  LoadSplashEvent({required this.onDone});
}
