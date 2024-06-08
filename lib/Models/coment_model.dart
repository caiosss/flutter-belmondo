

class ComentModel {
  final String forumId;
  final String content;
  final String userName;
  final String id;

  ComentModel({
    required this.forumId,
    required this.content,
    required this.userName,
    required this.id,
  });

  factory ComentModel.fromJson(Map<String, dynamic> data) => ComentModel(
    forumId: data['forumId'], 
    content: data['content'], 
    userName: data['userName'],
    id: data['id'],
    );

  Map<String, dynamic> toMap() => {
    'forumId': forumId,
    'content': content,
    'userName': userName,
    'id': id
  };
}