import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileViewScreen extends StatefulWidget {
  const MobileViewScreen({super.key, required this.difficulty});

  final String difficulty;

  @override
  State<StatefulWidget> createState() {
    return _MobileViewScreenState();
  }
}

class _MobileViewScreenState extends State<MobileViewScreen> {
  String currentTargetImage = "assets/images/target1.png";
  String currentNonTargetImage = "assets/images/nontarget1.png";
  Offset targetPosition = const Offset(100, 100);
  Offset nonTargetPosition = const Offset(200, 200);
  int score = 0;
  int timeLeft = 0;
  bool gameStart = false;
  late Timer gameTimer;
  Timer? targetTimer;

  void _startGame() {
    setState(() {
      score = 0;
      gameStart = true;
      timeLeft = widget.difficulty == 'Easy' ? 80 : widget.difficulty == 'Medium' ? 50 : 30;
    });

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

    _displayRandomImages();
  }

  void _displayRandomImages() {
    _moveImages();
    targetTimer?.cancel();

    targetTimer = Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        currentTargetImage = '';
        currentNonTargetImage = '';
      });
      Future.delayed(const Duration(milliseconds: 500), _displayRandomImages);
    });
  }

  void _moveImages() {
    final random = Random();
    final screenSize = MediaQuery.of(context).size;

    double xTarget = random.nextDouble() * (screenSize.width - 130);
    double yTarget = max(130.0, random.nextDouble() * (screenSize.height - 130 - 30));

    double xNonTarget = random.nextDouble() * (screenSize.width - 130);
    double yNonTarget = max(130.0, random.nextDouble() * (screenSize.height - 130 - 30));

    while ((xTarget - xNonTarget).abs() < 130 && (yTarget - yNonTarget).abs() < 130) {
      xNonTarget = random.nextDouble() * (screenSize.width - 130);
      yNonTarget = max(130.0, random.nextDouble() * (screenSize.height - 130 - 30));
    }

    setState(() {
      targetPosition = Offset(xTarget, yTarget);
      nonTargetPosition = Offset(xNonTarget, yNonTarget);
      currentTargetImage = "assets/images/target${random.nextInt(3) + 1}.png";
      currentNonTargetImage = "assets/images/nontarget${random.nextInt(3) + 1}.png";
    });
  }

  void _onTapTarget() {
    setState(() {
      if (currentTargetImage.contains("target1")) {
        score += 1;
      } else if (currentTargetImage.contains("target2")) {
        score += 2;
      } else if (currentTargetImage.contains("target3")) {
        score += 3;
      }
    });
    _displayRandomImages();
  }

  void _onTapNonTarget() {
    setState(() {
      if (currentNonTargetImage.contains("nontarget1")) {
        score -= 1;
      } else if (currentNonTargetImage.contains("nontarget2")) {
        score -= 2;
      } else if (currentNonTargetImage.contains("nontarget3")) {
        score -= 3;
      }
    });
    _displayRandomImages();
  }

  void _showDialog(String title, String message, String buttonText, Function onButtonPressed) {
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
                style: GoogleFonts.lilitaOne(textStyle: const TextStyle(color: Colors.white, fontSize: 44)),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: message.split('\$score')[0],
                  style: GoogleFonts.lilitaOne(
                    textStyle: const TextStyle(color: Colors.white, fontSize: 28),
                  ),
                  children: [
                    TextSpan(
                      text: "$score",  // Dynamic score value
                      style: GoogleFonts.lilitaOne(
                        textStyle: TextStyle(
                          color: score > 0
                              ? Colors.green
                              : (score < 0 ? Colors.red : Colors.white),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onButtonPressed();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                        style: GoogleFonts.lilitaOne(
                          textStyle: const TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGameOverDialog() {
    _showDialog(
      "Game Over",
      "Your score is ",
      "Restart",
      _startGame,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startGame();
    });
  }

  @override
  void dispose() {
    gameTimer.cancel();
    targetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color scoreColor;
    if (score > 0) {
      scoreColor = Colors.green;
    } else if (score < 0) {
      scoreColor = Colors.red;
    } else {
      scoreColor = Colors.white;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.score, color: Colors.white, size: 30), // Score icon
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    text: "Score : ",
                    style: GoogleFonts.lilitaOne(
                      textStyle: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    children: [
                      TextSpan(
                        text: "$score",
                        style: GoogleFonts.lilitaOne(
                          textStyle: TextStyle(color: scoreColor, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 30),
                const SizedBox(width: 8),
                Text(
                  "Time : $timeLeft",
                  style: GoogleFonts.lilitaOne(
                    textStyle: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ],
            ),
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
          if (gameStart && currentTargetImage.isNotEmpty)
            Positioned(
              left: targetPosition.dx,
              top: targetPosition.dy,
              child: GestureDetector(
                onTap: _onTapTarget,
                child: Image.asset(
                  currentTargetImage,
                  width: 130,
                  height: 130,
                ),
              ),
            ),
          if (gameStart && currentNonTargetImage.isNotEmpty)
            Positioned(
              left: nonTargetPosition.dx,
              top: nonTargetPosition.dy,
              child: GestureDetector(
                onTap: _onTapNonTarget,
                child: Image.asset(
                  currentNonTargetImage,
                  width: 130,
                  height: 130,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
