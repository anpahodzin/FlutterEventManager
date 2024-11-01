import 'package:flutter/material.dart';
import 'package:flutter_event_manager/feature/event/list/event_list_page.dart';
import 'package:flutter_event_manager/feature/home/main_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter mainRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => Destination.routeEventList,
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
        GoRoute(
          path: Destination.routeEventList,
          builder: (context, state) => const EventListPage(),
        ),
        GoRoute(
          path: Destination.routeFavourite,
          builder: (context, state) =>
              const Center(child: Text('Favourite')), // todo,
        ),
      ],
    ),
    GoRoute(
      path: Destination.routeDetails,
      builder: (context, state) =>
          const Center(child: Text('DetailsEventPage')), // todo,
    ),
  ],
);

class Destination {
  static const String routeEventList = "/event_list";
  static const String routeFavourite = "/favourite";

  static const String routeDetails = "/details";
}
