part of '../view/settings_view.dart';

class _CityModalBottomSheet extends StatefulWidget {
  const _CityModalBottomSheet();

  @override
  State<_CityModalBottomSheet> createState() => __CityModalBottomSheetState();
}

class __CityModalBottomSheetState extends State<_CityModalBottomSheet> {
  /// Controller for search city
  late TextEditingController _controllerForSearchCity;

  /// Searchable city list
  late List<City> searchableCityList;

  @override
  void initState() {
    super.initState();

    /// Initialize controller
    _controllerForSearchCity = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      enableFeedback: false,
      onTap: () => context.focusScope.unfocus(),
      child: SizedBox(
        height: context.screenSizes.dynamicHeight(0.7),
        width: context.screenSizes.width,
        child: Column(
          children: [
            Expanded(flex: 25, child: _textField()),
            Expanded(flex: 70, child: _cityListBuilder()),
            context.spacerWithFlex(flex: 5),
          ],
        ),
      ),
    );
  }

  /// Text field for searching city
  Widget _textField() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingsViewModel(locator(), context),
      builder: (context, viewModel, child) => Row(
        children: [
          context.spacerWithFlex(flex: 5),
          Expanded(
            flex: 90,
            child: AppTextfield(
              hintText: 'Şehir bul',
              controller: _controllerForSearchCity,
              prefixIcon: LineIcons.city,
              onChanged: (value) => _searchCity(value, viewModel),
            ),
          ),
          context.spacerWithFlex(flex: 5),
        ],
      ),
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) async {
        await viewModel.getCityNames(context);
        searchableCityList = viewModel.cityNames.data ?? [];
      },
    );
  }

  /// City list builder
  Widget _cityListBuilder() => ViewModelBuilder.reactive(
        viewModelBuilder: () => SettingsViewModel(locator(), context),
        builder: (context, viewModel, child) => switch (viewModel.cityNames) {
          ErrorState<List<City>>() => ExceptionWidget(message: ExceptionUtil.getExceptionMessage(viewModel.cityNames.exceptionType!)),
          LoadingState<List<City>>() => const LoadingWidget(),
          SuccessState<List<City>>() => _cityListView(),
        },
        fireOnViewModelReadyOnce: true,
        onViewModelReady: (viewModel) async {
          await viewModel.getCityNames(context);
          searchableCityList = viewModel.cityNames.data ?? [];
        },
      );

  /// City list view
  Widget _cityListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => HorizontalAppDivider(
        dividerColor: context.themeData.colorScheme.onSurface,
      ),
      itemCount: searchableCityList.length,
      itemBuilder: (context, index) => ListTile(
        leading: Text(
          searchableCityList[index].cityId.toString(),
          style: GoogleFonts.roboto(
            textStyle: context.textStyles.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.themeData.colorScheme.primary,
            ),
          ),
        ),
        title: Text(
          searchableCityList[index].name,
          style: GoogleFonts.roboto(
            textStyle: context.textStyles.headlineSmall?.copyWith(
              fontWeight: context.fontWeights.fw300,
              color: context.themeData.colorScheme.onSecondary,
            ),
          ),
        ),
        onTap: () {
          context.pop();
        },
      ),
    );
  }

  /// Search city on list
  void _searchCity(String query, SettingsViewModel viewModel) {
    /// If the query is empty, show all cities
    if (query == '') {
      setState(() => searchableCityList = viewModel.cityNames.data ?? []);
    } else {
      final searchedCity = searchableCityList.where((element) {
        final cityName = element.name.toLowerCase();
        final input = query.toLowerCase();

        return cityName.contains(input);
      }).toList();

      setState(() => searchableCityList = searchedCity);
    }
  }
}
