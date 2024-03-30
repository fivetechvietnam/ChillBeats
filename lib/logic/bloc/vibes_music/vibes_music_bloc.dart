

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/music_model.dart';
import '../../../data/repositories/music_repository.dart';
import 'vibes_music_event.dart';
import 'vibes_music_state.dart';

class VibesMusicBloc extends Bloc<VibesMusicEvent, VibesMusicState> {

  final MusicRepository _musicRepository = MusicRepository();

  VibesMusicBloc() : super(VibesMusicInitial()) {
    on<VibesMusicFetchEvent>(_SpecialMusicFetchEvent);
  }

  FutureOr<void> _SpecialMusicFetchEvent(VibesMusicFetchEvent event, Emitter<VibesMusicState> emit) async{
    try{
      emit(VibesMusicLoadingState());
      final List<MusicModel> list = await _musicRepository.fetchVibesMusic();
      emit(VibesMusicSuccessState(musicList: list));




    }catch(e){
      emit(VibesMusicFailureState(errorMessage: e.toString()));
    }
  }
}
