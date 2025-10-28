import 'package:flutter/material.dart';
import 'package:game_flappy_bird/main.dart';

// ignore: must_be_immutable
class OverGameOverlay extends StatelessWidget {
  MyGame game;
  OverGameOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white70, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.emoji_events, color: Colors.amber, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    'Your Score: ${game.score}',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Image.asset('assets/images/gameover.png'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Restart the game
                game.overlays.remove("OverGame");
                game.resumeEngine();
                game.player.reset();
                game.removePipe();
                game.resetScore();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Restart Game',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
