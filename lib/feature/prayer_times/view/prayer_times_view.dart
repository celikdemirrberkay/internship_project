import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/common/app_horizontal_divider.dart';
import 'package:internship_project/core/common/exception_widget.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/exception/exception_util.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:internship_project/feature/prayer_times/view_model/prayer_times_viewmodel.dart';
import 'package:internship_project/model/ayah.dart';
import 'package:internship_project/model/times_response.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:lottie/lottie.dart';
import 'package:one_clock/one_clock.dart';
import 'package:shimmer/shimmer.dart';
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
        context.spacerWithFlex(flex: 2),
        Expanded(flex: 10, child: _lottie()),
        Expanded(flex: 40, child: _prayerTimesContainerBuilder()),
        context.spacerWithFlex(flex: 2),
        Expanded(flex: 40, child: _godNamesContainerBuilder()),
        context.spacerWithFlex(flex: 2),
        Expanded(flex: 40, child: _ayahContainerBuilder()),
        context.spacerWithFlex(flex: 4),
      ],
    );
  }

  /// Lottie builder
  LottieBuilder _lottie() => LottieBuilder.asset(
        'assets/lottie/prayer.json',
      );

  /// God names container
  Widget _godNamesContainerBuilder() => ViewModelBuilder.reactive(
        viewModelBuilder: () => PrayerTimesViewmodel(
          locator(),
          locator(),
          locator(),
          context,
        ),
        builder: (context, viewModel, child) => switch (viewModel.godNames) {
          SuccessState() => _godNamesAndMeaningContainer(viewModel),
          ErrorState() => _errorWidget(ExceptionUtil.getExceptionMessage(viewModel.godNames.exceptionType!)),
          LoadingState() => _shimmerLoadingContainer(),
        },
      );

  /// God name and meaning container (with box decoration etc..)
  Widget _godNamesAndMeaningContainer(PrayerTimesViewmodel viewModel) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            decoration: _boxDecorationForGodNamesContainer(),
            child: SizedBox.expand(
              child: Column(
                children: [
                  context.spacerWithFlex(flex: 20),
                  Expanded(flex: 40, child: _godNameTextWidget(viewModel)),
                  context.spacerWithFlex(flex: 5),
                  Expanded(flex: 40, child: _godNameMeaningTextWidget(viewModel)),
                  context.spacerWithFlex(flex: 5),
                ],
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// God name meaning text widget
  Widget _godNameMeaningTextWidget(PrayerTimesViewmodel viewModel) {
    return SingleChildScrollView(
      child: Text(
        '"${viewModel.godNames.data!.meaning}"',
        textAlign: context.textAlignCenter,
        overflow: TextOverflow.fade,
        style: GoogleFonts.roboto(
          textStyle: context.appTextTheme.headlineSmall?.copyWith(
            color: context.themeData.colorScheme.onSecondary,
            fontWeight: context.fontWeights.fw400,
          ),
        ),
      ),
    );
  }

  /// God name text widget
  Widget _godNameTextWidget(PrayerTimesViewmodel viewModel) {
    return FittedBox(
      child: Text(
        viewModel.godNames.data!.name,
        textAlign: context.textAlignCenter,
        style: GoogleFonts.cookie(
          textStyle: context.appTextTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.secondary,
            fontWeight: context.fontWeights.fw500,
          ),
        ),
      ),
    );
  }

  /// Prayer times container builder
  Widget _prayerTimesContainerBuilder() {
    return ValueListenableBuilder(
      valueListenable: LocationService.cityName,
      builder: (context, cityName, child) => ViewModelBuilder.reactive(
        viewModelBuilder: () => PrayerTimesViewmodel(
          locator(),
          locator(),
          locator(),
          context,
        ),
        disposeViewModel: false,
        builder: (context, viewModel, child) => switch (viewModel.prayerTimesData) {
          SuccessState() => _prayerTimesContainer(viewModel.prayerTimesData.data!),
          ErrorState() => _errorWidget(ExceptionUtil.getExceptionMessage(viewModel.prayerTimesData.exceptionType!)),
          LoadingState() => _shimmerLoadingContainer(),
        },
        onViewModelReady: (viewModel) async {
          await viewModel.getPrayerTimes(
            city: cityName,
            country: 'turkey',
          );
        },
      ),
    );
  }

  /// God name container
  Widget _prayerTimesContainer(PrayerApiData data) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            decoration: _prayerTimesContainerDecoration(),
            child: Column(
              children: [
                context.spacerWithFlex(flex: 2),
                Expanded(flex: 14, child: _dateTextOnCard()),
                Expanded(flex: 14, child: _pinAndLocationRow()),
                context.spacerWithFlex(flex: 2),
                const Expanded(flex: 4, child: HorizontalAppDivider()),
                Expanded(flex: 60, child: _allTimesColumn(data)),
                context.spacerWithFlex(flex: 4),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// Prayer times container builder
  Widget _ayahContainerBuilder() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PrayerTimesViewmodel(
        locator(),
        locator(),
        locator(),
        context,
      ),
      builder: (context, viewModel, child) => switch (viewModel.ayah) {
        SuccessState() => _ayahTimesContainer(viewModel.ayah.data!),
        ErrorState() => _errorWidget(ExceptionUtil.getExceptionMessage(viewModel.ayah.exceptionType!)),
        LoadingState() => _shimmerLoadingContainer(),
      },
    );
  }

  Widget _errorWidget(String message) {
    return ExceptionWidget(
      message: message,
    );
  }

  /// God name container
  Widget _ayahTimesContainer(Ayah data) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            decoration: _ayahContainerDecoration(),
            child: Column(
              children: [
                context.spacerWithFlex(flex: 10),
                Expanded(flex: 20, child: _randomOneAyahText()),
                const HorizontalAppDivider(),
                Expanded(flex: 78, child: _ayahText(data)),
                context.spacerWithFlex(flex: 2),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// Ayah text widget
  Widget _ayahText(Ayah data) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 90,
          child: SingleChildScrollView(
            child: Text(
              data.text,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.headlineSmall?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                  fontWeight: context.fontWeights.fw300,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  /// One Ayah text
  Widget _randomOneAyahText() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 55,
          child: FittedBox(
            child: Text(
              'Rastgele Bir Ayet',
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.headlineSmall?.copyWith(
                  color: context.themeData.colorScheme.onSecondary,
                  fontWeight: context.fontWeights.fwBold,
                ),
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 45),
        Expanded(flex: 30, child: _ayahSvg()),
      ],
    );
  }

  SvgPicture _ayahSvg() => SvgPicture.asset(
        'assets/svg/ayah.svg',
        color: context.themeData.colorScheme.onSecondary,
      );

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
              LocationService.cityName.value,
              style: GoogleFonts.roboto(
                textStyle: context.appTextTheme.bodyLarge?.copyWith(
                  color: context.themeData.colorScheme.onPrimary,
                  fontWeight: context.fontWeights.fw500,
                ),
              ),
            ),
          ),
          context.spacerWithFlex(flex: 40),
          Expanded(flex: 20, child: SvgPicture.asset('assets/svg/mosque.svg')),
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
            child: _specialTextForAllTimesTexts(
              'İmsak\n${data.timings?.fajr}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTexts(
              'Sabah\n${data.timings?.sunrise}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTexts(
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
            child: _specialTextForAllTimesTexts(
              'İkindi\n${data.timings?.asr}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTexts(
              'Akşam\n${data.timings?.maghrib}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 30,
          child: FittedBox(
            child: _specialTextForAllTimesTexts(
              'Yatsı\n${data.timings?.isha}',
            ),
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  /// All times text column special text
  Widget _specialTextForAllTimesTexts(String text) => Text(
        text,
        textAlign: context.textAlignCenter,
        style: GoogleFonts.roboto(
          textStyle: context.appTextTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.onPrimary,
            fontWeight: context.fontWeights.fwBold,
            shadows: [
              Shadow(
                color: context.themeData.colorScheme.onSecondary,
                blurRadius: 1,
              ),
            ],
          ),
        ),
      );

  /// Shimmer loading effect container
  Widget _shimmerLoadingContainer() => Shimmer.fromColors(
        baseColor: AppTheme.shimmerBaseColor,
        highlightColor: AppTheme.shimmerHighlightColor,
        child: Row(
          children: [
            context.spacerWithFlex(flex: 3),
            Expanded(
              flex: 94,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: context.circularBorderRadius(radius: 24),
                  color: Colors.grey,
                ),
              ),
            ),
            context.spacerWithFlex(flex: 3),
          ],
        ),
      );

  /// Box decoration
  BoxDecoration _prayerTimesContainerDecoration() => BoxDecoration(
        color: context.themeData.colorScheme.primary,
        borderRadius: context.circularBorderRadius(radius: 24),
        border: Border.all(
          color: context.themeData.colorScheme.onSurface,
        ),
      );

  /// Ayah container decoration
  BoxDecoration _ayahContainerDecoration() {
    return BoxDecoration(
      color: context.themeData.colorScheme.onPrimary,
      borderRadius: context.circularBorderRadius(radius: 24),
      border: Border.all(
        color: context.themeData.colorScheme.onSurface,
      ),
    );
  }

  /// Box decoration for god names container
  BoxDecoration _boxDecorationForGodNamesContainer() {
    return BoxDecoration(
      color: context.themeData.colorScheme.onPrimary,
      borderRadius: context.circularBorderRadius(radius: 24),
      border: Border.all(
        color: context.themeData.colorScheme.onSurface,
      ),
      boxShadow: [
        BoxShadow(
          color: context.themeData.colorScheme.primaryContainer,
          blurRadius: 1,
        ),
      ],
    );
  }
}
