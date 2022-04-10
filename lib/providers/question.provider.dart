import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/api.dart';
import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/models/api_response.dart';
import 'package:adeo_app/models/question.dart';
import 'package:adeo_app/providers/base.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends BaseProvider {
  int selectedLevel;
  int selectedClass;
  List<Question> questionsList;
  int questionNumber;
  Question question;
  int selectedAnswer;
  BuildContext context;

  @override
  void initProvider(
      {@required BuildContext context,
      selectedLevel,
      int selectedClass}) async {
    // TODO: implement initProvider
    super.initProvider();
    this.context = context;
    this.selectedLevel = selectedLevel;
    this.selectedClass = selectedClass;
    reset();
    await index();
    next();
  }

  index() async {
    String url = Api.questions;
    var data = {'level_id': 1, 'course_id': 1, 'limit': 20};
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setUiState(UiState.loading),
    );
    var response = await http.get(url, queryParameters: data);
    setUiState(UiState.done);
    var apiResponse = ApiResponse.parse(response);
    if (apiResponse.allGood) {
      questionsList = apiResponse.data.map((e) {
        var question = Question.fromJson(e);
        question.text = Utils.parseHtmlString(question.text);
        question.answers = question.answers.map((e) {
          e.text = Utils.parseHtmlString(e.text);
          return e;
        }).toList();
        return question;
      }).toList();
    }
  }

  checkAnswer(){
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No answer selected')));
    }else{
      next();
    }
  }

  next() {
    if (questionNumber == null) {
      questionNumber = 0;
    } else {
      selectedAnswer = null;
      questionNumber++;
    }
    if (questionNumber < questionsList.length) {
      question = questionsList[questionNumber];
    } else {
      router.pushNamedAndRemoveUntil(AppRoutes.statsRoutes);
    }
    notifyListeners();
  }

  onAnswerSelected(value) {
    selectedAnswer = value;
    notifyListeners();
  }

  @override
  void reset() {
    // TODO: implement reset
    questionNumber = 0;
    questionsList = null;
    question = null;
    selectedAnswer = null;
    super.reset();
  }
}
