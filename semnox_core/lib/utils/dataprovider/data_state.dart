class DataState<T> {
  final T? data;
  final String? error;
  final DataProviderState state;
  DataState._(this.data, this.error, this.state);

  static DataState<T> idle<T>() =>
      DataState<T>._(null, null, DataProviderState.idle);
  static DataState<T> loading<T>() =>
      DataState<T>._(null, null, DataProviderState.loading);
  static DataState<T> ondata<T>(T data) =>
      DataState<T>._(data, null, DataProviderState.data);
  static DataState<T> onError<T>(String e) =>
      DataState<T>._(null, e, DataProviderState.error);
}

enum DataProviderState {
  idle,
  loading,
  data,
  error,
}
