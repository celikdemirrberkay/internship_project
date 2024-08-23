import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piri_qiblah/piri_qiblah.dart';
import '../../../core/common/app_elevated_button.dart';
import 'package:lottie/lottie.dart';

part '../widget/stepper_for_qibla.dart';

///
class QiblahCompassView extends StatefulWidget {
  ///
  const QiblahCompassView({super.key});

  @override
  State<QiblahCompassView> createState() => _QiblahCompassViewState();
}

///
late Animation<double>? animation;
late AnimationController? _animationController;
double begin = 0;

class _QiblahCompassViewState extends State<QiblahCompassView> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(
      begin: 0.0,
      end: 0.0,
    ).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: _compassWidget()),
    );
  }

  Widget _compassWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.spacerWithFlex(flex: 15),
          Expanded(flex: 6, child: _findQiblahText()),
          context.spacerWithFlex(flex: 20),
          Expanded(flex: 58, child: _piriQiblaWidget()),
          context.spacerWithFlex(flex: 30),
          Expanded(flex: 10, child: _howToUseButton()),
          context.spacerWithFlex(flex: 5),
        ],
      ),
    );
  }

  Widget _findQiblahText() => FittedBox(
        child: Text(
          'Kıble yönünü bul',
          style: GoogleFonts.roboto(
            textStyle: context.textStyles.headlineMedium?.copyWith(
              color: context.themeData.colorScheme.onSecondary,
            ),
          ),
        ),
      );

  /// How to use button
  Widget _howToUseButton() {
    return FittedBox(
      child: AppElevatedButton(
        text: 'Nasıl kullanılır?',
        onPressed: _buildModalBottomSheet,
        color: context.themeData.colorScheme.onPrimary,
        textColor: context.themeData.colorScheme.primary,
      ),
    );
  }

  /// Build modal bottom sheet
  Future<void> _buildModalBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        width: context.screenSizes.width,
        height: context.screenSizes.dynamicHeight(0.8),
        child: const _StepperForQibla(),
      ),
    );
  }

  /// Qiblah SVG
  Widget _piriQiblaWidget() {
    return const FittedBox(
      child: PiriQiblah(),
    );
  }
}
