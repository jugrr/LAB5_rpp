import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Network{
  final Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'x-api-key': '5ce7c6e9-5769-4e18-81d4-dc8a763b4bb3'
  };

  Future fetchData(String url)async {
    try{
      http.Response response = await http.get(url, headers: header);
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }
      else{
        print(response.statusCode);
        throw CircularProgressIndicator();
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future postData(String url, String id)async {
    try{
      Map<String, String> body = {'image_id':'$id'};
      
      http.Response response = await http.post(url, headers: header, body: jsonEncode(body));
      if(response.statusCode == 200){
        return true;
      }
      else{
        print(response.statusCode);
        throw Exception(response.statusCode);
      }
    }catch(e){
      print(e.toString());
    }
  }

    Future postVote(String url, String id, int vote)async {
    try{
      Map<String, dynamic> body = {'image_id':'$id', 'value': vote};
      
      http.Response response = await http.post(url, headers: header, body: jsonEncode(body),);
      if(response.statusCode == 200){
        return true;
      }
      else{
        print(response.statusCode);
        throw Exception(response.statusCode);
      }
    }catch(e){
      print(e.toString());
    }
  } 

}