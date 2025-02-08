import 'package:flutter_ai_age/http/my_api.dart';

Future<Map<String, dynamic>> uploadCompoundInterestData(
    Map<String, dynamic> data) async {
  final apiUrl = getUrlForEndpoint('upload_compound_interest');
  await getExtraInfo();

  return sendJsonData(data, apiUrl);
}

Future getExtraInfo() async {
  // Do something here
}
