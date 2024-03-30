/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/icons/logo.svg');

  /// File path: assets/icons/screenshot1.svg
  SvgGenImage get screenshot1 =>
      const SvgGenImage('assets/icons/screenshot1.svg');

  /// List of all assets
  List<SvgGenImage> get values => [logo, screenshot1];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/appstore.png
  AssetGenImage get appstore =>
      const AssetGenImage('assets/images/appstore.png');

  /// File path: assets/images/playstore.png
  AssetGenImage get playstore =>
      const AssetGenImage('assets/images/playstore.png');

  /// File path: assets/images/screenshot1.jpg
  AssetGenImage get screenshot1 =>
      const AssetGenImage('assets/images/screenshot1.jpg');

  /// File path: assets/images/screenshot2.jpg
  AssetGenImage get screenshot2 =>
      const AssetGenImage('assets/images/screenshot2.jpg');

  /// File path: assets/images/screenshot3.jpg
  AssetGenImage get screenshot3 =>
      const AssetGenImage('assets/images/screenshot3.jpg');

  /// File path: assets/images/screenshot4.jpg
  AssetGenImage get screenshot4 =>
      const AssetGenImage('assets/images/screenshot4.jpg');

  /// File path: assets/images/screenshot5.jpg
  AssetGenImage get screenshot5 =>
      const AssetGenImage('assets/images/screenshot5.jpg');

  /// File path: assets/images/user_default_profile_image.jpeg
  AssetGenImage get userDefaultProfileImage =>
      const AssetGenImage('assets/images/user_default_profile_image.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [
        appstore,
        playstore,
        screenshot1,
        screenshot2,
        screenshot3,
        screenshot4,
        screenshot5,
        userDefaultProfileImage
      ];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/lottie_loading_animation.json
  String get lottieLoadingAnimation =>
      'assets/jsons/lottie_loading_animation.json';

  /// File path: assets/jsons/lottie_work_in_progress.json
  String get lottieWorkInProgress =>
      'assets/jsons/lottie_work_in_progress.json';

  /// File path: assets/jsons/no_internet_lottie_animation.json
  String get noInternetLottieAnimation =>
      'assets/jsons/no_internet_lottie_animation.json';

  /// List of all assets
  List<String> get values =>
      [lottieLoadingAnimation, lottieWorkInProgress, noInternetLottieAnimation];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// List of all assets
  List<String> get values => [enUS];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
