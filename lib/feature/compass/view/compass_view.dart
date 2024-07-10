import 'package:flutter/material.dart';

/// Compass View to find qibla direction
class CompassView extends StatefulWidget {
  const CompassView({super.key});

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('data')),
    );
  }
}
