import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/services/app_services.dart';
import '../../../logic/bloc/all_music/all_music_bloc.dart';
import '../../../logic/bloc/all_music/all_music_event.dart';
import '../../../logic/bloc/popular_music/popular_music_bloc.dart';
import '../../../logic/bloc/special_music/special_music_bloc.dart';
import '../../../logic/bloc/top_picks_music/top_picks_music_bloc.dart';
import '../../../logic/bloc/top_picks_music/top_picks_music_event.dart';
import '../../../logic/cubit/greeting/greeting_cubit.dart';
import '../../../logic/cubit/theme_mode/theme_mode_cubit.dart';
import '../../../logic/cubit/youtube_music/youtube_music_cubit.dart';
import '../../../resources/hive/hive_resources.dart';
import 'package:chillbeats/generated/assets.gen.dart';
import '../initial/initial_page.dart';
import '../onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    
    super.initState();

    _fetchMusic();

    //---------Navigate To OnBoarding/Initial Page After Three Seconds-----//
    goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              /// Logo
              Center(
                child: Assets.icons.logo.svg(fit: BoxFit.contain)
              ),

              //- App Version Info
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    AppServices.appFullVersion,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  //---------------------- M E T H O D S ------------------//
  Future goToNextPage() async {
    //-!  Fetch Bool value from Hive database , to show OnBoarding Screen or not
    final bool onBoarding = await MyHiveBoxes.settingBox
            .get(MyHiveKeys.showOnBoardingScreenHiveKey) ??
        true;

    //--    Navigate To Next Screen
    Future.delayed(const Duration(seconds: 2), () {
      if (onBoarding) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoardingPage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const InitialPage()));
      }
    });
  }

  _fetchMusic() {
    //-----------Fetch  Special Music ------___--------///
    BlocProvider.of<SpecialMusicBloc>(context).add(SpecialMusicFetchEvent());

    //-----------Fetch  Popular Music ------___--------///
    BlocProvider.of<PopularMusicBloc>(context).add(PopularMusicFetchEvent());

    //-----------Fetch  TopPicks Music ------___--------///
    BlocProvider.of<TopPicksMusicBloc>(context)
        .add(TopPicksMusicFetchEvent());

    //-----------Fetch  All Music ------___--------///
    BlocProvider.of<AllMusicBloc>(context).add(AllMusicFetchEvent());

    //-------------Update Home Page Greeting Message -------///
    BlocProvider.of<GreetingCubit>(context).updateGreeting();

    //--------------- Fetch Youtube Music ------------------///
    BlocProvider.of<YoutubeMusicCubit>(context).fetchMusic();
  }
}
