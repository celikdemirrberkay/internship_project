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
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
              child: InkWell(
                onTap: _prayerTimeEntryBottomSheet,
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
          ),
          context.spacerWithFlex(flex: 5),
        ],
      ),
    );
  }

  /// Prayer time entry bottom sheet function
  Future<Widget?> _prayerTimeEntryBottomSheet() {
    return showModalBottomSheet<Widget>(
      context: context,
      builder: (context) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () => context.focusScope.unfocus(),
        child: Column(
          children: [
            const CloseContainer(),
            context.spacerWithFlex(flex: 5),
            Expanded(flex: 15, child: _howManyTimesDidYouMissText()),
            Expanded(flex: 15, child: _missedPrayerCountTextField()),
            Expanded(flex: 15, child: _saveButton()),
            context.spacerWithFlex(flex: 45),
          ],
        ),
      ),
    );
  }

  Widget _saveButton() => FittedBox(
        child: ViewModelBuilder.nonReactive(
          viewModelBuilder: () => MissedPrayerViewmodel(locator()),
          builder: (context, viewModel, child) => TextButton(
            child: Text(
              'Kaydet',
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.bodyMedium?.copyWith(
                  color: context.themeData.colorScheme.primary,
                ),
              ),
            ),
            onPressed: () async {
              if (_controller.text.isEmpty) {
                await Fluttertoast.showToast(msg: 'Geçerli bir sayı giriniz');
              } else {
                await viewModel.saveMissedPrayerCount(
                  widget.missedTime,
                  int.parse(_controller.text),
                );
                if (!mounted) return;
                context.pop();
              }
            },
          ),
        ),
      );

  /// Missed prayer count text field on bottom sheet
  Widget _missedPrayerCountTextField() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 40),
        Expanded(
          flex: 20,
          child: AppTextfield(
            keyboardType: TextInputType.number,
            controller: _controller,
            textAlign: TextAlign.center,
            hintText: '${widget.missedCount}',
          ),
        ),
        context.spacerWithFlex(flex: 40),
      ],
    );
  }

  /// How many times did you miss text on bottom sheet
  Widget _howManyTimesDidYouMissText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenSizes.dynamicWidth(0.15)),
      child: FittedBox(
        child: Text(
          '${widget.missedTime} için kaç vakit kaçırdınız?',
          style: GoogleFonts.roboto(
            textStyle: context.appTextTheme.bodyMedium?.copyWith(
              color: context.themeData.colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
