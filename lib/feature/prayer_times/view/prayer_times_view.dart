import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PrayerTimesViewmodel(
        locator(),
        locator(),
        context,
      ),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: _column(),
          ),
        ),
      ),
    );
  }

  /// Error widget
  Widget _errorWidget(String error) {
    return Center(
      child: Text(
        error,
        style: TextStyle(color: context.themeData.colorScheme.error),
      ),
    );
  }

  /// Times card widget for pray times
  Widget _column() {
    return Column(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(flex: 10, child: _lottie()),
        Expanded(flex: 45, child: _prayerTimesContainer()),
        context.spacerWithFlex(flex: 3),
        Expanded(flex: 35, child: _godNamesContainer()),
        context.spacerWithFlex(flex: 4),
      ],
    );
  }

  /// Lottie builder
  LottieBuilder _lottie() => LottieBuilder.asset('assets/lottie/prayer.json');

  /// God names container
  Widget _godNamesContainer() => ViewModelBuilder.reactive(
        viewModelBuilder: () => PrayerTimesViewmodel(locator(), locator(), context),
        builder: (context, viewModel, child) => viewModel.isBusy
            ? _loadingWidget()
            : viewModel.godNames.isRight
                ? Row(
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
                  )
                : _errorWidget(ExceptionMessage.errorOccured.message),
      );

  FittedBox _godNameMeaningTextWidget(PrayerTimesViewmodel viewModel, BuildContext context) {
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

  FittedBox _godNameTextWidget(PrayerTimesViewmodel viewModel, BuildContext context) {
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

  /// Prayer times container
  Widget _prayerTimesContainer() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PrayerTimesViewmodel(locator(), locator(), context),
      builder: (context, viewModel, child) => viewModel.isPrayerTimesLoaded
          ? _loadingWidget()
          : viewModel.datas.isRight
              ? Row(
                  children: [
                    context.spacerWithFlex(flex: 1),
                    Expanded(
                      flex: 30,
                      child: Container(
                        decoration: _boxDecoration(),
                        child: Column(
                          children: [
                            context.spacerWithFlex(flex: 2),
                            Expanded(flex: 15, child: _dateTextOnCard(viewModel.datas.right)),
                            Expanded(flex: 3, child: _divider()),
                            Expanded(flex: 60, child: _allTimesListTilesOnCard(viewModel.datas.right)),
                            context.spacerWithFlex(flex: 5),
                          ],
                        ),
                      ),
                    ),
                    context.spacerWithFlex(flex: 1),
                  ],
                )
              : _errorWidget(ExceptionMessage.errorOccured.message),
    );
  }

  /// Divider widget
  Widget _divider() => const Divider();

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

  /// Loading widget
  Widget _loadingWidget() => const Center(child: CircularProgressIndicator());

  /// Box decoration
  BoxDecoration _boxDecoration() => BoxDecoration(
        color: context.themeData.primaryColor,
        borderRadius: context.circularBorderRadius(
          radius: 12,
        ),
      );

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
