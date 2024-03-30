
import 'package:equatable/equatable.dart';

import '../../../data/models/music_model.dart';

abstract class AllMusicState extends Equatable {}


class AllMusicInitial extends AllMusicState {
  @override
  List<Object?> get props => [];
}


class AllMusicLoadingState extends AllMusicState{
  @override
  
  List<Object?> get props => [];
}
class AllMusicSuccessState extends AllMusicState{


  final List<MusicModel> musicList;

  AllMusicSuccessState({required this.musicList});

  @override
  
  List<Object?> get props => [musicList];
}


class AllMusicFailureState extends AllMusicState {


  final String errorMessage;

  AllMusicFailureState({required this.errorMessage});

  @override
  
  List<Object?> get props => [errorMessage];
}
