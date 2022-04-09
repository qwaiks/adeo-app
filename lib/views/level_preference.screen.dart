import 'package:adeo_app/config/colors.dart';
import 'package:adeo_app/config/locator.dart';
import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_images.dart';
import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/providers/level.provider.dart';
import 'package:adeo_app/services/router.service.dart';
import 'package:adeo_app/shared_widget/custom_button.dart';
import 'package:adeo_app/shared_widget/option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LevelPreferenceScreen extends StatefulWidget {
  const LevelPreferenceScreen({Key key}) : super(key: key);

  @override
  State<LevelPreferenceScreen> createState() => _LevelPreferenceScreenState();
}

class _LevelPreferenceScreenState extends State<LevelPreferenceScreen> {
  LevelProvider vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = context.read<LevelProvider>();
    vm.initProvider();
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<LevelProvider>();
    var router = locator<RouterService>();

    final skipButton = Align(
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          SvgPicture.asset(AppImages.cornerAbs),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  AppString.skip,
                  style: TextStyle(color: AppColors.background02, fontSize: 18),
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );

    final selectText = Text(
      AppString.selectLevel,
      style: TextStyle(fontSize: 29),
    );

    final options = CustomOptionList(
        list: AppString.levelOptions,
        itemValue: 'value',
        itemLabel: 'name',
        selectedValue: vm.selectedLevel,
        onChanged: vm.onChangeLevel);

    final button = CustomButton(
      text: AppString.next,
      isOutline: true,
      onPressed: () =>
          router.navigateTo(AppRoutes.classRoute, args: vm.selectedLevel),
    );

    final level = Stack(
      children: [
        SvgPicture.asset(
          AppImages.levelAbs,
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              selectText,
              verticalSpacer(),
              options,
              verticalSpacer(space: 50),
              button
            ],
          ),
        )
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [skipButton, verticalSpacer(), level],
          ),
          color: AppColors.background02,
        ),
      ),
    );
  }
}
