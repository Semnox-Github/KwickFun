import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/semnox_core.dart';

Widget _defaultLoader(_) {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget _defaultErrorBuilder(context, dynamic error) {
  return Center(
    child: SemnoxText.bodyReg2(text: "$error"),
  );
}

class DataProviderBuilder<T> extends StatelessWidget {
  const DataProviderBuilder({
    Key? key,
    required this.dataProvider,
    this.enableAnimation = true,
    this.loader = _defaultLoader,
    this.error = _defaultErrorBuilder,
    required this.builder,
  }) : super(key: key);
  final ValueStream<DataState<T>> dataProvider;
  final bool enableAnimation;
  final Widget Function(BuildContext context) loader;
  final Widget Function(BuildContext context, dynamic error) error;
  final Widget Function(BuildContext context, T? data) builder;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState<T>>(
      stream: dataProvider,
      builder: (BuildContext context, AsyncSnapshot<DataState<T>> snapshot) {
        Widget? child;
        if (snapshot.hasData && snapshot.data != null) {
          var provider = snapshot.data;

          if (provider != null) {
            switch (provider.state) {
              case DataProviderState.data:
                child ??= builder.call(context, provider.data);

                break;

              case DataProviderState.error:
                child ??= error.call(context, provider.error);
                break;
              case DataProviderState.idle:
              case DataProviderState.loading:
              default:
                child ??= loader.call(
                  context,
                );
            }
          }

          child ??= loader.call(
            context,
          );
        }

        if (snapshot.hasError) {
          child ??= error.call(context, snapshot.error);
        }

        child ??= loader.call(
          context,
        );

        return enableAnimation
            ? AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: child,
              )
            : child;
      },
    );
  }
}

class DataStateBuilder<T> extends StatelessWidget {
  const DataStateBuilder({
    Key? key,
    required this.dataProvider,
    this.enableAnimation = true,
    this.loader = _defaultLoader,
    this.error = _defaultErrorBuilder,
    required this.builder,
  }) : super(key: key);
  final DataState<T> dataProvider;
  final bool enableAnimation;
  final Widget Function(BuildContext context) loader;
  final Widget Function(BuildContext context, dynamic error) error;
  final Widget Function(BuildContext context, T? data) builder;
  @override
  Widget build(BuildContext context) {
    Widget? child;
    var provider = dataProvider;

    switch (provider.state) {
      case DataProviderState.data:
        child ??= builder.call(context, provider.data);

        break;

      case DataProviderState.error:
        child ??= error.call(context, provider.error);
        break;
      case DataProviderState.idle:
      case DataProviderState.loading:
      default:
        child ??= loader.call(
          context,
        );
    }

    // child ??= loader.call(
    //   context,
    // );

    return enableAnimation
        ? AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: child,
          )
        : child;
  }
}
