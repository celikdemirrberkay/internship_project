part of '../view/rosary_view.dart';

/// Chip widget for rosary view
@immutable
final class AppChips extends StatefulWidget {
  ///
  AppChips({
    required this.text,
    super.key,
  });

  /// Chip text
  final String text;

  /// Chip selected
  bool selected = false;

  @override
  State<AppChips> createState() => _AppChipsState();
}

class _AppChipsState extends State<AppChips> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ChoiceChip(
        shadowColor: Colors.black,
        showCheckmark: false,
        side: BorderSide(
          color: widget.selected ? Colors.green : Colors.black.withOpacity(0.3),
        ),
        color: WidgetStatePropertyAll(context.themeData.colorScheme.onPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: widget.selected ? 0 : 2,
        labelStyle: GoogleFonts.roboto(
          color: widget.selected ? Colors.green : Colors.black,
          fontWeight: context.fontWeights.fw500,
        ),
        selectedColor: context.themeData.colorScheme.primary,
        label: FittedBox(
          child: Text(
            widget.text,
            maxLines: 1,
          ),
        ),
        selected: widget.selected,
        onSelected: (value) {
          setState(() {
            widget.selected = value;
          });
        },
      ),
    );
  }
}
