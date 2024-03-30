part of 'special_music_bloc.dart';

@immutable
abstract class SpecialMusicState extends Equatable {}

class SpecialMusicInitial extends SpecialMusicState {
  @override
  List<Object?> get props => [];
}


class SpecialMusicLoadingState extends SpecialMusicState{
  @override
  
  List<Object?> get props => [];
}
class SpecialMusicSuccessState extends SpecialMusicState{


  final List<MusicModel> musicList;

  SpecialMusicSuccessState({required this.musicList});

  @override
  
  List<Object?> get props => [musicList];
}


class SpecialMusicFailureState extends SpecialMusicState{


  final String errorMessage;

  SpecialMusicFailureState({required this.errorMessage});
  @override
  
  List<Object?> get props => [errorMessage];
}
