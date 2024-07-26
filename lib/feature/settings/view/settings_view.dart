import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Settings view where user can change settings
class SettingsView extends StatefulWidget {
  ///
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _title(),
        leading: _backButton(context),
      ),
      body: SafeArea(child: _column()),
    );
  }

  Widget _column() {
    return SizedBox.expand(
      child: Column(
        children: [
          context.spacerWithFlex(flex: 3),
          Expanded(flex: 5, child: _headerText('Konum')),
          Expanded(flex: 8, child: _specialCards()),
          context.spacerWithFlex(flex: 3),
          Expanded(flex: 5, child: _headerText('Tema')),
          Expanded(flex: 8, child: _specialCardForTheme()),
          context.spacerWithFlex(flex: 3),
          Expanded(flex: 5, child: _headerText('Bildirim')),
          Expanded(flex: 8, child: _specialCardForNotification()),
          context.spacerWithFlex(flex: 45),
          Expanded(flex: 5, child: Text('data')),
          context.spacerWithFlex(flex: 2),
        ],
      ),
    );
  }

  Widget _specialCards() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: context.circularBorderRadius(radius: 12),
              color: context.themeData.colorScheme.onPrimary,
            ),
            child: Row(
              children: [
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 5,
                  child: FittedBox(
                    child: Icon(
                      Icons.location_on_outlined,
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ),
                context.spacerWithFlex(flex: 2),
                Expanded(
                  flex: 80,
                  child: Text(
                    'Şehri seçiniz',
                    style: GoogleFonts.roboto(
                      textStyle: context.appTextTheme.bodyLarge?.copyWith(
                        color: context.themeData.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// Special card for theme
  Widget _specialCardForTheme() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: context.circularBorderRadius(radius: 12),
              color: context.themeData.colorScheme.onPrimary,
            ),
            child: Row(
              children: [
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 5,
                  child: FittedBox(
                    child: Icon(
                      Icons.color_lens_outlined,
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ),
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 60,
                  child: Text(
                    'Temayı seçiniz',
                    style: GoogleFonts.roboto(
                      textStyle: context.appTextTheme.bodyLarge?.copyWith(
                        color: context.themeData.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 20, child: Switch(value: false, onChanged: (_) {})),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// Special card for notification
  Widget _specialCardForNotification() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: context.circularBorderRadius(radius: 12),
              color: context.themeData.colorScheme.onPrimary,
            ),
            child: Row(
              children: [
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 5,
                  child: FittedBox(
                    child: Icon(
                      Icons.notification_add_outlined,
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ),
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 60,
                  child: Text(
                    'Bildirimleri açın',
                    style: GoogleFonts.roboto(
                      textStyle: context.appTextTheme.bodyLarge?.copyWith(
                        color: context.themeData.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 20, child: Switch(value: true, onChanged: (_) {})),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  Widget _headerText(String text) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 95,
          child: Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: context.appTextTheme.headlineSmall?.copyWith(
                color: context.themeData.colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Back button
  Widget _backButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: context.themeData.colorScheme.onSecondary,
      ),
      onPressed: () => context.pop(),
    );
  }

  /// Title
  Widget _title() => Text(
        'Ayarlar',
        style: GoogleFonts.roboto(
          textStyle: context.appTextTheme.headlineSmall?.copyWith(
            color: context.themeData.colorScheme.onSecondary,
          ),
        ),
      );
}
