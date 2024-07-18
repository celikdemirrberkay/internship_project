import 'dart:async';

import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/feature/onboard/view_model/onboard_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

/// Onboard view
class OnboardView extends StatefulWidget {
  ///
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  /// Page controller
  final PageController _controller = PageController();

  /// Page index
  final ValueNotifier<double> _pageIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _pageIndex.value = _controller.page?.roundToDouble() ?? 0;
    });
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

  ///
  Widget _bottomBar() => ValueListenableBuilder(
        valueListenable: _pageIndex,
        builder: (context, value, child) => SizedBox.expand(
          child: ColoredBox(
            color: _pageIndex.value == 0
                ? const Color(0xFF723d5e)
                : _pageIndex.value == 1
                    ? const Color(0xFF05aebd)
                    : const Color(0xFF282828),
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
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => OnboardViewModel(locator()),
      builder: (context, viewModel, child) => ValueListenableBuilder(
        valueListenable: _pageIndex,
        builder: (context, value, child) => IconButton(
          icon: _pageIndex.value == 2 ? _startButton() : const Icon(Icons.arrow_forward_ios),
          color: context.themeData.colorScheme.onPrimary,
          onPressed: () async {
            await _forwardButtonOnPressed(viewModel);
          },
        ),
      ),
    );
  }

  /// Forward button onPressed
  Future<void> _forwardButtonOnPressed(OnboardViewModel viewModel) async {
    if (_pageIndex.value == 2) {
      await viewModel.setOnboardDone();
      if (!mounted) return;
      context.pushReplacementNamed('main');
    } else {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _startButton() => FittedBox(
        child: Text(
          'Başla',
          style: GoogleFonts.roboto(
            textStyle: context.appTextTheme.headlineMedium,
            color: context.themeData.colorScheme.onPrimary,
            fontWeight: context.fontWeights.fw500,
          ),
        ),
      );

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
