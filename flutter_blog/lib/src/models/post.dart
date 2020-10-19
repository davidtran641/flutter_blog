
class Post {
  int id;
  int userId;
  String  title;
  String body;

  Post.fromJson(Map<String, dynamic> json)  {
    if (json == null) { return; };
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    body = json['body'];
  }

  static List<Post> listFromJson(List<dynamic> json)  {
    return json == null ? List<Post>() : json.map((value) => Post.fromJson(value)).toList();
  } 
}