import 'dart:convert';

DataModel DataModelFromJson(String str) => DataModelFromJson(jsonDecode(str));
String DataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel{
  DataModel({
    required this.name,
    required this.email,
    required this.id,
    required this.password,
    required this.createdAt,
});
   String name;
   String email;
   String id;
   String password;
   String createdAt;

   factory DataModel.fromJson(Map<String, dynamic>json)=> DataModel(
     name: json["name"],
     email: json["email"],
     id: json["id"],
     password: json["password"],
     createdAt: json["createdAt"],
   );
   Map<String,dynamic> toJson() =>{
     "name": name,
     "email": email,
     "id": id,
     "password": password,
     "createdAt": createdAt,

   };






}