flutterexe = /Users/Shared/Flutter/flutter_3.19.5/bin/flutter

.PHONY: gen genAll rebuild check get localize runDev runDevQa runDevStaging lines release apk

# clean project, install dependencies & generate sources
rebuild:
	@${flutterexe} clean
	@${flutterexe} packages pub get
	@${flutterexe} packages pub run build_runner build --delete-conflicting-outputs
	fluttergen -c pubspec.yaml

# generate localizations, dependencies, image assets, colors, fonts
gen:
	@${flutterexe} packages pub run build_runner build --delete-conflicting-outputs

# generate localizations, dependencies, image assets, colors, fonts
genAll:
	@${flutterexe} packages pub run build_runner build --delete-conflicting-outputs
	@${flutterexe} pub run intl_utils:generate
	fluttergen -c pubspec.yaml

# generate localizations
# generation supports only json files, for more information run in terminal
# @${flutterexe} pub run easy_localization:generate --source-dir ./assets/translations
localize:
	@${flutterexe} pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
# analyze the project
check:
	dart analyze .
	# @${flutterexe} pub run dart_code_metrics:metrics analyze lib

# flavors
runDev:
	@${flutterexe} run --flavor dev -t lib/main.dart

runDevQa:
	@${flutterexe} run --flavor dev -t lib/main_qa.dart

runDevStaging:
	@${flutterexe} run --flavor dev -t lib/main_staging.dart

release:
	@${flutterexe} run --release -t lib/main_release.dart

prodRelease:
	@${flutterexe} run --flavor prod --release -t lib/main_release.dart

apk:
	@${flutterexe} build apk --release -t lib/main_release.dart

lines:
	find . -name '*.dart' | xargs wc -l

force_upgrade:
	@${flutterexe} update-packages --force-upgrade

fire_cli:
	@echo ========================
	@echo FlutterFire CLI by running the following command
	@echo ========================
	dart pub global activate flutterfire_cli
fire_config:
	@echo ========================
	@echo Firebase project and selected project applications
	@echo ========================
	flutterfire configure

create_splash:
	@${flutterexe} pub get
	@echo ========================
	@echo Updating the Splash Screen
	@echo ========================
	@${flutterexe} pub run flutter_native_splash:create

run_app:
	@echo ========================
	@echo Run ChillBeats Dev
	@echo pubspec is not updated!
	@echo ========================
	@${flutterexe} run -t lib/main.dart

run_app_ios:
	@echo ========================
	@echo Run ChillBeats Dev
	@echo pubspec is not updated!
	@echo ========================
	@${flutterexe} run -t lib/main.dart
build_app_apk:
	@echo ========================
	@echo Run ChillBeats APK
	@echo ========================
	@${flutterexe} build apk -v --release -t lib/main.dart -- no-shrink

build_app_aab:
	@echo ========================
	@echo Run ChillBeats aab
	@echo ========================
	@${flutterexe} build appbundle -v --release -t lib/main.dart -- no-shrink

build_app_ipa:
	@echo ========================
	@echo Run ChillBeats Archive
	@echo ========================
	@${flutterexe} build ios -v --release -t lib/main.dart -- no-shrink

push_tag:
	@versionstring=`cat pubspec.yaml | grep version: | cut -d '+' -f1`; vstring=`echo $$versionstring | cut -d ' ' -f2`; echo $$vstring; IFS='.' read -r -a ver <<< "$$vstring"; echo $${ver[0]}; echo $${ver[1]}; echo $${ver[2]}; buildnumber=`cat pubspec.yaml | grep version: | cut -d '+' -f2`; minor=$$(($${ver[2]}+0)); newbuildnumber=$$(($$buildnumber+0)); echo $$newbuildnumber; git tag "release/$${ver[0]}.$${ver[1]}.$$minor($$newbuildnumber)"; git push origin --tags

deploy_android: build_app_aab
	@echo ========================
	@echo Deploy ChillBeats Android and upload on Google Play
	@echo ========================
	@cd android;bundle install;bundle exec fastlane deploy;cd ..

deploy_ios: build_app_ipa
	@echo ========================
	@echo Deploy ChillBeats iOS and upload on TestFlight
	@echo ========================
	@cd ios;bundle install;bundle exec fastlane deploy;cd ..

deploy_app: push_tag deploy_android deploy_ios
	@echo ========================
	@echo Deploy ChillBeats Android and iOS
	@echo ========================