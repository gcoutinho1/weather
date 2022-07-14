import 'dart:convert';

import 'package:http/http.dart' as http;

class NetWorkHelper {
  final String url;

  NetWorkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      var longitude = jsonDecode(data)['coord']['lon'];
    } else {
      print(response.statusCode);
    }
  }
}
