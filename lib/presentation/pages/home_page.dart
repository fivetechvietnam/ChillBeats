import 'package:chillbeats/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:chillbeats/presentation/pages/view_more/view_more_page.dart';
import 'package:lottie/lottie.dart';
import 'package:one_context/one_context.dart';
import '../../logic/bloc/artists_data/artists_data_bloc.dart';
import '../../logic/bloc/artists_data/artists_data_event.dart';
import '../../logic/bloc/artists_data/artists_data_state.dart';
import '../../logic/bloc/all_music/all_music_bloc.dart';
import '../../logic/bloc/all_music/all_music_event.dart';
import '../../logic/bloc/popular_music/popular_music_bloc.dart';
import '../../logic/bloc/special_music/special_music_bloc.dart';
import '../../logic/bloc/top_picks_music/top_picks_music_bloc.dart';
import '../../logic/bloc/top_picks_music/top_picks_music_event.dart';
import '../../logic/bloc/top_picks_music/top_picks_music_state.dart';
import '../../logic/bloc/vibes_music/vibes_music_bloc.dart';
import '../../logic/bloc/vibes_music/vibes_music_event.dart';
import '../../logic/bloc/vibes_music/vibes_music_state.dart';
import '../widgets/artists_circle_avatar_list/artists_circle_cards_list_widget.dart';
import '../widgets/heading_with_view_more_button/heading_with_view_more_button_widget.dart';
import '../widgets/home_page_app_bar/home_app_bar.dart';
import '../widgets/music_cards_list/music_cards_list_widget.dart';
import '../widgets/lottie_animation/no_internet_lottie_animation_widget.dart';
import 'package:chillbeats/generated/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefreshMethod,

        ///     -------Storing/Preserve  Scroll Position
        child: PageStorage(
          bucket: pageBucket,
          child: CustomScrollView(
            key: const PageStorageKey("homePageStorageKey"),
            slivers: [
              //-------------------------App Bar ----------------------///
              const HomePageSliverAppBar(),

              //-------AppBar Bottom Padding
              SliverPadding(padding: EdgeInsets.only(bottom: 20.h)),

              //----------------------Special Section----------------------///

              ///-   --------------       Special Heading
              BlocBuilder<SpecialMusicBloc, SpecialMusicState>(
                builder: (context, state) {
                  return HeadingWithViewMoreButton(
                      heading: LocaleKeys.lofi_special.tr(),
                      viewMoreOnTap: () {
                        if (state is SpecialMusicSuccessState) {
                          OneContext().push(
                            MaterialPageRoute(
                              builder: (context) => ViewMorePage(
                                topHeading: LocaleKeys.lofi_special.tr(),
                                musicList: state.musicList,
                              ),
                            ),
                          );
                        }
                      });
                },
              ),

              /// ---------------       Special  Music List   ---------------///
              BlocBuilder<SpecialMusicBloc, SpecialMusicState>(
                builder: (context, state) {
                  //?----Fetching music is success
                  if (state is SpecialMusicSuccessState) {
                    if (state.musicList.isNotEmpty) {
                      return MusicCardsListWidget(
                        list: state.musicList,
                        pageStorageKey: "specialStorageKey",
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 0.4.sh,
                          child: const Center(
                              child: Text(
                                  "Something went wrong, refresh the page")),
                        ),
                      );
                    }

                    //-----    SpecialMusicLoadingState
                  } else if (state is SpecialMusicLoadingState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 0.30.sh,
                        child: Center(
                          child: Lottie.asset(Assets.jsons.lottieLoadingAnimation,
                              width: 0.2.sw),
                        ),
                      ),
                    );
                  }
                  //? ---- Music State is Failure State
                  else {
                    return const SliverToBoxAdapter(
                      child: NoInternetLottieAnimation(),
                    );
                  }
                },
              ),

              //----------------------Lo-fi Popular Section----------------------///
              /// --------------------------      Popular    Heading
              BlocBuilder<PopularMusicBloc, PopularMusicState>(
                builder: (context, state) {
                  return HeadingWithViewMoreButton(
                      heading: LocaleKeys.lofi_popular.tr(),
                      viewMoreOnTap: () {
                        if (state is PopularMusicSuccessState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewMorePage(
                                topHeading: LocaleKeys.lofi_popular.tr(),
                                musicList: state.musicList,
                              ),
                            ),
                          );
                        }
                      });
                },
              ),

              /// ----------------------------       Popular  Music List      --------------////
              BlocBuilder<PopularMusicBloc, PopularMusicState>(
                builder: (context, state) {
                  //?----Fetching music is success
                  if (state is PopularMusicSuccessState) {
                    if (state.musicList.isNotEmpty) {
                      return MusicCardsListWidget(
                        list: state.musicList,
                        pageStorageKey: "popularStorageKey",
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 0.4.sh,
                          child: const Center(
                              child: Text(
                                  "Something went wrong, refresh the page")),
                        ),
                      );
                    }
                  } else if (state is PopularMusicLoadingState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 0.30.sh,
                        child: Center(
                          child: Lottie.asset(Assets.jsons.lottieLoadingAnimation,
                              width: 0.2.sw),
                        ),
                      ),
                    );
                  }
                  //? ----   Music State is Failure State
                  else {
                    return const SliverToBoxAdapter(
                      child: NoInternetLottieAnimation(),
                    );
                  }
                },
              ),

              //------------------           Artists Section      ------------------///
              ///
              ///Heading
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Top Artists",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        letterSpacing: 1,
                    fontFamily: "Poppins"
                    ),
                  ),
                ),
              ),

              BlocBuilder<ArtistsDataBloc, ArtistsDataState>(
                builder: (context, state) {
                  //---------     If Success
                  if (state is ArtistsDataSuccessState) {
                    if (state.artistList.isNotEmpty) {
                      return ArtistsCardsListWidget(
                        artistList: state.artistList,
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 0.2.sh,
                          child: const Center(
                              child: Text(
                                  "Something went wrong, refresh the page")),
                        ),
                      );
                    }
                  }

                  //------------     If Loading
                  else if (state is ArtistsDataLoadingState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 0.2.sh,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Lottie.asset(Assets.jsons.lottieLoadingAnimation,
                                width: 0.2.sw),
                          ),
                        ),
                      ),
                    );
                  }

                  //-----   If No Internet Or Server Error
                  else {
                    return const SliverToBoxAdapter(
                      child: NoInternetLottieAnimation(),
                    );
                  }
                },
              ),

              //----------------------       TopPicks Section        ----------------------///

              /// --------------------------      TopPicks    Heading
              BlocBuilder<TopPicksMusicBloc, TopPicksMusicState>(
                builder: (context, state) {
                  return HeadingWithViewMoreButton(
                      heading: LocaleKeys.lofi_top_picks.tr(),
                      viewMoreOnTap: () {
                        if (state is TopPicksMusicSuccessState) {
                          OneContext().push(
                            MaterialPageRoute(
                              builder: (context) => ViewMorePage(
                                topHeading: LocaleKeys.lofi_top_picks.tr(),
                                musicList: state.musicList,
                              ),
                            ),
                          );
                        }
                      });
                },
              ),

              /// ----------------------------       TopPicks  Music List      --------------////
              BlocBuilder<TopPicksMusicBloc, TopPicksMusicState>(
                builder: (context, state) {
                  //?----Fetching music is success
                  if (state is TopPicksMusicSuccessState) {
                    if (state.musicList.isEmpty) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 0.4.sh,
                          child: const Center(
                              child: Text(
                                  "Something went wrong, refresh the page")),
                        ),
                      );
                    }
                    return MusicCardsListWidget(
                      list: state.musicList,
                      pageStorageKey: "topPicksStorageKey",
                    );
                  } else if (state is TopPicksMusicLoadingState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 0.30.sh,
                        child: Center(
                          child: Lottie.asset(Assets.jsons.lottieLoadingAnimation,
                              width: 0.2.sw),
                        ),
                      ),
                    );
                  }
                  //? ----       Music State is Failure State
                  else {
                    return const SliverToBoxAdapter(
                      child: NoInternetLottieAnimation(),
                    );
                  }
                },
              ),

              //----------------------------------------------------------------------///
              //----------------------Lo-fi Vibes Section----------------------///
              /// --------------------------      Vibes    Heading
              BlocBuilder<VibesMusicBloc, VibesMusicState>(
                builder: (context, state) {
                  return HeadingWithViewMoreButton(
                      heading: LocaleKeys.lofi_vibes.tr(),
                      viewMoreOnTap: () {
                        if (state is VibesMusicSuccessState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewMorePage(
                                topHeading: LocaleKeys.lofi_vibes.tr(),
                                musicList: state.musicList,
                              ),
                            ),
                          );
                        }
                      });
                },
              ),

              /// ----------------------------       Vibes  Music List      --------------////
              BlocBuilder<VibesMusicBloc, VibesMusicState>(
                builder: (context, state) {
                  //?----Fetching music is success
                  if (state is VibesMusicSuccessState) {
                    if (state.musicList.isNotEmpty) {
                      return MusicCardsListWidget(
                        list: state.musicList,
                        pageStorageKey: "vibesStorageKey",
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 0.4.sh,
                          child: const Center(
                              child: Text(
                                  "Something went wrong, refresh the page")),
                        ),
                      );
                    }
                  } else if (state is VibesMusicLoadingState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 0.30.sh,
                        child: Center(
                          child: Lottie.asset(Assets.jsons.lottieLoadingAnimation,
                              width: 0.2.sw),
                        ),
                      ),
                    );
                  }
                  //? ----   Music State is Failure State
                  else {
                    return const SliverToBoxAdapter(
                      child: NoInternetLottieAnimation(),
                    );
                  }
                },
              ),

              //----------------------------------------------------------------------///

              //------     Extra Sized Box
              SliverToBoxAdapter(
                child: Gap(
                  0.15.sh,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //---------------------------- M E T H O D S --------------------///
  Future<void> _onRefreshMethod() async {
    //--------Refresh  Special Music --------------///
    context.read<SpecialMusicBloc>().add(SpecialMusicFetchEvent());

    //--------Refresh  Popular Music --------------///
    context.read<PopularMusicBloc>().add(PopularMusicFetchEvent());

    //--------Refresh  Top Picks Music --------------///
    context
        .read<TopPicksMusicBloc>()
        .add(TopPicksMusicFetchEvent());

    //--------Refresh  All Music --------------///
    context.read<AllMusicBloc>().add(AllMusicFetchEvent());

    //--------Refresh Artist Data --------------///
    context.read<ArtistsDataBloc>().add(ArtistsDataFetchEvent());

    //--------Refresh  Vibes Music --------------///
    context.read<VibesMusicBloc>().add(VibesMusicFetchEvent());
  }
}
