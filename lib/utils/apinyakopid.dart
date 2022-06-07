import 'dart:convert';
import 'package:http/http.dart' as http;

class Covid {
  Map<String, dynamic> total;

  Covid({required this.total});
  factory Covid.createCovid(Map<String, dynamic> object) {
    return Covid(total: object['update']['total']);
  }
  static Future<Covid> sambungKeApi([String? total]) async {
    try {
      String apiURL = "https://data.covid19.go.id/public/api/update.json";
      var respon = await http.get(Uri.parse(apiURL));
      var jsonObjek = json.decode(respon.body);
      print(jsonObjek['update']);
      //return (jsonObjek).map((e) => Covid.createCovid(e)).toList();
      return Covid.createCovid((jsonObjek));
    } catch (e) {
      print(e);
      return Covid(total: {});
    }
  }
}
