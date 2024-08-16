import 'package:internship_project/core/exception/exception_type.dart';

/// Resource class is a generic class that holds data and exception type.
sealed class Resource<T> {
  ///
  const Resource({this.data, this.exceptionType});

  /// Data
  final T? data;

  /// Exception type
  final ExceptionTypes? exceptionType;
}

/// Success state
class SuccessState<T> extends Resource<T> {
  ///
  const SuccessState(T data) : super(data: data);
}

/// Error state
class ErrorState<T> extends Resource<T> {
  ///
  const ErrorState(ExceptionTypes type, [T? data]) : super(data: data, exceptionType: type);
}

/// Loading state
class LoadingState<T> extends Resource<T> {
  ///
  const LoadingState() : super();
}
