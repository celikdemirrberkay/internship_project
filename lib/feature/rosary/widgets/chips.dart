part of '../view/rosary_view.dart';

/// Chip widget for rosary view
@immutable
final class _AppChips extends StatefulWidget {
  ///
  const _AppChips({
    required this.text,
    this.onLongPress,
  });

  /// Chip text
  final String text;

  /// Long press function
  final void Function()? onLongPress;

  @override
  State<_AppChips> createState() => _AppChipsState();
}

class _AppChipsState extends State<_AppChips> {
  /// Chip selected
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: ChoiceChip(
          shadowColor: Colors.black,
          showCheckmark: false,
          side: BorderSide(
            color: selected ? Colors.green : Colors.black.withOpacity(0.3),
          ),
          color: WidgetStatePropertyAll(context.themeData.colorScheme.onPrimary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: selected ? 0 : 2,
          labelStyle: GoogleFonts.roboto(
            color: selected ? Colors.green : Colors.black,
            fontWeight: context.fontWeights.fw500,
          ),
          selectedColor: context.themeData.colorScheme.primary,
          label: FittedBox(child: Text(widget.text, maxLines: 1)),
          selected: selected,
          onSelected: (value) => setState(() => selected = value),
        ),
      ),
    );
  }
}
