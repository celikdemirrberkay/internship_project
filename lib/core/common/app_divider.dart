import 'package:flutter/material.dart';

/// A divider widget
@immutable
final class AppDivider extends StatefulWidget {
  ///
  const AppDivider({super.key});

  @override
  State<AppDivider> createState() => _AppDividerState();
}

class _AppDividerState extends State<AppDivider> {
  @override
  Widget build(BuildContext context) {
    return const Divider();
  }
}
