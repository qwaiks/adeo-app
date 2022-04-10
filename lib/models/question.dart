import 'package:adeo_app/models/answer.dart';

class Question {
  int id;
  int courseId;
  int topicId;
  String qid;
  String text;
  String instructions;
  String resource;
  String options;
  int position;
  String createdAt;
  String updatedAt;
  String qtype;
  int confirmed;
  int public;
  int flagged;
  int deleted;
  String editors;
  int editorId;
  //String topic;
  List<Answers> answers;

  Question(
      {this.id,
        this.courseId,
        this.topicId,
        this.qid,
        this.text,
        this.instructions,
        this.resource,
        this.options,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.qtype,
        this.confirmed,
        this.public,
        this.flagged,
        this.deleted,
        this.editors,
        this.editorId,
       // this.topic,
        this.answers});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    topicId = json['topic_id'];
    qid = json['qid'];
    text = json['text'];
    instructions = json['instructions'];
    resource = json['resource'];
    options = json['options'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    qtype = json['qtype'];
    confirmed = json['confirmed'];
    public = json['public'];
    flagged = json['flagged'];
    deleted = json['deleted'];
    editors = json['editors'];
    editorId = json['editor_id'];
    //topic = json['topic'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['topic_id'] = this.topicId;
    data['qid'] = this.qid;
    data['text'] = this.text;
    data['instructions'] = this.instructions;
    data['resource'] = this.resource;
    data['options'] = this.options;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['qtype'] = this.qtype;
    data['confirmed'] = this.confirmed;
    data['public'] = this.public;
    data['flagged'] = this.flagged;
    data['deleted'] = this.deleted;
    data['editors'] = this.editors;
    data['editor_id'] = this.editorId;
    //data['topic'] = this.topic;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
