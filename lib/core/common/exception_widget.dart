import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Error widget for showing error messages
@immutable
final class ExceptionWidget extends StatefulWidget {
  ///
  const ExceptionWidget({
    required this.message,
    super.key,
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
      child: Column(
        children: [
          context.spacerWithFlex(flex: 1),
          Expanded(flex: 2, child: SvgPicture.asset('assets/svg/error.svg')),
          Expanded(
            flex: 2,
            child: Text(
              widget.message,
              style: TextStyle(color: context.themeData.colorScheme.error),
            ),
          ),
          context.spacerWithFlex(flex: 1),
        ],
      ),
    );
  }
}
