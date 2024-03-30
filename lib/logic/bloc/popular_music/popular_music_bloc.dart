
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/music_model.dart';
import '../../../data/repositories/music_repository.dart';

part 'popular_music_event.dart';
part 'popular_music_state.dart';

class PopularMusicBloc extends Bloc<PopularMusicEvent, PopularMusicState> {

  final MusicRepository _musicRepository = MusicRepository();

  PopularMusicBloc() : super(PopularMusicInitial()) {
    on<PopularMusicFetchEvent>(_SpecialMusicFetchEvent);
  }

  FutureOr<void> _SpecialMusicFetchEvent(PopularMusicFetchEvent event, Emitter<PopularMusicState> emit) async{
    try{
      emit(PopularMusicLoadingState());
      final List<MusicModel> list = await _musicRepository.fetchPopularMusic();
      emit(PopularMusicSuccessState(musicList: list));




    }catch(e){
      emit(PopularMusicFailureState(errorMessage: e.toString()));
    }
  }
}
