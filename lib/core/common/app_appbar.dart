import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Appbar for the main view
class Appbarforapp extends StatefulWidget implements PreferredSizeWidget {
  ///
  const Appbarforapp({super.key});

  @override
  State<Appbarforapp> createState() => _AppbarforappState();

  /// Needed for the appbar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarforappState extends State<Appbarforapp> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: _appBarTitle(context),
      actions: [
        SizedBox(
          height: 40,
          width: 100,
          child: Text(
            DateFormat('dd.MM.yyyy').format(context.times.currentTime),
            style: GoogleFonts.roboto(
              textStyle: context.textStyles.bodyLarge?.copyWith(
                color: context.themeData.colorScheme.primary,
                fontWeight: context.fontWeights.fwBold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  Widget _appBarTitle(BuildContext context) {
    return FittedBox(
      child: Text(
        'Namaz Vakti',
        style: GoogleFonts.playfair(
          textStyle: context.appTextTheme.displaySmall,
          color: context.themeData.colorScheme.onSecondary,
          shadows: [
            Shadow(color: context.themeData.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
