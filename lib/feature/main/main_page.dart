import 'package:flutter/material.dart';
import 'package:flutter_event_manager/navigation/main_router.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<String> _routes = [
    Destination.routeEventList,
    Destination.routeFavourite,
    Destination.routeDownload,
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter Event Manager") //todo
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Events', // todo
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite', // todo
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Download', // todo
          ),
        ],
      ),
    );
  }
}
