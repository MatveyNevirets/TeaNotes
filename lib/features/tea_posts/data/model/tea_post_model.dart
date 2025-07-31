import 'package:tea_list/features/tea_posts/domain/entity/tea_post_entity.dart';


class TeaPostModel extends TeaPostEntity {
  TeaPostModel({required super.title, required super.body});

   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
    };
  }

  factory TeaPostModel.fromMap(Map<String, dynamic> map) {
    return TeaPostModel(
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }}
