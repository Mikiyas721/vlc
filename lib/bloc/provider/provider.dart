import 'package:flutter/material.dart';
import '../../core/utils/disposable.dart';

class Provider<T extends MyDisposable> extends InheritedWidget {
  final T bloc;

  Provider({Key key, Widget child, @required this.bloc})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static T of<T extends MyDisposable>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider<T>>()?.bloc;

}

class BlocProvider<T extends MyDisposable> extends StatefulWidget {
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

class _BlocProviderState<T extends MyDisposable> extends State<BlocProvider<T>> {
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
