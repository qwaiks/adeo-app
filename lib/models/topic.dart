class Topic {
  int id;
  int courseId;
  String topicID;
  String name;
  String author;
  String description;
  String notes;
  String category;
  String createdAt;
  String updatedAt;
  int confirmed;
  int public;
  int n;
  int p;
  String editors;
  int editorId;

  Topic(
      {this.id,
        this.courseId,
        this.topicID,
        this.name,
        this.author,
        this.description,
        this.notes,
        this.category,
        this.createdAt,
        this.updatedAt,
        this.confirmed,
        this.public,
        this.n,
        this.p,
        this.editors,
        this.editorId});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    topicID = json['topicID'];
    name = json['name'];
    author = json['author'];
    description = json['description'];
    notes = json['notes'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    confirmed = json['confirmed'];
    public = json['public'];
    n = json['N'];
    p = json['p'];
    editors = json['editors'];
    editorId = json['editor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['topicID'] = this.topicID;
    data['name'] = this.name;
    data['author'] = this.author;
    data['description'] = this.description;
    data['notes'] = this.notes;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['confirmed'] = this.confirmed;
    data['public'] = this.public;
    data['N'] = this.n;
    data['p'] = this.p;
    data['editors'] = this.editors;
    data['editor_id'] = this.editorId;
    return data;
  }
}
