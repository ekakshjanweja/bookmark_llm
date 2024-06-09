import 'package:bookmark_llm/features/auth/pages/login_page.dart';
import 'package:bookmark_llm/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {
    "/": (_) => const MaterialPage(child: LoginPage()),
  },
);

final loggedInRoute = RouteMap(routes: {
  "/": (_) => const MaterialPage(child: HomePage()),
});
