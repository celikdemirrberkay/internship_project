import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/common/app_horizontal_divider.dart';
import 'package:internship_project/core/common/exception_widget.dart';
import 'package:internship_project/core/common/loading_widget.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:internship_project/feature/prayer_times/view_model/prayer_times_viewmodel.dart';
import 'package:internship_project/repositories/model/times_response.dart';
import 'package:lottie/lottie.dart';
import 'package:one_clock/one_clock.dart';
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

  /// Prayer times and god names column
  Widget _column() {
    return Column(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(flex: 10, child: _lottie()),
        Expanded(flex: 45, child: _prayerTimesContainerBuilder()),
        context.spacerWithFlex(flex: 4),
        Expanded(flex: 25, child: _godNamesContainerBuilder()),
        context.spacerWithFlex(flex: 10),
      ],
    );
  }

  /// Lottie builder
  LottieBuilder _lottie() => LottieBuilder.asset('assets/lottie/prayer.json');

  /// God names container
  Widget _godNamesContainerBuilder() => ViewModelBuilder.reactive(
        viewModelBuilder: () => PrayerTimesViewmodel(locator(), locator(), context),
        builder: (context, viewModel, child) => viewModel.isGodNameLoading == true
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
    return Text(
      '"${viewModel.godNames.right[viewModel.randomInt].meaning}"',
      style: GoogleFonts.roboto(
        textStyle: context.appTextTheme.headlineSmall?.copyWith(
          color: context.themeData.colorScheme.primary,
          fontWeight: context.fontWeights.fw300,
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
            fontWeight: context.fontWeights.fw500,
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
      boxShadow: [
        BoxShadow(
          color: context.themeData.colorScheme.onSurface,
          blurRadius: 6,
        ),
      ],
    );
  }

  /// Prayer times container builder
  Widget _prayerTimesContainerBuilder() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PrayerTimesViewmodel(locator(), locator(), context),
      builder: (context, viewModel, child) => viewModel.isPrayerTimesLoading
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
            decoration: _prayerTimesContainerDecoration(),
            child: Column(
              children: [
                context.spacerWithFlex(flex: 2),
                Expanded(flex: 14, child: _dateTextOnCard()),
                Expanded(flex: 14, child: _pinAndLocationRow()),
                context.spacerWithFlex(flex: 2),
                const Expanded(flex: 4, child: HorizontalAppDivider()),
                Expanded(flex: 60, child: _allTimesColumn(viewModel.datas.right)),
                context.spacerWithFlex(flex: 4),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 1),
      ],
    );
  }

  /// Pin and location row
  Widget _pinAndLocationRow() => Row(
        children: [
          context.spacerWithFlex(flex: 5),
          Expanded(
            flex: 5,
            child: Icon(
              Icons.location_on_outlined,
              color: context.themeData.colorScheme.onPrimary,
            ),
          ),
          context.spacerWithFlex(flex: 5),
          Expanded(
            flex: 30,
            child: Text(
              'Istanbul',
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.bodyLarge?.copyWith(
                  color: context.themeData.colorScheme.onPrimary,
                  fontWeight: context.fontWeights.fw500,
                ),
              ),
            ),
          ),
          context.spacerWithFlex(flex: 65),
        ],
      );

  /// Date text on card
  Widget _dateTextOnCard() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(child: _timeIcon()),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: DigitalClock(
              isLive: true,
              format: 'HH:mm:ss',
              digitalClockTextColor: context.themeData.colorScheme.onPrimary,
            ),
          ),
        ),
        context.spacerWithFlex(flex: 65),
      ],
    );
  }

  /// Time icon
  Widget _timeIcon() {
    return Icon(
      Icons.access_time_outlined,
      color: context.themeData.colorScheme.onPrimary,
    );
  }

  /// All times list tiles on Times card
  Widget _allTimesColumn(PrayerApiData data) => Column(
        children: [
          context.spacerWithFlex(flex: 5),
          Expanded(flex: 30, child: _firstThreeTimesRow(data)),
          context.spacerWithFlex(flex: 15),
          Expanded(flex: 30, child: _lastThreeTimesRow(data)),
          context.spacerWithFlex(flex: 5),
        ],
      );

  /// First three times row like (Imsak, Sabah, Ogle)
  Widget _firstThreeTimesRow(PrayerApiData data) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              'İmsak\n${data.timings?.fajr}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              'Sabah\n${data.timings?.sunrise}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              'Öğle\n${data.timings?.dhuhr}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  /// Last three times row like (Ikindi, Aksam, Yatsi)
  Widget _lastThreeTimesRow(PrayerApiData data) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              'İkindi\n${data.timings?.asr}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              'Akşam\n${data.timings?.maghrib}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTextColumn(
              'Yatsi\n${data.timings?.isha}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  /// All times text column special text
  Widget _specialTextForAllTimesTextColumn(String text) => Text(
        text,
        textAlign: context.textAlignCenter,
        style: GoogleFonts.roboto(
          textStyle: context.appTextTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.onPrimary,
            fontWeight: context.fontWeights.fw500,
          ),
        ),
      );

  /// Box decoration
  BoxDecoration _prayerTimesContainerDecoration() => BoxDecoration(
        color: AppTheme.prayerContainerColor,
        borderRadius: context.circularBorderRadius(radius: 12),
      );
}
