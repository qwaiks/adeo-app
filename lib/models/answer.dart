class Answers {
  int id;
  int questionId;
  String text;
  int value;
  String solution;
  String createdAt;
  String updatedAt;
  int answerOrder;
  int responses;
  int flagged;
  String editors;
  int editorId;

  Answers(
      {this.id,
        this.questionId,
        this.text,
        this.value,
        this.solution,
        this.createdAt,
        this.updatedAt,
        this.answerOrder,
        this.responses,
        this.flagged,
        this.editors,
        this.editorId});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    text = json['text'];
    value = json['value'];
    solution = json['solution'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    answerOrder = json['answer_order'];
    responses = json['responses'];
    flagged = json['flagged'];
    editors = json['editors'];
    editorId = json['editor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_id'] = this.questionId;
    data['text'] = this.text;
    data['value'] = this.value;
    data['solution'] = this.solution;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['answer_order'] = this.answerOrder;
    data['responses'] = this.responses;
    data['flagged'] = this.flagged;
    data['editors'] = this.editors;
    data['editor_id'] = this.editorId;
    return data;
  }
}
