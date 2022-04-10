import 'dart:math';

import 'package:adeo_app/config/colors.dart';
import 'package:adeo_app/config/locator.dart';
import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_images.dart';
import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/providers/class.provider.dart';
import 'package:adeo_app/services/router.service.dart';
import 'package:adeo_app/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ClassPreferenceScreen extends StatefulWidget {
  final int selectedLevel;

  const ClassPreferenceScreen({Key key, this.selectedLevel}) : super(key: key);

  @override
  State<ClassPreferenceScreen> createState() => _ClassPreferenceScreenState();
}

class _ClassPreferenceScreenState extends State<ClassPreferenceScreen> {
  ClassProvider vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = context.read<ClassProvider>();
    vm.initProvider();
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<ClassProvider>();
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
                    style:
                        TextStyle(color: AppColors.background02, fontSize: 18),
                  ),
                  onPressed: () => router.navigateTo(AppRoutes.questionRoute,
                          args: {
                            'selectedLevel': widget.selectedLevel,
                            'selectedClass': 1
                          })),
            ),
          )
        ],
      ),
    );

    final selectClassPrompt = Text(
      AppString.selectClass,
      style: TextStyle(fontSize: 29, color: Colors.white),
    );

    final subjects = Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: Stack(
        children: vm.classOptions.map((e) {
          var width = MediaQuery.of(context).size.width * 0.8;
          var height = MediaQuery.of(context).size.height * 0.35;
          var name = e['name'];
          var value = e['value'];
          var selected = vm.selectedClass == value;
          return FloatClassWidget(
            text: name,
            onPressed: () => vm.onChangeClass(value),
            value: value,
            isSelected: selected,
            fullWidth: width.toInt(),
            fullHeight: height.toInt(),
          );
        }).toList(),
      ),
    );

    final button = CustomButton(
      text: AppString.next,
      isOutline: true,
      onPressed: () => router.navigateTo(AppRoutes.questionRoute, args: {
        'selectedLevel': widget.selectedLevel,
        'selectedClass': vm.selectedClass
      }),
    );

    final classNumbers = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              AppImages.questionsAbs,
            ),
          ),
          Positioned.fill(
            child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: AppString.classOptions.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var name = vm.classOptions[index]['name'];
                      int value = vm.classOptions[index]['value'];
                      var selected = vm.selectedClass == value;
                      return TextButton(
                        onPressed: () => vm.onChangeClass(value),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value.toString(),
                              style: TextStyle(
                                  fontSize: selected ? 40 : 29,
                                  color: Colors.white),
                            ),
                            Visibility(
                              child: Container(
                                height: 5,
                                width: 30,
                                color: Colors.white,
                              ),
                              visible: selected,
                            )
                          ],
                        ),
                      );
                    })),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.background03,
          child: Column(
            children: [
              skipButton,
              verticalSpacer(),
              selectClassPrompt,
              verticalSpacer(),
              classNumbers,
              subjects,
              verticalSpacer(),
              button
            ],
          ),
        ),
      ),
    );
  }
}

class FloatClassWidget extends StatefulWidget {
  final String text;
  final int value;
  final bool isSelected;
  final int fullWidth, fullHeight;
  final Function onPressed;

  const FloatClassWidget(
      {Key key,
      this.text,
      this.isSelected,
      this.value,
      this.onPressed,
      this.fullWidth,
      this.fullHeight})
      : super(key: key);

  @override
  State<FloatClassWidget> createState() => _FloatClassWidgetState();
}

class _FloatClassWidgetState extends State<FloatClassWidget> {
  double xPosition, yPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    xPosition = Random().nextInt(widget.fullWidth).toDouble();
    yPosition = Random().nextInt(widget.fullHeight).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (dd) {
        setState(() {
          yPosition = dd.localPosition.dy;
          xPosition = dd.localPosition.dx;
        });
      },
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Positioned(
                top: yPosition,
                left: xPosition,
                child: Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: widget.isSelected ? 32 : 20,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
