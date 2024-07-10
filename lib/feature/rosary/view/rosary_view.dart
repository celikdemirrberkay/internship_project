import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

///
class RosaryView extends StatefulWidget {
  const RosaryView({super.key});

  @override
  State<RosaryView> createState() => _RosaryViewState();
}

class _RosaryViewState extends State<RosaryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _rosaryFab(),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              Expanded(child: _lottie()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rosaryFab() {
    return FloatingActionButton.large(
      child: const Icon(Icons.add),
      onPressed: () {},
    );
  }

  /// Quran lottie
  LottieBuilder _lottie() {
    return LottieBuilder.asset(
      'assets/lottie/quran.json',
      repeat: false,
    );
  }
}
