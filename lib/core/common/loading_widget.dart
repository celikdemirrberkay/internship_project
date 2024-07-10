import 'package:flutter/material.dart';

/// Loading widget for showing loading indicator
@immutable
final class LoadingWidget extends StatefulWidget {
  ///
  const LoadingWidget({super.key, this.color});

  /// Color of the loading indicator
  final Color? color;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: widget.color,
      ),
    );
  }
}
