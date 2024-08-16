import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/constants/assets_constants.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/model/city.dart';

/// Service for fetching city names from json file
class CityNameService {
  /// Fetching data from json file and returning a list of turkey cities
  Future<Resource<List<City>>> getTurkeyCities(BuildContext context) async {
    try {
      /// Fetching data from json file
      final data = await DefaultAssetBundle.of(context).loadString(
        AssetsConstants.turkeysCityAsset.value,
      );

      /// Checking if data is not empty
      if (data.isNotEmpty) {
        final jsonResult = jsonDecode(data) as List<dynamic>;
        final listOfTurkeyCities = jsonResult.map((json) => City.fromJson(json as Map<String, dynamic>)).toList();
        return SuccessState(listOfTurkeyCities);
      } else {
        return const ErrorState(ExceptionTypes.noData);
      }
    } catch (_) {
      return const ErrorState(ExceptionTypes.errorOccured);
    }
  }
}
