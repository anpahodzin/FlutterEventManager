import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'bloc_base.dart';

typedef ProviderFactory<T> = SingleChildWidget Function(BuildContext, T);

class BlocMultiProvider<T extends BlocCore> extends StatelessWidget {
  const BlocMultiProvider({
    super.key,
    required this.bloc,
    required this.providerFactories,
    required this.child,
  });

  final T Function() bloc;
  final Widget child;
  final List<ProviderFactory<T>> providerFactories;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => bloc(),
      dispose: (context, bloc) {
        bloc.dispose();
      },
      child: _BlocMultiProvider(
        providerFactories: providerFactories,
        child: child,
      ),
    );
  }
}

class _BlocMultiProvider<T extends BlocCore> extends StatelessWidget {
  final Widget child;
  final List<ProviderFactory<T>> providerFactories;

  const _BlocMultiProvider({
    super.key,
    required this.providerFactories,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<T>();
    return MultiProvider(
      providers: providerFactories.map((it) => it(context, bloc)).toList(),
      child: child,
    );
  }
}
