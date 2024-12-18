import 'package:flutter/material.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';
import 'package:flutter_event_manager/feature/event/feature/details/presentation/details_event_page.dart';
import 'package:flutter_event_manager/feature/event/feature/download/presentation/download_page.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/presentation/event_list_page.dart';
import 'package:flutter_event_manager/feature/event/feature/favorite/presentation/favorite_page.dart';
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
            child: const FavoritePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: Destination.routeDownload,
          pageBuilder: (context, state) => getNoTransitionPage(
            child: const DownloadPage(),
            state: state,
          ),
        ),
      ],
    ),
    GoRoute(
        path: Destination.routeDetails,
        builder: (context, state) =>
            DetailsEventPage(event: state.extra as Event?)),
  ],
);

class Destination {
  static const String routeEventList = "/event_list";
  static const String routeFavourite = "/favourite";
  static const String routeDownload = "/download";

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
