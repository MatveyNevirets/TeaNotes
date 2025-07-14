import 'package:flutter/material.dart';
import 'package:tea_list/shared/domain/models/tea_model.dart';

class TeaCardToAdd extends StatelessWidget {
  const TeaCardToAdd({super.key, required this.tea});

  final Tea tea;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(tea.imagePath), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(16),
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
                  tea.title,
                  style: const TextStyle(color: Colors.white, fontFamily: 'Coiny', fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                );

                final renderObject = context.findRenderObject() as RenderBox?;
                if (renderObject != null) {
                  final layout = TextPainter(
                    text: TextSpan(text: tea.title, style: const TextStyle(fontFamily: 'Coiny', fontSize: 16)),
                    textDirection: TextDirection.ltr,
                    maxLines: 2,
                  );

                  layout.layout(maxWidth: renderObject.size.width);

                  if (layout.didExceedMaxLines) {
                    return Text(
                      tea.title,
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
    );
  }
}
