import 'dart:convert';

import 'package:http/http.dart' as http;

class NetWorkHelper {
  final String url;
  //TODO: implement error handling correctly

  NetWorkHelper(this.url);

  Future getData() async {
    // http.Response response = await http.get(Uri.parse(url));
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      }
    } catch (e) {
      print(e);
      // throw Exception(
      //     'Não foi possível se conectar a API ${response.statusCode}');
    }
  }

}
