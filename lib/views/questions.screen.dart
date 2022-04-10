import 'package:adeo_app/config/colors.dart';
import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/app_images.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/providers/question.provider.dart';
import 'package:adeo_app/shared_widget/custom_button.dart';
import 'package:adeo_app/shared_widget/option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionProvider vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = context.read<QuestionProvider>();
    vm.initProvider(context: context);
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<QuestionProvider>();

    final timer = Align(
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          SvgPicture.asset(AppImages.cornerAbs),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: const Text(
                AppString.skip,
                style: TextStyle(color: AppColors.background02, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );

    final top = Stack(
      children: [
        Container(
          height: 90,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: vm.questionsList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var selected = vm.questionNumber == index;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                              fontSize: selected ? 40 : 29,
                              color: Colors.white),
                        ),
                      ),
                      Visibility(
                        child: Container(
                          height: 5,
                          width: 50,
                          color: Colors.white,
                        ),
                        visible: selected,
                      )
                    ],
                  ),
                );
              }),
          color: AppColors.background01,
        ),
        timer,
      ],
    );

    final questionText = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: vm.isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.1),
              highlightColor: Colors.white,
              child: ListTile(
                  title: Container(
                    color: Colors.white,
                    height: 30.0,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.white,
                    height: 20.0,
                  )))
          : Text(
              vm.question.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
    );

    final images = Container(
      height: 110,
      color: Colors.grey,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, item) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://picsum.photos/200/300',
                  width: 130,
                  height: 105,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );

    final options = CustomOptionList(
      list: vm.question.answers.map((e) => e.toJson()).toList(),
      itemValue: 'id',
      itemLabel: 'text',
      selectedValue: vm.selectedAnswer,
      onChanged: vm.onAnswerSelected,
    );

    final button = CustomButton(
      isOutline: false,
      text: 'Next',
      onPressed: () => vm.checkAnswer(),
    );

    final questionsView = Column(
      children: [
        questionText,
        verticalSpacer(space: 30),
        images,
        verticalSpacer(),
        options
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade700,
          child: ListView(
            children: [
              top,
              verticalSpacer(space: 40),
              questionsView,
              verticalSpacer(space: 40),
              button
            ],
          ),
        ),
      ),
    );
  }
}
