import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:internship_project/core/common/exception_widget.dart';
import 'package:internship_project/core/common/loading_widget.dart';
import 'package:internship_project/core/exception/exception_message.dart';

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
double begin = 0.0;

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
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        body: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return ExceptionWidget(message: ExceptionMessage.errorOccured.message);
              case ConnectionState.waiting:
                return const Center(child: LoadingWidget());
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return ExceptionWidget(
                    message: ExceptionMessage.errorOccured.message,
                  );
                } else {
                  final qiblahDirection = snapshot.data;
                  animation = Tween(
                    begin: begin,
                    end: qiblahDirection!.qiblah * (pi / 180) * -1,
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
          SizedBox(
            height: 300,
            child: AnimatedBuilder(
              animation: animation!,
              builder: (context, child) => Transform.rotate(
                angle: animation!.value,
                child: Image.asset(
                  'assets/images/qibla.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
