

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:chillbeats/generated/assets.gen.dart';



class NoInternetLottieAnimation extends StatelessWidget {
  const NoInternetLottieAnimation({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        Assets.jsons.noInternetLottieAnimation,
        animate: true,
        fit: BoxFit.contain,
        width: 0.4.sw,
        height: 0.4.sw,
      ),
    );
  }
}