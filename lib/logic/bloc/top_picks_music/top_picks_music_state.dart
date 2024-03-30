import 'package:equatable/equatable.dart';

import '../../../data/models/music_model.dart';





abstract class TopPicksMusicState extends Equatable {}


class TopPicksMusicInitial extends TopPicksMusicState {
  @override
  
  List<Object?> get props => [];
}


class TopPicksMusicLoadingState extends TopPicksMusicState{
  @override
  
  List<Object?> get props => [];
}
class TopPicksMusicSuccessState extends TopPicksMusicState{


  final List<MusicModel> musicList;

  TopPicksMusicSuccessState({required this.musicList});

  @override
  
  List<Object?> get props => [musicList];
}


class TopPicksMusicFailureState extends TopPicksMusicState {


  final String errorMessage;

  TopPicksMusicFailureState({required this.errorMessage});

  @override
  
  List<Object?> get props => [errorMessage];
}
