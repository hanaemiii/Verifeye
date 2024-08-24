import 'package:flutter/material.dart';

final _window = WidgetsBinding.instance.platformDispatcher.views.first;

final devicePixelRatio = _window.devicePixelRatio;
final screenWidth = _window.physicalSize.shortestSide / devicePixelRatio;
final screenHeight = _window.physicalSize.longestSide / devicePixelRatio;
final safeAreaTop = _window.padding.top / devicePixelRatio;
final safeAreaBottom = _window.padding.bottom / devicePixelRatio;
