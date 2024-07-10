import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Elevated button widget
@immutable
final class AppElevatedButton extends StatefulWidget {
  ///
  const AppElevatedButton({
    required this.onPressed,
    required this.text,
    this.color,
    this.textColor,
    super.key,
  });

  /// On pressed function
  final void Function()? onPressed;

  /// Button text
  final String text;

  /// Button background color
  final Color? color;

  /// Button text color
  final Color? textColor;

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(3),
        backgroundColor: WidgetStatePropertyAll(widget.color),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: GoogleFonts.poppins(
          textStyle: context.textStyles.bodyLarge?.copyWith(
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}
