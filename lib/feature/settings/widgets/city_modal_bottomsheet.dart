part of '../view/settings_view.dart';

class _CityModalBottomSheet extends StatefulWidget {
  const _CityModalBottomSheet();

  @override
  State<_CityModalBottomSheet> createState() => __CityModalBottomSheetState();
}

class __CityModalBottomSheetState extends State<_CityModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      enableFeedback: false,
      onTap: () => context.focusScope.unfocus(),
      child: SizedBox(
        height: context.screenSizes.dynamicHeight(0.7),
        width: context.screenSizes.width,
        child: Column(
          children: [
            Expanded(flex: 25, child: _textField()),
            Expanded(flex: 70, child: _cityList()),
            context.spacerWithFlex(flex: 5),
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return Row(
      children: [
        context.spacerWithFlex(flex: 5),
        Expanded(
          flex: 90,
          child: AppTextfield(
            hintText: 'Şehir bul',
            controller: TextEditingController(),
            prefixIcon: LineIcons.city,
          ),
        ),
        context.spacerWithFlex(flex: 5),
      ],
    );
  }

  Widget _cityList() => ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          title: Text('Şehir $index'),
          onTap: () {},
        ),
      );
}
