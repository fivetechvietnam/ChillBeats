import 'dart:io';
import 'dart:ui';

import 'package:chillbeats/generated/assets.gen.dart';
import 'package:chillbeats/logic/bloc/user_profie/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillbeats/logic/cubit/theme_mode/theme_mode_cubit.dart';


class BlurBackgroundProfileImageWidget extends StatelessWidget {
  const BlurBackgroundProfileImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, themeState) {
        return BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, userProfileState) {
            final String userProfileImage =
                userProfileState.profileImageFilePath;
            return ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(themeState.accentColor),
                  image: userProfileImage.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(
                            File(userProfileImage),
                          ),
                          fit: BoxFit.cover)
                      :  DecorationImage(
                          image: Assets.images.userDefaultProfileImage.provider(),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
