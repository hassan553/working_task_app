class TaskModel {
  dynamic title;
  dynamic description;
  dynamic date;
  dynamic category;
  dynamic id;
  dynamic isDone;

  TaskModel({
    this.title,
    this.id,
    this.description,
     this.date,
    this.category,
    this.isDone,
  });

  TaskModel.fromJson(Map json) {
    title = json['title'];
    description = json['description'];
    category = json['category'];
    id = json['id'];
    date = json['date'];
    isDone=json['isDone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'date': date,
      'category': category,
      'isDone':isDone,
    };
  }
}
