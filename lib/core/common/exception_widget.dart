import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';

/// Error widget for showing error messages
@immutable
final class ExceptionWidget extends StatefulWidget {
  ///
  const ExceptionWidget({
    super.key,
    required this.message,
  });

  /// Error message
  final String message;

  @override
  State<ExceptionWidget> createState() => _ExceptionWidgetState();
}

class _ExceptionWidgetState extends State<ExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.message,
        style: TextStyle(color: context.themeData.colorScheme.error),
      ),
    );
  }
}
