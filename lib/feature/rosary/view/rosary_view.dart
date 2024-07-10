import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/common/app_elevated_button.dart';
import 'package:internship_project/feature/rosary/view_model/rosary_view_model.dart';
import 'package:stacked/stacked.dart';

/// Rosary page
class RosaryView extends StatefulWidget {
  ///
  const RosaryView({super.key});

  @override
  State<RosaryView> createState() => _RosaryViewState();
}

class _RosaryViewState extends State<RosaryView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: RosaryViewModel.new,
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              children: [
                context.spacerWithFlex(flex: 3),
                Expanded(flex: 7, child: _svg()),
                context.spacerWithFlex(flex: 10),
                Expanded(flex: 10, child: _rosaryCountText(viewModel)),
                Expanded(flex: 7, child: _rosaryText(context)),
                context.spacerWithFlex(flex: 12),
                Expanded(flex: 15, child: _rosaryCountUpButton(viewModel)),
                context.spacerWithFlex(flex: 10),
                Expanded(flex: 5, child: _resetRosaryButton(viewModel)),
                context.spacerWithFlex(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Reset rosary button widget
  Widget _resetRosaryButton(RosaryViewModel viewModel) {
    return AppElevatedButton(
      onPressed: () => viewModel.resetRosaryCount(),
      text: 'Sıfırla',
      textColor: context.themeData.primaryColor,
    );
  }

  /// Rosary count up button widget
  Widget _rosaryCountUpButton(RosaryViewModel viewModel) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 1),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: context.themeData.primaryColor,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () => viewModel.increaseRosaryCount(),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 1),
      ],
    );
  }

  /// Rosary count text widget
  Widget _rosaryCountText(RosaryViewModel viewModel) => FittedBox(
        child: Text(
          viewModel.rosaryCount.toString(),
          style: GoogleFonts.poppins(
            fontWeight: context.fontWeights.fw600,
            color: context.themeData.primaryColor,
          ),
        ),
      );

  /// Rosary text widget
  Widget _rosaryText(BuildContext context) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 15),
        Expanded(
          flex: 70,
          child: FittedBox(
            child: Text(
              'Çekilen Tespih Sayısı ',
              style: GoogleFonts.poppins(
                fontWeight: context.fontWeights.fw500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 15),
      ],
    );
  }

  /// Rosary svg widget
  Widget _svg() {
    return SvgPicture.asset('assets/svg/rosary_red.svg');
  }
}
