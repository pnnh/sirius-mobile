
import 'package:dream/application/pages/random.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/home/home.dart';


final GoRouter globalRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        // GoRoute(
        //   path: 'random',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return RandomPage();
        //   },
        // ),
      ],
    ),
  ],
);
