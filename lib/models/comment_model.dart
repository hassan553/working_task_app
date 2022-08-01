class CommentModel {
  dynamic image;
  dynamic description;
  dynamic name;

  CommentModel({
    this.description,
    this.name,
    this.image,
  });

  CommentModel.fromJson(Map json) {
    image = json['image'];
    description = json['description'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
    };
  }
}
