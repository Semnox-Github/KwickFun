import  'package:rxdart/rxdart.dart';

class MicroStateProvider<T> {
  late BehaviorSubject<T> _subject;
  MicroStateProvider({required T initial}) {
    _subject = BehaviorSubject.seeded(initial);
  }

  ValueStream<T> get dataStream => _subject.stream;
  T get data => _subject.value;

  void updateData(T data) {
    _subject.add(data);
  }
}
