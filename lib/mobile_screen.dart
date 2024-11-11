import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileViewScreen extends StatefulWidget {
  const MobileViewScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MobileViewScreenState();
  }
}

class _MobileViewScreenState extends State<MobileViewScreen> {
  String currentImage = "assets/images/target2.png";
  Offset targetPosition = const Offset(100, 100);
  int score = 0;
  int timeLeft = 0;
  bool gameStart = false;
  late Timer gameTimer;

  void _startGame() {
    setState(() {
      score = 0;
      timeLeft = 60;
      gameStart = true;
    });

    double timerInterval = 1.0;

    gameTimer =
        Timer.periodic(Duration(seconds: timerInterval.toInt()), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          gameStart = false;
          _showGameOverDialog();
        }
      });
    });
  }

  void _moveTarget() {
    final random = Random();
    final screenSize = MediaQuery.of(context).size;
    final x = random.nextDouble() * (screenSize.width - 180);
    final y = max(130.0, random.nextDouble() * (screenSize.height - 180));

    setState(() {
      targetPosition = Offset(x, y);
    });
  }

  void updateImageAndIncreaseScore() {
    setState(() {
      _increaseScore();
      _randomUpdateImage();
      _moveTarget();
    });
  }

  void _randomUpdateImage() {
    final random = Random();
    int randomNumber = random.nextInt(3) + 1;
    setState(() {
      currentImage = "assets/images/target$randomNumber.png";
    });
  }

  void _increaseScore() {
    score++;
  }

  void _showDialog(String title, String message, String buttonText,
      Function onButtonPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.transparent.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.white, fontSize: 24)),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.white, fontSize: 15)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFB0BEC5),
                        Color(0xFF78909C),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onButtonPressed();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.restart_alt,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          buttonText,
                          style: GoogleFonts.pressStart2p(
                            textStyle: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showGameOverDialog() {
    _showDialog(
      "Game Over",
      "Your score is $score",
      "Restart",
      _startGame,
    );
  }

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Score : $score",
              style: GoogleFonts.pressStart2p(
                textStyle: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Text(
              "Time : $timeLeft",
              style: GoogleFonts.pressStart2p(
                textStyle: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
            ),
          ),
          if (gameStart)
            Positioned(
              left: targetPosition.dx,
              top: targetPosition.dy,
              child: GestureDetector(
                onTap: updateImageAndIncreaseScore,
                child: Image.asset(
                  currentImage,
                  width: 180,
                  height: 180,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
