import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc_base.dart';

class BlocProvider<T extends BlocCore> extends StatelessWidget {
  const BlocProvider({
    super.key,
    required this.bloc,
    required this.child,
  });

  final T Function() bloc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => bloc(),
        dispose: (context, bloc) {
          bloc.dispose();
        },
        child: child);
  }
}
