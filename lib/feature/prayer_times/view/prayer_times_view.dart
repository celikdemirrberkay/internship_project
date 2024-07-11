import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/common/app_horizontal_divider.dart';
import 'package:internship_project/core/common/exception_widget.dart';
import 'package:internship_project/core/common/loading_widget.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/feature/prayer_times/view_model/prayer_times_viewmodel.dart';
import 'package:internship_project/repositories/model/times_response.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

/// Prayer Times View
class PrayerTimesView extends StatefulWidget {
  ///
  const PrayerTimesView({super.key});

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: _column(),
        ),
      ),
    );
  }

  /// Times card widget for pray times
  Widget _column() {
    return Column(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(flex: 10, child: _lottie()),
        Expanded(flex: 45, child: _prayerTimesContainerBuilder()),
        context.spacerWithFlex(flex: 3),
        Expanded(flex: 35, child: _godNamesContainerBuilder()),
        context.spacerWithFlex(flex: 4),
      ],
    );
  }

  /// Lottie builder
  LottieBuilder _lottie() => LottieBuilder.asset('assets/lottie/prayer.json');

  /// God names container
  Widget _godNamesContainerBuilder() => ViewModelBuilder.reactive(
        viewModelBuilder: () => PrayerTimesViewmodel(locator(), locator(), context),
        builder: (context, viewModel, child) => viewModel.isGodNameLoaded == true
            ? const LoadingWidget()
            : viewModel.godNames.isRight
                ? _godNamesAndMeaningContainer(context, viewModel)
                : ExceptionWidget(message: ExceptionMessage.errorOccured.message),
      );

  /// God name and meaning container (with box decoration etc..)
  Widget _godNamesAndMeaningContainer(BuildContext context, PrayerTimesViewmodel viewModel) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 90,
          child: Container(
            decoration: _boxDecorationForGodNamesContainer(),
            child: SizedBox.expand(
              child: Column(
                children: [
                  context.spacerWithFlex(flex: 10),
                  Expanded(flex: 20, child: _godNameTextWidget(viewModel, context)),
                  Expanded(flex: 10, child: _godNameMeaningTextWidget(viewModel, context)),
                  context.spacerWithFlex(flex: 10),
                ],
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  /// God name meaning text widget
  Widget _godNameMeaningTextWidget(PrayerTimesViewmodel viewModel, BuildContext context) {
    return FittedBox(
      child: Text(
        '"${viewModel.godNames.right[viewModel.randomInt].meaning}"',
        style: GoogleFonts.cookie(
          textStyle: context.appTextTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.primary,
            fontWeight: context.fontWeights.fw100,
          ),
        ),
      ),
    );
  }

  /// God name text widget
  Widget _godNameTextWidget(PrayerTimesViewmodel viewModel, BuildContext context) {
    return FittedBox(
      child: Text(
        viewModel.godNames.right[viewModel.randomInt].name,
        style: GoogleFonts.cookie(
          textStyle: context.appTextTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.secondary,
            fontWeight: context.fontWeights.fwBold,
          ),
        ),
      ),
    );
  }

  /// Box decoration for god names container
  BoxDecoration _boxDecorationForGodNamesContainer() {
    return BoxDecoration(
      color: context.themeData.colorScheme.onPrimary,
      borderRadius: context.circularBorderRadius(radius: 12),
      border: Border.all(color: context.themeData.primaryColor),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 1), //(x,y)
          blurRadius: 6,
        ),
      ],
    );
  }

  /// Prayer times container builder
  Widget _prayerTimesContainerBuilder() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PrayerTimesViewmodel(locator(), locator(), context),
      builder: (context, viewModel, child) => viewModel.isPrayerTimesLoaded
          ? const LoadingWidget()
          : viewModel.datas.isRight
              ? _prayerTimesContainer(context, viewModel)
              : ExceptionWidget(message: ExceptionMessage.errorOccured.message),
    );
  }

  /// God name container
  Widget _prayerTimesContainer(BuildContext context, PrayerTimesViewmodel viewModel) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 1),
        Expanded(
          flex: 30,
          child: Container(
            decoration: _godNameContainerBoxDecoration(),
            child: Column(
              children: [
                context.spacerWithFlex(flex: 2),
                Expanded(flex: 14, child: _dateTextOnCard(viewModel.datas.right)),
                const Expanded(flex: 4, child: HorizontalAppDivider()),
                Expanded(flex: 60, child: _allTimesListTilesOnCard(viewModel.datas.right)),
                context.spacerWithFlex(flex: 4),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 1),
      ],
    );
  }

  /// Date text on card
  Widget _dateTextOnCard(ApiData data) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 45,
          child: FittedBox(
            child: Text(
              data.date?.readable ?? '',
              style: GoogleFonts.cookie(
                textStyle: context.textStyles.bodyLarge?.copyWith(
                  color: context.themeData.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 50),
      ],
    );
  }

  /// All times list tiles on Times card
  Widget _allTimesListTilesOnCard(ApiData data) => Row(
        children: [
          context.spacerWithFlex(flex: 2),
          Expanded(flex: 5, child: _allTimesTextColumn()),
          context.spacerWithFlex(flex: 10),
          Expanded(flex: 5, child: _allTimesTimeColumn(data)),
          context.spacerWithFlex(flex: 2),
        ],
      );

  /// All times text column special text
  Widget _specialTextForAllTimesTextColumn(String text) => Text(
        text,
        style: GoogleFonts.dancingScript(
          textStyle: context.appTextTheme.displayLarge?.copyWith(
            color: context.themeData.colorScheme.onPrimary,
            fontWeight: context.fontWeights.fwBold,
          ),
        ),
      );

  /// All times text column like (Imsak, Sabah, Ogle, Ikindi, Aksam, Yatsi)
  Widget _allTimesTextColumn() {
    return Column(
      children: [
        Expanded(
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              _PrayTimesEnum.Imsak.name,
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              _PrayTimesEnum.Sabah.name,
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              _PrayTimesEnum.Ogle.name,
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              _PrayTimesEnum.Ikindi.name,
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              _PrayTimesEnum.Aksam.name,
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              _PrayTimesEnum.Yatsi.name,
            ),
          ),
        ),
      ],
    );
  }

  /// All times time column like (Imsak, Sabah, Ogle, Ikindi, Aksam, Yatsi)
  Widget _allTimesTimeColumn(ApiData data) => Column(
        children: [
          Expanded(
            child: FittedBox(
              child: Text(
                data.timings?.fajr ?? '',
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Text(
                data.timings?.sunrise ?? '',
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Text(
                data.timings?.dhuhr ?? '',
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Text(
                data.timings?.asr ?? '',
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Text(
                data.timings?.maghrib ?? '',
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Text(
                data.timings?.isha ?? '',
              ),
            ),
          ),
        ],
      );

  /// Box decoration
  BoxDecoration _godNameContainerBoxDecoration() => BoxDecoration(
        color: context.themeData.primaryColor,
        borderRadius: context.circularBorderRadius(
          radius: 12,
        ),
      );
}

/// Prayer times names enum
enum _PrayTimesEnum {
  Imsak,
  Sabah,
  Ogle,
  Ikindi,
  Aksam,
  Yatsi,
}
