sealed class Result<T> {
  const Result();
}

class SUCCESS<T> extends Result<T> {
  final T? data;

  SUCCESS({this.data});
}

class FAILURE<T> extends Result<T> {
  final Exception? exception;

  FAILURE({this.exception});
}
