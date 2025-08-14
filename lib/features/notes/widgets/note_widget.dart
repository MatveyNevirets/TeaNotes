// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/models/ceremony_model.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.ceremony, required this.index});

  final CeremonyModel ceremony;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go("/main_page/notes_details/", extra: [ceremony, index] as List<dynamic>),
      child: Container(
        margin: EdgeInsets.all(8),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        ceremony.imagePath!.substring(0, 6) == "assets"
                            ? AssetImage(ceremony.imagePath!)
                            : ResizeImage(
                              FileImage(File(ceremony.imagePath!)),
                              width:
                                  (MediaQuery.of(context).size.width /
                                          2 *
                                          (MediaQuery.of(context).devicePixelRatio * 2))
                                      .round(),
                            ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withAlpha(255), Colors.black.withAlpha(170), Colors.black.withAlpha(0)],
                      stops: [0.9, 0.95, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Builder(
                builder: (context) {
                  final text = Text(
                    "Церемония ${index + 1}\n\n${ceremony.date!}",
                    style: const TextStyle(color: Colors.white, fontFamily: 'Coiny', fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  );

                  final renderObject = context.findRenderObject() as RenderBox?;
                  if (renderObject != null) {
                    final layout = TextPainter(
                      text: TextSpan(
                        text: "Церемония ${index + 1}\n\n${ceremony.date!}",
                        style: const TextStyle(fontFamily: 'Coiny', fontSize: 16),
                      ),
                      textDirection: TextDirection.ltr,
                      maxLines: 3,
                    );

                    layout.layout(maxWidth: renderObject.size.width);

                    if (layout.didExceedMaxLines) {
                      return Text(
                        "Церемония ${index + 1}\n\n${ceremony.date!}",
                        style: const TextStyle(color: Colors.white, fontFamily: 'Coiny', fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  }

                  return text;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
