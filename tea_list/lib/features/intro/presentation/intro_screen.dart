import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/styles/string_consts.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void nextPage() {
      context.go("/main_page");
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                repeat: ImageRepeat.repeatY,
                image: AssetImage("assets/images/intro_background.png"),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: MediaQuery.sizeOf(context).height / 3,
            width: MediaQuery.sizeOf(context).width,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(180, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  stops: [0.0, 0.85, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: MediaQuery.sizeOf(context).height / 6,
            left: MediaQuery.sizeOf(context).width / 10,
            right: MediaQuery.sizeOf(context).width / 10,
            child: Text(
              style: TextStyle(
                fontFamily: 'Coiny',
                fontSize: 24,
                color: Colors.white,
                height: 1.5,
              ),
              StringConsts.introQuote,
            ),
          ),

          const SizedBox(height: 80),

          Positioned(
            left: MediaQuery.sizeOf(context).width / 10,
            right: MediaQuery.sizeOf(context).width / 10,
            bottom: MediaQuery.sizeOf(context).height / 15,
            child: StylizedButton(
              onPressed: () => nextPage(),
              text: StringConsts.getStarted,
            ),
          ),
        ],
      ),
    );
  }
}
