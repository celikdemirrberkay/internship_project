import 'dart:math';
import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common/app_elevated_button.dart';
import '../../../core/common/exception_widget.dart';
import '../../../core/common/loading_widget.dart';
import '../../../core/exception/exception_message.dart';
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
      child: Scaffold(
        body: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return ExceptionWidget(
                  message: ExceptionStrings.errorOccured.message,
                );
              case ConnectionState.waiting:
                return const Center(child: LoadingWidget());
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError || snapshot.data == null) {
                  return ExceptionWidget(
                    message: ExceptionStrings.errorOccured.message,
                  );
                } else {
                  final qiblahDirection = snapshot.data;
                  animation = Tween(
                    begin: begin,
                    end: (qiblahDirection!.qiblah) * (pi / 180) * -1,
                  ).animate(_animationController!);
                  begin = qiblahDirection.qiblah * (pi / 180) * -1;
                  _animationController!.forward(from: 0);

                  return _compassWidget(qiblahDirection);
                }
            }
          },
        ),
      ),
    );
  }

  Widget _compassWidget(QiblahDirection qiblahDirection) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.spacerWithFlex(flex: 15),
          Expanded(flex: 6, child: _findQiblahText()),
          context.spacerWithFlex(flex: 15),
          Expanded(flex: 8, child: _qiblahDirectionText(qiblahDirection)),
          context.spacerWithFlex(flex: 5),
          Expanded(flex: 50, child: _qiblahSvg()),
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
  Widget _qiblahSvg() {
    return SizedBox(
      child: AnimatedBuilder(
        animation: animation!,
        builder: (context, child) => Transform.rotate(
          angle: animation!.value + 57.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/svg/qiblah_compass.svg'),
            ],
          ),
        ),
      ),
    );
  }

  /// Qiblah direction text
  Widget _qiblahDirectionText(QiblahDirection qiblahDirection) {
    return FittedBox(
      child: Text(
        '${qiblahDirection.direction.toInt() - 180}°',
        style: TextStyle(
          color: qiblahDirection.direction.toInt() - 180 == 0 ? context.themeData.colorScheme.primary : context.themeData.colorScheme.error,
        ),
      ),
    );
  }
}
