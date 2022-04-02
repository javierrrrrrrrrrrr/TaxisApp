import 'package:flutter/material.dart';
import 'package:maps_app/screens/mapas/loading_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "loading": (context) => const LoadingScreen(),
};
