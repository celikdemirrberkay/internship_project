import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/model/god_names.dart';

/// Service for the God Names and meanings
class GodNamesService {
  /// Fetching data from json file and returning a list of GodNames
  Future<Either<String, List<GodNames>>> randomGodNameAndMeaning(BuildContext context) async {
    try {
      final data = await DefaultAssetBundle.of(context).loadString('assets/static/god_names.json');
      final jsonResult = jsonDecode(data) as List<dynamic>;

      final listOfGodNames = jsonResult.map((json) => GodNames.fromJson(json as Map<String, dynamic>)).toList();

      return Right(listOfGodNames);
    } catch (_) {
      return Left(ExceptionMessage.errorOccured.message);
    }
  }
}
