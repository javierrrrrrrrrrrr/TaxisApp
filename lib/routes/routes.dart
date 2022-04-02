import 'package:flutter/material.dart';

import '../views/Principales/home.dart';
import '../views/Principales/vista_negocio.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "home": (BuildContext context) => const HomePage(),
  "fondo": (BuildContext context) => const FondoNegocio(),
};
