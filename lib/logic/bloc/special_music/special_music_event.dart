part of 'special_music_bloc.dart';

@immutable
abstract class SpecialMusicEvent extends Equatable {}


class SpecialMusicFetchEvent extends SpecialMusicEvent{
  @override
  List<Object?> get props => [];

}
