import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'bloc_base.dart';

class BlocMultiProvider<T extends BlocCore> extends StatelessWidget {
  const BlocMultiProvider({
    super.key,
    required this.bloc,
    required this.providers,
    required this.child,
  });

  final T Function() bloc;
  final Widget child;
  final List<SingleChildWidget> providers;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => bloc(),
          dispose: (context, bloc) => bloc.dispose(),
        ),
        ...providers
      ],
      child: child,
    );
  }
}
