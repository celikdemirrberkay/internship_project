part of '../view/settings_view.dart';

/// Time selector bottomsheet
class _TimeSelectorBottomsheet extends StatefulWidget {
  const _TimeSelectorBottomsheet();

  @override
  State<_TimeSelectorBottomsheet> createState() => _TimeSelectorBottomsheetState();
}

class _TimeSelectorBottomsheetState extends State<_TimeSelectorBottomsheet> {
  /// Picker value
  int pickerValue = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenSizes.dynamicHeight(0.5),
      width: double.infinity,
      child: Column(
        children: [
          _closeBar(),
          context.spacerWithFlex(flex: 10),
          Expanded(flex: 10, child: _pickNotifTimeText()),
          Expanded(flex: 55, child: _cupertinoPicker()),
          Expanded(flex: 20, child: _pickerSetButton()),
          context.spacerWithFlex(flex: 40),
        ],
      ),
    );
  }

  /// Close bar
  Widget _closeBar() {
    return Container(
      width: context.screenSizes.dynamicWidth(0.2),
      height: 7,
      decoration: BoxDecoration(
        color: context.themeData.colorScheme.onSurface,
        borderRadius: context.circularBorderRadius(radius: 10),
      ),
    );
  }

  Widget _cupertinoPicker() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingsViewModel(locator(), locator(), locator()),
      builder: (context, viewModel, child) => CupertinoPicker(
        itemExtent: context.screenSizes.dynamicHeight(0.06),
        scrollController: FixedExtentScrollController(),
        onSelectedItemChanged: (value) async {
          pickerValue = value;
        },
        children: [
          _pickerSpecialText('Her Namaz Vaktinden 5 Dakika Önce'),
          _pickerSpecialText('Her Namaz Vaktinden 10 Dakika Önce'),
          _pickerSpecialText('Her Namaz Vaktinden 15 Dakika Önce'),
          _pickerSpecialText('Sadece Namaz Vaktinde'),
        ],
      ),
    );
  }

  /// Picker text
  Widget _pickNotifTimeText() {
    return FittedBox(
      alignment: AlignmentDirectional.bottomCenter,
      child: Text(
        'Bildirim Zamanı Seç',
        style: GoogleFonts.roboto(
          textStyle: context.appTextTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.primary,
            fontWeight: context.fontWeights.fw300,
          ),
        ),
      ),
    );
  }

  /// Picker set button
  Widget _pickerSetButton() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingsViewModel(locator(), locator(), locator()),
      builder: (context, viewModel, child) => FittedBox(
        child: TextButton(
          child: FittedBox(
            child: Text(
              'Kur',
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.bodyLarge?.copyWith(
                  color: context.themeData.colorScheme.primary,
                ),
              ),
            ),
          ),
          onPressed: () async {
            await viewModel.pickButtonOnPressed(pickerValue);
            context.pop();
          },
        ),
      ),
    );
  }

  /// Picker special text
  Widget _pickerSpecialText(String text) => Padding(
        padding: const EdgeInsets.all(15),
        child: FittedBox(
          child: Text(
            text,
          ),
        ),
      );
}
