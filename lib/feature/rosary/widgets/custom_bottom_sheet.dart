part of '../view/rosary_view.dart';

/// Custom alert dialog for add dhikr
class _CustomBottomSheet extends StatefulWidget {
  ///
  const _CustomBottomSheet({
    required this.dhikrInputController,
    this.onAddPressed,
  });

  /// Add pressed function
  final void Function()? onAddPressed;

  /// Dhikr input controller
  final TextEditingController dhikrInputController;

  @override
  State<_CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<_CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.focusScope.unfocus(),
      child: Container(
        decoration: _decorationOfBottomSheet(context),
        child: SizedBox(
          height: context.screenSizes.dynamicHeight(0.65),
          width: context.screenSizes.width,
          child: Column(children: _columnsChildren()),
        ),
      ),
    );
  }

  /// Add button of bottom sheet
  List<Widget> _columnsChildren() => [
        _closeContainer(),
        context.spacerWithFlex(flex: 6),
        Expanded(flex: 7, child: _title()),
        context.spacerWithFlex(flex: 3),
        Expanded(flex: 15, child: _textFieldOfBottomSheet()),
        context.spacerWithFlex(flex: 5),
        Expanded(flex: 8, child: _addButton()),
        context.spacerWithFlex(flex: 53),
      ];

  /// Close container of bottom sheet
  Widget _closeContainer() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 40),
        Expanded(
          flex: 20,
          child: Container(
            height: context.screenSizes.height * 0.007,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: context.circularBorderRadius(radius: 6),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 40),
      ],
    );
  }

  /// Add button of bottom sheet
  Widget _addButton() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 10),
        Expanded(
          flex: 80,
          child: SizedBox.expand(
            child: AppElevatedButton(
              text: 'Ekle',
              color: context.themeData.colorScheme.primary,
              onPressed: widget.onAddPressed,
              textColor: context.themeData.colorScheme.secondary,
            ),
          ),
        ),
        context.spacerWithFlex(flex: 10),
      ],
    );
  }

  /// Title of bottom sheet
  Widget _title() => Row(
        children: [
          context.spacerWithFlex(flex: 20),
          Expanded(
            flex: 60,
            child: FittedBox(
              child: Text(
                'Kendi zikrinizi ekleyiniz',
                style: GoogleFonts.roboto(
                  textStyle: context.appTextTheme.bodyLarge,
                  color: context.themeData.colorScheme.secondary,
                  fontWeight: context.fontWeights.fw300,
                ),
              ),
            ),
          ),
          context.spacerWithFlex(flex: 20),
        ],
      );

  /// Textfield of bottom sheet
  Widget _textFieldOfBottomSheet() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 90,
          child: AppTextfield(
            hintText: 'Zikir ekle',
            maxLength: 15,
            controller: widget.dhikrInputController,
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  /// Decoration of bottom sheet
  BoxDecoration _decorationOfBottomSheet(BuildContext context) {
    return BoxDecoration(
      borderRadius: context.circularBorderRadius(radius: 12),
    );
  }
}
