import 'package:flutter/material.dart';

/// A divider widget
@immutable
final class HorizontalAppDivider extends StatefulWidget {
  ///
  const HorizontalAppDivider({super.key});

  @override
  State<HorizontalAppDivider> createState() => _HorizontalAppDividerState();
}

class _HorizontalAppDividerState extends State<HorizontalAppDivider> {
  @override
  Widget build(BuildContext context) {
    return const Divider();
  }
}
