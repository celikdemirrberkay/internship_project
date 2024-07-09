import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/feature/prayer_times/view_model/prayer_times_viewmodel.dart';
import 'package:internship_project/repositories/model/response.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

///
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
      viewModelBuilder: () => PrayerTimesViewmodel(locator()),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: viewModel.isBusy
                ? _loadingWidget()
                : viewModel.datas.isRight
                    ? _column(viewModel.datas.right)
                    : _errorWidget(viewModel.datas.left),
          ),
        ),
      ),
    );
  }

  Widget _errorWidget(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  /// Times card widget for pray times
  Widget _column(ApiData data) {
    return Column(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(flex: 10, child: LottieBuilder.asset('assets/lottie/prayer.json')),
        Expanded(flex: 45, child: _prayerTimesContainer(data)),
        context.spacerWithFlex(flex: 40),
      ],
    );
  }

  /// Prayer times container
  Widget _prayerTimesContainer(ApiData data) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 1),
        Expanded(
          flex: 30,
          child: Container(
            decoration: _boxDecoration(),
            child: Column(
              children: [
                context.spacerWithFlex(flex: 2),
                Expanded(flex: 15, child: _dateTextOnCard(data)),
                Expanded(flex: 3, child: _divider()),
                Expanded(flex: 60, child: _allTimesListTiles(data)),
                context.spacerWithFlex(flex: 5),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 1),
      ],
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

  Widget _allTimesListTiles(ApiData data) => Row(
        children: [
          context.spacerWithFlex(flex: 2),
          Expanded(flex: 5, child: _allTimesTextColumn()),
          context.spacerWithFlex(flex: 10),
          Expanded(flex: 5, child: _allTimesTimeColumn(data)),
          context.spacerWithFlex(flex: 2),
        ],
      );

  /// All times text column special text
  Text _specialTextForAllTimesTextColumn(String text) => Text(
        text,
        style: GoogleFonts.dancingScript(
          textStyle: context.appTextTheme.displayLarge?.copyWith(
            color: context.themeData.colorScheme.onPrimary,
            fontWeight: context.fontWeights.fwBold,
          ),
        ),
      );

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
