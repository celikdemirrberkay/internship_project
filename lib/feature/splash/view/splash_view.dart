import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/common/loading_widget.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/app_constants.dart';
import 'package:internship_project/core/home_widgets/home_widget_manager.dart';
import 'package:internship_project/feature/splash/view_model/splash_view_model.dart';
import 'package:internship_project/service/local/hive/db_service.dart';

/// Splash View
class SplashView extends StatefulWidget {
  ///
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  ///
  late final SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel(locator());
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    /// Check if onboard is done
    final onboardSituation = await locator<LocalDatabaseService>().isOnboardDone();

    /// Request location permission
    await _viewModel.requestAndCheckPermissionForLocation();

    /// Set city and country name for prayer times request
    await _viewModel.setCityAndCountryName();

    /// Set notifications on opening if it is enabled
    await _viewModel.setNotificationsOnOpening();

    /// Update the home widget for Android
    await HomeWidgetManager.updateAndroidWidget();

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
  Widget _splashLoading() => Row(
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
