import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';

/// A divider widget
@immutable
final class HorizontalAppDivider extends StatefulWidget {
  ///
  const HorizontalAppDivider({super.key, this.dividerColor});

  /// Divider color
  final Color? dividerColor;

  @override
  State<HorizontalAppDivider> createState() => _HorizontalAppDividerState();
}

class _HorizontalAppDividerState extends State<HorizontalAppDivider> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: widget.dividerColor ?? context.themeData.colorScheme.primary,
    );
  }
}
