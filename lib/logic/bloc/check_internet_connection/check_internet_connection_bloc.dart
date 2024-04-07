import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart'; // Import this for BuildContext
import 'package:chillbeats/di/dependency_injection.dart';

import '../../cubit/youtube_music/youtube_music_cubit.dart';
import '../artists_data/artists_data_bloc.dart';
import '../artists_data/artists_data_event.dart';
import '../all_music/all_music_bloc.dart';
import '../all_music/all_music_event.dart';
import '../popular_music/popular_music_bloc.dart';
import '../special_music/special_music_bloc.dart';
import '../top_picks_music/top_picks_music_bloc.dart';
import '../top_picks_music/top_picks_music_event.dart';
import '../vibes_music/vibes_music_bloc.dart';
import '../vibes_music/vibes_music_event.dart';

part 'check_internet_connection_event.dart';
part 'check_internet_connection_state.dart';

class CheckInternetConnectionBloc
    extends Bloc<CheckInternetConnectionEvent, CheckInternetConnectionState> {
  final connectivity = locator.get<Connectivity>();
  final BuildContext context; // Add context here

  // Constructor to initialize the bloc with Connectivity instance
  CheckInternetConnectionBloc(this.context)
      : super(CheckInternetConnectionInitial()) {
    // Listen for changes in connectivity
    connectivity.onConnectivityChanged.listen((connectivityResult) {
      // If connectivity is neither mobile nor wifi, dispatch NoInternetConnectionEvent
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        add(NoInternetConnectionEvent());
      } else {
        add(InternetConnectionRestoredEvent());
      }
    });

    // Handle NoInternetConnectionEvent by emitting NoInternetConnectionState
    on<NoInternetConnectionEvent>((event, emit) {
      emit(NoInternetConnectionState());
    });

    // ----------Auto add Events on Internet Restored Event ---------------///
    on<InternetConnectionRestoredEvent>((event, emit) {
      //--------Refresh  Special Music --------------///
      BlocProvider.of<SpecialMusicBloc>(context).add(SpecialMusicFetchEvent());

      //--------Refresh  Popular Music --------------///
      BlocProvider.of<PopularMusicBloc>(context).add(PopularMusicFetchEvent());

      //--------Refresh  TopPicks Music --------------///
      BlocProvider.of<TopPicksMusicBloc>(context)
          .add(TopPicksMusicFetchEvent());

      //--------Refresh  All Music --------------///
      BlocProvider.of<AllMusicBloc>(context).add(AllMusicFetchEvent());

      //--------Refresh Artist Data --------------///
      BlocProvider.of<ArtistsDataBloc>(context).add(ArtistsDataFetchEvent());
    });

    //--------Refresh  Vibes Music --------------///
    BlocProvider.of<VibesMusicBloc>(context).add(VibesMusicFetchEvent());
    BlocProvider.of<YoutubeMusicCubit>(context).fetchMusic();
  }
}
