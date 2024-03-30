

import '../../di/dependency_injection.dart';
import '../datasources/musicData/music_data_api.dart';
import '../models/artist_model.dart';
import '../models/music_model.dart';

class MusicRepository {
  final MusicData musicData = locator.get<MusicData>();

  // ------------------              Special Music    ---------------///
  Future<List<MusicModel>> fetchSpecialMusic() async {
    final List<dynamic> musicList = await musicData.getSpecialMusic();
    if (musicList.isNotEmpty) {
      return musicList.map((e) => MusicModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch  Special Music.");
    }
  }

  // ------------------              Popular Music    ---------------///
  Future<List<MusicModel>> fetchPopularMusic() async {
    final List<dynamic> musicList = await musicData.getPopularMusic();
    if (musicList.isNotEmpty) {
      return musicList.map((e) => MusicModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch  Popular Music.");
    }
  }


  // ------------------              TopPicks Music    ---------------///
  Future<List<MusicModel>> fetchTopPicksMusic() async {
    final List<dynamic> musicList = await musicData.getTopPicksMusic();
    if (musicList.isNotEmpty) {
      return musicList.map((e) => MusicModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch  TopPicks Music.");
    }
  }


  // ------------------              Artists Images    ---------------///
  Future<List<ArtistModel>> fetchArtists() async {
    final List<dynamic> artistList = await musicData.getArtistsData();
    if (artistList.isNotEmpty) {
      return artistList.map((e) => ArtistModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch  Artists");
    }
  }



  // ------------------              Vibes Music    ---------------///
  Future<List<MusicModel>> fetchVibesMusic() async {
    final List<dynamic> musicList = await musicData.getVibesMusic();
    if (musicList.isNotEmpty) {
      return musicList.map((e) => MusicModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch  Vibes Music.");
    }
  }
}
