import 'package:flutter/material.dart';
import 'package:flutter_event_manager/feature/event/list/event_list_page.dart';
import 'package:flutter_event_manager/feature/main/main_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter mainRouter = GoRouter(
  initialLocation: Destination.routeEventList,
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => Destination.routeEventList,
    ),
    ShellRoute(
      builder: (context, state, child) => MainPage(child: child),
      routes: [
        GoRoute(
          path: Destination.routeEventList,
          pageBuilder: (context, state) => getNoTransitionPage(
            child: const EventListPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: Destination.routeFavourite,
          pageBuilder: (context, state) => getNoTransitionPage(
            child: Center(
              child: ElevatedButton(
                onPressed: () => context.push('/details'),
                child: const Text('Open Favorite'),
              ),
            ), // todo,
            state: state,
          ),
        ),
      ],
    ),
    GoRoute(
      path: Destination.routeDetails,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('DetailsEventPage'),
        ),
      ), // todo,
    ),
  ],
);

class Destination {
  static const String routeEventList = "/event_list";
  static const String routeFavourite = "/favourite";

  static const String routeDetails = "/details";
}

Page getNoTransitionPage({
  required Widget child,
  required GoRouterState state,
}) {
  return NoTransitionPage(
    key: state.pageKey,
    child: child,
  );
}
