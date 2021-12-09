import 'package:http/http.dart' as http;
import 'dart:convert';

class Networkhelper{
  Networkhelper(this.apiKey);
  final String apiKey;
  Future<dynamic> getData()async{
    Uri url = Uri.parse(apiKey);
    var response =await http.get(url);
    if(response.statusCode==200)
    {
      dynamic data=jsonDecode(response.body);
      return data;
     }
    else{
      print(response.statusCode);
    }

  }
}