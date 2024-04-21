abstract class Response<T>{
  final T? data;
  final String? error;
  const Response({this.data, this.error});
}
class Success<T> extends Response<T>{
  const Success(T data): super(data: data);
}

class Failure<T> extends Response<T>{
  const Failure(String error): super(error: error);
}