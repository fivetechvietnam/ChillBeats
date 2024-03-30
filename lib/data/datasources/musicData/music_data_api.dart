import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:chillbeats/di/dependency_injection.dart';

import 'music_data_urls.dart';


class MusicData extends MusicDataKeys{
  final Dio _dio = locator.get<Dio>();


  //----         Special Music     ------------///
  Future<List> getSpecialMusic() async {
    try {
      final response = await _dio.get(apiSpecialUrl);
      return response.data;
    } catch (e) {
      log("Error fetching  Special Music: $e");
      return [];
    }
  }

  //----         Popular Music     ------------///
  Future<List> getPopularMusic() async {
    try {
      final response = await _dio.get(apiPopularUrl);
      return response.data;
    } catch (e) {
      log("Error fetching  Popular Music: $e");
      return [];
    }
  }

  //----         TopPicks Music     ------------///
  Future<List> getTopPicksMusic() async {
    try {
      final response = await _dio.get(apiTopPicksUrl);
      return response.data;
    } catch (e) {
      log("Error fetching  TopPicks Music: $e");
      return [];
    }
  }


  //----         Artists Data     ------------///
  Future<List> getArtistsData() async {
    try {
      final response = await _dio.get(apiartistsUrl);
      return response.data;
    } catch (e) {
      log("Error fetching Artists Data: $e");
      return [];
    }
  }



  //----         Vibes Music     ------------///
  Future<List> getVibesMusic() async {
    try {
      final response = await _dio.get(apiVibesUrl);
      return response.data;
    } catch (e) {
      log("Error fetching  Vibes Music: $e");
      return [];
    }
  }

}
