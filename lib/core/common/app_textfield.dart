import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Textfield widget
@immutable
final class AppTextfield extends StatefulWidget {
  ///
  const AppTextfield({
    super.key,
    required this.hintText,
  });

  /// Hint text
  final String hintText;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 15,
      style: GoogleFonts.roboto(
        color: context.themeData.colorScheme.onSecondary,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: context.circularBorderRadius(radius: 12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: context.circularBorderRadius(radius: 12),
          borderSide: BorderSide(
            width: 2,
            color: context.themeData.colorScheme.primary,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.themeData.colorScheme.primary,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.roboto(
          color: Colors.grey,
        ),
      ),
    );
  }
}
