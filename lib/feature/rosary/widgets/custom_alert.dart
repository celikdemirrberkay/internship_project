part of '../view/rosary_view.dart';

/// Custom alert dialog for add dhikr
class CustomAlertDialog extends StatefulWidget {
  ///
  const CustomAlertDialog({super.key});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Kendi zikrini ekle',
        style: GoogleFonts.roboto(
          color: context.themeData.colorScheme.primary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: null,
          child: Text(
            'Ekle',
            style: GoogleFonts.roboto(
              color: context.themeData.colorScheme.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: null,
          child: Text(
            'İptal',
            style: GoogleFonts.roboto(
              color: context.themeData.colorScheme.primary,
            ),
          ),
        ),
      ],
      content: AppTextfield(
        hintText: 'Dhikr',
      ),
    );
  }
}
