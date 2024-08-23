import 'package:dart_vader/dart_vader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/common/app_horizontal_divider.dart';
import 'package:internship_project/core/common/app_textfield.dart';
import 'package:internship_project/core/common/exception_widget.dart';
import 'package:internship_project/core/common/loading_widget.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/core/exception/exception_util.dart';
import 'package:internship_project/core/theme/app_theme.dart';
import 'package:internship_project/feature/settings/view_model/settings_view_model.dart';
import 'package:internship_project/model/city.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

part '../widgets/city_modal_bottomsheet.dart';
part '../widgets/time_selector_bottomsheet.dart';

/// Settings view where user can change settings
class SettingsView extends StatefulWidget {
  ///
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: _title(),
        leading: _backButton(context),
        backgroundColor: context.themeData.colorScheme.onPrimary,
      ),
      body: SafeArea(child: _column()),
    );
  }

  Widget _column() {
    return SizedBox.expand(
      child: Column(
        children: [
          context.spacerWithFlex(flex: 3),
          Expanded(flex: 5, child: _headerText('Konum')),
          Expanded(flex: 8, child: _specialCardForCity()),
          context.spacerWithFlex(flex: 3),
          Expanded(flex: 5, child: _headerText('Tema')),
          Expanded(flex: 8, child: _specialCardForTheme()),
          context.spacerWithFlex(flex: 3),
          Expanded(flex: 5, child: _headerText('Bildirim')),
          Expanded(flex: 8, child: _specialCardForNotification()),
          context.spacerWithFlex(flex: 2),
          Expanded(flex: 5, child: _selectNotifSchedule()),
          context.spacerWithFlex(flex: 38),
          Expanded(flex: 5, child: _apiDescriptionText()),
          context.spacerWithFlex(flex: 2),
        ],
      ),
    );
  }

  /// Select when to get notifications
  Widget _selectNotifSchedule() => Row(
        children: [
          context.spacerWithFlex(flex: 3),
          Expanded(
            flex: 52,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _showScheduleTimeSelectorBottomSheet,
                child: Text(
                  'Bildirim Zamanlarını Seçin',
                  style: GoogleFonts.roboto(
                    textStyle: context.appTextTheme.bodyLarge?.copyWith(
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          context.spacerWithFlex(flex: 45),
        ],
      );

  /// Show schedule time selector bottom sheet
  Future<Widget?> _showScheduleTimeSelectorBottomSheet() {
    return showModalBottomSheet<Widget>(
      context: context,
      builder: (context) => const _TimeSelectorBottomsheet(),
    );
  }

  Widget _apiDescriptionText() => FittedBox(
        child: Text(
          'Tüm namaz vakitleri verileri\naladhan.com sitesinden alınmaktadır.',
          textAlign: context.textAlignCenter,
          style: GoogleFonts.roboto(
            textStyle: context.appTextTheme.bodySmall?.copyWith(
              color: AppTheme.shimmerBaseColor,
            ),
          ),
        ),
      );

  Widget _specialCardForCity() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: InkWell(
            onTap: () async => _buildCityModalBottomSheet(),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: context.circularBorderRadius(radius: 12),
                color: context.themeData.colorScheme.onPrimary,
              ),
              child: Row(
                children: [
                  context.spacerWithFlex(flex: 3),
                  Expanded(
                    flex: 5,
                    child: FittedBox(
                      child: Icon(
                        Icons.location_on_outlined,
                        color: context.themeData.colorScheme.primary,
                      ),
                    ),
                  ),
                  context.spacerWithFlex(flex: 2),
                  Expanded(
                    flex: 80,
                    child: Text(
                      'Şehri seçiniz',
                      style: GoogleFonts.roboto(
                        textStyle: context.appTextTheme.bodyLarge?.copyWith(
                          color: context.themeData.colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// Special card for theme
  Widget _specialCardForTheme() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: context.circularBorderRadius(radius: 12),
              color: context.themeData.colorScheme.onPrimary,
            ),
            child: Row(
              children: [
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 5,
                  child: FittedBox(
                    child: Icon(
                      Icons.color_lens_outlined,
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ),
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 60,
                  child: Text(
                    'Temayı seçiniz',
                    style: GoogleFonts.roboto(
                      textStyle: context.appTextTheme.bodyLarge?.copyWith(
                        color: context.themeData.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 20, child: _themeSwitch()),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// Theme selection switch
  Widget _themeSwitch() => ViewModelBuilder.reactive(
        viewModelBuilder: () => SettingsViewModel(locator(), locator(), locator()),
        builder: (context, viewModel, child) => Switch(
          value: viewModel.isDarkMode,
          inactiveTrackColor: Colors.yellow.shade100,
          inactiveThumbColor: Colors.yellow,
          activeTrackColor: Colors.blue.shade100,
          activeColor: Colors.blue,
          thumbIcon: WidgetStatePropertyAll(
            Icon(
              viewModel.isDarkMode ? LineIcons.moon : LineIcons.sun,
              color: context.themeData.colorScheme.onSecondary,
            ),
          ),
          onChanged: (_) async => viewModel.updateTheme(),
        ),
      );

  /// Special card for notification
  Widget _specialCardForNotification() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 3),
        Expanded(
          flex: 94,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: context.circularBorderRadius(radius: 12),
              color: context.themeData.colorScheme.onPrimary,
            ),
            child: Row(
              children: [
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 5,
                  child: FittedBox(
                    child: Icon(
                      Icons.notification_add_outlined,
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ),
                context.spacerWithFlex(flex: 3),
                Expanded(
                  flex: 60,
                  child: Text(
                    'Bildirimleri kontrol edin',
                    style: GoogleFonts.roboto(
                      textStyle: context.appTextTheme.bodyLarge?.copyWith(
                        color: context.themeData.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 20, child: _notificationSwitch()),
              ],
            ),
          ),
        ),
        context.spacerWithFlex(flex: 3),
      ],
    );
  }

  /// Notification switch
  Widget _notificationSwitch() => ViewModelBuilder.reactive(
        viewModelBuilder: () => SettingsViewModel(
          locator(),
          locator(),
          locator(),
        ),
        builder: (context, viewModel, child) => switch (viewModel.isNotificationOpen) {
          ErrorState<bool>() => const Icon(LineIcons.cross),
          LoadingState<bool>() => const LoadingWidget(),
          SuccessState<bool>() => Switch(
              value: viewModel.isNotificationOpen.data ?? false,
              onChanged: (value) => viewModel.updateNotificationStatus(value: value),
            ),
        },
      );

  /// Header text
  Widget _headerText(String text) {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 95,
          child: Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: context.appTextTheme.headlineSmall?.copyWith(
                color: context.themeData.colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Back button
  Widget _backButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: context.themeData.colorScheme.onSecondary,
      ),
      onPressed: () => context.pushReplacementNamed('main'),
    );
  }

  /// Title
  Widget _title() => Text(
        'Ayarlar',
        style: GoogleFonts.roboto(
          textStyle: context.appTextTheme.headlineSmall?.copyWith(
            color: context.themeData.colorScheme.onSecondary,
          ),
        ),
      );

  /// Build city selection modal bottom sheet
  Future<void> _buildCityModalBottomSheet() => showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) => const _CityModalBottomSheet(),
      );
}
