import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Onboard view
class OnboardView extends StatefulWidget {
  ///
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  late PageController _controller;
  ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 88, child: _pageViewBuilder()),
          Expanded(flex: 12, child: _bottomBar()),
        ],
      ),
    );
  }

  ///
  Widget _bottomBar() => ValueListenableBuilder(
        valueListenable: _pageIndex,
        builder: (context, value, child) => SizedBox.expand(
          child: ColoredBox(
            color: value == 0
                ? Colors.purple.shade900
                : value == 1
                    ? Colors.cyan.shade500
                    : context.themeData.colorScheme.onSecondary,
            child: SizedBox.expand(
              child: Row(
                children: [
                  Expanded(child: _backButton()),
                  Expanded(child: _smoothPageIndicator()),
                  Expanded(child: _forwardButton()),
                ],
              ),
            ),
          ),
        ),
      );

  /// Page view builder
  Widget _pageViewBuilder() {
    return PageView(
      controller: _controller,
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

  Center _smoothPageIndicator() {
    return Center(
      child: SmoothPageIndicator(
        controller: _controller,
        count: 3,
        effect: WormEffect(
          activeDotColor: context.themeData.colorScheme.onPrimary,
          dotColor: context.themeData.colorScheme.onSurface,
        ),
      ),
    );
  }

  /// Forward button
  Widget _forwardButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_forward_ios),
      color: context.themeData.colorScheme.onPrimary,
      onPressed: () {
        if (_controller.page == 2) {
        } else {
          _controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  /// Back button
  Widget _backButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      color: context.themeData.colorScheme.onPrimary,
      onPressed: () {
        if (_controller.page == 0) {
        } else {
          _controller.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }
}
