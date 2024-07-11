import 'package:flutter/material.dart';

/// A divider widget (vertical)
class VerticalAppDivider extends StatefulWidget {
  ///
  const VerticalAppDivider({super.key});

  @override
  State<VerticalAppDivider> createState() => _VerticalAppDividerState();
}

class _VerticalAppDividerState extends State<VerticalAppDivider> {
  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      color: Colors.black,
    );
  }
}
