
class DataResponse<T> {
  T data;
  bool hasChanged;
  DataResponse({
    required this.data,
    required this.hasChanged,
  });
}

