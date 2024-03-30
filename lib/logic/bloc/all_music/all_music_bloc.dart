
import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data/models/music_model.dart';
import '../../../data/repositories/music_repository.dart';
import 'all_music_event.dart';
import 'all_music_state.dart';


class AllMusicBloc extends Bloc<AllMusicEvent, AllMusicState> {

  final MusicRepository _musicRepository = MusicRepository();

  AllMusicBloc() : super(AllMusicInitial()) {
    on<AllMusicFetchEvent>(_SpecialMusicFetchEvent);
  }

  FutureOr<void> _SpecialMusicFetchEvent(AllMusicFetchEvent event, Emitter<AllMusicState> emit) async{
    try{
      emit(AllMusicLoadingState());
      final List<MusicModel> specialList = await _musicRepository.fetchSpecialMusic();
      final List<MusicModel> popularList = await _musicRepository.fetchPopularMusic();
      final List<MusicModel> topPicksList = await _musicRepository.fetchTopPicksMusic();
      final List<MusicModel> vibesList = await _musicRepository.fetchVibesMusic();

      List<MusicModel> combinedList = [];
      combinedList = [...specialList, ...popularList, ...topPicksList, ...vibesList].toSet().toList();


      emit(AllMusicSuccessState(musicList: combinedList));




    }catch(e){
      emit(AllMusicFailureState(errorMessage: e.toString()));
    }
  }
}
