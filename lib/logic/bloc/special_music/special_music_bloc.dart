

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/music_model.dart';
import '../../../data/repositories/music_repository.dart';

part 'special_music_event.dart';
part 'special_music_state.dart';

class SpecialMusicBloc extends Bloc<SpecialMusicEvent, SpecialMusicState> {

  final MusicRepository _musicRepository = MusicRepository();

  SpecialMusicBloc() : super(SpecialMusicInitial()) {
    on<SpecialMusicFetchEvent>(_SpecialMusicFetchEvent);
  }

  FutureOr<void> _SpecialMusicFetchEvent(SpecialMusicFetchEvent event, Emitter<SpecialMusicState> emit) async{
    try{
      emit(SpecialMusicLoadingState());
      final List<MusicModel> list = await _musicRepository.fetchSpecialMusic();
      emit(SpecialMusicSuccessState(musicList: list));




    }catch(e){
      emit(SpecialMusicFailureState(errorMessage: e.toString()));
    }
  }
}
