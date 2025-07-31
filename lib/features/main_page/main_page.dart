import 'package:flutter/material.dart';
import 'package:tea_list/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:tea_list/features/favorite/presentation/favorite_screen.dart';
import 'package:tea_list/features/home/presentation/home_page.dart';
import 'package:tea_list/features/notes/presentation/notes_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController();

  final _screens = <Widget>[HomePage(), NotesScreen(), FavoriteScreen()];

  final int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _pageController, physics: const NeverScrollableScrollPhysics(), children: _screens),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        customBottomNavigationBarController: _pageController,
      ),
    );
  }
}
