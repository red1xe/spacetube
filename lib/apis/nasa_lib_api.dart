import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacetube/func/groupLinks.dart';
import 'dart:core';
import '../models/nasa_model.dart';

class NasaApi {
  static Future<List<NasaModel>> getNasaData(
      {String query = "sun", String media_type = "image"}) async {
    var url =
        "https://images-api.nasa.gov/search?q=$query&media_type=$media_type";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data = data['collection']['items'];
        List<NasaModel> nasaData = [];
        for (var item in data) {
          nasaData.add(NasaModel.fromJson(item));
        }
        return nasaData;
      }
    } catch (e) {
      if (e is NoSuchMethodError) {
        print('An error occurred: $e');
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          var alldata = data['collection']['items'];
          List<NasaModel> nasaData = [];
          for (var item in alldata) {
            nasaData.add(NasaModel.fromJsonSearch(item));
          }
          return nasaData;
        }
      } else {
        print('An error occurred: $e');
      }
    }
    return [];
  }

  static Future<List> getImage(String query) async {
    var url = query;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List> getVideo(String query) async {
    var url = query;
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List> getAudio(String query) async {
    var url = query;
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data = groupmp3links(data);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
