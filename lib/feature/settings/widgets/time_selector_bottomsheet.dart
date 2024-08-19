part of '../view/settings_view.dart';

/// Time selector bottomsheet
class _TimeSelectorBottomsheet extends StatefulWidget {
  const _TimeSelectorBottomsheet();

  @override
  State<_TimeSelectorBottomsheet> createState() => _TimeSelectorBottomsheetState();
}

class _TimeSelectorBottomsheetState extends State<_TimeSelectorBottomsheet> {
  int pickerValue = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenSizes.dynamicHeight(0.5),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: context.screenSizes.dynamicWidth(0.2),
            height: 7,
            decoration: BoxDecoration(
              color: context.themeData.colorScheme.onSurface,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            flex: 50,
            child: CupertinoPicker(
              itemExtent: context.screenSizes.dynamicHeight(0.06),
              scrollController: FixedExtentScrollController(),
              onSelectedItemChanged: (value) => pickerValue = value,
              children: [
                _pickerSpecialText('Her Namaz Vaktinden 5 Dakika Önce'),
                _pickerSpecialText('Her Namaz Vaktinden 10 Dakika Önce'),
                _pickerSpecialText('Her Namaz Vaktinden 15 Dakika Önce'),
                _pickerSpecialText('Her Namaz Vaktinden Önce Bildirim Gönderme'),
              ],
            ),
          ),
          Expanded(flex: 20, child: _pickerSetButton(context)),
          context.spacerWithFlex(flex: 40),
        ],
      ),
    );
  }

  /// Picker set button
  Widget _pickerSetButton(BuildContext context) {
    return FittedBox(
      child: TextButton(
        onPressed: () {},
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
