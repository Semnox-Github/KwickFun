import  'package:rxdart/rxdart.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';


class DataProvider<T> {
  final BehaviorSubject<DataState<T>> _subject =
      BehaviorSubject.seeded(DataState.idle<T>());
  DataProvider({T? initial}) {
    if (initial != null) {
      updateData(initial);
    }
  }
  ValueStream<DataState<T>> get dataStream => _subject.stream;
  T? get data => dataStream.value.data;
  bool get isLoading => dataStream.value.state == DataProviderState.loading ;
  Future<void> handleFuture(Future<T> future) async {
    startLoading();
    try {
      T data = await future;
      updateData(data);
    } catch (e) {
      addError("$e");
    }
  }

  void updateData(T data) {
    _subject.add(DataState.ondata<T>(data));
  }

  void startLoading() {
    _subject.add(DataState.loading<T>());
  }

  void addError(String error) {
    _subject.add(DataState.onError<T>(error));
  }
}
