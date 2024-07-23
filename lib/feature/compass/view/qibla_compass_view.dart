import 'dart:math';
import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/common/loading_widget.dart';

/// Qibla Compass View
/// This widget is used to show the Qibla's direction
class QiblaCompassView extends StatefulWidget {
  ///
  const QiblaCompassView({super.key});

  @override
  State<QiblaCompassView> createState() => _QiblaCompassViewState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblaCompassViewState extends State<QiblaCompassView> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: GoogleFonts.roboto(
                    color: context.themeData.colorScheme.primary,
                  ),
                ),
              );
            }

            final qiblahDirection = snapshot.data;
            animation = Tween(
              begin: begin,
              end: qiblahDirection!.qiblah * (pi / 180) * -1,
            ).animate(
              _animationController!,
            );
            begin = qiblahDirection.qiblah * (pi / 180) * -1;
            _animationController!.forward(from: 0);

            return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "${qiblahDirection.direction.toInt()}°",
                  style: GoogleFonts.roboto(
                    color: context.themeData.colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 300,
                    child: AnimatedBuilder(
                      animation: animation!,
                      builder: (context, child) => Transform.rotate(
                        angle: animation!.value,
                        child: SvgPicture.asset(
                          'assets/svg/needle.svg',
                        ),
                      ),
                    ))
              ]),
            );
          },
        ),
      ),
    );
  }
}
