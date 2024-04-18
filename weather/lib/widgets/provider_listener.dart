import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

typedef ConditionCheck<T> = bool Function(T t);
typedef Callback<T> = void Function(BuildContext context, T t);

class ProviderListener<T> extends StatefulWidget {
  final Widget child;
  final ConditionCheck<T> conditionCheck;
  final Callback<T> listener;

  const ProviderListener({super.key, required this.conditionCheck, required this.listener, required this.child});
  @override
  State<StatefulWidget> createState() => _ProviderListenerState<T>();

}

class _ProviderListenerState<T> extends State<ProviderListener<T>> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.watch<T>();
    if (widget.conditionCheck(provider)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        widget.listener(context, provider);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}