import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/asset.dart';
import '../constants.dart';

Future<Asset> fetchAsset(String assetId) async {
  String url = "https://app.tpstreams.com/api/v1/${Constants.ORG_CODE}/assets/$assetId/";
  Map<String, String> requestHeaders = {
    'Authorization': 'Token ${Constants.AUTHORIZATION_TOKEN}'
  };
  final response = await http.get(Uri.parse(url), headers: requestHeaders);

  if (response.statusCode == 200) {
    return Asset.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data from API.');
  }
}
