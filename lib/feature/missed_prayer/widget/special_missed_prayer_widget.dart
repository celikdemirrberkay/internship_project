part of '../view/missed_prayer_view.dart';

@immutable
final class _SpecialMissedPrayerWidget extends StatefulWidget {
  const _SpecialMissedPrayerWidget({
    required this.missedTime,
    required this.missedCount,
  });

  /// Name of missed time
  final String missedTime;

  /// Count of missed time
  final int missedCount;

  @override
  State<_SpecialMissedPrayerWidget> createState() => _SpecialMissedPrayerWidgetState();
}

class _SpecialMissedPrayerWidgetState extends State<_SpecialMissedPrayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 2),
        Expanded(flex: 20, child: _specialMissedPrayerRowAddButton()),
        Expanded(flex: 56, child: _specialMissedPrayerRowMiddleContainer()),
        Expanded(flex: 20, child: _specialMissedPrayerRowRemoveButton()),
        context.spacerWithFlex(flex: 2),
      ],
    );
  }

  Widget _specialMissedPrayerRowAddButton() {
    return FittedBox(
      child: CircleAvatar(
        backgroundColor: context.themeData.colorScheme.onError,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _specialMissedPrayerRowRemoveButton() {
    return FittedBox(
      child: CircleAvatar(
        backgroundColor: context.themeData.colorScheme.primary,
        child: const Icon(Icons.remove),
      ),
    );
  }

  Widget _specialMissedPrayerRowMiddleContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: context.circularBorderRadius(radius: 20),
      ),
      child: Column(
        children: [
          context.spacerWithFlex(flex: 5),
          Expanded(
            flex: 40,
            child: FittedBox(
              child: Text(
                widget.missedTime,
                style: GoogleFonts.roboto(
                  textStyle: context.appTextTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.onSecondary,
                    fontWeight: context.fontWeights.fwBold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 40,
            child: FittedBox(
              child: Text(
                '${widget.missedCount}',
                style: GoogleFonts.roboto(
                  textStyle: context.appTextTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.onSecondary,
                    fontWeight: context.fontWeights.fw300,
                  ),
                ),
              ),
            ),
          ),
          context.spacerWithFlex(flex: 5),
        ],
      ),
    );
  }
}
