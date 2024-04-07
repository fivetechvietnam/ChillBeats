import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:chillbeats/generated/assets.gen.dart';
import 'package:chillbeats/logic/bloc/user_profie/user_profile_bloc.dart';
import 'package:chillbeats/logic/cubit/greeting/greeting_cubit.dart';
import 'package:chillbeats/logic/cubit/theme_mode/theme_mode_cubit.dart';
import 'package:chillbeats/presentation/pages/global_search/global_music_search_page.dart';
import 'package:chillbeats/presentation/pages/settings/profile_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageSliverAppBar extends StatelessWidget {
  const HomePageSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0.1.sh,
      elevation: 0,
      // backgroundColor: Colors.amber,
      floating: true,
      actions: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ));
                          },

                          //---------       User Profile Image   Avatar  -------//
                          child: BlocBuilder<UserProfileBloc, UserProfileState>(
                            builder: (context, state) {
                              if (state.profileImageFilePath
                                  .toString()
                                  .isNotEmpty) {
                                return SpinPerfect(
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(
                                      File(state.profileImageFilePath),
                                    ),
                                  ),
                                );
                              } else {
                                return BlocBuilder<ThemeModeCubit,
                                    ThemeModeState>(
                                  builder: (context, state) {
                                    return SpinPerfect(
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Color(state.accentColor),
                                        backgroundImage: Assets
                                            .images.userDefaultProfileImage
                                            .provider(),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //-------    Greeting ----------///
                              BlocBuilder<GreetingCubit, GreetingState>(
                                builder: (context, state) {
                                  return SlideInDown(
                                    child: Text(
                                      state.greeting,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              //----------     User Profile Name   ---------///
                              BlocBuilder<UserProfileBloc, UserProfileState>(
                                builder: (context, state) {
                                  return SlideInUp(
                                    child: Text(
                                      state.username,
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //---Search Icon Button-----///
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GlobalMusicSearchPage(),
                        ));
                        log("\n Search Button is Pressed!");
                      },
                      icon: const Icon(EvaIcons.search),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
