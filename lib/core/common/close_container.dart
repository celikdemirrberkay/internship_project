import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';

/// Close container for bottom sheets
@immutable
final class CloseContainer extends StatelessWidget {
  ///
  const CloseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 40),
        Expanded(
          flex: 20,
          child: Container(
            height: context.screenSizes.height * 0.007,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: context.circularBorderRadius(radius: 6),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 40),
      ],
    );
  }
}
