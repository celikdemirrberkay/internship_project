import 'package:dart_vader/dart_vader.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:internship_project/core/common/app_elevated_button.dart';
import 'package:internship_project/feature/rosary/view_model/rosary_view_model.dart';
import 'package:internship_project/repositories/local/shared_pref/db_service.dart';
import 'package:stacked/stacked.dart';

part '../widgets/chips.dart';

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
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: RosaryViewModel.new,
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              children: _columnChildren(viewModel),
            ),
          ),
        ),
      ),
    );
  }

  /// Rosary view column children
  List<Widget> _columnChildren(RosaryViewModel viewModel) => [
        context.spacerWithFlex(flex: 3),
        Expanded(flex: 7, child: _selectableChips(viewModel)),
        context.spacerWithFlex(flex: 10),
        Expanded(flex: 10, child: _rosaryCountText(viewModel)),
        Expanded(flex: 7, child: _rosaryText(context)),
        context.spacerWithFlex(flex: 12),
        Expanded(flex: 15, child: _rosaryCountUpButton(viewModel)),
        context.spacerWithFlex(flex: 10),
        Expanded(flex: 5, child: _resetRosaryButton(viewModel)),
        context.spacerWithFlex(flex: 3),
      ];

  /// Selectable chips widget
  Widget _selectableChips(RosaryViewModel viewModel) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 1),
        Expanded(flex: 5, child: _addDhikrIconButton(viewModel)),
        context.spacerWithFlex(flex: 1),
        Expanded(flex: 50, child: _dhikrListView(viewModel)),
        context.spacerWithFlex(flex: 1),
      ],
    );
  }

  /// Dhikr list view
  Widget _dhikrListView(RosaryViewModel viewModel) {
    return ValueListenableBuilder(
      valueListenable: viewModel.dhikrStringList,
      builder: (context, value, child) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.dhikrStringList.value.length,
        itemBuilder: (context, index) => FittedBox(
          child: AppChips(
            text: viewModel.dhikrStringList.value[index],
          ),
        ),
      ),
    );
  }

  /// Add dhikr icon button widget
  Widget _addDhikrIconButton(RosaryViewModel viewModel) {
    return FittedBox(
      child: InkWell(
        borderRadius: context.circularBorderRadius(radius: 100),
        child: Icon(
          Icons.add_outlined,
          color: Colors.black.withOpacity(0.7),
        ),
        onTap: () async {},
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.themeData.primaryColor,
                  context.themeData.primaryColor.withOpacity(0.7),
                ],
              ),
            ),
            child: InkWell(
              borderRadius: context.circularBorderRadius(radius: 100),
              onTap: () => viewModel.increaseRosaryCount(),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 1),
      ],
    );
  }

  /// Rosary count text widget
  Widget _rosaryCountText(RosaryViewModel viewModel) => ValueListenableBuilder(
        valueListenable: viewModel.rosaryCount,
        builder: (context, value, child) => FittedBox(
          child: Text(
            value.toString(),
            style: GoogleFonts.roboto(
              fontWeight: context.fontWeights.fw600,
              color: context.themeData.primaryColor,
            ),
          ),
        ),
      );

  /// Rosary text widget
  Widget _rosaryText(BuildContext context) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 20),
        Expanded(
          flex: 60,
          child: FittedBox(
            child: Text(
              'Çekilen Tespih Sayısı ',
              style: GoogleFonts.roboto(
                fontWeight: context.fontWeights.fw500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 20),
      ],
    );
  }
}
