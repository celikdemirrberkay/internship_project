import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_clock/one_clock.dart';

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
      title: FittedBox(
        child: Text(
          'Namaz Vakti',
          style: GoogleFonts.playfair(
            textStyle: context.appTextTheme.displaySmall,
            color: context.themeData.colorScheme.primary,
          ),
        ),
      ),
      actions: [
<<<<<<< HEAD
<<<<<<< HEAD
        DigitalClock(
          isLive: true,
          digitalClockTextColor: context.themeData.colorScheme.primary,
          format: 'HH:mm:ss',
        ),
        const SizedBox(width: 10)
=======
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.location_pin,
            color: context.themeData.colorScheme.secondary,
          ),
        ),
>>>>>>> 47ff30c (View and view model structure change a bit)
=======
        DigitalClock(
          isLive: true,
          digitalClockTextColor: context.themeData.colorScheme.primary,
        ),
        const SizedBox(width: 10)
>>>>>>> 0a4e4a0 (Realtime clock added.)
      ],
    );
  }
}
