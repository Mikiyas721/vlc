import 'package:flutter/material.dart';
import '../../core/utils/disposable.dart';

class Provider<T> extends InheritedWidget {
  final T bloc;

  Provider({Key key, Widget child, @required this.bloc}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static T of<T>(BuildContext context) {
    Provider<T> provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();
    return provider?.bloc;
  } // who calls this method???
}

class BlocProvider<T extends Disposable> extends StatefulWidget {
  final T Function() blocFactory;
  final Widget Function(BuildContext, T) builder;

  BlocProvider({Key key, @required this.blocFactory, @required this.builder}) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState();
}

class _BlocProviderState<T extends Disposable> extends State<BlocProvider<T>> {
  T bloc;

  @override
  void initState() {
    bloc = widget.blocFactory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      bloc: bloc,
      child: widget.builder(context, bloc),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
