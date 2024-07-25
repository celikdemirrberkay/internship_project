import 'package:internship_project/core/exception/exception_type.dart';

/// Resource class is a generic class that holds data and exception type.
sealed class Resource<T> {
  ///
  Resource({this.data, this.exceptionType});

  /// Data
  final T? data;

  /// Exception type
  final ExceptionType? exceptionType;
}

/// Success state
class SuccessState<T> extends Resource<T> {
  ///
  SuccessState(T data) : super(data: data);
}

/// Error state
class ErrorState<T> extends Resource<T> {
  ///
  ErrorState(ExceptionType type, [T? data]) : super(data: data, exceptionType: type);
}

/// Loading state
class LoadingState<T> extends Resource<T> {
  ///
  LoadingState() : super();
}
