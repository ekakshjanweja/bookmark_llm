import 'package:bookmark_llm/features/auth/pages/login_page.dart';
import 'package:bookmark_llm/features/carousel_animation/pags/carousel_animation_page.dart';
import 'package:bookmark_llm/features/home/pages/home_page.dart';
import 'package:bookmark_llm/features/home/pages/notification_redirect_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {
    LoginPage.routeName: (_) => const MaterialPage(child: LoginPage()),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    HomePage.routeName: (_) => const MaterialPage(child: HomePage()),
    NotificationRedirectPage.routeName: (routeData) => MaterialPage(
          child: NotificationRedirectPage(
              title: routeData.queryParameters["title"] ?? ""),
        ),
    CarouselAnimationPage.routeName: (_) =>
        const MaterialPage(child: CarouselAnimationPage()),
  },
);
