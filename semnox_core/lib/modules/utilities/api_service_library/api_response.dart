class APIResponse<T> {
  Map<String, dynamic> header;
  T data;
  APIResponse({
    required this.header,
    required this.data,
  });

  dynamic getHeader(String key) {
    return header[key];
  }

  String? getAuthToken() {
    List? header = getHeader("authorization");
    return (header?.isEmpty ?? false) ? null : header?.first;
  }
}
