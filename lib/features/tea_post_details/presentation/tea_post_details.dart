// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tea_list/features/tea_posts/domain/entity/tea_post_entity.dart';

class TeaPostDetails extends StatelessWidget {
  const TeaPostDetails({super.key, required this.teaPostEntity});

  final TeaPostEntity teaPostEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(teaPostEntity.title, style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            SizedBox(height: 4, width: double.maxFinite, child: ColoredBox(color: Colors.black)),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Text(teaPostEntity.body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
