import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/models/tea_model.dart';

class TeaCardToAdd extends StatefulWidget {
  const TeaCardToAdd({super.key, required this.tea, required this.onFavoriteChanged});

  final TeaModel tea;
  final Function(bool isFavorite) onFavoriteChanged;

  @override
  State<TeaCardToAdd> createState() => _TeaCardToAddState();
}

class _TeaCardToAddState extends State<TeaCardToAdd> {
  @override
  Widget build(BuildContext context) {
    log(widget.tea.imagePath);
    return GestureDetector(
      onTap: () => context.go("/main_page/details", extra: [widget.tea, context]),
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
                        widget.tea.imagePath.substring(0, 6) == "assets"
                            ? AssetImage(widget.tea.imagePath)
                            : ResizeImage(
                              FileImage(File(widget.tea.imagePath)),
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
            Padding(
              padding: const EdgeInsets.all(4),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color:
                        widget.tea.isFavorite ? const Color.fromARGB(160, 249, 204, 201) : Colors.white.withAlpha(160),
                    borderRadius: BorderRadius.circular(16),
                    border: BoxBorder.all(width: 2, color: Colors.black),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.tea.isFavorite = !widget.tea.isFavorite;
                          widget.onFavoriteChanged.call(widget.tea.isFavorite);
                        });
                      },
                      icon: Icon(
                        color: widget.tea.isFavorite ? Colors.red : Colors.black,
                        size: 25,
                        widget.tea.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 9,
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
                    widget.tea.title,
                    style: const TextStyle(color: Colors.white, fontFamily: 'Coiny', fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );

                  final renderObject = context.findRenderObject() as RenderBox?;
                  if (renderObject != null) {
                    final layout = TextPainter(
                      text: TextSpan(text: widget.tea.title, style: const TextStyle(fontFamily: 'Coiny', fontSize: 16)),
                      textDirection: TextDirection.ltr,
                      maxLines: 2,
                    );

                    layout.layout(maxWidth: renderObject.size.width);

                    if (layout.didExceedMaxLines) {
                      return Text(
                        widget.tea.title,
                        style: const TextStyle(color: Colors.white, fontFamily: 'Coiny', fontSize: 14),
                        maxLines: 2,
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
