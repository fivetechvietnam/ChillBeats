
import 'package:equatable/equatable.dart';

import '../../../data/models/music_model.dart';

abstract class VibesMusicState extends Equatable {}


class VibesMusicInitial extends VibesMusicState {
  @override
  
  List<Object?> get props => [];
}


class VibesMusicLoadingState extends VibesMusicState{
  @override
  
  List<Object?> get props => [];
}
class VibesMusicSuccessState extends VibesMusicState{


  final List<MusicModel> musicList;

  VibesMusicSuccessState({required this.musicList});

  @override
  
  List<Object?> get props => [musicList];
}


class VibesMusicFailureState extends VibesMusicState {


  final String errorMessage;

  VibesMusicFailureState({required this.errorMessage});

  @override
  
  List<Object?> get props => [errorMessage];
}
