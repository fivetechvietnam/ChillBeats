import 'package:chillbeats/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String appVersion = "1.0.0(1)";

  @override
  void initState() {
    super.initState();
    _getAppVersion();
    _fetchMusic();

    //---------Navigate To OnBoarding/Initial Page After Three Seconds-----//
    goToNextPage();
  }

  _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = "${packageInfo.version}(${packageInfo.buildNumber})";
    });
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icons.logo.svg(
                      fit: BoxFit.contain,
                      width: 300,
                      height: 300,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, right: 16, left: 16),
                      child: Text(
                        LocaleKeys.app_slogan.tr(),
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),

              //- App Version Info
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    appVersion,
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
    BlocProvider.of<TopPicksMusicBloc>(context).add(TopPicksMusicFetchEvent());

    //-----------Fetch  All Music ------___--------///
    BlocProvider.of<AllMusicBloc>(context).add(AllMusicFetchEvent());

    //-------------Update Home Page Greeting Message -------///
    BlocProvider.of<GreetingCubit>(context).updateGreeting();

    //--------------- Fetch Youtube Music ------------------///
    BlocProvider.of<YoutubeMusicCubit>(context).fetchMusic();
  }
}
