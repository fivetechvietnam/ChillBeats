import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart'; // Import this for BuildContext
import 'package:chillbeats/di/dependency_injection.dart';
import 'package:one_context/one_context.dart';

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

  // Constructor to initialize the bloc with Connectivity instance
  CheckInternetConnectionBloc() : super(CheckInternetConnectionInitial()) {
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

    //----------Auto add Events on Internet Restored Event ---------------///
    on<InternetConnectionRestoredEvent>((event, emit) {
      //--------Refresh  Special Music --------------///
      OneContext()
          .context!
          .read<SpecialMusicBloc>()
          .add(SpecialMusicFetchEvent());

      //--------Refresh  Popular Music --------------///
      OneContext()
          .context!
          .read<PopularMusicBloc>()
          .add(PopularMusicFetchEvent());

      //--------Refresh  TopPicks Music --------------///
      OneContext()
          .context!
          .read<TopPicksMusicBloc>()
          .add(TopPicksMusicFetchEvent());

      //--------Refresh  All Music --------------///
      OneContext()
          .context!
          .read<AllMusicBloc>()
          .add(AllMusicFetchEvent());

      //--------Refresh Artist Data --------------///
      OneContext()
          .context!
          .read<ArtistsDataBloc>()
          .add(ArtistsDataFetchEvent());
    });

    //--------Refresh  Vibes Music --------------///
    OneContext()
        .context!
        .read<VibesMusicBloc>()
        .add(VibesMusicFetchEvent());

    OneContext().context!.read<YoutubeMusicCubit>().fetchMusic();
  }
}
