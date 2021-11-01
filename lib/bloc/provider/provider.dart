import 'package:flutter/material.dart';
import '../../core/utils/disposable.dart';

class Provider<T extends Disposable> extends InheritedWidget {
  final T bloc;

  Provider({Key key, Widget child, @required this.bloc})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static T of<T extends Disposable>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider<T>>()?.bloc;
//Not working
}

class BlocProvider<T extends Disposable> extends StatefulWidget {
  final T Function() blocFactory;
  final void Function(T) onInit;
  final void Function(T) onDispose;
  final Widget Function(BuildContext, T) builder;

  BlocProvider({
    Key key,
    @required this.blocFactory,
    @required this.builder,
    this.onInit,
    this.onDispose,
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState();
}

class _BlocProviderState<T extends Disposable> extends State<BlocProvider<T>> {
  T bloc;

  @override
  void initState() {
    bloc = widget.blocFactory();
    widget.onInit?.call(bloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      bloc: bloc,
      child: Builder(builder: (BuildContext context) {
        return widget.builder(context, bloc);
      }),
    );
  }

  @override
  void dispose() {
    //bloc.dispose();
    widget.onDispose?.call(bloc);
    super.dispose();
  }
}
