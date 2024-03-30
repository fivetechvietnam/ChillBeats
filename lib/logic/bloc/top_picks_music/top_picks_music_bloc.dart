// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/models/music_model.dart';
import '../../../data/repositories/music_repository.dart';
import 'top_picks_music_event.dart';
import 'top_picks_music_state.dart';


class TopPicksMusicBloc extends Bloc<TopPicksMusicEvent, TopPicksMusicState> {

  final MusicRepository _musicRepository = MusicRepository();

  TopPicksMusicBloc() : super(TopPicksMusicInitial()) {
    on<TopPicksMusicFetchEvent>(_SpecialMusicFetchEvent);
  }

  FutureOr<void> _SpecialMusicFetchEvent(TopPicksMusicFetchEvent event, Emitter<TopPicksMusicState> emit) async{
    try{
      emit(TopPicksMusicLoadingState());
      final List<MusicModel> list = await _musicRepository.fetchTopPicksMusic();
      emit(TopPicksMusicSuccessState(musicList: list));




    }catch(e){
      emit(TopPicksMusicFailureState(errorMessage: e.toString()));
    }
  }
}
