import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internship_project/repositories/model/god_names.dart';

/// Service for the God Names and meanings
class GodNamesService {
  static Future<List<GodNames>> randomGodNameAndMeaning(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString('assets/static/god_names.json');
    final jsonResult = jsonDecode(data) as List<dynamic>;

    final listOfGodNames = jsonResult.map((json) => GodNames.fromJson(json as Map<String, dynamic>)).toList();

    return listOfGodNames;
  }
}
