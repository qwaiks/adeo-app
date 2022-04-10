import 'dart:developer';

import 'package:adeo_app/config/utils.dart';
import 'package:adeo_app/constants/api.dart';
import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/models/api_response.dart';
import 'package:adeo_app/models/question.dart';
import 'package:adeo_app/models/stats.dart';
import 'package:adeo_app/providers/base.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class QuestionProvider extends BaseProvider {
  int selectedLevel;
  int selectedClass;
  List<Question> questionsList;
  int questionNumber;
  Question question;
  int selectedAnswer;
  BuildContext context;
  List<String> images;
  Map<String, Stats> questionStats;
  StopWatchTimer stopWatchTimer;
  int fullQuestionTime, prevWatchTime;

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
    stopWatchTimer = StopWatchTimer();
    await index();
    next();
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  index() async {
    String url = Api.questions;
    var data = {'level_id': 1, 'course_id': 1, 'limit': 4};
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setUiState(UiState.loading),
    );
    var response = await http.get(url, queryParameters: data);
    var apiResponse = ApiResponse.parse(response);
    if (apiResponse.allGood) {
      questionsList =
          apiResponse.data.map((e) => Question.fromJson(e)).toList();
    }
    setUiState(UiState.done);
  }

  checkAnswer() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No answer selected')));
    } else {
      //get selected answer from list of answers
      var ans = question.answers
          .singleWhere((element) => element.id == selectedAnswer);
      //check if stat is already in map list of stats for topic
      String topic = question.topic?.name ?? 'unknown';
      bool hasStats = questionStats.containsKey(topic);
      //initialize local stats to update stats of topic
      var stat = hasStats ? questionStats[topic] : Stats();
      //increment topic stats for number of questions answers
      stat.numOfQuestion++;
      //check if option selected is the correct answer
      if (ans.value == 1) {
        // increment correct answers number for topic
        stat.correctAnswers++;
      }
      var timeDiff = stopWatchTimer.rawTime.value - prevWatchTime;
      prevWatchTime = stopWatchTimer.rawTime.value;
      if (hasStats) {
        //update duration spent on topic
        stat.time = stat.time + timeDiff;
      } else {
        // set duration if topic is has no duration .
        stat.time = stopWatchTimer.rawTime.value;
      }
      //update stats record.
      questionStats[topic] = stat;
      //move to next question
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
      images = Utils.parseHtmlImages(question.text);
      question.text = Utils.parseHtmlString(question.text);
      question.answers = question.answers.map((e) {
        e.text = Utils.parseHtmlString(e.text);
        return e;
      }).toList();
    } else {
      fullQuestionTime = stopWatchTimer.rawTime.value;
      stopWatchTimer.onExecute.add(StopWatchExecute.stop);
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
    questionNumber = null;
    questionsList = null;
    questionStats = {};
    question = null;
    images = [];
    fullQuestionTime = null;
    stopWatchTimer = null;
    selectedAnswer = null;
    prevWatchTime = 0;
    super.reset();
  }
}
