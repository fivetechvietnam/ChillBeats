part of 'popular_music_bloc.dart';

@immutable
abstract class PopularMusicState extends Equatable {}


class PopularMusicInitial extends PopularMusicState {
  @override
  List<Object?> get props => [];
}


class PopularMusicLoadingState extends PopularMusicState{
  @override
  
  List<Object?> get props => [];
}
class PopularMusicSuccessState extends PopularMusicState{


  final List<MusicModel> musicList;

  PopularMusicSuccessState({required this.musicList});

  @override
  
  List<Object?> get props => [musicList];
}


class PopularMusicFailureState extends PopularMusicState {


  final String errorMessage;

  PopularMusicFailureState({required this.errorMessage});

  @override
  
  List<Object?> get props => [errorMessage];
}
