import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part '../widget/special_missed_prayer_widget.dart';

/// MissedPrayerView
class MissedPrayerView extends StatefulWidget {
  ///
  const MissedPrayerView({super.key});

  @override
  State<MissedPrayerView> createState() => _MissedPrayerViewState();
}

class _MissedPrayerViewState extends State<MissedPrayerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              context.spacerWithFlex(flex: 5),
              Expanded(flex: 20, child: _missedPrayerExplainContainer()),
              context.spacerWithFlex(flex: 5),
              const Expanded(flex: 10, child: _SpecialMissedPrayerWidget(missedTime: 'İmsak', missedCount: 0)),
              context.spacerWithFlex(flex: 2),
              const Expanded(
                  flex: 10,
                  child: _SpecialMissedPrayerWidget(
                    missedCount: 0,
                    missedTime: 'Sabah',
                  )),
              context.spacerWithFlex(flex: 2),
              const Expanded(
                  flex: 10,
                  child: _SpecialMissedPrayerWidget(
                    missedCount: 0,
                    missedTime: 'Öğlen',
                  )),
              context.spacerWithFlex(flex: 2),
              const Expanded(
                  flex: 10,
                  child: _SpecialMissedPrayerWidget(
                    missedCount: 0,
                    missedTime: 'İkindi',
                  )),
              context.spacerWithFlex(flex: 2),
              const Expanded(
                  flex: 10,
                  child: _SpecialMissedPrayerWidget(
                    missedCount: 0,
                    missedTime: 'Akşam',
                  )),
              context.spacerWithFlex(flex: 2),
              const Expanded(
                  flex: 10,
                  child: _SpecialMissedPrayerWidget(
                    missedCount: 0,
                    missedTime: 'Yatsı',
                  )),
              context.spacerWithFlex(flex: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// Missed prayer explain container
  Widget _missedPrayerExplainContainer() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 95,
          child: Container(
            decoration: BoxDecoration(
              color: context.themeData.colorScheme.onPrimary,
              borderRadius: context.circularBorderRadius(radius: 20),
            ),
            child: Column(
              children: [
                context.spacerWithFlex(flex: 10),
                Expanded(flex: 40, child: _followMissedPrayersText()),
                Expanded(flex: 40, child: _followMissedPrayerExplainText()),
                context.spacerWithFlex(flex: 10),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  /// Follow missed prayer explain text
  Widget _followMissedPrayerExplainText() => Row(
        children: [
          context.spacerWithFlex(flex: 2),
          Expanded(
            flex: 80,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kaza namazları vakit namazları kılındıktan\nsonra kılınmalıdır...',
                style: GoogleFonts.roboto(
                  textStyle: context.appTextTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ),
          context.spacerWithFlex(flex: 12),
        ],
      );

  /// Follow missed prayers text
  Widget _followMissedPrayersText() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 2),
        Expanded(
          flex: 45,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              'Kaza Namazı Takibi',
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.bodyLarge?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 53),
      ],
    );
  }
}
