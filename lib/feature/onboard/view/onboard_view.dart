import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

/// Onboard view
class OnboardView extends StatefulWidget {
  ///
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 9, child: _pageViewBuilder()),
          Expanded(child: _bottomBar()),
        ],
      ),
    );
  }

  ///
  Widget _bottomBar() => Container(
        color: context.themeData.colorScheme.primary,
      );

  /// Page view builder
  Widget _pageViewBuilder() {
    return PageView(
      children: [
        _onboardContainer(
          lottiePath: 'assets/lottie/onboard1.json',
          text: 'Namaz vakitlerini takip et, her girişte rastgele ayet ve esmaül hüsna oku !',
        ),
        _onboardContainer(
          lottiePath: 'assets/lottie/onboard2.json',
          text: 'Günlük zikirlerini çek ve zikirlerini kaydet !',
        ),
        _onboardContainer(
          lottiePath: 'assets/lottie/onboard3.json',
          text: 'Kıble yönünü öğren ve namaz kılarken doğru yöne dön !',
        ),
      ],
    );
  }

  /// Onboard specific container
  Widget _onboardContainer({required String lottiePath, required String text}) {
    return SizedBox.expand(
      child: Column(
        children: [
          Expanded(flex: 70, child: LottieBuilder.asset(lottiePath)),
          Expanded(flex: 20, child: _onboardText(text)),
          context.spacerWithFlex(flex: 10),
        ],
      ),
    );
  }

  /// Onboard text
  Widget _onboardText(String text) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Text(
            text,
            textAlign: context.textAlignCenter,
            style: GoogleFonts.roboto(
              textStyle: context.appTextTheme.headlineSmall,
              color: context.themeData.colorScheme.secondary,
              fontWeight: context.fontWeights.fw300,
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }
}
