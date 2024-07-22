import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/constants/app_constants.dart';
import 'package:internship_project/core/theme/app_theme.dart';
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
      actions: [_settingsIconButton()],
    );
  }

  Widget _settingsIconButton() {
    return IconButton(
      icon: Icon(
        Icons.settings_outlined,
        color: context.themeData.colorScheme.primaryContainer,
      ),
      onPressed: () {},
    );
  }

  ///
  Widget _appBarTitle(BuildContext context) {
    return FittedBox(
      child: Text(
        AppConstants.appName,
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
