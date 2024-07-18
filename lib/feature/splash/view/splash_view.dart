import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/common/loading_widget.dart';
import 'package:internship_project/core/constants/app_constants.dart';
import 'package:internship_project/core/init/app_initializer.dart';
import 'package:internship_project/feature/splash/view_model/splash_view_model.dart';
import 'package:stacked/stacked.dart';

/// Splash View
class SplashView extends StatefulWidget {
  ///
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    /// Check if onboard is done
    final onboardSituation = await AppInitializer.isOnboardDone();

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 2));

    // Check if the widget is still mounted before navigating
    if (!mounted) return;

    /// If onboard is done, navigate to home
    onboardSituation
        ? context.pushReplacementNamed(
            'main',
          )
        : context.pushReplacementNamed(
            'onboard',
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            context.spacerWithFlex(flex: 15),
            Expanded(flex: 40, child: _splashSvg()),
            Expanded(flex: 10, child: _splashText()),
            context.spacerWithFlex(flex: 20),
            Expanded(flex: 6, child: _splashLoading()),
            context.spacerWithFlex(flex: 10),
          ],
        ),
      ),
    );
  }

  /// Splash loading widget
  Widget _splashLoading() => ViewModelBuilder.reactive(
        viewModelBuilder: SplashViewModel.new,
        builder: (context, viewModel, child) => Row(
          children: [
            context.spacerWithFlex(flex: 40),
            Expanded(
              flex: 20,
              child: FittedBox(
                child: LoadingWidget(
                  color: context.themeData.colorScheme.primary,
                ),
              ),
            ),
            context.spacerWithFlex(flex: 40),
          ],
        ),
      );

  /// Splash text
  Widget _splashText() => FittedBox(
        child: Text(
          AppConstants.appName,
          style: GoogleFonts.playfair(
            textStyle: context.appTextTheme.bodyLarge?.copyWith(
              color: context.themeData.colorScheme.secondary,
              fontWeight: context.fontWeights.fw300,
            ),
          ),
        ),
      );

  /// Splash svg
  Widget _splashSvg() => Row(
        children: [
          context.spacerWithFlex(flex: 15),
          Expanded(
            flex: 70,
            child: SvgPicture.asset(
              'assets/svg/splash.svg',
            ),
          ),
          context.spacerWithFlex(flex: 15),
        ],
      );
}
