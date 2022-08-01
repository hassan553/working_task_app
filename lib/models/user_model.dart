class UserModel{
  dynamic name;
  dynamic email;
  dynamic  password;
  dynamic  phone;
  dynamic image;
  dynamic id;
  dynamic  jobTitle;
  UserModel({this.phone,this.id,this.image,this.name,this.email,this.jobTitle,this.password,});
  UserModel.fromJson(Map json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    id=json['id'];
    jobTitle=json['jobTitle'];
  }
  Map<String,dynamic> toMap(){
    return {
      'email': email,
      'phone': phone,
      'id': id,
      'name': name,
      'image': image,
      'jobTitle': jobTitle,
      'password':password,
    };
  }
}