import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/constants/assets_constants.dart';
import 'package:internship_project/core/exception/exception_type.dart';
import 'package:internship_project/model/god_names.dart';

/// Service for the God Names and meanings
class GodNamesService {
  /// Fetching data from json file and returning a list of GodNames
  Future<Resource<God>> randomGodNameAndMeaning(BuildContext context) async {
    /// Generate random number between 0 and 99
    final randomAyahNumber = Random().nextInt(99);
    try {
      /// Fetching god names from json file
      final data = await DefaultAssetBundle.of(context).loadString(
        AssetsConstants.godNamesAsset.value,
      );

      /// Convert data to List<dynamic>
      final jsonResult = jsonDecode(data) as List<dynamic>;

      if (jsonResult.isEmpty) {
        return const ErrorState(ExceptionTypes.noData);
      } else {
        final listOfGodNames = jsonResult.map((json) => God.fromJson(json as Map<String, dynamic>)).toList();
        return SuccessState(listOfGodNames[randomAyahNumber]);
      }
    } catch (_) {
      return const ErrorState(ExceptionTypes.errorOccured);
    }
  }
}
