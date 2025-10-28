import 'package:flutter/material.dart';
import 'package:game_flappy_bird/main.dart';

// ignore: must_be_immutable
class StartGameOverlay extends StatelessWidget {
  MyGame game;
  StartGameOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.resetScore();
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.startGame();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background-day.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset('assets/images/message.png'),
        ),
      ),
    );
  }
}
