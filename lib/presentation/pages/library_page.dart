import 'package:chillbeats/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chillbeats/presentation/pages/view_more/view_more_page.dart';
import 'package:lottie/lottie.dart';

import '../../logic/bloc/favorite_button/favorite_button_bloc.dart';
import '../../logic/bloc/all_music/all_music_bloc.dart';
import '../../logic/bloc/all_music/all_music_state.dart';
import '../widgets/heading_with_view_more_button/heading_with_view_more_button_widget.dart';
import '../widgets/music_cards_list/music_cards_list_widget.dart';
import '../widgets/lottie_animation/no_internet_lottie_animation_widget.dart';
import 'package:chillbeats/generated/assets.gen.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Library",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          ///-   --------------       My Favorite
          BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
            builder: (context, favoriteState) {
              return BlocBuilder<AllMusicBloc, AllMusicState>(
                builder: (context, state) {
                  // Heading with View More Button Widget
                  return HeadingWithViewMoreButton(
                    heading: LocaleKeys.my_favorite.tr(),
                    viewMoreOnTap: () {
                      if (state is AllMusicSuccessState) {
                        // Filter the favorite list
                        final favoriteList = state.musicList
                            .where((element) => favoriteState.favoriteList
                                .contains(element.title))
                            .toList();
                        // Navigate to View More Page with filtered list
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewMorePage(
                              topHeading: LocaleKeys.my_favorite.tr(),
                              musicList: favoriteList,
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),

          ///       -------------Favorite List
          BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
            builder: (context, favoriteState) {
              return BlocBuilder<AllMusicBloc, AllMusicState>(
                builder: (context, state) {
                  //------------        If  Success State
                  if (state is AllMusicSuccessState) {
                    //  Filter the favorite list
                    final favoriteList = state.musicList
                        .where((element) =>
                            favoriteState.favoriteList.contains(element.title))
                        .toList();

                    if (favoriteList.isNotEmpty) {
                      //  Display the filtered favorite list using MusicCardsListWidget
                      return MusicCardsListWidget(
                        list: favoriteList,
                        pageStorageKey: "favoriteStorageKey",
                      );
                    }

                    //----   If Favorite list is Empty
                    else {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 0.30.sh,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              LocaleKeys.no_favorite_items_available.tr(),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  //?-----------            If Loading State
                  else if (state is AllMusicLoadingState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 0.30.sh,
                        child: Center(
                          child: Lottie.asset(
                              Assets.jsons.lottieLoadingAnimation,
                              width: 0.2.sw),
                        ),
                      ),
                    );
                  }
                  //?-----------              If failure State
                  else {
                    return const SliverToBoxAdapter(
                        child: NoInternetLottieAnimation());
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
