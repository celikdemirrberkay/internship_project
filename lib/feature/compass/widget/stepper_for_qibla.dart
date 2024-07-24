part of '../view/qibla_compass_view.dart';

/// Stepper widget for qibla compass
@immutable
final class _StepperForQibla extends StatefulWidget {
  ///
  const _StepperForQibla();

  @override
  State<_StepperForQibla> createState() => _StepperForQiblaState();
}

class _StepperForQiblaState extends State<_StepperForQibla> {
  /// Current step of stepper
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      steps: [
        Step(
          isActive: _currentStep == 0,
          title: _label('Hareket Ettir'),
          content: _content(
            text: 'Telefonu dikey konumda tutarak doğru yönü bulana kadar hareket ettirin .',
            lottiePath: 'assets/lottie/rotate_phone.json',
          ),
        ),
        Step(
          isActive: _currentStep == 1,
          title: _label('Hizala'),
          content: _content(
            lottiePath: 'assets/lottie/rotate_done.json',
            text: 'Yeşil 0° ekranda gözüktüğünde telefonu sabit tutun .',
          ),
        ),
        Step(
          isActive: _currentStep == 2,
          title: _label('Tamamla'),
          content: _content(
            lottiePath: 'assets/lottie/stepper_done.json',
            text: 'Beliren yöne göre seccadenizi serebilirsiniz !',
            lottieRepeat: false,
          ),
        ),
      ],
      controlsBuilder: (context, details) => const SizedBox(),
      onStepTapped: (value) => setState(() => _currentStep = value),
    );
  }

  /// Content of stepper
  Widget _content({
    required String lottiePath,
    required String text,
    bool? lottieRepeat,
  }) =>
      SizedBox(
        child: Column(
          children: [
            Lottie.asset(lottiePath, repeat: lottieRepeat),
            Text(
              text,
              textAlign: context.textAlignCenter,
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.bodyMedium?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                  fontWeight: context.fontWeights.fw300,
                ),
              ),
            ),
          ],
        ),
      );

  /// Label of stepper
  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.roboto(
          textStyle: context.appTextTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.onSecondary,
            fontWeight: context.fontWeights.fwBold,
          ),
        ),
      );
}
